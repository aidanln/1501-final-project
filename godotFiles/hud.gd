extends CanvasLayer

# notifies main that the start button was pressed
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	$HelpMessage.hide()
	$ScoreLabel.hide()

# generic message changer
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout
	$Message.show()

func show_escaped1(itemCount):
	if (itemCount < 3) :
		show_message("Good Job! You escaped through the main exit. However, you did not collect all of the keys.")
	else :
		show_message("Good Job! You escaped through the main exit while collecting all of the keys!")
	await get_tree().create_timer(5.0).timeout
	$Message.hide()

	# $Message.text = "Dodge the Creeps!"
	# $Message.show()
	# await get_tree().create_timer(1.0).timeout
	# $StartButton.show()
func show_escaped2(itemCount):
	if (itemCount < 3) :
		show_message("Good Job! You escaped through the side exit. However, you did not collect all of the keys.")
	else :
		show_message("Good Job! You escaped Through the side exit while collecting all of the keys!")
	await get_tree().create_timer(5.0).timeout
	$Message.hide()

func show_escaped3(_itemCount):
	show_message("Good Job! You escaped through the secret exit while collecting all of the keys and saving the cameraman!")
	await get_tree().create_timer(5.0).timeout
	$Message.hide()

func update_score(score):
	$ScoreLabel.text = str(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_start_button_pressed():
	$Menu/HBoxContainer/StartButton.hide()
	$Menu/HBoxContainer/HelpButton.hide()
	$Menu/HBoxContainer/QuitButton.hide()
	$HelpMessage.hide()
	$SubMessage.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()

func _on_help_button_pressed():
	$Message.hide()
	$HelpMessage.show()
	await get_tree().create_timer(10.0).timeout
	$Message.show()
	$HelpMessage.hide()

func _on_quit_button_pressed():
	get_tree().quit()
