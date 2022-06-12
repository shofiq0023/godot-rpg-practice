extends KinematicBody2D

const ACCEL = 500;
const MAX_SPEED = 90;
const FRICTION = 500;

var velocity = Vector2.ZERO;
onready var _anim = $AnimationPlayer;
onready var _anim_tree = $AnimationTree;
onready var _anim_state = _anim_tree.get("parameters/playback");

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO;
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");
	input_vector = input_vector.normalized();
	
	if input_vector != Vector2.ZERO:
		_anim_tree.set("parameters/Idle/blend_position", input_vector);
		_anim_tree.set("parameters/Run/blend_position", input_vector);
		_anim_state.travel("Run");
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCEL * delta);
	else:
		_anim_state.travel("Idle");
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta);
	
	velocity = move_and_slide(velocity);
