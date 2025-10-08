@tool
extends DataResource
class_name GameStateData

@export var level_name: String = "New Level"
@export var player_start_position: Vector2 = Vector2.ZERO
@export var enemy_spawn_points: Array[Vector2] = []
@export var time_limit: float = 300.0
