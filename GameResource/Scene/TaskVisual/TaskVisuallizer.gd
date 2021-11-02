extends Control
# Task Visual

onready var normal_kill_counter = $HBoxContainer/VBoxContainer/Kill/Count

func _ready() -> void:
    modulate.a = 0
    EntityData.connect("kill_count_updated", self, "_update_normal_kill_counter")


# connected by signal emmited in entity data scr
func _update_normal_kill_counter(count):
    normal_kill_counter.text = String(count)
    interpolate_by_tween(0, 1, true)


# called if label need to be visible or not
func interpolate_by_tween(initial_value, final_value, loop: bool):
    $Tween.interpolate_property(self, "modulate:a", initial_value, final_value, .5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
    $Tween.start()
    if loop:
        $VisbleTimer.start()


func _on_VisbleTimer_timeout() -> void:
    interpolate_by_tween(1, 0, false)
