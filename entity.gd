extends Sprite2D

# Physics Server variables
var object: RID;
var shape: RID;

@onready var color_rect: ColorRect = $ColorRect

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

    await get_tree().create_timer(0.2).timeout
    color_rect.color = Color(randf(), randf(), randf())
    color_rect.visible = true

func _physics_process(_delta):
    # Update the position of the body
    var trans: Transform2D = PhysicsServer2D.body_get_state(object, PhysicsServer2D.BODY_STATE_TRANSFORM)
    global_transform = trans