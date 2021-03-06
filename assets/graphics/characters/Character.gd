extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var path

onready var sprite = $Sprite
onready var animal = $AnimationPlayer
onready var tween = $Tween
onready var label = $Label

var turn :=0
var cname = 'player'
var next_pos
var step_size = Vector2(32,32)
var direction = Vector2(0,1) 
var directions = {	"down":Vector2.DOWN,
					"up":Vector2.UP,
					"left":Vector2.LEFT,
					"right":Vector2.RIGHT,
					"left_up":Vector2.LEFT+Vector2.UP,
					"left_down":Vector2.LEFT+Vector2.DOWN,
					"right_up":Vector2.RIGHT+Vector2.UP,
					"right_down":Vector2.RIGHT+Vector2.DOWN}
					
var input_keys = {
	'down':Vector2.DOWN,
	'up':Vector2.UP,
	'left':Vector2.LEFT,
	'right':Vector2.RIGHT
}					

var is_dead = false
				
var state = "idle"
var dir = "up" # down
var is_idle = true # 空闲时才能接收指令。 与动画播放相对。
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = load(path)
	pass # Replace with function body.

func _process(delta):
	key_input()
	label.text = str(turn)
	if Input.is_action_just_pressed("space") :
		is_dead = true
		print_debug("space" + str(is_dead))
	pass


func key_input():
	if tween.is_active() :
		return
	for dir in input_keys:
		if Input.is_action_pressed(dir):
			move(dir)	

#	pass
func get_next_pos(direction:Vector2):
	return self.position + direction*step_size


func move(dir:String):
	turn = turn + 1
	var direction = directions[dir]
	tween.interpolate_property(self,"position",self.position,get_next_pos(direction),0.3,Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.start()
	animal.play("move_" + dir)
	
func attack(dir:String):
	turn + 2
		
