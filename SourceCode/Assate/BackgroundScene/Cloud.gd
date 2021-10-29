extends Sprite
# Cloud
var speed
onready var screen_size = get_viewport().get_visible_rect().size

func _ready() -> void:
    randomize()
    speed = randi() % 40 + 1
    global_position = Vector2(
        rand_range(0, screen_size.x),
        rand_range(10, screen_size.y - 50)
    )
    var new_scale = rand_range(2, 4)
    scale = Vector2(new_scale, new_scale)


func _process(delta: float) -> void:
    global_position.x += speed * delta
