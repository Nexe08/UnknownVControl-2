extends Node
# Save System

signal saving_data
signal loading_data

const SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"


# Dictionery that contain data
onready var game_data = {
    "Player": {
        "current_life": PlayerData.current_life,
        "current_life_regain_speed": PlayerData.current_life_regain_speed,
        "current_life_regain_time": PlayerData.current_life_regain_time,
        "current_respawn_chance": PlayerData.current_respawn_chance,
        "current_fire_rate": PlayerData.current_fire_rate,
        "current_ammo_count": PlayerData.current_ammo_count,
        "current_mag_capacity": PlayerData.current_mag_capacity,
        "current_reload_speed": PlayerData.current_reload_speed,
        "MAX_LIFE": PlayerData.MAX_LIFE,
        "MAX_RESPAWN_COUNT": PlayerData.MAX_RESPAWN_COUNT,
        "MAX_MAG_CAPACITY": PlayerData.MAX_MAG_CAPACITY,
        "MAX_AMMO_COUNT": PlayerData.MAX_AMMO_COUNT,
        "MAX_RELOAD_TIME": PlayerData.MAX_RELOAD_TIME,
        "MAX_RELOAD_SPEED": PlayerData.MAX_RELOAD_SPEED,
    }
}


func _input(event: InputEvent) -> void:
    # save
    if event.is_action_pressed("s"):
        var dir = Directory.new()
        if not dir.dir_exists(SAVE_DIR):
            dir.make_dir_recursive(SAVE_DIR)
        
        var file = File.new()
        var error = file.open_encrypted_with_pass(save_path, File.WRITE, "Cossy Code")
        if error == OK:
            file.store_var(game_data)
            file.close()
        emit_signal("saving_data")
        print("data saved")
    
    if event.is_action_pressed("space"):
        load_data()

func save_data():
    pass

func load_data():
    var file = File.new()
    if file.file_exists(save_path):
        var error = file.open_encrypted_with_pass(save_path, File.READ, "Cossy Code")
        if error == OK:
            var data = file.get_var()
            file.close()
            # just for testing
            game_data = data
            emit_signal("loading_data")
