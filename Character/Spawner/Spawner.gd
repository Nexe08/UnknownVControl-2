extends KinematicBody2D
# Spawner

enum TYPE {bullet, bee}
export (TYPE) var spawner_type = TYPE.bullet
export var Life:= 5.0
onready var is_alive:= true

var Bee = preload("res://Character/Bee/Bee.tscn")
var BigHostileBullet = preload("res://Object/Bullet/BigHostileBullet.tscn")


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
    Life -= _takken_damage
    $HealthBar.emit_signal("value_changed", Life)
    
    if Life > 0:
        if is_instance_valid(self):
            var dir = global_position.direction_to(_intity_position) # knockback direction
            get_parent().emit_signal("get_hit", 90 * dir.x) # set hanger knockback direction
            
            $Sprite.get_material().set_shader_param("flash_modifire", 1)
            
            yield(get_tree().create_timer(0.15), "timeout")
            
            $Sprite.get_material().set_shader_param("flash_modifire", 0)
            Global.Camera.shake(0.9, 0.2)
    else:
        self_distruction()


func self_distruction():
    EntityData.change_onscreen_spawner_count(-1) # update count
    
    is_alive = false
    $HitBox/CollisionShape2D.set_deferred("disabled" , true)
    
    # change sprite to dead sprite
    $Sprite.texture = load("res://Assate/dead_spawner_sprite.png")
    
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
                    var node = Bee.instance()
                    node.global_position = $EntitySpawnPosition.global_position
                    Global.Game.add_child(node)
            
            TYPE.bullet:
                for i in 3:
                    var node = BigHostileBullet.instance()
                    node.global_position = $EntitySpawnPosition.global_position
                    node.shoot(Vector2(rand_range(-1, 1), 1), self)
                    Global.Game.add_child(node)

