extends Sprite
# Player Visual Sprite

export (NodePath) var jump_partical_path = ""

var hit_ground = false
var prev_velocity = Vector2()

onready var parent = get_parent().get_parent()
onready var jump_force = parent.jump_force

onready var fsm = $AnimationTree.get("parameters/playback")
#onready var jump_partical = get_node(jump_partical_path)


func _process(delta: float) -> void:
    var velocity = parent.velocity
    var is_grounded = parent.is_grounded
    var move_direction = parent.move_direction()
    
    if is_grounded:
        if move_direction == 0:
            fsm.travel("idle")
        else:
            fsm.travel("move")
    else:
        fsm.travel("jump")
    
    if move_direction < 0:
        flip_h = true
    elif move_direction > 0:
        flip_h = false
    
    if not is_grounded:
        hit_ground = false
        scale.x = range_lerp(abs(velocity.y), 0, abs(jump_force), 1.25, 0.75)
        scale.y = range_lerp(abs(velocity.y), 0, abs(jump_force), 0.75, 1.25)
    
    if not hit_ground and is_grounded:
        hit_ground = true
        scale.x = range_lerp(abs(prev_velocity.y), 0, abs(1700), 1.4, 2.0)
        scale.y = range_lerp(abs(prev_velocity.y), 0, abs(1700), 0.57, 0.5)
#		jump_partical.restart()
#		jump_partical.emitting = true
    
    scale = lerp(scale, Vector2(1, 1), 1 - pow(0.006, delta))
