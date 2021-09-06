extends RigidBody2D



# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var drag_enabled = false

export var speed = 75
var card_type = "raven"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)
#	print(layer)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	pass
		

var layer = get_collision_layer()
var dragging = false
var drag_start = Vector2()

func _input(event):
#	if event.is_action_pressed("click") and not dragging:
#		dragging = true
#		drag_start = get_global_mouse_position()
	if event.is_action_released("click") and dragging:
		dragging = false
		var drag_end = get_global_mouse_position()
		var dir = drag_start - drag_end
		apply_impulse(Vector2(), -dir * 1 * speed)
		
func _input_event(viewport, event, shape_idx):
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT and event.pressed:
#			print("clicked")
	if event.is_action_pressed("click"):
#		print("Dragging")
		dragging = true
		_change_layer(2)
		drag_start = get_global_mouse_position()
	elif event.is_action_pressed("right_click"):
		_change_layer(layer * 2)

func _change_layer(Layer):
	if Layer > 16:
		_change_layer(16)
		return
	match Layer:
		2:
			collision_layer = 2
			collision_mask = 2
			modulate = Color(1,1,1,1)
			z_index = 0
		4:
			collision_layer = 4
			collision_mask = 4
			modulate = Color(0.9,0.9,0.9,1)
			z_index = -1
		8:
			collision_layer = 8
			collision_mask = 8
			modulate = Color(0.8,0.8,0.8,1)
			z_index = -2
		16:
			collision_layer = 16
			collision_mask = 16
			modulate = Color(0.7,0.7,0.7,1)
			z_index = -3
			
	layer = collision_layer
#	print(collision_mask)
		
