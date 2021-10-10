extends MarginContainer
# Wave Change Screen

onready var wave_count_text = $VBox/WaveCompletionText/WaveCount


func _ready() -> void:
    Global.WaveChangeScreen = self
    # warning-ignore:return_value_discarded
    WaveModifire.connect("playing", self, "_change_wave_count_text")


func _change_wave_count_text(_value):
    wave_count_text.text = String(WaveModifire.current_wave)
