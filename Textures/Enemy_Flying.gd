extends KinematicBody2D
#animation frames for enemy, 28,29, 31,32,33. optional hit frames, 40-41

onready var line2d = $Line2D

export(int) var speed : int = 90
var velocity: Vector2 = Vector2.ZERO
onready var area := $Area2D
var path: Array = []
var levelNavigation: Navigation2D = null
var player = null
onready var Animation := $AnimationPlayer
onready var sprite := $Sprite

func _ready() -> void:
	area.connect("body_entered", self, "_on_Area2D_body_entered")
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
		
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]




func _on_Area2D_body_entered():
	line2d.global_position = Vector2.ZERO
	if player and levelNavigation:
		generate_path()
		navigate() 
	move()

func _physics_process(delta):
	line2d.global_position = Vector2.ZERO
	if player and levelNavigation:
		generate_path()
		navigate() 
	move()

func move():
	velocity = move_and_slide(velocity)
	Animation.play("Flying")
	
	
func navigate():
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * speed

		
	if global_position == path[0]:
		path.pop_front()
	
func generate_path():
	if levelNavigation != null and player != null:
		path = levelNavigation.get_simple_path(global_position, player.global_position, false)
		line2d.points = path
		
		
