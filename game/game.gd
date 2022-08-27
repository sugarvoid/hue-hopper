extends Node


enum DIFFICULTY {
	EASY,
	MEDIUM,
	HARD
}

const MED_MIN_SCORE: int = 100
const MED_MAX_SCORE: int = 199
const HARD_MIN_SCORE: int = 200
const NUMBER_OF_COLORS: int = 200
const CORRECT_POINT_VALUE: int = 5
const EMENY_KILLED_POINTS: int = 20
const CAM_SHAKE_AMOUNT: int = 13
const LEVEL_LENGTH: float = 30.00

onready var sound_manager: SoundManager = get_node("SoundManager")
onready var iteam_manager: ItemManager = get_node("ItemManager")
onready var enemy_manager: EnemyManager = get_node("EnemyManager")


onready var LevelMusic = get_node("LevelMusic")
onready var background_image: Sprite = get_node("BackGround")
onready var player: Player = get_node("Player")
onready var controls_sprite: Sprite = get_node("ControlsSprite")
onready var combo_bar: TextureProgress = get_node("HUD/ComboBar")
onready var hud: HUD = get_node("HUD") 

var is_game_over: bool 
var rng :RandomNumberGenerator
var color_list: Array = []
var current_multiplier: int = 1
var combo_fever: bool = false
var combo_time = 5
var bounceNumber = 0
var current_color: String = "Purple"
var _current_difficulty : int 
var colors: Array = [
	"Blue",
	"Purple",
	"Yellow",
	"Orange"
]

func _ready() -> void:
	start_new_game()
	_connect_signals()
	rng = RandomNumberGenerator.new()
	_update_HUD_hearts(player.get_hearts())
	_create_color_pattern()
	if Global.is_music_enabled: 
		sound_manager.play(SoundManager.AUDIO_PATHS.level_music)
	enemy_manager.connect("player_killed_enemy", self, "_player_killed_enemy")
	LevelMusic.play()
	


func _process(delta) -> void:
	print(LevelMusic.volume_db)
	if !self.is_game_over:
		_determine_game_difficulty()
		$DebuffCounter.frame = player.debuff_timer.time_left
	else:
		go_to_gameover_screen()

func _connect_signals() -> void:
	player.connect("player_has_landed_on_ground", self, "_player_landed")
	player.connect("on_player_health_changed", self, "_update_HUD_hearts")
	player.connect("on_falling_item_contact", self, "_play_falling_item_sound")
	enemy_manager.connect("player_killed_enemy", self, "_player_killed_enemy")

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

func _update_HUD_hearts(player_health: int) -> void:
	player.set_hearts(player_health)
	self.hud.update_hearts(player.get_hearts())
	if player.get_hearts() <= 0:
		# TODO: wipe enemies 
		# play a death animation 
		Global.player_score = player.get_score()
		go_to_gameover_screen()

func _player_landed(player_color: String) -> void:
	bounceNumber += 1
	
	$Cam2D.shake(CAM_SHAKE_AMOUNT)
	
	# COMPARE PLAYER BOTTON TO GAME'S COLOR
	if self.current_color == player_color:
		sound_manager.play(SoundManager.AUDIO_PATHS.correct)
		player.display_point_text(CORRECT_POINT_VALUE, Color.whitesmoke)
		_add_to_player_score(CORRECT_POINT_VALUE)
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
			sound_manager.play(SoundManager.AUDIO_PATHS.wrong)

	# GET NEW COLOR
	_get_new_color()
	# SEND HUD NEW COLOR
	$ColoredSign.update_lights(current_color)
	## UPDATE BACKGROUND
	_update_background(current_color)
	###_update_hud()

func _update_background(color: String) -> void:
	match color:
		"Blue":
			self.background_image.frame = 3
		"Purple":
			self.background_image.frame = 1
		"Yellow":
			self.background_image.frame = 0
		"Orange":
			self.background_image.frame = 2

func _play_falling_item_sound() -> void: 
	$FallingItemBreak.play()

func _player_killed_enemy() -> void:
	_add_to_player_score(EMENY_KILLED_POINTS)

func _add_to_player_score(amount: int) -> void:
	self.player.add_to_score(amount)
	self.hud.update_score(player.get_score())
