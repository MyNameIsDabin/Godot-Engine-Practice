extends Area2D
signal hit

export var speed = 400
var screensize

func start(pos):
	set_pos(pos)
	show()
	get_node("CollisionShape2D").call_deferred("set_disabled", false)

func _ready():
	screensize = get_viewport_rect().size
	hide()
	set_process(true)

func _process(delta):
	var AnimatedSprite = get_node("AnimatedSprite")
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		AnimatedSprite.play()
	else:
		AnimatedSprite.stop()

	set_pos(get_pos() + velocity * delta)
	set_pos(Vector2(
			clamp(get_pos().x, 0, screensize.x),
			clamp(get_pos().y, 0, screensize.y)))
			
	if velocity.x != 0:
		AnimatedSprite.set_animation("right")
		AnimatedSprite.set_flip_v(false)
		AnimatedSprite.set_flip_h(velocity.x < 0)
	elif velocity.y != 0:
		AnimatedSprite.set_animation("up")
		AnimatedSprite.set_flip_v(velocity.y > 0)

func _on_Player_body_enter(body):
	hide()
	emit_signal("hit")
	get_node("CollisionShape2D").call_deferred("set_disabled", true)