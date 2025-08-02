class_name Character extends CharacterBody2D

@onready var dash_timer: Timer = $DashTimer
@onready var timestamp_timer: Timer = $TimestampTimer

const MAX_SPEED: float       = 100.0
const MAX_FALL_SPEED: float  = 200.0
const MAX_SPEED_BURST: float = 300.0
const MAX_SPEED_LERP: float  = 0.5

const FRICTION: float          = 1000.0
const ACCELERAION: float       = 300.0
const JUMP_ACCELERATION: float = 150.0
const DASH_ACCELERATION: float = 300.0
 
const MAXIMUM_NUMBER_OF_JUMPS: int = 2
const MAXIMUM_NUMBER_OF_DASHES: int = 1

const MAXIMUM_LOOP_TIME: int = 5
const LOOP_GRANULARITY: float = 0.05
const MAXIMUM_NUMBER_OF_TIMESTAMPS: int = int(float(MAXIMUM_LOOP_TIME) / 0.1)

var GRAVITY: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var current_max_speed = 0.0
var target_max_speed  = MAX_SPEED
var target_velocity: Vector2 = Vector2.ZERO
var direction: int = 0

var njumps: int = MAXIMUM_NUMBER_OF_JUMPS
var jump_timer: float = 0.0
var ndashes: int = MAXIMUM_NUMBER_OF_DASHES
var dashing: bool = false

var positions: Array[Vector2] = []
var current_timestamp: int = 0
var looping: bool = false

func _ready() -> void:
	timestamp_timer.start(LOOP_GRANULARITY)

func _process(delta: float) -> void:
	if Input.is_action_pressed("loop"):
		looping = true
	else:
		looping = false
		
func _physics_process(delta: float) -> void:
	if looping:
		return
		
	if is_on_floor():
		njumps = MAXIMUM_NUMBER_OF_JUMPS
		ndashes = MAXIMUM_NUMBER_OF_DASHES
	else:
		if not dashing:
			target_velocity.y += (GRAVITY * delta)
		
	direction = 0
	if Input.is_action_pressed("move_left"):
		direction = -1
	if Input.is_action_pressed("move_right"):
		direction = 1
	if Input.is_action_just_pressed("jump") and njumps > 0:
		njumps -= 1
		jump_timer = 0.0
	if Input.is_action_pressed("jump") and jump_timer < 0.25 and not dashing:
		target_velocity.y = -JUMP_ACCELERATION
		jump_timer += delta	
	if Input.is_action_just_pressed("dash") and ndashes > 0:
		current_max_speed = MAX_SPEED_BURST
		dashing = true
		ndashes -= 1
		dash_timer.start(0.25)
#
	current_max_speed = lerp(current_max_speed, target_max_speed, delta * MAX_SPEED_LERP)
				#
	target_velocity.x += direction * ACCELERAION * delta
	if dashing:
		target_velocity.x += (DASH_ACCELERATION if target_velocity.x > 0  else -DASH_ACCELERATION) * delta
		target_velocity.y = 0.0
		
	if (direction == 0 and is_on_floor()):
		target_velocity.x = move_toward(target_velocity.x, 0.0, FRICTION * delta)
		
	target_velocity.x = clamp(target_velocity.x, -current_max_speed, current_max_speed)
	target_velocity.y = clamp(target_velocity.y, -INF, MAX_FALL_SPEED)
	  
	velocity = target_velocity
	move_and_slide()

func _on_dash_timer_timeout() -> void:
	dashing = false
	target_velocity.x = move_toward(target_velocity.x, 0.0, 0.9)

func _on_timestamp_timer_timeout() -> void:
	if looping:
		var next_position = positions.pop_back()
		if next_position == null:
			looping = false
		else:
			position = next_position
	else:
		if (positions.size() >= MAXIMUM_NUMBER_OF_TIMESTAMPS):
			positions.pop_front()
		positions.push_back(position)
