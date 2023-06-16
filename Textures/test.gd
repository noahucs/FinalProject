extends Node2D



onready var text := $End
onready var player := $Player
onready var over := $Gameover
onready var Win := $End_Win
onready var text_win := $End_WinText
onready var gen = $Random_spot

var min_sprite := 2
var max_sprite := 4

func _ready():
	text.hide()
	text_win.hide()
	over.connect("body_entered", self, "_Finished_game")
	Win.connect("body_entered", self, "_Win_game")
	randomize()
	spawnSprite()
	
	
func spawnSprite():
	var numCopies = randi_range(mi_sprite, max_sprite)
	for i in range(numCopies):
		var spriteInstance = sprite.duplicate()
		add_child(spriteInstance)
		var position = Vector2(rand_range(area2d.rect_min.x, area2d.rect_max.x),
		rand_range(area2d.rect_min.y, area2d.rect_max.y))
		spriteInstance.position = position
	
func finish_game():
	set_process(false)
	player.set_physics_process(false)
	over.show()
	
func win_game():
	set_process(false)
	player.set_physics_process(false)
	text_win.show()
	
func _Win_game(body: PhysicsBody2D) -> void:
	if body.is_in_group("sprite"):
		win_game()
	
func _Finished_game(body: PhysicsBody2D) -> void:
	if body.is_in_group("sprite"):
		finish_game()
	
