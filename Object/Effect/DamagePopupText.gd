extends Node2D
# DamagePopupText

func set_text(value):
    if value is String:
        modulate = Color(1, 0, 0)
    else:
        modulate = Color(0, 1, 0)
    
    $Label.text = String(value)
