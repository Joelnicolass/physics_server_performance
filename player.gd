extends Node2D

@export var SPEED: float = 50.0

func _physics_process(delta):
    var dir: Vector2 = global_position.direction_to(get_global_mouse_position()).normalized()
    global_position += dir * SPEED * delta