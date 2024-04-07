extends Node

var score

# called when game starts
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_start_message("Escape the Mansion!")
	$MenuMusic.stop()
	$MainMusic.play()
	$PlayArea.show()
	$Path2D.set_process(true)
	$CanvasLayer.show()
	$SFXTimer.start()
	$Player.show()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayArea.hide()
	$Path2D.set_process(false)
	$CanvasLayer.hide()
	$MenuMusic.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# called when player hits the butler or they win
func game_over():
	$ScoreTimer.stop()
	#$HUD.show_game_over()
	$MainMusic.stop()
	$MenuMusic.play()
	$PlayArea.hide()
	$CanvasLayer.hide()
	$StartTimer.stop()
	$SFXTimer.stop()
	$Path2D.set_process(false)
	get_tree().quit()



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
		$HUD.show_escaped1(itemCount)
		$MainMusic.stop()
		$PlayArea.hide()
		$Path2D.set_process(false)
		$ur_winnar.play()
		$Player.can_move = 0
		await get_tree().create_timer(5.0).timeout
		game_over()
	else:
		$HUD.show_message("You need at least 2 keys first!")
	
func _on_escape_2_area_entered(_area:Area2D):
	var itemCount = 0
	for item in $Player.inventory.inventory:
		if (item != null):
			itemCount += 1
		$ScoreTimer.stop()
		$HUD.show_escaped2(itemCount)
		$MainMusic.stop()
		$PlayArea.hide()
		$Path2D.set_process(false)
		$ur_winnar.play()
		$Player.can_move = 0
		await get_tree().create_timer(5.0).timeout
		game_over()

func _on_escape_3_area_entered(_area:Area2D):
	var itemCount = 0
	for item in $Player.inventory.inventory:
		if (item != null):
			itemCount += 1
		$ScoreTimer.stop()
		$HUD.show_escaped3(itemCount)
		$MainMusic.stop()
		$PlayArea.hide()
		$Path2D.set_process(false)
		$ur_winnar.play()
		$Player.can_move = 0
		await get_tree().create_timer(5.0).timeout
		game_over()

func _on_sfx_timer_timeout():
	var i = randi_range(1, 6)
	if (i == 1) :
		$Player/cameraman.play()
	if (i == 2) :
		$Player/hungry.play()
	if (i == 3) :
		$Player/imissmymom.play()
	if (i == 4) :
		$Player/leave.play()
	if (i == 5) :
		$Player/whatwasthat.play()
	if (i == 6) :
		$Player/whereami.play()

func _on_lock_key_3_area_entered(_area):
	if ($Player.inventory.inventory[1] != null) :
		$LockKey3/LockKey3Sprite.hide()
		$LockKey3/LockKey3Hitbox2.queue_free()
		$LockKey3PlayerCollision/LockKey3Hitbox.set_deferred("disabled", true)

func _on_lock_camerman_area_entered(_area):
	if ($Player.inventory.inventory[2] != null) :
		$LockCamerman/LockCamermanSprite.hide()
		$LockCamerman/LockCameramanHitbox2.queue_free()
		$LockCameramanPlayerCollision/LockCameramanHitbox.set_deferred("disabled", true)

# if escape is clicked, close the game (its fullscreen so this is needed)
func _input(_event):
	if Input.is_action_pressed("quit_game"):
		get_tree().quit()
