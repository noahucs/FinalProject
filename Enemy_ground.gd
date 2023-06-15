extends KinematicBody2D
#animation frames for enemy, 28,29, 31,32,33. optional hit frames, 40-41


const speed := 100.0
#onready
var velocity := Vector2.ZERO
var sprite := $Ground
var Animation := $AnimationPlayer

func _physics_process(delta: float) -> void:
	Animation.play("Enemy_ani")
	var direction := Vector2.ZERO
	direction.x = speed if direction.x == 0 else -direction.x
	direction = move_and_slide(direction, Vector2.UP)
	if not is_on_floor():
		direction.x *= -1
