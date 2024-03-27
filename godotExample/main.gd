extends Node

var score

# called when game starts
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Escape the Mansion!")
	$Music.play()
	$PlayArea.show()
	$Path2D.set_process(true)
	$CanvasLayer.show()
	$SFXTimer.start()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayArea.hide()
	$Path2D.set_process(false)
	$CanvasLayer.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# called when player hits a mob
func game_over():
	$ScoreTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$PlayArea.hide()
	$Path2D.set_process(false)
	$CanvasLayer.hide()

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$ScoreTimer.start()
	
# called when player hits the escape ladder outside
func _on_escape_area_entered(_area:Area2D) :
	$ScoreTimer.stop()
	$HUD.show_escaped()
	$Music.stop()
	$PlayArea.hide()
	$Path2D.set_process(false)
	$CanvasLayer.hide()


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
