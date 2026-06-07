extends CharacterBody2D
@onready var Player_Character: CharacterBody2D = $Player_Character
@onready var SpawnPoint: Node2D = $SpawnPoint


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	# Pushing logic
	for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			
			# Check if what we hit is a RigidBody2D
			if collider is RigidBody2D:
				# Calculate the direction of the push (usually horizontal)
				var push_dir = -collision.get_normal()
				
				# Apply the force to the block at the point of impact
				# The '100.0' is the strength of your push
				collider.apply_central_impulse(push_dir * 100.0)


func _on_death_zone_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
# Check if the object that fell into the zone is actually the player
	if body == Player_Character:
		respawn_player()

func respawn_player() -> void:
	# 1. Reset the player's position to the spawn point
	Player_Character.global_position = SpawnPoint.global_position
	
	# 2. Reset the player's velocity so they don't keep falling instantly
	Player_Character.velocity = Vector2.ZERO
