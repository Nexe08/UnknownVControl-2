extends Area2D
# Map Changing Portal

export (NodePath) var root_node = ""
onready var parent = get_node(root_node) # parent shoud be map in most cases


func _ready() -> void:
    visible = false
    set_physics_process(false)
    $CollisionShape2D.disabled = true


func get_activated():
    visible = true
    set_physics_process(true)
    $CollisionShape2D.call_deferred("set_disabled", false)


# call game scripts methode
func _on_MapChangingPortal_body_entered(_body: Node) -> void:
    Global.Game.change_map()
