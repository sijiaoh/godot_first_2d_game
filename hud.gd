extends CanvasLayer

signal start_game

var initial_message

func _ready():
	initial_message = $MessageLabel.text

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")

	await $MessageTimer.timeout

	$MessageLabel.text = initial_message
	$MessageLabel.show()

	await get_tree().create_timer(1.0).timeout
	$GameStartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_message_timer_timeout():
	$MessageLabel.hide()

func _on_game_start_button_pressed():
	$GameStartButton.hide()
	$ScoreLabel.show()
	$MessageLabel.hide()
	start_game.emit()
