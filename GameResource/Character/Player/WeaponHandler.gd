extends Node2D
# Weapon Handler


signal current_weapon_data_for_ui(value)

var current_weapon
var detected_weapon = null
var detected_drop = null

var weapon_drop_detected: bool = false

onready var parent = get_parent().get_parent() # Player
onready var weapons = $WeaponsList.get_children()


func _ready() -> void:
#    current_weapon = $WeaponsList/LaserBeem
    current_weapon = $WeaponsList/DefaultGun
    _handel_current_weapon_visiblity()
#    current_weapon.visible = true
    current_weapon.connect("weapon_data_for_UI", self, "_on_current_weapon_signal_emmited")


func _process(_delta: float) -> void:
    if is_instance_valid(current_weapon):
        current_weapon.set_view_direction(_input_direction())


# this function isn't running every frame 
# that's why we are connecting signal again
# Because current weapon was changed thats why 
# signal also need to be updated
func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("e"):
        if detected_weapon and detected_drop:
            for a_weapon in weapons:
                if a_weapon.name == detected_weapon.name:
                    current_weapon = a_weapon
                    detected_drop.set_picked_up(true) # from weapon drop script
                    _handel_current_weapon_visiblity()
                    
                    if not current_weapon.is_connected("weapon_data_for_UI", self, "_on_current_weapon_signal_emmited"):
                        current_weapon.connect("weapon_data_for_UI", self, "_on_current_weapon_signal_emmited")


# shows current weapon
# hide other weapon if it isn't current weapon
func _handel_current_weapon_visiblity():
    for a_weapon in weapons:
        if a_weapon.name == current_weapon.name:
            a_weapon.visible = true
        elif not a_weapon.name == current_weapon.name:
            a_weapon.visible = false


# Input for attacking direction
func _input_direction() -> Vector2:
    var x = int(Input.get_action_strength("right") - Input.get_action_strength("left"))
    var y = int(Input.get_action_strength("down") - Input.get_action_strength("up"))
    return Vector2(x, y)


# connected by signal called in current weapon 
# it will take data like MAX AMMO and current ammo from currennt weapon
# and will send this to bullet counter HUD by signal
func _on_current_weapon_signal_emmited(data: Array):
    emit_signal("current_weapon_data_for_ui", data)


# weapon drop is in range
func _on_WeaponDropDetector_body_entered(_body: Node) -> void:
    weapon_drop_detected = true
    detected_drop = _body
    
    if _body.has_method("get_droped_weapon_type"):
        detected_weapon = _body.get_droped_weapon_type()


# weapon drop isn't in range
func _on_WeaponDropDetector_body_exited(_body: Node) -> void:
    weapon_drop_detected = false
    
    if detected_drop == _body:
        detected_weapon = null
        detected_drop = null
