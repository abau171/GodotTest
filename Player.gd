extends KinematicBody2D


var velocity = Vector2(0, 0)
const GRAVITY_ACCEL = 30

const WALK_ACCEL = 50
const WALK_DRAG = 0.9
const AIRWALK_ACCEL = 20
const AIRWALK_DRAG = 0.98

const JUMP_SPEED = 700
const WALLJUMP_HORIZ_SPEED = 400
const WALLJUMP_VERT_SPEED = 600


func _physics_process(delta):

	var hitting_left_wall = test_move(transform, Vector2.LEFT)
	var hitting_right_wall = test_move(transform, Vector2.RIGHT)

	velocity.x *= WALK_DRAG if is_on_floor() else AIRWALK_DRAG
	var horiz_accel = WALK_ACCEL if is_on_floor() else AIRWALK_ACCEL
	if Input.is_action_pressed("move_left"):
		velocity.x -= horiz_accel
	if Input.is_action_pressed("move_right"):
		velocity.x += horiz_accel

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -JUMP_SPEED
		elif hitting_left_wall:
			velocity = Vector2(WALLJUMP_HORIZ_SPEED, -WALLJUMP_VERT_SPEED)
		elif hitting_right_wall:
			velocity = Vector2(-WALLJUMP_HORIZ_SPEED, -WALLJUMP_VERT_SPEED)
	velocity.y += GRAVITY_ACCEL

	velocity = move_and_slide(velocity, Vector2.UP)
