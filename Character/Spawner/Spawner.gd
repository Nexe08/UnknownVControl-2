extends KinematicBody2D
# Spawner

enum TYPE {bullet, bee}
export (TYPE) var spawner_type = TYPE.bullet
export var Life:= 5.0
onready var is_alive:= true
onready var ready_to_engage:= false setget set_ready_to_engage


func _ready() -> void:
    EntityData.change_onscreen_spawner_count(1) # update count
    Life = EntityData.Spawner.Life # All spawner have same amount of Life
    $HealthBar.max_value = Life
    $HealthBar.value = Life
    
    match spawner_type:
        TYPE.bee:
            $Sprite.texture = load("res://Assate/BeeSpawner.png")
            return
        
        TYPE.bullet:
            $Sprite.texture = load("res://Assate/SpikeSpawner.png")
            return


# called from big bullet script
func heal():
    if Life < EntityData.Spawner.Life:
        Life += EntityData.Spawner.Heal_amount
        $HealingPartical.restart()
        $HealingPartical.emitting = true
        $HealthBar.emit_signal("value_changed", Life)
        Life = clamp(Life, 0, EntityData.Spawner.Life)


func take_damage(_takken_damage, _intity_position = Vector2.ZERO):
    if ready_to_engage:
        Life -= _takken_damage
        $HealthBar.emit_signal("value_changed", Life)
        
        if Life > 0:
            if is_instance_valid(self):
                # knockback direction
                var dir = global_position.direction_to(_intity_position)
                
                get_hit(90 * dir.x) # set hanger knockback direction
                
                # visual indicate that get hited (flash)
#                $Sprite.get_material().set_shader_param("flash_modifire", 1)
#                if is_instance_valid(self):
#                    yield(get_tree().create_timer(0.15), "timeout")
#                $Sprite.get_material().set_shader_param("flash_modifire", 0)
        else:
            self_distruction()


# hang if get hit
func get_hit(value):
    rotation_degrees = lerp(rotation_degrees, value, .12)
    $Tween.start()
    $Tween.interpolate_property(self, "rotation_degrees", rotation_degrees, 0, 3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)


# proceed for getting destroyed
func self_distruction():
    # Effect
    Global.Camera.shake(10, .2)
    ScreenEffect.start_freez_screen(.06)
    ScreenEffect.start_abration(2, .23)
    ScreenEffect.start_flash_screen(.09)
    
    EntityData.change_onscreen_spawner_count(-1) # update count
    
    is_alive = false
    $HitBox/CollisionShape2D.set_deferred("disabled" , true)
    
    # this instance will deleted after animation was finished
    $InAndOutInScreen.play("out")
    
    # change sprite to dead sprite
    $Sprite.texture = load("res://Assate/dead_spawner_sprite.png")
    
    var death_partical_instance = Global.Big_explosition.instance()
    get_parent().add_child(death_partical_instance)
    death_partical_instance.global_position = $HealingPartical.global_position
    
    # stop processing
    set_physics_process(false)
    set_physics_process_internal(false)
    set_process(false)
    set_process_internal(false)


func _spawn_timer_timeout() -> void:
    if is_alive:
        $AnimationPlayer.play("anticipation")


func _spawn_entity():
    $AnimationPlayer.play("default")
    if is_alive:
        match spawner_type:
            TYPE.bee:
                var bee_count = EntityData.Bee.Count
                if EntityData.onscreen_bee_count < bee_count:
                    var node = Global.Bee.instance()
                    get_parent().add_child(node)
                    node.global_position = $EntitySpawnPosition.global_position
            
            TYPE.bullet:
                for i in 3:
                    var node = Global.BigHostileBullet.instance()
                    node.shoot(Vector2(rand_range(-1, 1), 1), self)
                    get_parent().add_child(node)
                    node.global_position = $EntitySpawnPosition.global_position


# called in animation player
func set_ready_to_engage(value: bool):
    ready_to_engage = value
    print(ready_to_engage , " : ", value)
