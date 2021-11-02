extends KinematicBody2D
# BigDroply


# track player position until anticipation animation wll not start
# and stop tracking player untill attack or reovery animation will not finished
# do this three time and desapeare
# can take damage if is in attack, recovery
# use raycast so he will not start attacking player from behind the world obstical
# set initial position and type

# type idea is not in process it hase been removed

# type <
# spawn logic (In EntityData Script) <
# apearing logic <
# following target( Player ) <
# create laser <
# anticipation line to show that laser is about to fire
# disapearing
# set vonrability
# polishing 

export var life: float
var velocity = Vector2.ZERO

var can_move : bool = false setget set_can_move
var is_alive: bool = true

onready var anim = $AnimationTree.get("parameters/playback")
# contain all node that are free to rotate without effecting root parent
onready var target = Global.Player # predefined target
onready var vb = $VisualBody 
onready var ss = get_viewport().get_visible_rect().size


func _ready() -> void:
#    life = EntityData.Droply.Life
    global_position = Vector2(rand_range(45, ss.x-45), -45)
    vb.rotation_degrees = 0


func _physics_process(_delta: float) -> void:
    var direction = velocity.normalized()
    if direction.x < 0:
        $VisualBody/Sprite.flip_h = true
    else:
        $VisualBody/Sprite.flip_h = false
    
    if not is_alive:
        return
    
    if not can_move:
        velocity.x = lerp(velocity.x, 0, 2 * _delta)
    
    velocity = move_and_slide(velocity)


func take_damage(_takken_damage, _position = Vector2.ZERO):
    if life <= 0:
        is_alive = false
        anim.travel("death")
        return
    
    life -= _takken_damage
    
    # play damage takken animation


# called in animation player
func self_distruction():
    # dead animation
    # getting out from screen
    
    # queue_free was called in animation
    pass


# called in animation player
# attack animation
func start_laser(can: bool):
    $VisualBody/Laser.set_is_casting(can)


# called in animationplayer
func set_can_move(value: bool):
    can_move = value


# called in every animation
# check animation and then change it if needed
# used in attack
func handel_transfer_animation():
    var current_anim = anim.get_current_node()
    match current_anim:
        "attack":
            # for now it will go directly to the recovery
            anim.travel("recovery")
            return
        
        "recovery":
            # for now it will loop, will not disapear
            anim.travel("track_target")


# called in animation player
func handel_apearing():
    $Tween.interpolate_property(self, "global_position:y", global_position.y, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
    $Tween.start()


# called in animation player
func handel_tracking_target():
    var direction = global_position.direction_to(target.global_position)
    
    match anim.get_current_node():
        "attack":
            velocity.x = EntityData.Droply.Movement_speed / 2 * direction.x
            return
        
        'track_target':
            velocity.x = EntityData.Droply.Movement_speed * direction.x
            return


func _on_detecting_player(_body: Area2D) -> void:
    $PlayerDetectionTimer.stop()
    $PlayerDetectionTimer.start()


func _on_PlayerDetector_body_exited(_body: Node) -> void:
    $PlayerDetectionTimer.stop()


func _on_PlayerDetectionTimer_timeout() -> void:
    anim.travel("attack")
