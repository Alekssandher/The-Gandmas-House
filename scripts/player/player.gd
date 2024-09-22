extends CharacterBody3D


@export_category("Settings Player")

@export var speed: Int = 3
@export var  jumpForce: Float = 4.5


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

@export_category("Settings Footsteps")
@export var footstepAudio: AudioStreamPlayer3D
@export var footstepsTimer: Timer
@export var footstepsTimerRunning: Timer
var cameraTween: Tween

var collision
var grounded: Bool = false
var moving: Bool
var running: Bool
var canRegenStammina: Bool
var canRun: Bool = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity := ProjectSettings.get_setting("physics/3d/default_gravity")
var camVertical := 0
var initialRotation: Vector3

var mouseVisibility: Bool

#Obiovisily?
var input_dir
var direction
#Positions for shake
var x
var y
var z
var i

func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#GameManager.gameOver = false
	
	initialRotation = camera.rotation_degrees
	
#Camera move and mouse Input 
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouseSensitivity))
	
		camVertical -= event.relative.y * mouseSensitivity
		camVertical = clamp(camVertical, cameraLimitDown, cameraLimitUp)
		
		$head/vertical.rotation_degrees.x = camVertical
		
	if Input.is_action_just_pressed("esc") and !mouseVisibility:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mouseVisibility = true
		
	elif Input.is_action_just_pressed("esc") and mouseVisibility:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		mouseVisibility = false
	
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
		
	
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpForce
	
	
	#Func to run
	run()
	checkCollision()
	checkStammina()
	cameraShake()
	
	input_dir = Input.get_vector("left", "right", "up", "down")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		footsteps()
		moving = true
		
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		camera.position = Vector3(0, 0, 0)
		moving = false

	move_and_slide()

func checkCollision():
	pass

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
		speed = 5
		recoveryTimer.stop()
		if !running:
			stamminaTimer.start()
		running = true
		
	else:
		speed = 3
		
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
		
func footsteps():
	if running and canRun:
		if !is_on_floor(): return
		if footstepsTimer.time_left <= 0:
			footstepAudio.pitch_scale = randf_range(0.8, 1.2)
			footstepAudio.play()
			footstepsTimer.start(0.3)
			animateCameraTween(1)
			
	else:
		if !is_on_floor(): return
		if footstepsTimer.time_left <= 0:
			footstepAudio.pitch_scale = randf_range(0.8, 1.2)
			footstepAudio.play()
			footstepsTimer.start(0.65)
			
func animateCameraTween(check):
	cameraTween = get_tree().create_tween()
	if check == 1:
		cameraTween.tween_property(camera, "position", Vector3(0, randf_range(0, 0.2), 0), 0.1)
	elif check == 2:
		cameraTween.tween_property(camera, "position", Vector3(0, randf_range(0, 0.2), 0), 0.4)
