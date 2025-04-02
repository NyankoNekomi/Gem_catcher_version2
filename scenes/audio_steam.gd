extends Node

@onready var bgm_node: AudioStreamPlayer = $BGM
@onready var player: AudioStreamPlayer2D = $sfx


var bgm = preload("res://Asset/bgm_action_5.mp3")

var sfx:Dictionary= {
	
	"explode":preload("res://Asset/explode.wav"),
	"spell":preload("res://Asset/spell1_0.wav")
		
}

func play_clip(clip_key: String, random_pitch: bool = false) -> void:
	if sfx.has(clip_key) == false:
		return
	
	if player == null:
		return
	
	player.stream = sfx[clip_key]
	
	if random_pitch:
		var pitch_multiplier = randf_range(0.9, 1.1)  # adjust this range to your liking
		player.pitch_scale = pitch_multiplier
	
	player.play()

func play_bg_clip(player: AudioStreamPlayer, clip_key: String, random_pitch: bool = false) -> void:
	if sfx.has(clip_key) == false:
		return
	
	if player == null:
		return
	
	player.stream = sfx[clip_key]
	
	if random_pitch:
		var pitch_multiplier = randf_range(0.9, 1.1)  # adjust this range to your liking
		player.pitch_scale = pitch_multiplier
	
	player.play()
