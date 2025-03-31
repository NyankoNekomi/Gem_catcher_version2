extends Node2D

class_name Game
@onready var paddle: Area2D = $paddleScene

@onready var spawn_gems: Timer = $SpawnGems
const GEM = preload("res://scenes/gem.tscn")
const MARGIN: float = 70.0

var _score: int = 0
static var _vp_r: Rect2
var _lives: int = 3

signal score_change(new_score:int)
signal speed_change
signal lives_reduced(new_lives: int)

static func get_vpr() -> Rect2:
	return _vp_r

func _ready() -> void:
	update_vp()
	get_viewport().size_changed.connect(update_vp)
	spawn_gems.start()  # Start the timer to spawn gems
	spawn_gem()  # Spawn the first gem immediately


func update_vp() -> void:
	_vp_r = get_viewport_rect()

func spawn_gem() -> void:
	var new_gem: Gem = GEM.instantiate()
	var x_pos: float = randf_range(
		_vp_r.position.x + MARGIN,
		_vp_r.end.x - MARGIN
	)
	new_gem.position = Vector2(x_pos, -MARGIN)
	add_child(new_gem)
	
	new_gem.gem_off_screen.connect(_on_gem_off_screen)

func _on_spawn_gems_timeout() -> void:
	spawn_gem()
	spawn_gems.wait_time = randf_range(1,3)
#
func stop_all() -> void:
	#sound.stop()
	#sound.stream = EXPLODE
	#sound.play()
	spawn_gems.stop()
	paddle.set_process(false)
	for child in get_children():
		if child is Gem:
			child.set_process(false)




func _on_paddle_area_entered(area: Area2D) -> void:
	_score += randi_range(1,10)
	score_change.emit(_score)
	
	if _score > 300:
		speed_change.emit()

#
#
func _on_gem_off_screen() -> void:
	reduce_life()
	


func reduce_life():
	_lives -=1
	lives_reduced.emit(_lives)
	if _lives < 0:
		stop_all()
	
