extends CharacterBody3D


@export_category("Settings Player")

@export var defaultSpeed: float = 2
@export var  jumpForce: float = 3.5
@export var runningSpeed: float = 5
var speed: float = defaultSpeed

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
@export var talkTimer: Timer

@export var animationPlayer: AnimationPlayer

var cameraTween: Tween

var collision: bool
var grounded: bool = false
var moving: bool
var running: bool
var canRegenStammina: bool
var canRun: bool = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var camVertical := 0
var initialRotation: Vector3

var mouseVisibility: bool
var screenMode: bool

#Obiovisily?
var input_dir := Vector2(0, 0)
var direction := Vector3(0, 0, 0)

#Positions for shake
var x: float = 0.0
var y: float = 0.0
var z: float = 0.0

var lookedAtCar := false
var lookBlocked := false
func _ready() -> void:
	
	animationPlayer.play("transitionIn")
	
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
		
	if Input.is_action_just_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if !mouseVisibility else Input.MOUSE_MODE_CAPTURED)
		mouseVisibility = !mouseVisibility
	
	if Input.is_action_just_pressed("f11"):
		if DisplayServer.window_get_mode() == DisplayServer.WindowMode.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)
		
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
		
	

func _physics_process(delta: float) -> void:
	
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

func checkCollision() -> void:
	pass

func cameraShake() -> void:
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
func run() -> void:
	if Input.is_action_pressed("shift") and canRun and moving:
		progressBarControl.show()
		if !canRun: return
		speed = runningSpeed
		recoveryTimer.stop()
		if !running:
			stamminaTimer.start()
		running = true
		
	else:
		speed = defaultSpeed
		
	if Input.is_action_just_released("shift"):
		stamminaTimer.stop()
		canRegenStammina = true

		if canRegenStammina:
			recoveryTimer.start()
		
		running = false
func checkStammina() -> void:
	if progressBarControl.value == 0:
		canRun = false
		
	if progressBarControl.value == 100:
		progressBarControl.hide()
		canRegenStammina = true
		canRun = true
		
func footsteps() -> void:
	if running and canRun:
		if !is_on_floor(): return
		if footstepsTimer.time_left <= 0:
			footstepAudio.pitch_scale = randf_range(0.8, 1.2)
			footstepAudio.play()
			footstepsTimer.start(0.3)
			animateCameraTween()
			
	else:
		if !is_on_floor(): return
		if footstepsTimer.time_left <= 0:
			footstepAudio.pitch_scale = randf_range(0.8, 1.2)
			footstepAudio.play()
			footstepsTimer.start(0.75)
			
func animateCameraTween() -> void:
	cameraTween = get_tree().create_tween()
	
	cameraTween.tween_property(camera, "position", Vector3(0, 0.1, 0), 0.1)
	cameraTween.tween_property(camera, "position", Vector3(0, 0, 0), 0.1)
	

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("interactable"):
		print("interactable")


func _on_area_3d_area_exited(area: Area3D) -> void:
	pass # Replace with function body.


func _on_long_view_area_entered(area: Area3D) -> void:
	
	if lookedAtCar or lookBlocked: return
	
	if area.is_in_group("car"):
		await World.typingEffect("Is that my grandma's car?", 0.1, 2)
		lookedAtCar = true


func _on_long_view_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"): return
	lookBlocked = true
	


func _on_long_view_body_exited(body: Node3D) -> void:
	lookBlocked = false


func _on_timer_timeout() -> void:
	await World.typingEffect("Here I am, following what an unknown voice says.", 0.1, 1.5)
	#await World.typingEffect("Let's see where it takes me.", 0.1, 1.5)
	#await World.typingEffect("They said It was a huge, old house... somewhere around here", 0.1, 1.5)
