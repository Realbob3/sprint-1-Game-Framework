extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

@onready var player: CharacterBody2D = $Player
@onready var spawn_point: Node2D = $SpawnPoint

func _on_deathzone_body_entered(body: Node2D) -> void:
	# Check if the object that fell into the zone is actually the player
	if body == player:
		respawn_player()

func respawn_player() -> void:
	# Reset the player's position to the spawn point
	player.global_position = spawn_point.global_position
	
	# Reset the player's velocity so they don't keep falling instantly
	player.velocity = Vector2.ZERO
