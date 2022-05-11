extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var GRAVITY = 20
const UP = Vector2(0,-1)
export var MAXFALLSPEED=1000;
export var MAXSPEED=200;
const JUMPFORCE=500	
var motion =Vector2();
var faceRight=true;
var canAirJump;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!is_on_floor()):
		motion.y+=GRAVITY
		if(motion.y>MAXFALLSPEED):
			motion.y=MAXFALLSPEED
#	print(motion.y)
	
	
	if(Input.is_action_pressed("ui_right")):
		motion.x=MAXSPEED
		$AnimatedSprite.play("Walking")
		if(!faceRight):
			faceRight=true
			$AnimatedSprite.flip_h=!$AnimatedSprite.flip_h;
	elif(Input.is_action_pressed("ui_left")):
		motion.x=-MAXSPEED
		$AnimatedSprite.play("Walking")
		if(faceRight):
			faceRight=false
			$AnimatedSprite.flip_h=!$AnimatedSprite.flip_h;
		
		
	else:
		motion.x=0
		$AnimatedSprite.play("Idle")
		
	if is_on_floor():
		if(Input.is_action_just_pressed	("ui_up")):
			motion.y=-JUMPFORCE;
			canAirJump=true;
			print(canAirJump)
			print("first")
	elif(canAirJump):
		if(Input.is_action_just_pressed("ui_up")):
			motion.y=-JUMPFORCE;
			canAirJump=false
			print("second")
	
	if(Input.is_action_just_released("ui_page_down")):
		$AnimatedSprite/Explosion6.visible=true
		$AnimatedSprite/Explosion6.play("default")
#
#
			
	move_and_slide(motion,UP)
	
