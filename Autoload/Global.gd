extends Node
# Global


var Camera
var Game
var Main
var Player
var WaveChangeScreen

var player_path: PackedScene = preload("res://Character/Player/Player.tscn")
var bullet_path: PackedScene = preload("res://Object/Bullet/Bullet.tscn")
var melee_projectile_path: PackedScene = preload("res://Object/Bullet/MeleeProjectile.tscn")


############### MAP ####################
var map_1: PackedScene = preload("res://Scene/WaveMap/Map_1.tscn")

