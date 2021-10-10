extends Node
# WaveModifire
# universel area to store data of ingame entity like enemy, player, bullet etc...
# can be moved in saparate file
# value shows entity states on first wave
# value will change with difficulty/wave 

signal emmit_event(event_name) # connected in HUD to show prograss in wave
signal change_wave
# emmited every time var playing get chagede
# connected in TimeVisual && WaveChangeScreen script
signal playing(value)

# wave type
enum Type {NORMAL_RUN, KILL_RUN, SPAWNER_KILL_RUN, TIME_RUN}
export (Type) var current_wave_type = Type.NORMAL_RUN
onready var current_wave: int = 1

onready var current_kill_count:int = 0 # totle kills not spawners
onready var onscreen_enemy_count:int = 0 # count all enemy
onready var onscreen_bee_count: int = 0
onready var onscreen_spawner_count: int = 0

var difficulty_threshold:= 0.2 # control difficulty high == hard

# modified in map script every time map get loaded or destroyed
onready var playing: bool = false setget set_playing

var Entity_data = {
    "Bee": {
        "Count": int(rand_range(4, 6)), # Max number of instance at a time on screen
        "Life": 2 # HP
    },
    
    "Spawner": {
        "Life": 40,
        "Count": 4, # Max number of instance at a time on screen
        "SpawneTimer": 3,
        "Heal_amount": 1 # how much health regain on get hit
    },
    
    "BigHostileBullet": {
        "Damage": 1.0,
        "Speed": 160,
        "LifeTime": 4.0,
        "Damping": 0.4
       },
   }


func _ready() -> void:
    randomize()
    # warning-ignore:return_value_discarded
    update_difficulty() # update data for first wave
#    choose_wave_type() # intial wave type


func _process(_delta: float) -> void:
    if playing:
        check_task_for_next_wave()


func check_task_for_next_wave():
    match current_wave_type:
        Type.NORMAL_RUN:
            if onscreen_spawner_count == 0 and onscreen_enemy_count == 0:
                choose_wave_type()
        
        Type.KILL_RUN:
            if onscreen_spawner_count == 0 and current_kill_count >= 0:
                choose_wave_type()
        
        Type.SPAWNER_KILL_RUN:
            if onscreen_spawner_count == 0:
                choose_wave_type()
        
        Type.TIME_RUN:
            if onscreen_enemy_count == 0:
                choose_wave_type()


func choose_wave_type():
#    var index = int(rand_range(0, 4))
    var list = [Type.NORMAL_RUN, Type.KILL_RUN, Type.SPAWNER_KILL_RUN, Type.TIME_RUN]
    current_wave_type = list[0]
    change_current_wave()
    emit_signal("change_wave")


# called every time wave will change
func update_difficulty():
    # Difficulty = InitialDifficulty + Level * DifficultyGradient
    Entity_data.Bee.Life = abs(round(Entity_data.Bee.Life + current_wave * difficulty_threshold))
    Entity_data.Spawner.Life = abs(round(Entity_data.Spawner.Life + current_wave * difficulty_threshold))


func change_current_wave():
    update_difficulty()
    current_wave += 1


# updates the value
# enemy kill
func change_current_kill_count(value=0):
    current_kill_count += value
    emit_signal("emmit_event", "+1 Common Kill")


# update the value
# All Enemy
func change_onscreen_enemy_count(value=0):
    onscreen_enemy_count += value


# updates the value
# spawner
func change_onscreen_spawner_count(value=0):
    onscreen_spawner_count = int(clamp(onscreen_spawner_count, 0, Entity_data.Spawner.Count))
    onscreen_spawner_count += value
    if value < 0:
        emit_signal("emmit_event", "+1 Spawner Kill")


# called when entity get deleted / created
# bee
func change_onscreen_bee_count(value=0):
    onscreen_bee_count = int(clamp(onscreen_bee_count, 0, Entity_data.Bee.Count))
    onscreen_bee_count += value


func set_playing(_value):
    playing = _value
    emit_signal("playing", playing)
