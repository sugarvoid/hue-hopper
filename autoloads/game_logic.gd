extends Node



const CORRECT_POINTS: int = 5
const WRONG_POINTS: int = 5



enum BUFFS {
	HEALTH_UP,
	REPLACE
}

enum DEBUFFS {
	ROTATION,
	BOUNCE_DOWN,
	ROTATION_UP,
}

enum PICKUPS {
	SPIKE,
	COIN,
	GEM
}

const ITEMS: Dictionary = {
	"coin" : 0
}


var _current_debuff: String

# var has_morning_passed: bool = false
# var has_evening_passed: bool = false

onready var debuff_timer: Timer = Timer.new()


func _ready():
	GameSettings.create_high_score_file()
	add_child(debuff_timer)
	Signals.connect("on_orb_pickup", self, "_on_orb_pickup")
	debuff_timer.connect("timeout", self, "_on_debuff_timer_timeout")
	pass



func get_current_debuff() -> String:
	return "Debuff: " + self._current_debuff

func _on_orb_pickup(debuff_id) -> void:
	match debuff_id:
		GameLogic.DEBUFFS.ROTATION:
			_current_debuff = "SLOW DOWN"
			PlayerData.rotation_speed = 2.0
		GameLogic.DEBUFFS.BOUNCE_DOWN:
			_current_debuff = "LOW BOUNCE"
			PlayerData.bounce_force = 200
		GameLogic.DEBUFFS.ROTATION_UP:
			_current_debuff = "ROTATION UP"
		_:
			pass
	
	debuff_timer.start(10)

func _remove_debuffs():
	PlayerData.rotation_speed = PlayerData.DEFAULT_ROTATION_SPEED
	PlayerData.bounce_force = PlayerData.DEFAULT_BOUCE_FORCE

func _on_debuff_timer_timeout() -> void:
	_current_debuff = ""
	_remove_debuffs()

func is_left_mouse_click(input: InputEventMouseButton) -> bool:
	return (input is InputEventMouseButton 
	and input.button_index == BUTTON_LEFT 
	and input.pressed)
