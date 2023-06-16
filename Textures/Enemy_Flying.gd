extends KinematicBody2D
#animation frames for enemy, 28,29, 31,32,33. optional hit frames, 40-41


export(int) var speed : int = 90
var velocity: Vector2 = Vector2.ZERO
var path: Array = []
var levelNavigation: Navigation2D = null
var player = null
onready var Animation := $AnimationPlayer
onready var danger := $Danger
onready var time := $Timer


const projectile = preload('res://Enemy_projectile.tscn')

func _ready() -> void:
	Animation.play("Flying")
	danger.connect("body_entered", self, "detection_radius")
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
		
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]
		
	time.connect("timeout", self, "new_pathfinding")
	var bodies = get_slide_collision_count()
	for i in range(bodies):
		var body = get_slide_collision(i).collider
		if body.is_in_group("deletable"):
			queue_free() 


func new_pathfinding():
	if player and levelNavigation:
		generate_path()
		navigate() 
	move()

func move():
	velocity = move_and_slide(velocity)
	
	
func navigate():
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * speed

	if global_position == path[0]:
		path.pop_front()
	
func generate_path():
	if levelNavigation != null and player != null:
		path = levelNavigation.get_simple_path(global_position, player.global_position, false)
		
func detection_radius():
	time.start()
