extends KinematicBody2D


const DIRECTION_TO_FRAME := {
	Vector2.DOWN: 0,
	Vector2.RIGHT: 2,
	Vector2.UP: 4,
}


#const DIRECTION_TO_FRAME := {
#	Vector2.DOWN: 0,
#	Vector2.DOWN + Vector2.RIGHT: 1,
#	Vector2.RIGHT: 2,
#	Vector2.UP + Vector2.RIGHT: 3,
#	Vector2.UP: 4,
#}


var drag_factor := 0.13
var velocity := Vector2.ZERO

onready var sprite := $Sprite
const Vf := 100.0
const Vi := 0.0
const Gravity := 150.0

const SPEED := 390.0
func _physics_process(delta: float) -> void:
	#Basic Movement
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var gravity := delta * Gravity
	var desired_velocity := SPEED * direction
	var steering_vector := desired_velocity - velocity
	velocity += steering_vector * drag_factor
	velocity = move_and_slide(velocity)
	var direction_key := direction.round()
	direction_key.x = abs(direction_key.x)
	
	#flip for model
	if direction_key in DIRECTION_TO_FRAME:
		sprite.frame = DIRECTION_TO_FRAME[direction_key]
		sprite.flip_h = sign(direction.x) == -1
	#Physics for moving up.
	
	
