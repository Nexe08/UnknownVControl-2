extends Node2D
class_name Weapon
# Weapon

# for UI 
signal bullet_count_updated(value)

export var speed: float
export var damage: float
export var spred: float
export var knockback: float
export var MAX_AMMO: int
export (int) var current_ammo = MAX_AMMO setget set_ammo_count
export (PackedScene) var projectile

onready var parent = get_parent()
onready var animation = $AnimationPlayer

var view_direction: Vector2 = Vector2.ZERO setget set_view_direction
var projectile_direction: float = 0

var refill_mag: bool # currently refilling or not
var can_fire: bool = true # controls rate of fire



func _process(delta: float) -> void:
    _handel_shooting_direction()
    _handel_refilling_mag(delta)


func _handel_shooting_direction():
    if view_direction.x != 0:
        if view_direction.x < 0:
            animation.play("left")
            projectile_direction = 180
        else:
            animation.play("right")
            projectile_direction = 0
        _shoot()
    elif view_direction.y != 0:
        if view_direction.y < 0:
            animation.play("up")
            projectile_direction = -90
        elif view_direction.y > 0:
            animation.play("down")
            projectile_direction = 90
        _shoot()
    else:
        animation.play("right")
        projectile_direction = 0


func _shoot():
    refill_mag = false
    if can_fire:
        if current_ammo <= 0:
            return
        
        can_fire = false
        current_ammo-=1
        $FireRate.stop()
        $FireRate.start()
        $MuzzelFlash.play("default")
        
        var projectile_instance = projectile.instance()
        projectile_instance.global_position = $MuzzelPosition.global_position
        projectile_instance.rotation_degrees = projectile_direction
        
        projectile_instance.shoot(view_direction, self)
        
        Global.Player.apply_knockback(knockback, -view_direction)
        # create projectile
        Global.Player.get_parent().add_child(projectile_instance)
    
    if current_ammo < MAX_AMMO:
        $ReloadTime.stop()
        $ReloadTime.start()
    else:
        refill_mag = false
    
    set_ammo_count(current_ammo)


func _handel_refilling_mag(delta: float):
    if refill_mag == true:
        if current_ammo <= MAX_AMMO:
            current_ammo += 40.0 * delta
            set_ammo_count(current_ammo)
        else:
            refill_mag = false


# signal call
func _on_FireRate_timeout() -> void:
    can_fire = true


func _on_ReloadTime_timeout() -> void:
    $ReloadTime.stop()
    $ReloadTime.start()
    refill_mag = true


###################################################################
################### GLOBAL FUNCTION'S #############################
###################################################################


func set_view_direction(dir: Vector2):
    view_direction = dir


func set_ammo_count(value):
    current_ammo = value
    emit_signal("bullet_count_updated", [current_ammo, MAX_AMMO])
