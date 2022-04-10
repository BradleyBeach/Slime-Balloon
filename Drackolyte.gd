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
	var result = space_state.intersect_ray(Vector2(position.x, position.y), Vector2(-10000, position.y),[], 0b1)
	#print(get_node("./Player").position.x)
	if result:
		shoot_Player()

func shoot_Player():
	if canFire == true:
		$AnimatedSprite.animation = "attack"
		var b = EnemyBullet.instance()
		get_parent().add_child(b)
		b.transform = $EnemyMuzzle.global_transform
		canFire = false
		get_node("CanFireAgainTimer").start()
		#owner.add_child(b) #if we just added child, bullet moves with player, so add to world
		#b.transform = $Muzzle.global_transform

func _on_CanFireAgainTimer_timeout():
	canFire = true


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		print("hit player")
		print(body)
		#body.queue_free()
		body.queue_free()
		queue_free()


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == 'attack':
		$AnimatedSprite.animation = 'default'
		print("back to quiet")
