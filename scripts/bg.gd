extends ParallaxBackground
@onready var sprite_2d: Sprite2D = $ParallaxLayer/Sprite2D

const  SCROLL_SPEED = 10



func _ready() -> void:
	sprite_2d.region_enabled = true
	
	
func _process(delta: float) -> void:
	
	sprite_2d.region_rect.position += delta * Vector2(0,SCROLL_SPEED)
