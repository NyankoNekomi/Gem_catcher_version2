extends Area2D

class_name Gem

# Array to hold the paths to the gem textures
var gem_sprite_array: Array = [
	"res://Asset/gem sprites/Asset 1@3x-8.png",
	"res://Asset/gem sprites/Asset 3@3x-8.png",
	"res://Asset/gem sprites/Asset 4@3x-8.png",
	"res://Asset/gem sprites/Asset 5@3x-8.png",
	"res://Asset/gem sprites/Asset 6@3x-8.png",
	"res://Asset/gem sprites/Asset 7@3x-8.png",
	"res://Asset/gem sprites/Asset 8@3x-8.png",
	"res://Asset/gem sprites/Asset 9@3x-8.png",
	"res://Asset/gem sprites/Asset 10@3x-8.png",
	"res://Asset/gem sprites/Asset 11@3x-8.png"
]

@onready var sprite_2d: Sprite2D = $Sprite2D

signal gem_off_screen

const SPEED: float = 200.0
static var _vp_r: Rect2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_vp_r = get_viewport_rect()
	set_random_gem_texture()  # Set a random texture when the gem is ready

# Function to set a random gem texture
func set_random_gem_texture() -> void:
	var random_index = randi() % gem_sprite_array.size()  # Get a random index
	var texture_path = gem_sprite_array[random_index]  # Get the texture path
	var texture = load(texture_path)  # Load the texture
	sprite_2d.texture = texture  # Set the texture to the sprite

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += SPEED * delta
	
	if position.y > Game.get_vpr().end.y:
		gem_off_screen.emit()
		die()

func _on_area_entered(area: Area2D) -> void:
	#print("Gem hits paddle")
	die()

func die() -> void:
	set_process(false)
	queue_free()
