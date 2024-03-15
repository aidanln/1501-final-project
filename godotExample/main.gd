extends Node

var score

# called when game starts
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # temporary

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# called when player hits a mob
func game_over():
	$ScoreTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$ScoreTimer.start()


