extends Node2D

onready var text := $End
onready var player := $Player
onready var over := $Gameover

func ready():
	text.connect("body_entered", self, "_Finished_game")

func finish_game():
	set_process(false)
	player.set_physics_process(false)
	
func _Finished_game(body: Node):
	finish_game()
	
		
