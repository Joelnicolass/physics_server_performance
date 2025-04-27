extends Sprite2D

# Physics Server variables
var object: RID;
var shape: RID;

@onready var color_rect: ColorRect = $ColorRect

@export var SPEED: float = 40.0
var can_move: bool = true
var target: Node2D

func _ready():
    # Physics Server initialization
    var ps := PhysicsServer2D
    object = ps.body_create()

    # Create a shape
    shape = PhysicsServer2D.rectangle_shape_create()
    # Set the shape radius
    PhysicsServer2D.shape_set_data(shape, Vector2(12, 12))
    # Add the shape to the body
    PhysicsServer2D.body_add_shape(object, shape)

    # Set body space
    # This is the space where the body will be active
    ps.body_set_space(object, get_world_2d().space)
    
    # Set transform
    var trans := Transform2D(0, global_position)
    ps.body_set_state(object, PhysicsServer2D.BODY_STATE_TRANSFORM, trans)
    
    # Set the body mode to Rigid
    ps.body_set_mode(object, PhysicsServer2D.BODY_MODE_RIGID_LINEAR)
    ps.body_set_param(object, PhysicsServer2D.BODY_PARAM_GRAVITY_SCALE, 0.0)

    target = get_tree().current_scene.get_node("Player")

    await get_tree().create_timer(0.2).timeout
    color_rect.color = Color(randf(), randf(), randf())
    color_rect.visible = true

func _physics_process(_delta):
    if can_move:
        # Move the body towards the target
        # Check if the target is set
        if target == null: return
        var dir: Vector2 = global_position.direction_to(target.position).normalized()
        PhysicsServer2D.body_set_state(object, PhysicsServer2D.BODY_STATE_LINEAR_VELOCITY, dir * SPEED)
    else:
        # Stop the body
        PhysicsServer2D.body_set_state(object, PhysicsServer2D.BODY_STATE_LINEAR_VELOCITY, Vector2.ZERO)

    # Update the position of the body
    var trans: Transform2D = PhysicsServer2D.body_get_state(object, PhysicsServer2D.BODY_STATE_TRANSFORM)
    global_transform = trans