@tool
extends Node

# This is a placeholder for DataPoll functionality.
# Add your manager logic here.

func _ready():
	if Engine.is_editor_hint():
		print("DataPoll is ready in editor.")
	else:
		print("DataPoll is ready in game.")
