extends Node


enum DIFFICULTY {
	EASY,
	MEDIUM,
	HARD
}

#const EASY_MAX_SCORE: int = 100
const MED_MIN_SCORE: int = 100
const MED_MAX_SCORE: int = 199
const HARD_MIN_SCORE: int = 200
const NUMBER_OF_COLORS: int = 200
const CORRECT_POINT_VALUE: int = 5
const WRONG_POINTS: int = -5

onready var sound_manager: SoundManager = get_node("SoundManager")
onready var iteam_manager: ItemManager = get_node("ItemManager")
onready var LevelMusic = get_node("LevelMusic")
onready var background = get_node("BackGround")
onready var player: Player = get_node("Player")
onready var combo_bar: TextureProgress = get_node("HUD/ComboBar")
onready var HUD: HUD = get_node("HUD") 

var is_game_over: bool 
var rng :RandomNumberGenerator
var color_list: Array = []
var current_multiplier: int = 1
var combo_fever: bool = false
var combo_time = 5
var bounceNumber = 0
var current_color: String = "Yellow"
var _current_difficulty : int 
var colors: Array = [
	"Red",
	"Purple",
	"Yellow",
	"Green"
]

func _ready():
	start_new_game()
	rng = RandomNumberGenerator.new()
	_update_HUD_hearts(player.get_hearts())
	_create_color_pattern()
	if Global.is_music_enabled: 
		LevelMusic.play()
	Signals.emit_signal("color_changed", current_color) # Set color label to default player bottom
	player.connect("player_has_landed_on_ground", self, "_player_landed")
	player.connect("on_player_health_changed", self, "_update_HUD_hearts")
	player.connect("on_falling_item_contact", self, "_play_falling_item_sound")

func _process(delta):
	if !self.is_game_over:
		_determine_game_difficulty()
		$DebuffCounter.frame = player.debuff_timer.time_left
	else:
		Global.go_to_gameover_screen()

func go_to_gameover_screen() -> void:
	get_tree().change_scene(Global.SCENE_PATHS.game_over)

func start_new_game():
	player.init_player_data()
	_determine_game_difficulty()

func _get_random_number() -> int:
	rng.randomize()
	return rng.randi_range(0, 4)

func _create_color_pattern() -> void:
	color_list.resize(NUMBER_OF_COLORS)
	for i in NUMBER_OF_COLORS:
		color_list[i] = _get_random_number()

func _determine_game_difficulty() -> void:
	var player_score = player.get_score()
	
	if player_score >= MED_MIN_SCORE && player_score < MED_MAX_SCORE:
		_current_difficulty = DIFFICULTY.MEDIUM
	elif player_score > MED_MAX_SCORE:
		_current_difficulty = DIFFICULTY.HARD
	else:
		_current_difficulty = DIFFICULTY.EASY

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

func _end_game() -> void:
	pass

func _update_HUD_hearts(player_health) -> void:
	player.set_hearts(player_health)
	self.HUD.update_hearts(player.get_hearts())
	if player.get_hearts() <= 0:
		Global.player_score = player.get_score()
		go_to_gameover_screen()

func _player_landed(player_color) -> void:
	bounceNumber += 1
	
	$Cam2D.shake(13)
	
	# COMPARE PLAYER BOTTON TO GAME'S COLOR
	if self.current_color == player_color:
		SoundManager.play(SoundManager.AUDIO_PATHS.correct)
		player.display_point_text(CORRECT_POINT_VALUE, Color.whitesmoke)
		player.add_to_score(CORRECT_POINT_VALUE)
	else:
		# TODO: Add some sort of difference 
		match _current_difficulty:
			DIFFICULTY.EASY:
				player.take_damage()
			DIFFICULTY.MEDIUM:
				player.take_damage()
			DIFFICULTY.HARD:
				player.take_damage()
		if Global.is_fx_enabled:
			$SoundWrong.play()

	# GET NEW COLOR
	_get_new_color()
	# SEND HUD NEW COLOR
	$ColoredSign.update_lights(current_color)
	self.HUD.update_score(player.get_score())

func _play_falling_item_sound() -> void: 
	$FallingItemBreak.play()
