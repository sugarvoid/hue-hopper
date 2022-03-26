
extends KinematicBody2D
class_name Player

"""
Player Data/Stats
"""
var bounce_force: float = DEFAULT_BOUCE_FORCE
var rotation_speed: float = DEFAULT_ROTATION_SPEED
var jump_force: float
var coins: int
var _score: int
var hearts: int
var multiplier: int 
const DEFAULT_ROTATION_SPEED: float = 5.3
const DEFAULT_BOUCE_FORCE: float = 400.00
var is_facing_right: bool = true


const ACCELERATION = 600
const AIR_RES = 0.02
var JUMPFORCE: float = PlayerData.bounce_force
const FRICTION = 0.15
var speed: float

var rotation_dir = 0
var flips_achived: int = 0
#var rotation_speed: float
var has_game_started: bool = false
var colors: Array = [purple,red,green,yellow]

var floating_score: PackedScene = preload("res://utils/floating_text/floating_text.tscn")

var GRAVITY: float

const UP = Vector2(0, -1)
var velocity: Vector2 = Vector2.ZERO



onready var sprite: Sprite = $Sprite


onready var purple: Position2D = $Ball/Purple
onready var red: Position2D = $Ball/Red
onready var green: Position2D = $Ball/Green
onready var yellow: Position2D = $Ball/Yellow
onready var timer: Timer = $Timer
onready var ball: Node2D = $Ball
onready var grey_guy: AnimatedSprite = $GreyGuy
onready var blink_animation_player: AnimationPlayer = $BlinkAnimationPlayer
onready var invic_timer: Timer = $InvicTimer



func _ready() -> void:
	Signals.emit_signal("player_stat_changed") #Sets the player hearts at start of game
	Signals.connect("player_touched_spike", self, "take_damage")
	self.GRAVITY = 600.00
	self.speed = 70.00


func init_player_data() -> void:
	hearts = 3
	coins = 0
	multiplier = 1
	_score = 0

func flip_sprite() -> void:
	self.scale.x *= -1 

func _physics_process(delta: float) -> void:

	if has_game_started:
		var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left") # 1 = right  -1 = left

		velocity.x += x_input * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -speed, speed)
		
		if x_input > 0:
			grey_guy.set_flip_h(true)
		elif x_input < 0:
			grey_guy.set_flip_h(false)
			
		if !is_on_floor():
			rotation_dir = 0
			if Input.is_action_pressed("rotate_right"):
				grey_guy.play("walking")
				rotation_dir += 1
			elif Input.is_action_pressed("rotate_left"):
				grey_guy.play("walking")
				rotation_dir -= 1
			else:
				grey_guy.stop()
				#animation_player.stop()
		
		if is_on_floor() and self.global_position.y >= 218: # Actully laned
			rumble_controller(0.3, 0.2)
			Signals.emit_signal("player_has_landed_on_ground", get_bottom_color())
			
			velocity.y = -JUMPFORCE
		elif is_on_floor(): # Landed on enemy
			rumble_controller(0.6, 0.1)
			Signals.emit_signal("player_has_landed_on_enemy")
			
			velocity.y = (-JUMPFORCE + 100)
		
		velocity.x = lerp(velocity.x, 0, FRICTION)
		ball.rotation += rotation_dir * PlayerData.rotation_speed * delta
		
	if velocity.y > GRAVITY:
		velocity.y = GRAVITY
		
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func get_bottom_color_deg():
	var rot_num = round($Ball.rotation)
	print(rot_num)
	
	
	if rot_num == -2 or rot_num == 5:
		print('Red') 
	elif rot_num == 0:
		print('Yellow') 
	elif rot_num == -3 or rot_num == 3:
		print('Purple') 
	elif rot_num == 2 or rot_num == -5:
		print('Green')

func rumble_controller(amount: float, duration: float):
	if GameSettings.is_rumble_enabled:
		Input.start_joy_vibration(0, amount, amount, duration)

func display_point_text() -> void:
	var score = floating_score.instance()
	score.set_text(str(10), Color.green)
	##score.position = $ScorePositon.position
	add_child(score)

func find_largest_dict_val(dict: Dictionary): 
	var max_val = -9999
	var max_var
	for i in dict:
		var val =  dict[i]
		if val > max_val:
			max_val = val
			max_var = i
	return max_var

func get_bottom_color() -> String:
	var dic: Dictionary = {
		"Purple": purple.global_position.y,
		"Red": red.global_position.y,
		"Green": green.global_position.y,
		"Yellow": yellow.global_position.y,
	}
	#TODO: Finish this floating text
	#display_point_text()
	return find_largest_dict_val(dic)
	

func change_score(amount: int):
	self.score += amount

func sort_points(a: Position2D, b: Position2D):
	return a.position.y == b.position.y


func take_damage() -> void:
	if invic_timer.is_stopped():
		invic_timer.start()
		print('hit a spike')
		blink_animation_player.play("blink")
		PlayerData.hearts -= 1
	
	if PlayerData.hearts <= 0:
		get_tree().change_scene("res://scenes/GameOver.tscn")

	Signals.emit_signal("player_stat_changed")

func _on_AttackArea_body_entered(body: Node) -> void:
	print("attack")
	if body.is_in_group("Enemy"):
		body.take_damage(self.attack)

func add_coin(amount: int):
	self.coins += amount

func _on_Pulse_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):
		body.queue_free()

func _on_Timer_timeout() -> void:
	has_game_started = true

func get_score() -> int:
	return self._score


func change_player_score(amount: int) -> void:
	self._score += (amount * multiplier)
	multiplier = 1 # resets multiplier
	if self._score < 0:
		self._score = 0
