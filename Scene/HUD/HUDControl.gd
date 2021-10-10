extends Control
# HUD Control

var HUDLabel = preload("res://Scene/HUD/HudLabel.tscn")




func _ready() -> void:
# warning-ignore:return_value_discarded
#    WaveModifire.connect("emmit_event", self, "add_notification")


func add_notification(event_name: String = "test"):
    var node = HUDLabel.instance()
    node.rect_position.x = -node.rect_size.x
    node.text = event_name
    $VBox.add_child(node)
