extends CharacterBody3D


@export_category("Settings Player")

@export var speed = 5
@export var  jumpForce = 4.5

@export_category("Settings Camera")
@export var mouseSensitivity := 0.2
@export var cameraLimitDown := -80.0
@export var cameraLimitUp := 60.0
@export var camera: Camera3D
@export var shakeFixTimer: Timer

@export_category("Settings Stammina Bar")
@export var progressBarControl: ProgressBar
@export var stamminaTimer: Timer
@export var recoveryTimer: Timer

var moving
var running
var canRegenStammina
var canRun = true
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var camVertical := 0
var initialRotation: Vector3

#Obiovisily?
var input_dir
var direction
#Positions for shake
var x
var y
var z


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#GameManager.gameOver = false
	
	initialRotation = camera.rotation_degrees
	
#Rotação da camera 
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouseSensitivity))
	
		camVertical -= event.relative.y * mouseSensitivity
		camVertical = clamp(camVertical, cameraLimitDown, cameraLimitUp)
		
		$head/vertical.rotation_degrees.x = camVertical
		
	if Input.is_action_just_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
		
	
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpForce
		
		
	# Get the input direction and handle the movement/deceleration.
	
	#explosion test
	#if Input.is_action_just_pressed("leftClick"):
		#ExplosionManager.activeShake = true
		#shakeFixTimer.start()
		#
	#Func to run
	run()
	checkStammina()
	cameraShake()
	input_dir = Input.get_vector("left", "right", "up", "down")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		moving = true
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		moving = false

	move_and_slide()
	

func cameraShake():
	if ExplosionManager.activeShake == true:
		x = randf_range(-1.5, 1.7)
		y = randf_range(-1.5, 1.7)
		z = randf_range(-1.5, 1.7)
		camera.rotation_degrees = Vector3(x, y, z)
		shakeFixTimer.start()
		
#shake play by time configs
	#elif ExplosionManager.activeShake == false:
		#shakeFixTimer.stop()
	#
	#
#func _on_timer_timeout():
	#
	#camera.rotation_degrees = initialRotation
	#ExplosionManager.activeShake = false


#func _on_area_3d_area_entered(area):
	#if area.is_in_group("initialExplosionArea"):
		#shakeFixTimer.start()
func run():
	if Input.is_action_pressed("shift") and canRun and moving:
		progressBarControl.show()
		if !canRun: return
		speed = 10
		recoveryTimer.stop()
		if !running:
			stamminaTimer.start()
		running = true
		
	else:
		speed = 5
		
	if Input.is_action_just_released("shift"):
		stamminaTimer.stop()
		canRegenStammina = true

		if canRegenStammina:
			recoveryTimer.start()
		
		running = false
func checkStammina():
	if progressBarControl.value == 0:
		canRun = false
		
	if progressBarControl.value == 100:
		progressBarControl.hide()
		canRegenStammina = true
		canRun = true
		
