extends Node

@export var mob_scene: PackedScene

var score

func new_game():
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready!")

	var position = $PlayerSpawnPosition.position
	$Player.start(position)
	$StartDelayTimer.start()

	$BackGroundBGM.play()

func game_over():
	$MobSpawnTimer.stop()
	$ScoreCountTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")

	$BackGroundBGM.stop()
	$GameOverSE.play()

func _on_mob_spawn_timer_timeout():
	var mob = mob_scene.instantiate()
	add_child(mob)

	var location = $MobPath/MobSpawnLocation
	location.progress_ratio = randf()

	mob.position = location.position

	var direction = location.rotation + PI / 2
	direction += randf_range( - PI / 4, PI / 4)
	mob.rotation = direction + PI / 2

	var velocity = Vector2(randf_range(150, 250), 0)
	mob.linear_velocity = velocity.rotated(direction)

func _on_score_count_timer_timeout():
	score += 100
	$HUD.update_score(score)

func _on_start_delay_timer_timeout():
	$MobSpawnTimer.start()
	$ScoreCountTimer.start()

func _on_hud_start_game():
	new_game()

func _on_player_hit():
	game_over()
