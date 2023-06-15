extends Node2D

onready var text := $End
onready var player := $Player
onready var over := $Gameover
export(Textures) var sprite1_textures
export(Textures) var sprite2_textures

var min_sprite := 2
var max_sprite := 4

func ready():
	var amount_sprite := rand_range(min_sprite, max_sprite)
	for i in range(amount_sprite):
		spawn_sprite()
	over.hide()
	text.connect("body_entered", self, "_Finished_game")

func spawn_sprite():
	var sprite_type = rand_range(1, 2)
	var position = Vecto2()
	var area: Rect2
	var sprite_instance: sprite
	if sprite_type == 1:
		area = sprite1_area
		sprite_instance: Sprite.new()
		sprite_instance.texture = sprite1_textures
	else:
		area = sprite2_area
		sprite_instance = Sprite.new()
		sprite_instance.textures = sprite2_textures
		
	position.x = rand_range(area.position.x, area.position.x + area.size.x)
	position.y = rand_range(area.position.y, area.postion.y + area.size.y)
	
	add_child(sprite_instance)
	sprite_instance.position = position
	
func rand_range(min: float, max: float) -> float:
	return randf_range(min, max)
	
func finish_game():
	set_process(false)
	player.set_physics_process(false)
	over.show()
	
func _Finished_game(body: Node):
	if body.is_in_group("Player")
		finish_game()
	
