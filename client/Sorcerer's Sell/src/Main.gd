extends Node

var version = [0,0,4]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_show_version()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func _show_version():
	$UI/BotRight/BRVBox/VersionContainer/VersionLabel.text = "v" + str(version[0]) + "." + str(version[1]) + "." + str(version[2])
	pass
