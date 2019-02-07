extends Node

export (PackedScene) var Mob
var score

func _ready():
	randomize()

func game_over():
	get_node("ScoreTimer").stop()
	get_node("MobTimer").stop()
	get_node("HUD").show_game_over()
	
func new_game():
	score = 0
	get_node("Player").start(get_node("StartPosition").get_pos())
	get_node("StartTimer").start()
	get_node("HUD").update_score(score)
	get_node("HUD").show_message("Get Ready")

func _on_MobTimer_timeout():
	get_node("MobPath/MobSpawnLocation").set_offset(randi())
	var mob = Mob.instance()
	add_child(mob)
	var direction = get_node("MobPath/MobSpawnLocation").get_rot()
	mob.set_pos(get_node("MobPath/MobSpawnLocation").get_pos())
	direction += rand_range(-PI/4, PI/4)
	mob.set_rot(direction)
	mob.set_linear_velocity(Vector2(rand_range(mob.min_speed, mob.max_speed), 0))
	mob.set_linear_velocity(mob.get_linear_velocity().rotated(direction))

func _on_ScoreTimer_timeout():
	score += 1
	get_node("HUD").update_score(score)

func _on_StartTimer_timeout():
	get_node("MobTimer").start()
	get_node("ScoreTimer").start()
