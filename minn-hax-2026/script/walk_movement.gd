extends CharacterBody3D

@export var playerRoot: Node3D

var walkSpeed = 4
var runSpeed = 8
var speed = walkSpeed

const gravity = 20
const jump_height = 2

const small = 0.01

var cameraY
var agentFortyJeffM

# Tracks player rotation to set Idle facing direction
var previous_rotation = 0

# Capture mouse when game launches
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	agentFortyJeffM = playerRoot.get_node("agentFortyJeffM")
	cameraY = playerRoot.get_node("CameraY")

func toggleActive(active: bool):
	$CollisionShape3D.set_disabled(not active)
	agentFortyJeffM.rotation.x = 0
	agentFortyJeffM.rotation.z = 0

# Called on every physics frame
func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if not playerRoot.useWalkMovement:
		return
	
	var forward = -1 * cameraY.get_global_transform().basis.z
	var right = cameraY.get_global_transform().basis.x

	# Increase speed when shift is held
	if Input.is_action_pressed("run"):
		speed = runSpeed
		agentFortyJeffM.setSpeed(3)
	else:
		speed = walkSpeed
		agentFortyJeffM.setSpeed(1.8)

	# Add up current player direction based on input 
	if Input.is_action_pressed("right"):
		direction += right

	if Input.is_action_pressed("left"):
		direction += -1 * right

	if Input.is_action_pressed("back"):
		direction += -1 * forward

	if Input.is_action_pressed("forward"):
		direction += forward

	# Gravity
	if !is_on_floor():
		velocity.y -= gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = sqrt(2.0 * gravity * jump_height)

	var dir = direction.normalized()
	var target_rotation = atan2(dir.x, dir.z) + PI
	if dir.length() < small:
		target_rotation = previous_rotation
		agentFortyJeffM.playAnimation("Idle")
	else:
		agentFortyJeffM.playAnimation("RunAction")
	previous_rotation = target_rotation
	agentFortyJeffM.rotation.y = lerp_angle(
		agentFortyJeffM.rotation.y,
		target_rotation,
		10.0 * delta
	)
	velocity.x = dir.x * speed
	velocity.z = dir.z * speed

	# Move the player while respecting physics bounds
	move_and_slide()
