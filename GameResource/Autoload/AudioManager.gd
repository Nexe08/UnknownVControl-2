extends Node2D
# Audio Manager


func randomize_audio(type):
    var sounds = type.get_children()
    sounds.shuffle()
    sounds[0].play()


# called in player bullet script in ready function
func play_bullet_shooting_sfx():
    randomize_audio($SFX/BulletShooting)


# called in player script
func play_walk_sfx():
    randomize_audio($SFX/PlayerWalk)


# called in player script
func play_jump_sfx():
    randomize_audio($SFX/PlayerJump)

