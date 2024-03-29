tool
extends Node2D

var destroy = false
var last_key = ""
var pitch_increase = 0

func _ready():
    $AudioStreamPlayer.pitch_scale = 1.0 + pitch_increase * 0.01
    $AudioStreamPlayer.play()
    $AnimatedSprite.frame = 0
    $AnimatedSprite.play("default")
    $AnimationPlayer.play("default")
    $Particles2D.emitting = true
    $Timer.start()
    $Label.text = last_key
    $Label.modulate = Color(rand_range(0,2), rand_range(0,2), rand_range(0,2))

func _on_Timer_timeout():
    if destroy:
        queue_free()
