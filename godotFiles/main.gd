extends Node

var score

# called when game starts
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_start_message("Escape the Mansion!")
	$HUD.show_exposition()
	$Player.can_move = 1
	$Player/Scream.play()
	$MenuMusic.stop()
	$MainMusic.play()
	$PlayArea.show()
	$Path2D.set_process(true)
	$CanvasLayer.show()
	$SFXTimer.start()
	$Player.show()
	$Path2D/PathFollow2D/Mob.spawn_butler()

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayArea.hide()
	$Path2D.set_process(false)
	$CanvasLayer.hide()
	$MenuMusic.play()
	$Player.can_move = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# called when player hits the butler or they win
func game_over():
	$HUD/SubMessage.hide()
	AudioServer.set_bus_mute(2, true)
	$ScoreTimer.stop()
	#$HUD.show_game_over()
	$MainMusic.stop()
	$MenuMusic.play()
	$PlayArea.hide()
	$StartTimer.stop()
	$SFXTimer.stop()
	$Path2D.set_process(false)

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$ScoreTimer.start()

# called when player hits the escape ladder outside
func _on_escape_area_entered(_area:Area2D):
	var itemCount = 0
	# get amount of items in the inventory
	for item in $Player.inventory.inventory:
		if (item != null):
			itemCount += 1
	if (itemCount > 1):
		$ScoreTimer.stop()
		$Player.can_move = 0
		$HUD.show_escaped1(itemCount)
		$MainMusic.stop()
		$PlayArea.hide()
		$CanvasLayer.hide()
		$Path2D.set_process(false)
		$ur_winnar.play()
		$HUD/Black.show()
		$CanvasLayer/Control.hide()
		await get_tree().create_timer(3.0).timeout
		game_over()
	else:
		$HUD.show_sub_message("You need at least 2 keys first!")
	
func _on_escape_2_area_entered(_area:Area2D):
	var itemCount = 0
	for item in $Player.inventory.inventory:
		if (item != null):
			itemCount += 1
		$ScoreTimer.stop()
		$Player.can_move = 0
		$HUD.show_escaped2(itemCount)
		$MainMusic.stop()
		$PlayArea.hide()
		$Path2D.set_process(false)
		$ur_winnar.play()
		$HUD/Black.show()
		$CanvasLayer/Control.hide()
		await get_tree().create_timer(3.0).timeout
		game_over()

func _on_escape_3_area_entered(_area:Area2D):
	var itemCount = 0
	for item in $Player.inventory.inventory:
		if (item != null):
			itemCount += 1
		$ScoreTimer.stop()
		$Player.can_move = 0
		$HUD.show_escaped3(itemCount)
		$MainMusic.stop()
		$PlayArea.hide()
		$Path2D.set_process(false)
		$ur_winnar.play()
		$HUD/Black.show()
		$CanvasLayer/Control.hide()
		await get_tree().create_timer(3.0).timeout
		game_over()

# handle the random voiceline
func _on_sfx_timer_timeout():
	var i = randi_range(1, 6)
	if (i == 1) :
		$Player/cameraman.play()
		$HUD.show_sub_message_no_timer('You: "This stupid cameraman, what an idiot! Now I have to go back and look for him in the terribly scary place..."')
		# custom timer cuz this line is very long
		await get_tree().create_timer(10.0).timeout
		$HUD/SubMessage.hide()
	if (i == 2) :
		$Player/hungry.play()
		$HUD.show_sub_message('You: "Im hungry."')
	if (i == 3) :
		$Player/imissmymom.play()
		$HUD.show_sub_message('You: "God I miss my mom!"')
	if (i == 4) :
		$Player/leave.play()
		$HUD.show_sub_message_no_timer('You: "Man this place really sucks, I really just want to leave!"')
		# custom timer cuz this line is very long
		await get_tree().create_timer(3.0).timeout
		$HUD/SubMessage.hide()
	if (i == 5) :
		$Player/whatwasthat.play()
		$HUD.show_sub_message_no_timer('You: "Shoot, what was that? Did I hear something?"')
		# custom timer cuz this line is very long
		await get_tree().create_timer(3.0).timeout
		$HUD/SubMessage.hide()
	if (i == 6) :
		$Player/whereami.play()
		$HUD.show_sub_message('You: "Man, I am REALLY lost, where am I?"')

func _on_lock_key_3_area_entered(_area):
	if ($Player.inventory.inventory[1] != null):
		$LockKey3/LockKey3Sprite.hide()
		$LockKey3/DoorSprite.hide()
		$LockKey3/LockKey3Hitbox2.queue_free()
		$LockKey3PlayerCollision/LockKey3Hitbox.set_deferred("disabled", true)
	else:
		$HUD.show_sub_message("Locked. Looks like you need 2 keys to open this door...")

func _on_lock_key_2_area_entered(_area:Area2D):
	if ($Player.inventory.inventory[0] != null) :
		$LockKey2/LockKey2Sprite.hide()
		$LockKey2/DoorSprite3.hide()
		$LockKey2/LockKey2Hitbox2.queue_free()
		$LockKey2PlayerCollision2/LockKey2Hitbox.set_deferred("disabled", true)
	else:
		$HUD.show_sub_message("Locked. Looks like you need a key to open this door...")

func _on_lock_camerman_area_entered(_area):
	if ($Player.inventory.inventory[2] != null):
		$LockCamerman/LockCamermanSprite.hide()
		$LockCamerman/DoorSprite2.hide()
		$LockCamerman/LockCameramanHitbox2.queue_free()
		$LockCameramanPlayerCollision/LockCameramanHitbox.set_deferred("disabled", true)
	else:
		$HUD.show_sub_message("Locked. Looks like you need 3 keys to open this door...")

# if escape is clicked, close the game (its fullscreen so this is needed)
func _input(_event):
	if Input.is_action_pressed("quit_game"):
		get_tree().quit()

# called if player gets within mob detection radius
func _on_player_detected():
	$HUD.show_start_message("GAME OVER!") # replace with actual jumpscare
	$HUD/Jumpscare.show()
	$HUD/Black.show()
	$CanvasLayer/Control.hide()
	AudioServer.set_bus_mute(2, true)
	$Player/Jumpscare.play()
	$Path2D/PathFollow2D/Mob.speed = 0
	$Player.can_move = 0
	$HUD/SubMessage.queue_free()
	await get_tree().create_timer(6.0).timeout
	get_tree().quit()
