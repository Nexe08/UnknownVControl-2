extends Node2D
# wave_type

func _ready() -> void:
    Global.Player.global_position = $PlayerSpawnPosition.global_position
    WaveModifire.set_playing(true)


func destroy():
    WaveModifire.set_playing(false)
    queue_free()
