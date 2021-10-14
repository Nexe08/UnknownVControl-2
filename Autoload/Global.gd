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

var Damage_popup_text: PackedScene = preload("res://Object/Effect/DamagePopupText.tscn")

var Bullet_explosition: PackedScene = preload("res://Object/Effect/BulletExplosition.tscn")
var Big_explosition: PackedScene = preload("res://Object/Effect/BigExlosition.tscn")
var Dead_animation: PackedScene = preload("res://Object/Effect/Explostion_1.tscn")

var Bee: PackedScene = preload("res://Character/Bee/Bee.tscn")
var BigHostileBullet: PackedScene = preload("res://Object/Bullet/BigHostileBullet.tscn")
var HostileBullet: PackedScene = preload("res://Object/Bullet/HostileBullet.tscn")


############### MAP ####################
var map_1: PackedScene = preload("res://Scene/WaveMap/Map_1.tscn")


# add text that show how mutch damage player gives the entity
func add_damage_popup_text(_text, _node, _position):
    var damage_popup_text_instance = Damage_popup_text.instance()
    damage_popup_text_instance.set_text(_text)
    
    _node.get_parent().add_child(damage_popup_text_instance)
    
    # give bit randomness
    damage_popup_text_instance.global_position.x = rand_range(_position.x - 16, _position.x + 16)
    damage_popup_text_instance.global_position.y = _position.y

