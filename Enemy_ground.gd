extends KinematicBody2D
#animation frames for enemy, 28,29, 31,32,33. optional hit frames, 40-41


export var speed = 20.0
export var platform_distance = 5.0

#onready
var velocity := Vector2.ZERO
var sprite := $Ground
var Animation := $AnimationPlayer

func _physics_process(delta: float) -> void:
	Animation.play("Enemy_ani")
	velocity.x = speed * get_direction()
	var collision = move_and_collide()
	var bodies = get_slide_collision_count()
	for i in range(bodies):
		var body = get_slide_collision(i).collider
		if body.is_in_group("deletable"):
			queue_free()
	if collision:
		speed *= -1

func get_direction() -> int:
	var direction = 1
	if position.x < platform_distance:
		direction = 1
		sprite.flip_h = false
	elif position.x > (get_viewport_rect().size.x - platform_distance):
		direciton = -1 
		sprite.flip_h = true
	return direction
