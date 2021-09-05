extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	pass


func _on_CardCapture_body_entered(body):
	if body.is_in_group("card"):
		print(true)
		if "card_type" in body:
			if _card_check(body.card_type):
				body.queue_free()
				print("Card gone!")


func _card_check(type) -> bool:
	match type:
		"raven":
			if _mana_check("death", 1):
				Signals.emit_signal("log_this", "Raven flies.")
				return true
			else:
				Signals.emit_signal("log_this", "Lacking death.")
				return false
	return false

func _mana_check(type, amt) -> bool:
	Signals.emit_signal("spend_mana", type, amt)
	var check = yield(Signals, "mana_spent_check")
	if check:
		return true
	else:
		return false
