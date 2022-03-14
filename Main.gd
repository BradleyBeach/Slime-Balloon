extends Node

export(PackedScene) var mob_scene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func game_over():
	$MobTimer.stop()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	


func _on_MobTimer_timeout():
	#picking where on path to spawn them
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()
	
	#adding it
	var mob = mob_scene.instance()
	add_child(mob)
	
	#sending it off
	mob.position = mob_spawn_location.position
	var velocity = Vector2(rand_range(150, 250), 0.0)
	mob.linear_velocity = -velocity


func _on_StartTimer_timeout():
	$MobTimer.start()
