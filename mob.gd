extends RigidBody2D

func _ready():
	var animations = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(animations[randi() % animations.size()])

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
