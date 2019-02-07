extends CanvasLayer

signal start_game

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func show_message(text):
	get_node("MessageLabel").set_text(text)
	get_node("MessageLabel").show()
	get_node("MessageTimer").start()

func show_game_over():
	show_message("Game Over")
	yield(get_node("MessageTimer"), "timeout")
	get_node("MessageLabel").set_text("Dodge the\nCreeps!")
	get_node("MessageLabel").show()
	get_node("StartButton").show()
	#yield(get_node("StartTimer"), "timeout")
	#get_node("StartButton").show()
	#yield(get_tree().create_timer(1), "timeout") #SceneTree의 create_timer() 이건 안된다.

func update_score(score):
	get_node("ScoreLabel").set_text(str(score))

func _on_StartButton_pressed():
	get_node("StartButton").hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	get_node("MessageLabel").hide()