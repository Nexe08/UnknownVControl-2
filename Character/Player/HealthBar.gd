extends TextureProgress
# Player Health Bar / Manager

onready var hide:= false


func _ready() -> void:
    max_value = PlayerData.MAX_LIFE


func _process(_delta: float) -> void:
    if hide == true:
        modulate = modulate.linear_interpolate(Color(1, 1, 1, 0), 10 * get_physics_process_delta_time())


func _on_HealthBar_value_changed(_value: float) -> void:
    hide = false
    
    value = _value
    max_value = PlayerData.MAX_LIFE
    
    # 20% of max health
    if ((PlayerData.MAX_LIFE * 100) / 20) < 20:
        $AnimationPlayer.play("below_20per")
    else:
        $AnimationPlayer.play("default")
        $Timer.stop()
        $Timer.start()
    
    modulate = Color(1, 1, 1, 1)


func _on_Timer_timeout() -> void:
    hide = true

