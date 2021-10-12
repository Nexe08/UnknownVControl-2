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


var Bullet_explosition: PackedScene = preload("res://Object/Effect/BulletExplosition.tscn")
var Big_explosition: PackedScene = preload("res://Object/Effect/BigExlosition.tscn")
var Dead_animation: PackedScene = preload("res://Object/Effect/Explostion_1.tscn")



var Bee: PackedScene = preload("res://Character/Bee/Bee.tscn")
var BigHostileBullet: PackedScene = preload("res://Object/Bullet/BigHostileBullet.tscn")
var HostileBullet: PackedScene = preload("res://Object/Bullet/HostileBullet.tscn")


############### MAP ####################
var map_1: PackedScene = preload("res://Scene/WaveMap/Map_1.tscn")

