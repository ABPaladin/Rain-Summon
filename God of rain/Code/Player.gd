extends CharacterBody2D

@export var SPEED : int = 200
@export var GRAVITY : int = 500
@export var JUMP_FORCE : int = 255
@onready var player = $player
var currenHealth: int = 4 

@onready var ananas = $"../ananas"
@onready var bone = $"../bone"
@onready var sea = $"../sea"

@onready var boneItem = $"Control/items/Bone-Selector/Bone"
@onready var seaItem = $"Control/items/Sea-Selector/Sea"
@onready var ananasItem = $"Control/items/Ananas-Selector/Pineapple"

@onready var heart = $Control/Container/Heart
@onready var heart_2 = $Control/Container/Heart2
@onready var heart_3 = $Control/Container/Heart3

@onready var end_book = $"../End-Book"
@onready var collision_shape_2d = $"../End-Book/CollisionShape2D"


@onready var timer = $Timer
@onready var progress_bar = $Control/Timer/Label/ProgressBar




@export var items = []

func show_timer():
	if timer:
		var time = timer.get_time_left()  # Get the time left on the timer
		print(time)
		progress_bar.value = time
	else:
		print("Timer node is not initialized or not found.")

func _physics_process(delta):
	show_timer()
	var direction = Input.get_axis("Left","Right")
	if direction:
		velocity.x = direction * SPEED
		player.play("run")
	else:
		velocity.x = 0
		player.play("idle")
	
	if direction == 1:
		player.flip_h = false
	elif direction == -1:
		player.flip_h = true
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		if velocity.y > 0:
			player.play("fall")
		
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		player.play("jump")
		velocity.y -= JUMP_FORCE
	move_and_slide()

func check_win_condition():
	if items.size() == 3:
		end_book.visible = true
		collision_shape_2d.set_deferred("disabled", false)
		print(collision_shape_2d.disabled)
		print("bookcreated")

func _on_death_area_area_entered(area):
	SceneTransition.change_scene_to_file("res://Scenes/End.tscn")

func _on_hurtbox_area_entered(area):
	if area.name == "hitbox":
		currenHealth -= 1
		print(currenHealth)
		player.play("hit")
	if currenHealth == 2:
		heart_3.visible = false
		player.play("hit")
	elif currenHealth == 1:
		heart_2.visible = false
		player.play("hit")
	elif currenHealth == 0: 
		heart.visible = false
		SceneTransition.change_scene_to_file("res://Scenes/End.tscn")
		print_debug(area.get_parent().name)
		

func _on_items_area_entered(area):
	if area == ananas:
		items.append("ananas")
		ananas.queue_free()
		ananasItem.visible = true
		print("ananas")
		print(items.size())
	elif area == bone:
		items.append("bone")
		bone.queue_free()
		boneItem.visible = true
		print("bone")
		print(items.size())
	elif area == sea:
		items.append("sea")
		sea.queue_free()
		seaItem.visible = true
		print("sea")
		print(items.size())
		check_win_condition()
	
var hasCollided = false
func _on_hitbox_area_entered(area):
	if area.name == "hurtbox":
		var collidedObject = area.get_parent()
		if collidedObject != self:
			print_debug(collidedObject.name)
			collidedObject.queue_free()
			velocity.y -= JUMP_FORCE

func _on_end_book_area_entered(area):
	SceneTransition.change_scene_to_file("res://Scenes/WinScene.tscn")


func _on_timer_timeout():
	SceneTransition.change_scene_to_file("res://Scenes/End.tscn")
