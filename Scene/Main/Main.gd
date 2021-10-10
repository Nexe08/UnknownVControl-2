extends Node2D
#  Main


func _ready() -> void:
    Global.Main = self


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("c"):
        take_screenshot()


func take_screenshot():
#    get_viewport().get_texture().get_data()
    yield(get_tree(), "idle_frame")
    yield(get_tree(), "idle_frame")
    var img = get_viewport().get_texture().get_data()
    img.flip_y()
    img.save_png("user://Screenshot_" + String(OS.get_date().year) + "_" + String(OS.get_date().month) + "_" + String(OS.get_date().day) + ".png")
