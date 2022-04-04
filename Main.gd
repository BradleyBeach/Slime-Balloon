extends Node

export(PackedScene) var mob_scene
export(PackedScene) var mob_scene_2
var score
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
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
	mob_spawn_location.offset = rng.randi()
	
	#pick which and adding it
	var which_mob = rng.randi_range(1,2)
	var mob
	if which_mob == 1:
		mob = mob_scene.instance()
		add_child(mob)
	if which_mob == 2:
		mob = mob_scene_2.instance()
		add_child(mob)
	
	#sending it off
	mob.position = mob_spawn_location.position
	var velocity = Vector2(rand_range(150, 250), 0.0)
	mob.linear_velocity = -velocity


func _on_StartTimer_timeout():
	$MobTimer.start()
