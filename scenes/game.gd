extends Node

#const EASY_MAX_SCORE: int = 100
const MED_MIN_SCORE: int = 100
const MED_MAX_SCORE: int = 199
const HARD_MIN_SCORE: int = 200

const NUMBER_OF_COLORS: int = 200




onready var LevelMusic = get_node("LevelMusic")
onready var background = get_node("BackGround")
onready var player: Player = get_node("Player")
onready var combo_bar: TextureProgress = get_node("HUD/ComboBar")
onready var HUD: HUD = get_node("HUD") 

var rng :RandomNumberGenerator
var color_list: Array = []
var current_multiplier: int = 1
var combo_fever: bool = false
var combo_time = 5

var bounceNumber = 0

### var _curr_color: int = COLORS.GREEN

var current_color: String = "Yellow"
var _current_difficulty : int 
var colors: Array = [
	"Red",
	"Purple",
	"Yellow",
	"Green"
]

func _ready():
	rng = RandomNumberGenerator.new()
	_create_color_pattern()
	if Global.is_music_enabled: 
		LevelMusic.play()
	Signals.emit_signal("color_changed", current_color) # Set color label to default player bottom
	Signals.connect("player_has_landed_on_ground", self, "_player_landed")
	Signals.connect("player_touched_paint", self, "_play_spike_fx")
	


func _process(delta):
	_determine_game_difficulty()
	_handle_background_color()
	$HUD.update_player_score(player.get_score())


func start_new_game():
	player.init_player_data()
	
	_determine_game_difficulty()

#TODO: Remove since background will not be color rect anymore
func _handle_background_color() -> void:
	match _current_difficulty:
		Global.DIFFICULTY.MEDIUM:
			#change light colors 
			# TODO: make better
			$HUD.change_score_color()
		Global.DIFFICULTY.HARD:
			#change light colors
			pass 

func _get_random_number() -> int:
	rng.randomize()
	return rng.randi_range(0, 4)

func _create_color_pattern() -> void:
	color_list.resize(NUMBER_OF_COLORS)
	for i in NUMBER_OF_COLORS:
		color_list[i] = _get_random_number()
	print(color_list)

func _determine_game_difficulty() -> void:
	var score = player.get_score()
	
	if score >= MED_MIN_SCORE && score < MED_MAX_SCORE:
		_current_difficulty = Global.DIFFICULTY.MEDIUM
	elif score > MED_MAX_SCORE:
		_current_difficulty = Global.DIFFICULTY.HARD
	else:
		_current_difficulty = Global.DIFFICULTY.EASY

func _reset_multiplier() -> void:
	self.current_multiplier = 1
	self.combo_fever = false

func _unhandled_input(event) -> void:
	if event.is_action_pressed("mute"):
		LevelMusic.playing = !LevelMusic.playing
		Global.is_fx_enabled = !Global.is_fx_enabled
		Global.is_music_enabled = !Global.is_music_enabled


func _get_new_color() -> void:
	current_color = colors[randi() % colors.size()]

func _play_spike_fx() -> void:
	if Global.is_fx_enabled:
		$SpikeContact.play()


func _end_game() -> void:
	pass


func _player_landed(player_color) -> void:
	bounceNumber += 1
	print('Bounce #' + str(bounceNumber) )
	
	$Cam2D.shake(13)
	
	# COMPARE PLAYER BOTTON TO GAME'S COLOR
	if self.current_color == player_color:
		if Global.is_fx_enabled:
			$SoundRight.play()
		player.change_player_score(Global.CORRECT_POINTS)
	else:
		match _current_difficulty:
			Global.DIFFICULTY.EASY:
				Signals.emit_signal("on_red_button_pressed")
			Global.DIFFICULTY.MEDIUM:
				Signals.emit_signal("on_red_button_pressed")
				Signals.emit_signal("on_red_button_pressed")
			Global.DIFFICULTY.HARD:
				Signals.emit_signal("on_red_button_pressed")
				Signals.emit_signal("on_red_button_pressed")
				Signals.emit_signal("on_red_button_pressed")
		if Global.is_fx_enabled:
			$SoundWrong.play()
		
	Signals.emit_signal("player_stat_changed")
	# GET NEW COLOR
	_get_new_color()
	# SEND HUD NEW COLOR
	$ColoredSign.update_lights(current_color)
	Signals.emit_signal("color_changed", current_color)
