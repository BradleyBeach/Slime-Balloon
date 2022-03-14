extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var canFire = true
export (PackedScene) var Bullet
export (PackedScene) var MuzzleFlash
export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_just_pressed("fire"):
		fire()
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func fire():
	if canFire == true:
		#muzzleflash
		var muz = MuzzleFlash.instance()
		add_child(muz)
		muz.transform = $Muzzle.transform
		muz.set_scale(Vector2(.1, .1))
		
		#bullet
		var b = Bullet.instance()
		owner.add_child(b)
		b.transform = $Muzzle.global_transform
		canFire = false
		get_node("CanFireAgainTimer").start()
		#owner.add_child(b) #if we just added child, bullet moves with player, so add to world
		#b.transform = $Muzzle.global_transform

func _on_CanFireAgainTimer_timeout():
	canFire = true

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
