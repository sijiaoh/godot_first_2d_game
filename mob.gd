extends RigidBody2D

@export var speed = 100

var direction = Vector2(0, 0)

func _ready():
	direction = Vector2(randf() - 0.5, randf() - 0.5).normalized()
	rotation = direction.angle()

	var animations = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.animation = animations[randi() % animations.size()]

func _process(delta):
	move_local_y(speed * delta)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
