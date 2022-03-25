extends Node

#const EASY_MAX_SCORE: int = 100
const MED_MIN_SCORE: int = 100
const MED_MAX_SCORE: int = 199
const HARD_MIN_SCORE: int = 200

enum DIFFICULTY {
	EASY,
	MEDIUM,
	HARD
}

onready var background = get_node("BackGround")
onready var player: Player = get_node("Player")

var current_color: String = "Yellow"

onready var LevelMusic = get_node("LevelMusic")


var _current_difficulty = DIFFICULTY.EASY


var colors: Array = [
	"Red",
	"Purple",
	"Yellow",
	"Green"
]

func _ready():
	if GameSettings.is_music_enabled: 
		LevelMusic.play()
	Signals.emit_signal("color_changed", current_color) # Set color label to default player bottom
	Signals.connect("player_has_landed_on_ground", self, "_player_landed")
	Signals.connect("player_touched_spike", self, "_play_spike_fx")
	

func _process(delta):
	_handle_background_color()

func start_new_game():
	player.init_player_data()


func _handle_background_color() -> void:
	match _current_difficulty:
		DIFFICULTY.MEDIUM:
			background.change_color(1)
		DIFFICULTY.HARD:
			background.change_color(2)

func _determine_game_difficulty() -> void:
	var score = player.get_score()

	if score >= MED_MIN_SCORE && score < MED_MAX_SCORE:
		_current_difficulty = DIFFICULTY.MEDIUM
	elif score > MED_MAX_SCORE:
		_current_difficulty = DIFFICULTY.HARD
	else:
		_current_difficulty = DIFFICULTY.EASY

func _unhandled_input(event) -> void:
	if event.is_action_pressed("mute"):
		LevelMusic.playing = !LevelMusic.playing
		GameSettings.is_fx_enabled = !GameSettings.is_fx_enabled
		GameSettings.is_music_enabled = !GameSettings.is_music_enabled

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
		PlayerData.change_player_score(GameLogic.CORRECT_POINTS)
	else:
		Signals.emit_signal("on_red_button_pressed")
		if GameSettings.is_fx_enabled:
			$SoundWrong.play()
		
	Signals.emit_signal("player_stat_changed")
	# GET NEW COLOR
	_get_new_color()
	# SEND HUD NEW COLOR
	Signals.emit_signal("color_changed", current_color)
