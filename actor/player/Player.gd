
extends KinematicBody2D
class_name Player



"""
Player Data/Stats
"""

const DEFAULT_ROTATION_SPEED: float = 5.3
const DEFAULT_BOUCE_FORCE: float = 400.00
const ACCELERATION: float = 600.00
const AIR_RES: float = 0.02
const FRICTION: float = 0.15
const UP = Vector2(0, -1)

const white_out_degs: Array = [
	0,
	90,
	180
]
var GRAVITY: float = 600.0

var _x # For removing error for change scence funtion
var bounce_force: float
var rotation_speed: float
var jump_force: float
var _score: int
var hearts: int
var multiplier: int 
var is_facing_right: bool = true
var speed: float
var rotation_dir = 0
var flips_achived: int = 0
var has_game_started: bool = false
var velocity: Vector2 = Vector2.ZERO
var is_whited_out: bool = false

var colors: Array


##### onready var sprite: Sprite = $Ball/Sprite
onready var purple: Position2D = $Ball/Purple
onready var red: Position2D = $Ball/Red
onready var green: Position2D = $Ball/Green
onready var yellow: Position2D = $Ball/Yellow
onready var timer: Timer = $Timer
onready var ball: Node2D = $Ball
onready var grey_guy: AnimatedSprite = $GreyGuy
onready var blink_animation_player: AnimationPlayer = $BlinkAnimationPlayer
onready var invic_timer: Timer = $InvicTimer
onready var debuff_timer: Timer = $DebuffTimer


var p_FloatingText: PackedScene = preload("res://interface/floating_text/floating_text.tscn")


func _ready() -> void:
	Signals.emit_signal("player_stat_changed") #Sets the player hearts at start of game
	_x = Signals.connect("player_touched_paint", self, "_white_out")
	_x = Signals.connect("on_orb_pickup", self, "apply_debuff")
	##self.GRAVITY = 600.00
	self.speed = 70.00
	_clear_debuff()


func apply_debuff(type: int) -> void:
	match(type):
		Global.DEBUFFS.BOUNCE_DOWN:
			self.bounce_force -= 85 
		Global.DEBUFFS.ROTATION_UP:
			self.increase_rotate_speed()
		Global.DEBUFFS.WHITE_OUT:
			var rad_rot = white_out_degs[randi() % white_out_degs.size()]
			$Ball/WhiteOut.rotation_degrees = rad_rot
			$Ball/WhiteOut.visible = true
	
	$DebuffTimer.start(10)

func init_player_data() -> void:
	hearts = 3
	multiplier = 1
	_score = 0

func _white_out():
	apply_debuff(Global.DEBUFFS.WHITE_OUT)

func flip_sprite() -> void:
	self.scale.x *= -1 

func _bounce() -> void:
	self.GRAVITY = 600
	velocity.y = -self.bounce_force
	

func _update_sprite(x_input: int) -> void:
	if x_input > 0:
		grey_guy.set_flip_h(true)
	elif x_input < 0:
		grey_guy.set_flip_h(false)

func _physics_process(delta: float) -> void:
	if has_game_started:
		
		if self.velocity.y == 0:
			_bounce()
		
		var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left") # 1 = right  -1 = left

		velocity.x += x_input * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -speed, speed)
		
		_update_sprite(x_input)
		
		if !is_on_floor():
			rotation_dir = 0
			if Input.is_action_just_pressed("slam"):
				Global.raise_error("space bar was pressed")
				self.GRAVITY = 9000
			
			if Input.is_action_pressed("rotate_right"):
				grey_guy.play("walking")
				rotation_dir += 1
			elif Input.is_action_pressed("rotate_left"):
				grey_guy.play("walking")
				rotation_dir -= 1
			else:
				grey_guy.stop()
		
		if is_on_floor() and self.global_position.y >= 218: # Actully laned
			rumble_controller(0.3, 0.2)
			Signals.emit_signal("player_has_landed_on_ground", get_bottom_color())
			
			#########velocity.y = -self.bounce_force
		elif is_on_floor(): # Landed on enemy
			rumble_controller(0.6, 0.1)
			Signals.emit_signal("player_has_landed_on_enemy")
			
			velocity.y = (-self.bounce_force + 100)
		
		velocity.x = lerp(velocity.x, 0, FRICTION)
		ball.rotation += rotation_dir * self.rotation_speed * delta
		
	if velocity.y > GRAVITY:
		velocity.y = GRAVITY
		
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2.UP)


func get_bottom_color_deg():
	var rot_num = round($Ball.rotation)
	if rot_num == -2 or rot_num == 5:
		print('Red') 
	elif rot_num == 0:
		print('Yellow') 
	elif rot_num == -3 or rot_num == 3:
		print('Purple') 
	elif rot_num == 2 or rot_num == -5:
		print('Green')

func rumble_controller(amount: float, duration: float):
	if Global.is_rumble_enabled:
		Input.start_joy_vibration(0, amount, amount, duration)

func display_point_text(value: int, color: Color) -> void:
	var floating_text = p_FloatingText.instance()
	floating_text.setup(str(value), color)
	floating_text.position = $ScorePositon.global_position
	owner.add_child(floating_text)


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
	#TODO: Move floating text to better fitting spot
	return find_largest_dict_val(dic)


func change_score(amount: int):
	self.score += amount


func sort_points(a: Position2D, b: Position2D):
	return a.position.y == b.position.y




func take_damage() -> void:
	if invic_timer.is_stopped():
		invic_timer.start()
		blink_animation_player.play("blink")
		PlayerData.hearts -= 1
	
	if PlayerData.hearts <= 0:
		_x = get_tree().change_scene("res://interface/menu/GameOver.tscn")

	Signals.emit_signal("player_stat_changed")


func _on_AttackArea_body_entered(body: Node) -> void:
	print("attack")
	if body.is_in_group("Enemy"):
		body.take_damage(self.attack)



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

func increase_rotate_speed() -> void:
	self.rotation_speed = 15.5

func _clear_debuff() -> void:
	self.bounce_force = DEFAULT_BOUCE_FORCE
	self.rotation_speed = DEFAULT_ROTATION_SPEED
	$Ball/WhiteOut.rotation_degrees = 0
	$Ball/WhiteOut.visible = false


func _on_DebuffTimer_timeout():
	_clear_debuff()
