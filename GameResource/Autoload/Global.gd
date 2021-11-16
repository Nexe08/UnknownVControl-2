extends Node
# Global

enum Weapons {DefaultGun}


# CURRENT OBJECT IN TREE IF ASSIGNED USE (is_valide_instance(name) to check)
var Camera
var Game
var Main
var MapContainer
var Player
var GroundEntitySpawnPositions
var WaveChangeScreen

# RELETED TO PLAYER
var player_path: PackedScene = preload("res://Character/Player/Player.tscn")
var bullet_path: PackedScene = preload("res://Object/Bullet/Bullet.tscn")
var melee_projectile_path: PackedScene = preload("res://Object/Bullet/MeleeProjectile.tscn")

# COMMONLY USED
var Damage_popup_text: PackedScene = preload("res://Object/Effect/DamagePopupText.tscn")

# VFX
var Bullet_explosition: PackedScene = preload("res://Object/Effect/BulletExplosition.tscn")
var Big_explosition: PackedScene = preload("res://Object/Effect/BigExlosition.tscn")
var Dead_animation: PackedScene = preload("res://Object/Effect/Explostion_1.tscn")

# ENTITY
var Big_droply_path: PackedScene = preload("res://Character/BigDroply/BigDroply.tscn")

var Bee_path: PackedScene = preload("res://Character/Bee/New/Bee.tscn")
var grub_path: PackedScene = preload("res://Character/Grub/Grub.tscn")

# PROJECTILE
var BigHostileBullet: PackedScene = preload("res://Object/Bullet/BigHostileBullet.tscn")
var HostileBulletPath: PackedScene = preload("res://Object/Bullet/HostileBullet.tscn")


# add text that show how mutch damage player gives the entity
func add_damage_popup_text(_text, _node, _position):
    var damage_popup_text_instance = Damage_popup_text.instance()
    damage_popup_text_instance.set_text(_text)
    
    _node.get_parent().add_child(damage_popup_text_instance)
    
    # give bit randomness
    damage_popup_text_instance.global_position.x = rand_range(_position.x - 16, _position.x + 16)
    damage_popup_text_instance.global_position.y = _position.y

