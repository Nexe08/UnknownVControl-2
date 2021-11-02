extends Camera2D
# Camera

var camera_shake_intencity: float
var camera_shake_duration: float


func _ready() -> void:
    randomize()
    Global.Camera = self


func _process(delta: float) -> void:
    if camera_shake_duration <= 0:
        camera_shake_duration = 0
        camera_shake_intencity = 0
        offset = Vector2.ZERO
    else:
        camera_shake_duration -= delta
        offset = Vector2(randf(), randf()) * camera_shake_intencity


func shake(shake_intencity, shake_duration):
    if shake_intencity > camera_shake_intencity and shake_duration > camera_shake_duration: 
        camera_shake_intencity = shake_intencity
        camera_shake_duration = shake_duration
