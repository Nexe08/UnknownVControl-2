extends TileMap



func flow(value):
    $Timer.stop()
    $Timer.start()


func _on_Timer_timeout() -> void:
    pass
