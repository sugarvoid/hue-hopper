
extends Actor

class_name Player

signal player_has_landed()

var frames: Dictionary = { 
	"defualt" : 0,
	"air" : 1 
	}

var rotation_dir = 0
var flips_achived: int = 0
const ACCELERATION = 600
const AIR_RES = 0.02
const JUMPFORCE: float = 400.00
const FRICTION = 0.15

var hearts: int = 3
var coins: int = 0
var rotation_speed: float = 4.0
var has_game_started: bool = false

onready var pulse_detector = $Pulse/CollisionShape2D
onready var blue: Position2D = $Blue
onready var red: Position2D = $Red
onready var green: Position2D = $Green
onready var yellow: Position2D = $Yellow

var colors: Array = [blue,red,green,yellow]

func _ready() -> void:
	Signals.emit_signal("on_player_life_change", self.hearts)
	self.GRAVITY = 500
	self.speed = 70.00

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("pulse"):
		send_pulse()
	if event.is_action_released("start"):
		has_game_started = true

func _physics_process(delta: float) -> void:
	#print(blue.get_global_position())
	if has_game_started:
		var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left") # 1 = right  -1 = left

		#self.handle_facing_direction(x_input)

		velocity.x += x_input * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -speed, speed)
		
		if !is_on_floor():
			rotation_dir = 0
			
			if Input.is_action_pressed("ui_right"):
				rotation_dir += 1
			if Input.is_action_pressed("ui_left"):
				rotation_dir -= 1
		
		if is_on_floor():
			print(sprite.get_frame())
			toggle_sprite(sprite.get_frame())
			Signals.emit_signal("player_has_landed", find_lowest_point())
			#print(get_landed_position())
			velocity.y = -JUMPFORCE
			if x_input != 0:
				sprite.frame = 0
			else:
				sprite.frame = 1
		
		velocity.x = lerp(velocity.x, 0, FRICTION)
		rotation += rotation_dir * rotation_speed * delta

func toggle_sprite(frame: int):
	if frame == 1:
		sprite.set_frame(0)
	if frame == 0:
		sprite.set_frame(1)

func add_point() -> void:
	self.score += 1

func find_largest_dict_val(dict: Dictionary):
	var max_val = -999999
	var max_var
	for i in dict:
		var val =  dict[i]
		if val > max_val:
			max_val = val
			max_var = i
	return max_var

func find_lowest_point() -> String:
	
	var dic: Dictionary = {
		"Blue": blue.global_position.y,
		"Red": red.global_position.y,
		"Green": green.global_position.y,
		"Yellow": yellow.global_position.y,
	}

	return find_largest_dict_val(dic)
	

func sort_points(a: Position2D, b: Position2D):
	return a.position.y == b.position.y

func debug_points():
	print("b: " + str(blue.global_position.y))
	print("y: " + str(yellow.global_position.y))
	print("r: " + str(red.global_position.y))
	print("g: " + str(green.global_position.y))

func take_damage() -> void:
	self.hearts -= 1
	Signals.emit_signal("on_player_life_change", self.hearts)

func _on_AttackArea_body_entered(body: Node) -> void:
	print("attack")
	if body.is_in_group("Enemy"):
		body.take_damage(self.attack)
	

func send_pulse() -> void:
	pulse_detector.disabled = false

func _on_PlayerArea_body_entered(body: Node) -> void:
	if body.is_in_group("Enemy"):
		print("hit by pig")


func _on_Player_health_changed() -> void:
	print("hit")
	#self.get_knocked_back()
	#animatedSprite.play("hit")
	# pass # Replace with function body.



func _on_Pulse_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):
		body.queue_free()
	#pass # Replace with function body.
