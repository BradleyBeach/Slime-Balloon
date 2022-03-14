extends Area2D

var speed = -500

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_EnemyBullet_body_entered(body):
	print(body.get_name())
	if body.is_in_group("player"):
		print("hit player")
		print(body)
		#body.queue_free()
		body.queue_free()
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
