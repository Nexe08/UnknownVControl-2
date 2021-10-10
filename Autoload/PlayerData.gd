extends Node
# Player Data

# Life
var current_life:= 20.0
var current_life_regain_speed:= 1.5
var current_life_regain_time:= 1.8

var MAX_LIFE:= 20.0

# respawn
var current_respawn_chance: int = 3

var MAX_RESPAWN_COUNT: int = 3

# Player Weapon Data
var current_fire_rate:= 0.125 # fire rate of weapon
var current_ammo_count:= 20.0
var current_mag_capacity:= 20.0 # ammo count inside mag
var current_reload_speed:= 20.0 # how fast reload will finish
var current_reload_time:= 1.3 # how fast reload will start after mag was empty 

var MAX_MAG_CAPACITY:= 20.0
var MAX_AMMO_COUNT:= 20.0
var MAX_RELOAD_TIME:= 1.3
var MAX_RELOAD_SPEED:= 20.0

