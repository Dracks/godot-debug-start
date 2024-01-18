extends Button

class_name StartDebugScene;

# The scene the button will point
@export var scene : PackedScene
# This key is used in the start.json to reference to an specific scene easily
@export var key: String

func _ready():
	assert(scene != null, 'scene is mandatory to work')
	self.pressed.connect(func(): start_scene())
	
	if key == null:
		print("Warning: Key not provided for `{}` Button".format(text))


func start_scene() -> void:
	var error = get_tree().change_scene_to_packed(scene)
	if error:
		print('Error ({}) loading main scene'.format(error))
