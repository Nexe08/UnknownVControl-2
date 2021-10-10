extends Node2D
# MainMenu

export (PackedScene) var next_scene
export (NodePath) var current_scene_path = "."
export (NodePath) var desire_parent_path = ".."

onready var current_scene = get_node(current_scene_path)
onready var desire_parent = get_node(desire_parent_path)


func disable(value):
    set_physics_process(value)
    set_physics_process_internal(value)
    set_process(value)
    set_process_internal(value)
    
    global_position.x = get_viewport().get_visible_rect().size.x + 300 if value else 0.0


func _player_wanna_to_play(_body: Node) -> void:
    SceneChanger.emit_signal("start_transition", next_scene, desire_parent)
    disable(true)


func _player_wanna_to_leave(_body: Node) -> void:
    pass # Replace with function body.
