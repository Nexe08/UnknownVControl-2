extends Node2D
# DamagePopupText

func set_text(value):
    if value is String:
        modulate = Color("e46060")
    else:
        modulate = Color("1f1f1f")
    
    $Label.text = String(value)
