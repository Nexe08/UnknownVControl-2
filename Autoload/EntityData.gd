extends Node
# Entity Data

# called every time kill count will change in negetive or positive direction
signal kill_count_updated(count)


onready var current_kill_count:int = 0 # totle kills not spawners
onready var onscreen_enemy_count:int = 0 # count all enemy
onready var onscreen_bee_count: int = 0
onready var onscreen_spawner_count: int = 0

onready var difficulty_threshold:= 0.2

var Bee = {
    "Count": int(rand_range(4, 6)), # Max number of instance at a time on screen
    "Life": 2 # HP
}

var Spawner = {
    "Life": 40,
    "Count": 4, # Max number of instance at a time on screen
    "SpawneTimer": 3,
    "Heal_amount": 1 # how much health regain on get hit
}

var BigHostileBullet = {
    "Damage": 1.0,
    "Speed": 160,
    "LifeTime": 4.0,
    "Damping": 0.4
}


func update_dificulty(_level):
    # difficulty = current difficulty + level * difficulty threshold
    
    # not add becase need to check old code structure
    pass


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
# All Enemy
func change_onscreen_enemy_count(value=0):
    onscreen_enemy_count += value


# updates the value
# spawner
func change_onscreen_spawner_count(value=0):
    onscreen_spawner_count = int(clamp(onscreen_spawner_count, 0, Spawner.Count))
    onscreen_spawner_count += value


# called when entity get deleted / created
# bee
func change_onscreen_bee_count(value=0):
    onscreen_bee_count = int(clamp(onscreen_bee_count, 0, Bee.Count))
    onscreen_bee_count += value

