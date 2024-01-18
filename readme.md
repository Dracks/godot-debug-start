# Debug start menu
This module provides a simple debug start scene, that will allow to start any scene in your game, 
and automatically start the main scene when the start.json is not in the root of the project


## How to use it
1. Create an scene (I prefeer to add it in the root of your project) that inherits from start.tscn.
2. Set in the scene the main scene you wish as default for your game (usually the splash)
3. Add inside the vbox list one instance of start-debug-scene for every scene that you wish to have a shortcut.
4. Add an empty start.json file to enable the menu, I recommend to add the start.json into the gitignore, the way that everybody can have his custom config.


You must configure the export to don't include the start.json file, that way the app automatically will start to the default scene


## Json configurations
In the json you can do two different things:
1. Overwrite the default scene to be launched (pending to have some kind of timeout)
To do it, you should add a key in the json called start, that contains an string. 
This string can be a key pointing to the key of a button (defined in the scene start-debug-scene);
Or a path to an scene started with res://

2. Add more debug scenes. Adding the key shortcuts into the json, you will be able to add
custom buttons to the list, this key will be an object, on every property name will be transformed to 
the button key and contain another object with properties scene and name, which the first one must be 
a scene url with the prefix res:// and the second the name to be shown in the buttons
