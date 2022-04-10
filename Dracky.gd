extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var canFire = true
export (PackedScene) var EnemyBullet

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.playing = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	#TODO - break this off into a different class so some Dracky divebomb and some target
	#var result = space_state.intersect_ray(Vector2(position.x, position.y), Vector2(position.x, 10000),[], 0b1)
	#print(get_node("./Player").position.x)
	#if result:
	#	shoot_Player()

#TODO - break this off into a different class so some Dracky divebomb and some target
#"shoots" itself at player once
#func shoot_Player():
#	if canFire == true:
#		apply_central_impulse(Vector2(0,200))
#		canFire = false



func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		print("hit player")
		print(body)
		#body.queue_free()
		body.queue_free()
		queue_free()


func _on_Area2D2_body_entered(body):
	if canFire:
		$AnimatedSprite.animation = 'attack'
		var aim = (body.position - self.position)
		apply_central_impulse(Vector2(aim))
		canFire = false
		
