extends Spatial

func _ready():
	$Panel.hide()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().reload_current_scene()

func _on_Area_body_entered(body):
	if body is RigidBody:
		$Panel.show()
