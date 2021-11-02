extends Sprite
# Sign Board

export (String) var Text = ""

func _ready() -> void:
    $Node2D/Label.text = Text


func _on_Area2D_body_entered(_body: Node) -> void:
    $AnimationPlayer.play("open")


func _on_Area2D_body_exited(_body: Node) -> void:
    $AnimationPlayer.play("close")
