
extends Actor

class_name Player


const ACCELERATION = 600
const AIR_RES = 0.02
const JUMPFORCE: float = 400.00
const FRICTION = 0.15

var rotation_dir = 0
var flips_achived: int = 0
var rotation_speed: float = 4.0
var has_game_started: bool = false
var bounces = 0
var colors: Array = [purple,red,green,yellow]

onready var purple: Position2D = $Ball/Purple
onready var red: Position2D = $Ball/Red
onready var green: Position2D = $Ball/Green
onready var yellow: Position2D = $Ball/Yellow
onready var timer: Timer = $Timer
onready var ball: Node2D = $Ball
onready var grey_guy: AnimatedSprite = $GreyGuy



func _ready() -> void:
	Signals.emit_signal("on_player_life_change", PlayerData.hearts)
	self.GRAVITY = 500
	self.speed = 70.00

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
			if Input.is_action_pressed("ui_right"):
				grey_guy.play("move")
				rotation_dir += 1
			elif Input.is_action_pressed("ui_left"):
				grey_guy.play("move")
				rotation_dir -= 1
			else:
				grey_guy.stop()
		
		if is_on_floor() and self.global_position.y >= 218: # Actully laned
			self.bounces += 1
			Signals.emit_signal("player_has_landed", find_lowest_point())
			velocity.y = -JUMPFORCE
		elif is_on_floor(): # Landed on enemy
			velocity.y = (-JUMPFORCE + 100)
		
		velocity.x = lerp(velocity.x, 0, FRICTION)
		ball.rotation += rotation_dir * rotation_speed * delta

func toggle_sprite(frame: int):
	if frame == 1:
		sprite.set_frame(0)
	if frame == 0:
		sprite.set_frame(1)

func add_point() -> void:
	self.score += 1

func find_largest_dict_val(dict: Dictionary):
	var max_val = -9999
	var max_var
	for i in dict:
		var val =  dict[i]
		if val > max_val:
			max_val = val
			max_var = i
	return max_var

func find_lowest_point() -> String:
	var dic: Dictionary = {
		"Purple": purple.global_position.y,
		"Red": red.global_position.y,
		"Green": green.global_position.y,
		"Yellow": yellow.global_position.y,
	}
	return find_largest_dict_val(dic)
	

func change_score(amount: int):
	self.score += amount

func sort_points(a: Position2D, b: Position2D):
	return a.position.y == b.position.y

func debug_points():
	print("p: " + str(purple.global_position.y))
	print("y: " + str(yellow.global_position.y))
	print("r: " + str(red.global_position.y))
	print("g: " + str(green.global_position.y))

func take_damage() -> void:
	PlayerData.hearts -= 1
	
	if PlayerData.hearts <= 0:
		get_tree().change_scene("res://scenes/GameOver.tscn")
		
	Signals.emit_signal("on_player_life_change", PlayerData.hearts)

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
