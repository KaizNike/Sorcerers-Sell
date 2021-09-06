extends Node

var version = [0,0,6] # Gameplay


onready var statsVBox = $UI/PanelContainer/StatVBox
onready var cardSpawn = $CardArea/Cards
export(PackedScene) var card
var paths = {"decay": 0, "life": 0, "reaction": 0, "meta": 0, "death": 0, "solar": 0}
var empowered_paths = {"decay": 0, "life": 0, "reaction": 0, "meta": 0, "death": 0, "solar": 0}
var stats = {"health": 100, "sanity": 100, "hunger": 0}
var gold = 0
var visibleBeasts = []
var unhandledBeasts = []
var beast = {'type': "", 'owner': 0}

var progressStarted = false
var progress = 0 setget _progress_change
var progressRate = 2
var progressState = 0

var multChecked = false
# Called when the node enters the scene tree for the first time.
func _ready():
	self.progress = 2
	_show_version()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if progressStarted:
		self.progress += progressRate * delta

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func _show_version():
	$UI/BotRight/BRVBox/VersionContainer/VersionLabel.text = "v" + str(version[0]) + "." + str(version[1]) + "." + str(version[2])
	pass


func _progress_change(val):
	if val > 99.999:
		progress = 0
		progressStarted = false
		_progress_finished()
	else:
		progress = val
	$UI/PanelContainer/StatVBox/Time.value = progress
	

func _progress_finished():
	match progressState:
		0:
			print("You get a card!")
			_spawn_card("deathhand")
			
	for stat in empowered_paths:
		var firstStat = empowered_paths.get(stat)
		var secondStat = paths.get(stat)
		if firstStat > secondStat:
			match stat:
				"death":
					paths.death += 1
			_update_paths()
	pass

func _update_paths():
	statsVBox.paths = paths
	statsVBox.update_paths()


func _update_stats():
	statsVBox.stats = stats
	statsVBox.update_stats()

func _spawn_card(type):
	var Card = card.instance()
	Card.card_type = type
	cardSpawn.add_child(Card)


func _card_check(type) -> bool:
	match type:
		"raven":
			if _mana_check("death", 1):
				Signals.emit_signal("log_this", "Raven flies.")
				return true
			else:
				Signals.emit_signal("log_this", "Lacking death.")
				return false
		"deathhand":
			stats.sanity -= 5
			_update_stats()
			empowered_paths.death += 1
			statsVBox.empowered_paths = empowered_paths
			_update_paths()
			return true
	return false

func _mana_check(type, amt) -> bool:
	if _spend_mana(type, amt):
		return true
	else:
		return false


func _add_path(type,amt):
	
	pass

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
				return true
		"solar":
			pass
	return false


func _on_CardCapture_body_entered(body):
	if body.is_in_group("card"):
#		print(true)
		if "card_type" in body:
			if _card_check(body.card_type):
				body.queue_free()
				print("Card gone!")


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		Signals.emit_signal("log_this", "You ponder.")
		if progressStarted:
			self.progress += 20
		else:
			progressStarted = true
	pass # Replace with function body.


func _on_PingButton_pressed():
	if not multChecked:
		Signals.emit_signal("log_this", "Not implemented! Maybe in v0.1!")
		multChecked = true
	pass # Replace with function body.
