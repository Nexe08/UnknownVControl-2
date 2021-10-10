extends HBoxContainer
# Time Visual

var Time: float = 0
var start: = false


func _ready() -> void:
# warning-ignore:return_value_discarded
    WaveModifire.connect("playing", self, "_start")


func _process(delta: float) -> void:
    if start:
        visible = true
        Time += delta
    else:
        visible = false
        return
    
    var ms = fmod(Time, 1) * 1000
    var s = fmod(Time, 60)
    
    $s.text = "%02d" % s
    $ms.text = "%03d" % ms


func _start(value):
    start = value
    Time = 0

