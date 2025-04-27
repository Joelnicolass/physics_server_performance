extends Area2D

var timer: Timer


func _ready():
    timer = Timer.new()
    timer.wait_time = 0.5
    timer.connect("timeout", _on_timer_timeout)
    add_child(timer)
    timer.start()


func fire(dir: Vector2):
    var bullet = preload("res://bullet.tscn").instantiate()
    bullet.global_position = global_position
    bullet.dir = dir
    get_tree().current_scene.add_child(bullet)
    

func _on_timer_timeout():
    var dir: Vector2 = Vector2.RIGHT
    var near_bodies: Array[Node2D] = get_overlapping_bodies()
    if not near_bodies.is_empty():
        var target = near_bodies.front()
    
        # Check if the target is a valid body
        if target.has_method("die"):
            # Set direction to the target
            dir = global_position.direction_to(target.global_position).normalized()
    
    fire(dir)
