extends CharacterBody3D

@export var WALK_SPEED: float = 3.0
@export var SPRINT_SPEED: float = 6.0
@export var JUMP_VELOCITY: float = 4.8
@export var SENSITIVITY: float = 0.003
@export var gravity: float = 9.8

var base_camera_position: Vector3 = Vector3.ZERO

# Nodes (adjust paths if your scene differs)
@onready var head: Node3D = $CameraRig
@onready var camera: Camera3D = $CameraRig/Camera3D
@onready var raycast: RayCast3D = $CameraRig/Camera3D/RayCast3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	base_camera_position = camera.position
	if raycast:
		raycast.enabled = true
	add_to_group("player")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# yaw on head, pitch on camera
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))

	if event.is_action_pressed("interact"):
		_interact()
		
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _physics_process(delta: float) -> void:
	# Input -> world direction relative to head's facing
	var input_vec: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var forward: Vector3 = head.global_transform.basis.z
	var right: Vector3 = head.global_transform.basis.x
	var move_dir: Vector3 = (right * input_vec.x + forward * input_vec.y)
	if move_dir.length() > 0.0:
		move_dir = move_dir.normalized()

	# Choose speed
	var target_speed: float = WALK_SPEED
	if Input.is_action_pressed("sprint"):
		target_speed = SPRINT_SPEED

	var desired: Vector3 = move_dir * target_speed
	velocity.x = desired.x
	velocity.z = desired.z
	velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	move_and_slide()

func _interact() -> void:
	if raycast and raycast.is_colliding():
		var target = raycast.get_collider()
		if target and target.has_method("interact"):
			target.interact()
