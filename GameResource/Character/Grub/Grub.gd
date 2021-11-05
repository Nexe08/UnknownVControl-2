extends KinematicBody2D
# Grub

export var life: float # = EntityData.Grub.Life
var velocity := Vector2.ZERO
var gravity := 700.0
var direction := 1.0 # move direction

var is_ready := false setget set_is_ready # check moving condition


const UP = Vector2.UP

onready var health_bar = $HealthBar
onready var anim = $AnimationTree.get("parameters/playback")

func _ready() -> void:
    EntityData.Grub.Onscreen_count += 1
    EntityData.change_onscreen_grub_count(1)
    EntityData.change_onscreen_enemy_count(1)
    update_health_bar()


func _physics_process(delta: float) -> void:
    velocity.y += gravity * delta # applying gravity
    velocity = move_and_slide(velocity, UP)
    
    if not is_ready:
        velocity.x = 0
        return
    
    change_direction(delta)
    velocity.x = EntityData.Grub.Movement_speed * direction


# moving direction
func change_direction(_delta: float) -> void:
    if is_on_floor():
        if not floor_detected() or wall_detected():
            direction *= -1
            var dir = direction * -direction
            visual_body_direction(dir)


# move sprite and all neccery node on changing direction
func visual_body_direction(dir):
    $TerrainDetector.scale.x *= dir
    $Sprite.scale.x *= dir


# detects the wall
func wall_detected():
    return $TerrainDetector/WallDetector.is_colliding()


# detects the floor
func floor_detected():
    return $TerrainDetector/GroundDetector.is_colliding()


func take_damage(takken_damage, _damage_dir: Vector2 = Vector2.ZERO):
    if life > 0:
        velocity.x = 0
        velocity.x = 800 * -global_position.direction_to(_damage_dir).x
    
    if not is_ready:
        return
    
    life -= takken_damage
    
    update_health_bar()
    
    if life <= 0:
        anim.travel("explode")
    else:
        anim.travel("take_damage")


# queue free wase called in animation player
# called in aniamtion player
func self_distruction():
    # effects
    Global.Camera.shake(2.5, .28)
    ScreenEffect.start_freez_screen(.09)
    ScreenEffect.start_abration(4, .2)
    ScreenEffect.start_flash_screen(.05)
    
    EntityData.change_onscreen_grub_count(-1) # update count
    EntityData.change_onscreen_enemy_count(-1) # update count
    EntityData.change_current_kill_count(1)
    
    EntityData.Grub.Onscreen_count -= 1


# setget methode
func set_is_ready(value: bool):
    is_ready = value


# mainly use to update halth bar
func update_health_bar():
    health_bar.value = life
    health_bar.max_value = EntityData.Grub.Life
    health_bar.emit_signal("value_changed", life)


# Effect of geting contect with target
# give damage to target
# take damage
func _on_target_body_entered(body: Node) -> void:
    if body.has_method("take_damage"):
        body.take_damage(EntityData.Grub.Damage, global_position)
        take_damage(EntityData.Grub.Self_damage)
