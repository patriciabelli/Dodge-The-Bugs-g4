extends Node2D

@export var bug_scene : PackedScene

var score
@onready var hud: CanvasLayer = $HUD
@onready var bug_timer: Timer = $BugTimer
@onready var score_timer: Timer = $ScoreTimer
@onready var start_timer: Timer = $StartTimer
@onready var player: Area2D = $player
@onready var start_position: Marker2D = $StartPosition
@onready var bug_path_location: PathFollow2D = $BugPath/BugPathLocation
@onready var bg_music: AudioStreamPlayer = $BgMusic
@onready var game_over_sound: AudioStreamPlayer2D = $GameOverSound

func game_over() -> void:
	bug_timer.stop()
	score_timer.stop()
	hud.show_game_over()
	bg_music.stop()
	game_over_sound.play()
	
func new_game():
	start_timer.start()
	player.start_pos(start_position.position)
	score = 0
	hud.update_score(score)
	hud.show_message("Get Ready!")
	get_tree().call_group("bugs", "queue_free")
	bg_music.play()

func _on_score_timer_timeout() -> void:
	score += 1
	hud.update_score(score)

func _on_start_timer_timeout() -> void:
	bug_timer.start()
	score_timer.start()

func _on_bug_timer_timeout() -> void:
	var bug = bug_scene.instantiate()
	var bug_location = bug_path_location
	bug_location.progress_ratio = randf()
	
	
	var direction = bug_location.rotation + PI / 2
	bug.position = bug_location.position
	direction += randf_range(-PI / 4, PI / 4)
	bug.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	bug.linear_velocity = velocity.rotated(direction)
	add_child(bug)
