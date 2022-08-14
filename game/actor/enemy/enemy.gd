extends KinematicBody2D

class_name Enemy


signal player_killed_me

onready var animated_sprite = $AnimatedSprite


export(int, "Box", "Spike", "Bat" ) var type
const GRAVITY: float = 700.0
const UP = Vector2(0, -1)
var velocity: Vector2 = Vector2.ZERO
var diriction = -1
var is_facing_right: bool = true
var speed: float
var color: String
var colors: Array = [
	"red",
	"purple",
	"yellow",
	"green"
]

func get_random_color() -> String:
	return colors[randi() % colors.size()]

func _ready() -> void:
	randomize()
	if self.type == Global.ENEMY_TYPE.BOX:
		self.animated_sprite.play(self.color)
	if diriction == 1:
		flip_sprite() 

func flip_sprite() -> void:
	self.scale.x *= -1 

func _physics_process(delta: float) -> void:
	if self.type != Global.ENEMY_TYPE.BAT:
		if velocity.y > GRAVITY:
			velocity.y = GRAVITY
			
		velocity.y += GRAVITY * delta
		velocity.x = speed * diriction
		velocity = move_and_slide(velocity)
	else:
		self.velocity.y = global_position.y
		position.x += (speed * diriction) * delta
	
	if not is_facing_right:
		flip_sprite()
		is_facing_right = true

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

func _slide_down() -> void:
	$CollisionShape2D.queue_free()
	self.position = Vector2(self.position.x, self.position.y + 1)

func _on_DamageArea_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		if self.type == Global.ENEMY_TYPE.BOX: 
			print(("landed on box body"))
			if self.color == body.get_bottom_color().to_lower(): # Checks if player bottom matches enemy color
				#TODO: needs fixing. position 
				#$AnimationPlayer.play("Die")
				
				emit_signal("player_killed_me")
				_slide_down()
				
				#queue_free()
			else:
				body.take_damage()
		else:
			body.take_damage()

