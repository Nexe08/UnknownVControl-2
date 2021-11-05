extends Node
# Player Data

# Life
var current_life:= 20.0
var current_life_regain_speed:= 1.5
var current_life_regain_time:= 1.8

var MAX_LIFE:= 20.0 setget update_max_life

# respawn
var current_respawn_chance: int = 3

var MAX_RESPAWN_COUNT: int = 3

# Player Weapon Data
var current_fire_rate:= 0.125 # fire rate of weapon
var current_ammo_count:= 20.0
var current_mag_capacity:= 50.0 # ammo count inside mag
var current_reload_speed:= 20.0 # how fast reload will finish
var current_reload_time:= .7 # how fast reload will start after mag was empty 

# can be used as intial value
var MAX_MAG_CAPACITY:= 50.0
var MAX_AMMO_COUNT:= 20.0
var MAX_RELOAD_TIME:= 1
var MAX_RELOAD_SPEED:= 40.0


func update_max_life(value):
    MAX_LIFE = value
