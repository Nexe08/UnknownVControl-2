extends Node2D
# ScreenEffect


func _process(_delta: float) -> void:
    $CanvasLayer/Label.text = String(Performance.get_monitor(Performance.TIME_FPS))


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("p"): # debug pause screen
        get_tree().set_pause(!get_tree().is_paused())
        start_grayscale(0, get_tree().is_paused())
        start_abration(3, .1)
    
    if event.is_action_pressed("r"): # debug reload game
        # warning-ignore:return_value_discarded
        get_tree().reload_current_scene()


func start_freez_screen(time):
    get_tree().paused = true
    yield(get_tree().create_timer(time), "timeout")
    get_tree().paused = false


func start_grayscale(time:float = 0.0, parmanent: bool = false):
    if not parmanent: 
        $CanvasLayer/Abration.get_material().set_shader_param("grayscale", true)
        yield(get_tree().create_timer(time), "timeout")
        $CanvasLayer/Abration.get_material().set_shader_param("grayscale", false)
    else:
        $CanvasLayer/Abration.get_material().set_shader_param("grayscale", true)


func start_abration(amount:float, time: float):
    $CanvasLayer/Abration.material.set_shader_param("strength", amount)
    yield(get_tree().create_timer(time), "timeout")
    $CanvasLayer/Abration.material.set_shader_param("strength", 0)



func start_flash_screen(time, color: Color = Color.white):
    $CanvasLayer/FlashScreen.color = color
    $CanvasLayer/FlashScreen.visible = true
    yield(get_tree().create_timer(time), "timeout")
    $CanvasLayer/FlashScreen.visible = false
