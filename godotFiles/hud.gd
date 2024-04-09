extends CanvasLayer

# notifies main that the start button was pressed
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	$HelpMessage.hide()
	$ScoreLabel.hide()
	$EndingMessage.hide()
	$EscToQuit.hide()
	$Exposition.hide()
	$Jumpscare.hide()
	$Black.hide()

# generic message changer
func show_message(text):
	$Message.text = text
	$Message.show()
	#$MessageTimer.start()

func show_exposition():
	$Exposition.show()
	await get_tree().create_timer(7.0).timeout
	$Exposition.hide()

func show_ending_message(text):
	$EndingMessage.text = text
	$EndingMessage.show()
	#$MessageTimer.start()

func show_start_message(text):
	$Message.text = text
	$Message.show()
	await get_tree().create_timer(7.0).timeout
	$Message.hide()

# generic sub-message changer
func show_sub_message(text):
	$SubMessage.text = text
	$SubMessage.show()
	$SubMessageTimer.start()

# generic sub-message changer
func show_sub_message_no_timer(text):
	$SubMessage.text = text
	$SubMessage.show()

func show_game_over():
	show_message("Game Over")
	await get_tree().create_timer(5.0).timeout
	#$Message.show()

# handles top of screen escape
func show_escaped1(itemCount):
	show_ending_message("You collected all three keys and unlocked a passage leading... somewhere. You descended a ladder until reaching solid ground. It was pitch black darkness, but you walked along a path, holding your hand against the bumpy and damp wall, until you tripped over the first steps of a staircase. Regaining your balance, you crawled up the steps until you were once again in the moonlight. You can go home now. No need to think about anything else. Nothing matters besides the life you've built and will continue to lead. To glory.")
	$EscToQuit.show()
	# $Message.text = "Dodge the Creeps!"
	# $Message.show()
	# await get_tree().create_timer(1.0).timeout
	# $StartButton.show()

# handles side exit escape
func show_escaped2(itemCount):
	#if (itemCount < 3):
		#show_message("Good Job! You escaped through the side exit. However, you did not collect all of the keys.")
	#else:
	show_ending_message("You found what seemed to be an exit. A ladder led down a hole in the floor. It was pitch black, but you stumbled your way down, feeling for each rung below you before stepping. Once at the bottom, you took a look around. But you can't see very far in front of you... in fact, with your hand outstretched, you can feel a wall. There are walls on all four sides with no room to take a step in any direction. You start to scramble your way back up the hole, but you hear the sound of metal grinding upon metal. It couldn't be. You clamber up faster until you reach the top, but it's too late. There's no way out. You waste away all your strength trying to find or create some sort of opening. But it's no use. Your energy gone, you fall back down to the bottom. There's no way out.")
	$EscToQuit.show()
# handles cameraman escape
func show_escaped3(_itemCount):
	show_ending_message("You collected the keys needed, and yet something tugged at your mind. You'd always put yourself first. Through everything. And yet there was always someone who stuck it through with you. Your best friend. The one behind the scenes during the entirety of your career on ViewTube. He stands in front of you now, saying in a choked up voice, 'I knew you would come back for me. The exit's right here-- I've been waiting for you.' It's so clear now. None of it would've been worth it without the days spent working by his side, laughing at the dumb jokes you made together. You apologize for taking him for granted. And the two of you leave the mansion alive, evidence of something sinister in hand. Everything is going to be alright.")
	$EscToQuit.show()
# useless function cuz score is irrelevant
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

# hides the main message after a certain amount of time
func _on_message_timer_timeout():
	$Message.hide()

# hides the sub message after a certain amount of time
func _on_sub_message_timer_timeout():
	$SubMessage.hide()

func _on_help_button_pressed():
	$Message.hide()
	$HelpMessage.show()

func _on_quit_button_pressed():
	get_tree().quit()
