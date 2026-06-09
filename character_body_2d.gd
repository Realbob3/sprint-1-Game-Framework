extends CharacterBody2D
@onready var SpawnPoint: Node2D = $SpawnPoint


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var max_jumps = 2
var jumps_left = 0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jumps_left = max_jumps

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jumps_left > 0:
		velocity.y = JUMP_VELOCITY
		jumps_left -= 1
		
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


func _on_death_zone_body_entered(body: Node2D) -> void:
	# 'self' means this player script
	if body == self:
		respawn_player()

# 2. This resets the whole level flawlessly
func respawn_player() -> void:
	get_tree().reload_current_scene()


func _on_death_zone_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
