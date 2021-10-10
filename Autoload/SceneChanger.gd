extends Node2D
# SceneChanger
# warning-ignore:unused_signal
signal start_transition(new_scene, prev_scene, desire_parent)

var next_scene
var next_scene_parent

func _excute_transition():
	if is_instance_valid(next_scene_parent): # is inside tree
		if next_scene != null: # is defined
			var node = next_scene.instance()
			next_scene_parent.add_child(node)


func _on_scene_transition_started(new_scene, desire_parent) -> void:
	next_scene = new_scene
	next_scene_parent = desire_parent
	$CanvasLayer/ColorRect/AnimationPlayer.play("transition")
