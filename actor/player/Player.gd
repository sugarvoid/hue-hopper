
extends Actor

class_name Player


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

onready var pulse_detector = $Pulse/CollisionShape2D

func _ready() -> void:
	Signals.emit_signal("on_player_life_change", self.hearts)
	self.GRAVITY = 500
	self.speed = 70.00

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_accept"):
		send_pulse()

func _physics_process(delta: float) -> void:
	
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left") # 1 = right  -1 = left

	self.handle_facing_direction(x_input)

	velocity.x += x_input * ACCELERATION * delta
	velocity.x = clamp(velocity.x, -speed, speed)
	
	if !is_on_floor():
		rotation_dir = 0
		
		if Input.is_action_pressed("ui_right"):
			rotation_dir += 1
		if Input.is_action_pressed("ui_left"):
			rotation_dir -= 1
	
	if is_on_floor():
		velocity.y = -JUMPFORCE
		if x_input != 0:
			sprite.frame = 0
		else:
			sprite.frame = 1
	
	velocity.x = lerp(velocity.x, 0, FRICTION)
	rotation += rotation_dir * rotation_speed * delta


func add_point() -> void:
	self.score += 1

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
