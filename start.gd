extends Control

class_name Start

const FILE_NAME="res://start.json"

@export var default_scene : PackedScene

@onready var shortcuts_list : VBoxContainer = $Panel/ScrollContainer/Shortcuts

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(default_scene != null, 'default scene is mandatory to work')
	
	var doFileExists = FileAccess.file_exists(FILE_NAME)
	if doFileExists:
		var file := FileAccess.open(FILE_NAME, FileAccess.READ)
		if file.get_error():
			print("Error ({}) loading start.json".format(file.get_error()))
			start_default()
		else:
			var test_json_conv := JSON.new()
			var error := test_json_conv.parse(file.get_as_text())
			if error:
				print("Error {} parsing start.json: \n{}\n{}".format([error, test_json_conv.get_error_line(), test_json_conv.get_error_message()]))
				start_default()
			else:
				var config :Dictionary= test_json_conv.get_data()
				process_config(config)
	else:
		start_default()


func process_config(config: Dictionary) -> void:
	process_config_shortcuts(config.get('shortcuts', {}))
	var children := shortcuts_list.get_children()
	
	process_json_default_scene(config.get('start', 'default'))
	
	if shortcuts_list.get_child_count() == 0:
		start_default()

func process_config_shortcuts(shortcuts: Dictionary) -> void:
	
	for key in shortcuts.keys():
		var info = shortcuts.get(key, {})
		var scene_resource = info.get('scene')
		var button := StartDebugScene.new()
		button.text = info.get('name')
		button.scene = load(scene_resource)
		button.key = key
		button.anchor_left = 0
		button.anchor_right = 1
		shortcuts_list.add_child(button)

func process_json_default_scene(start_config: String) -> void:
	if start_config != 'default':
		var shortcuts_buttons :Array[StartDebugScene] = shortcuts_list.get_children().filter(func (child): child is StartDebugScene)
		var shortcuts := shortcuts_buttons.map(func (child): child.key)
		if start_config.begins_with('res://'):
			default_scene = load(start_config)
		elif start_config not in shortcuts:
			print('Invalid startConfig ${startConfig}, ignoring it')
		else: 
			var new_default_scene :StartDebugScene= shortcuts_buttons.filter(func (child): child.key == start_config)[0]
			default_scene = new_default_scene.scene


func start_default():
	print('Starting default scene')
	var error = get_tree().change_scene_to_packed(default_scene)
	if error:
		print('Error ({}) loading main scene'.format(error))
		
func start_game(data: Dictionary):
	pass
