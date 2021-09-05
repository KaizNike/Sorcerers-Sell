extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var paths = {"decay": 0, "life": 0, "reaction": 0, "meta": 0, "death": 5, "solar": 0}
var empowered_paths = {"decay": 0, "life": 0, "reaction": 0, "meta": 0, "death": 5, "solar": 0}
var stats = {"health": 65, "sanity": 66, "hunger": 35}
# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("spend_mana", self, "_spend_mana")
	_update_paths()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _update_paths():
	$MPVSplit0/DecayStat.text = str(paths.decay)
	$MPVSplit1/LifeStat.text = str(paths.life)
	$MPVSplit2/ReactionStat.text = str(paths.reaction)
	$MPVSplit3/MetaStat.text = str(paths.meta)
	$MPVSplit4/DeathStat.text = str(paths.death)
	$MPVSplit5/SolarStat.text = str(paths.solar)


func _spend_mana(type, amt):
	match type:
		"decay":
			pass
		"life":
			pass
		"reaction":
			pass
		"meta":
			pass
		"death":
			if (paths.death - amt) > -1:
				paths.death -= amt
				_update_paths()
				Signals.emit_signal("mana_spent_check", true)
				return
			pass
		"solar":
			pass
	Signals.emit_signal("mana_spent_check", false)
	pass
