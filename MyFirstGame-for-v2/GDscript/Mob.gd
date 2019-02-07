extends RigidBody2D

export var min_speed = 150
export var max_speed = 250
var mob_types = ["walk", "swim", "fly"]

func _ready():
	get_node("AnimatedSprite").set_animation(mob_types[randi()%mob_types.size()])

func _on_Visibility_exit_screen():
	queue_free()