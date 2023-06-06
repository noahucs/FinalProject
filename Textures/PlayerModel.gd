extends KinematicBody2D

const DIRECTION_TO_FRAME := {
	Vector2.DOWN: 0,
	Vector2.RIGHT: 2,
	Vector2.UP: 4,
}

onready var sprite := $Sprite
export var movement_speed := 150.0
var velocity := Vector2.ZERO

export var jump_height : float = 45.0
export var jump_max_height : float = 0.5
export var jump_min_height : float = 0.4

onready var jump_speed : float = (2.0 * jump_height) / jump_max_height * -1.0
onready var jump_gravity : float = (-2.0 * jump_height) / (jump_max_height * jump_max_height) * -1.0
onready var jump_fall_gravity : float = (-2.0 * jump_height) / (jump_min_height * jump_min_height) * -1.0

const fireball = preload('res://Textures/Projectile.tscn')

func _physics_process(delta: float) -> void:
	velocity.y += get_gravity() * delta
	velocity.x = get_input_velocity() * movement_speed
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		jump()
	if Input.is_action_just_pressed("Shoot"):
		proj()

	velocity + move_and_slide(velocity, Vector2.UP) 
	
	$Sprite/Node2D.look_at(get_global_mouse_position())
	

	
	
func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else jump_fall_gravity
	
func jump():
	velocity.y = jump_speed
	
	
func get_input_velocity() -> float:
	var horizontal := 0.0
	
	if Input.is_action_pressed("move_left"):
		horizontal -= 1.0
		sprite.flip_h = true
	if Input.is_action_pressed("move_right"):
		horizontal += 1.0
		sprite.flip_h = false
	return horizontal
	
func proj():
	var projectile = fireball.instance()
	
	get_parent().add_child(projectile)
	projectile.position = $Sprite/Node2D/Position2D.global_position 
	
	projectile.velocity = get_global_mouse_position() - projectile.position

