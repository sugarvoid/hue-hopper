extends Node

const MISS: int = -10
const HIT: int = 5

var current_color: String = "Yellow"

var colors: Array = [
	"Red",
	"Purple",
	"Yellow",
	"Green"
]



func _ready():
	if GameSettings.is_music_enabled: 
		$LevelMusic.play()
	Signals.emit_signal("color_changed", current_color) # Set color label to default player bottom
	Signals.connect("player_has_landed_on_ground", self, "_player_landed")
	Signals.connect("player_touched_spike", self, "_play_spike_fx")
	

func _unhandled_input(event) -> void:
	if event.is_action_pressed("mute"):
		$LevelMusic.stop()
		GameSettings.is_fx_enabled = false
		GameSettings.is_music_enabled = false

func _get_new_color() -> void:
	current_color = colors[randi() % colors.size()]

func _play_spike_fx() -> void:
	if GameSettings.is_fx_enabled:
		$SpikeContact.play()

func _player_landed(player_color) -> void:
	$Cam2D.shake(20)
	# COMPARE PLAYER BOTTON TO GAME'S COLOR
	if self.current_color == player_color:
		if GameSettings.is_fx_enabled:
			$SoundRight.play()
		PlayerData.change_player_score(HIT)
	else:
		if GameSettings.is_fx_enabled:
			$SoundWrong.play()
		PlayerData.change_player_score(MISS)
		
	Signals.emit_signal("player_stat_changed")
	# GET NEW COLOR
	_get_new_color()
	# SEND HUD NEW COLOR
	Signals.emit_signal("color_changed", current_color)
