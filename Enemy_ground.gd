extends KinematicBody2D
#animation frames for enemy, 28,29, 31,32,33. optional hit frames, 40-41


const speed := 250.0
onready var timer := $Walk_Left
onready var timers := $Walk_Right
onready var velocity := Vector2.ZERO
onready var sprite := $Ground
onready var Animation := $AnimationPlayer

func _physics_process(delta: float) -> void:
	var direction := Vector2.ZERO
	if is_on_floor():
		direction.x = 1.0
		move_and_slide(direction)
		sprite.flip_h = true
		Animation.play("Enemy_ani")
	else:
		direction.x = -1.0
		move_and_slide(direction)
		sprite.flip_h = false
		Animation.play("Enemy_ani")
