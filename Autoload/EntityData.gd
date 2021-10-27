extends Node
# Entity Data

# called every time kill count will change in negetive or positive direction
# connected in wave midifire
# connected in TaskVisualizer

# only those var will be stored here witch one gonna effected by difficulty

signal kill_count_updated(count)

onready var current_kill_count:int = 0 # totle kills
onready var onscreen_enemy_count:int = 0 # count all enemy
onready var onscreen_bee_count: int = 0
onready var  onscreen_grub_count: int = 0

onready var difficulty_threshold:= 0.2

onready var screen_size = get_viewport().get_visible_rect().size # screen size

var Bee = {
    "Count": int(rand_range(4, 6)), # Max number of instance at a time on screen
    "Life": 2.0, # HP
    "Movement_accel": 0.08,
    "Movement_speed": 60.0
}

var Grub = {
    "Onscreen_count": 0,
    "Count": int(rand_range(4, 6)), # Max number of instance at a time on screen
    "Life": 3.0,
    "Damage": 1, # normal given damage to target
    "Damage_explosition": 5, # given damage to target while exploding
    "Self_damage": .5, # get damage amount while connecting with target
    "Movement_accel": 0.08,
    "Movement_speed": 30.0,
}

var Droply = {
    "Onscreen_count": 0,
    "ONSCREEN_MAX_COUNT": 1,
    "Life": 10,
    "Movement_accel": 0.9,
    "Movement_speed": 150
}

var BigHostileBullet = {
    "Damage": 1.0,
    "Speed": 160,
    "LifeTime": 4.0,
    "Damping": 0.4
}


# called in map script or any script that needed to spawn "bee"
# this methode can be transferd in Global script
# this methode is been used in * WaveMapClass
func spawn_bee(_parent):
    if onscreen_bee_count >= 5:
        return
    
    var bee_instance = Global.Bee_path.instance()
    var ss = screen_size
    # setting instance position in top portion of the screen
    bee_instance.global_position = Vector2(rand_range(10, ss.x-10), rand_range(10, ss.y/2 - 100))
    _parent.add_child(bee_instance)


# called in map script or any script that needed to spawn "droply"
# this methode can be transferd in Global script
# this methode is been used in * WaveMapClass
func spawn_grub(_parent):
    if Grub.Onscreen_count >= 5:
        return
    
    var grub_instance = Global.grub_path.instance()
    
    var positions_node = Global.GroundEntitySpawnPositions.get_children()
    
    var pos_vec = positions_node[int(rand_range(0, positions_node.size()))].global_position
    # setting position
    grub_instance.global_position = Vector2(rand_range(pos_vec.x-10, pos_vec.x+10), pos_vec.y)
    
    _parent.add_child(grub_instance)


# called in map script or any script that needed to spawn "droply"
# this methode can be transferd in Global script
# this methode is been used in * WaveMapClass
func spawn_big_droply(_parent):
    # manage onscreen droply count
    if Droply.Onscreen_count >= Droply.ONSCREEN_MAX_COUNT:
        return
    
    var droply_instance = Global.Big_droply_path.instance()
    _parent.add_child(droply_instance)


# reset every data like kill count
# reset value that needed to be tracked for only one wave
func reset():
    current_kill_count = 0


# updates the value
# enemy kills
func change_current_kill_count(value=0):
    current_kill_count += value
    emit_signal("kill_count_updated", current_kill_count)


# update the value
# Droply
func change_onscreen_droply_count(value):
    Droply.Onscreen_count += value


# update the value
# All Enemy
func change_onscreen_enemy_count(value=0):
    onscreen_enemy_count += value


# called when entity get deleted / created
# Bee
func change_onscreen_bee_count(value=0):
    onscreen_bee_count = int(clamp(onscreen_bee_count, 0, Bee.Count))
    onscreen_bee_count += value


# called when entity get deleted / created
# Grub
func change_onscreen_grub_count(value):
    onscreen_grub_count = int(clamp(onscreen_grub_count, 0, Grub.Count))
    onscreen_grub_count += value
