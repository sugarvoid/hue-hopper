extends Node


const AUDIO_PATHS: Dictionary = {
	"correct" : "res://game/sound/correct.wav",
	"wrong" : "res://game/sound/wrong.wav",
	"glass" : "res://game/sound/hard-glass-impact.wav",
}

var players = 5
var bus = "master"

var available = []  # The available players.
var queue = []  # The queue of sounds to play.


func _ready():
	# Create the pool of AudioStreamPlayer nodes.
	for i in players:
		var p = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		p.connect("finished", self, "_on_stream_finished", [p])
		p.bus = bus

func _on_stream_finished(stream):
	# When finished playing a stream, make the player available again.
	available.append(stream)

func play(sound_path):
	queue.append(sound_path)

func _process(_delta):
	if Global.is_fx_enabled:
		# Play a queued sound if any players are available.
		if not queue.empty() and not available.empty():
			available[0].stream = load(queue.pop_front())
			available[0].play()
			available.pop_front()
