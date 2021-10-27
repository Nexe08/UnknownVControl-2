extends Node2D
# Weapon Handler

signal weapon_data_for_ui(value)

var current_weapon

onready var parent = get_parent().get_parent() # Player


func _ready() -> void:
    current_weapon = $DefaultGun
    
    current_weapon.connect("bullet_count_updated", self, "_on_bullet_count_update")
    pass


func _process(_delta: float) -> void:
    for weapon in get_children():
        weapon.set_view_direction(input_direction())


func input_direction() -> Vector2:
    var x = int(Input.get_action_strength("right") - Input.get_action_strength("left"))
    var y = int(Input.get_action_strength("down") - Input.get_action_strength("up"))
    return Vector2(x, y)


# signal
func _on_bullet_count_update(value):
    emit_signal("weapon_data_for_ui", value)
