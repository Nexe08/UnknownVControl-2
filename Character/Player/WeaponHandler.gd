extends Node2D
# Weapon Handler


onready var parent = get_parent().get_parent() # Player



func _process(_delta: float) -> void:
    $Gun.set_view_direction(input_direction())
    manage_reload_speed_and_time()


func manage_reload_speed_and_time():
    if parent.move_direction() != 0: # moving
        PlayerData.current_reload_speed = PlayerData.MAX_RELOAD_SPEED
        PlayerData.current_reload_time = PlayerData.MAX_RELOAD_TIME + .3
    else: # not moving
        PlayerData.current_reload_speed = PlayerData.MAX_RELOAD_SPEED * 5
        PlayerData.current_reload_time = PlayerData.MAX_RELOAD_TIME - .3


func input_direction() -> Vector2:
    var x = int(Input.get_action_strength("right") - Input.get_action_strength("left"))
    var y = int(Input.get_action_strength("down") - Input.get_action_strength("up"))
    return Vector2(x, y)