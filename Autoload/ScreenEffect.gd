extends Node2D
# ScreenEffect

func _process(_delta: float) -> void:
    Engine.time_scale = lerp(Engine.time_scale, 1, 2 * _delta)


#######
# debug
func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("p"): # debug pause screen
        get_tree().set_pause(!get_tree().is_paused())
        start_abration(3, .1)
    
    if event.is_action_pressed("r"): # debug reload game
        get_tree().reload_current_scene()
# debug
#######


func start_slow_time(time_scale = .5):
    Engine.time_scale = time_scale


func start_freez_screen(time):
    get_tree().paused = true
    yield(get_tree().create_timer(time), "timeout")
    get_tree().paused = false


func start_screen_shake(duration, time):
    if is_instance_valid(Global.Camera):
        Global.Camera.shake(duration, time)


func start_grayscale():
    $CanvasLayer/ScreenColor.get_material().set_shader_param("on", false)


func start_abration(amount:float, time: float):
    if randi() % 2 == 0:
        $CanvasLayer/Abration.material.set_shader_param("strength", Vector2(0, amount * 2))
    else:
        $CanvasLayer/Abration.material.set_shader_param("strength", Vector2(amount, 0))
    yield(get_tree().create_timer(time), "timeout")
    $CanvasLayer/Abration.material.set_shader_param("strength", Vector2.ZERO)



func start_flash_screen(time=0, color: Color = Color.white):
    $CanvasLayer/FlashScreen.color = color
    $CanvasLayer/FlashScreen.visible = true
    yield(get_tree().create_timer(time), "timeout")
    $CanvasLayer/FlashScreen.visible = false
