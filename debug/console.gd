extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var input_box: LineEdit = $Input
onready var output_box: TextEdit = $Output
onready var command_handler = $command_handler

var command_history_line = CommandHistory.history.size()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_box.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_console"):
		get_tree().paused = false
		queue_free()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		match event.scancode:
			KEY_UP:
				goto_command_history(-1)
			KEY_DOWN:
				goto_command_history(1)

func goto_command_history(offset: int):
	command_history_line += offset
	command_history_line = clamp(command_history_line, 0, CommandHistory.history.size())
	if command_history_line < CommandHistory.history.size() and CommandHistory.history.size() > 0:
		input_box.text = CommandHistory.history[command_history_line]
		input_box.call_deferred("set_cursor_position", 9999)

func process_command(input: String) -> void:
	var words = input.split(" ")
	words = Array(words)
	
	# Clean white space
	for _i in range(words.count("")):
		words.erase("")
	
	if words.size() == 0:
		return
		
	CommandHistory.history.append(input)
	var command_word = words.pop_front()
	
	for c in command_handler.valid_commands:
		if c[0] == command_word: # checks if first word matchs one of the valid commands
			if words.size() != c[1].size(): # check if the correct amount of args where givin
				print_text(str('Failure executing command "', command_word, '", expected ', c[1].size(), ' parameters'))
				return
			for i in range(words.size()):
				if not check_type(words[i], c[1][i]):
					print_text(str('Failure executing command "', command_word, '", parameter ', (i + 1),
								' ("', words[1], '") is of wrong type'))
					return
			print_text(command_handler.callv(command_word, words))
			return
	print_text(str('Command "', command_word, '" does not exist.'))

func check_type(string, type):
	match type:
		command_handler.ARG_INT:
			return string.is_valid_integer()
		command_handler.ARG_FLOAT:
			return string.is_valid_float()
		command_handler.ARG_STRING:
			return true
		command_handler.ARG_BOOL:
			return (string == "true" or string == "false")
		_:
			return false

func print_text(text: String) -> void:
	output_box.text = str(output_box.text, "\n", text)
	output_box.set_v_scroll(999999)

func _on_Input_text_entered(new_text: String) -> void:
	input_box.clear()
	process_command(new_text)
	command_history_line = CommandHistory.history.size()
