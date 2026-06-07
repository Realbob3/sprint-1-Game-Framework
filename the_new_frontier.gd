extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Get references to our nodes
@onready var Player_Character: CharacterBody2D = $Player_Character
@onready var SpawnPoint: Node2D = $SpawnPoint

func _on_killzone_body_entered(body: Node2D) -> void:
	print("Something fell in the zone: ", body.name)
	# Check if the object that fell into the zone is actually the player
	if body == Player_Character:
		print("It was the player! Respawning...")
		respawn_player()

func respawn_player() -> void:
	# 1. Reset the player's position to the spawn point
	Player_Character.global_position = SpawnPoint.global_position
	
	# 2. Reset the player's velocity so they don't keep falling instantly
	Player_Character.velocity = Vector2.ZERO
