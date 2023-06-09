extends Area2D
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
onready var danger := $Danger
onready var time := $Timer
var target: PhysicsBody2D = null
var target_list := [] 
onready var point := $Sprite/Node2D/Position2D
export(float, 0.01, 1)var rotation_factor := 0.4

const projectile = preload('res://Enemy_projectile.tscn')

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "on_body_exited")
	time.connect("timeout", self, "_on_Timer_timeout")
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
		
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]


func _physics_process(delta):
	line2d.global_position = Vector2.ZERO
	if player and levelNavigation:
		generate_path()
		navigate() 
	#move()

	
func rotate_angle():
	var target_angle := PI / 2
	if target:
		target_angle = target.global_position.angle_to_point(global_position)
	sprite.rotation = lerp_angle(sprite.rotation, target_angle, rotation_factor)

func selection() -> void:
	if target_list:
		target = target_list[0]
	else:
		target = null
		
func _on_body_entered(body: Node) -> void:
	target_list.append(body)
	selection()
		
func _on_body_exited(body: Node) -> void:
	var index := target_list.find(body)
	target_list.remove(index)
	selection()
	
func _on_Timer_timeout() -> void:
	if not target_list:
		return
	var projectile := preload("res://Enemy_projectile.tscn").instance()
	add_child(projectile)
	projectile.global_transform = point.global_transform

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
		
		
