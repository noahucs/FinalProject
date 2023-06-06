extends KinematicBody2D

var velocity = Vector2(0, 1)

var speed := 500.0

func _physics_process(delta):
	move_and_collide(velocity.normalized()* delta * speed)
