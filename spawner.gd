extends Node2D

@export var max_spawn: int = 10000
@export var spawn_interval: float = 0.1
@export var spawn_item: PackedScene

var spawn_timer: Timer
var spawn_count: int = 0

func _ready():
    spawn_timer = Timer.new()
    spawn_timer.wait_time = spawn_interval
    spawn_timer.connect("timeout", _on_spawn_timer_timeout)
    add_child(spawn_timer)
    spawn_timer.start()

func _on_spawn_timer_timeout():
    if spawn_count < max_spawn:
        var item = spawn_item.instantiate()
        add_child(item)
        item.position = Vector2(randf_range(-200, 200), randf_range(-200, 200))
        spawn_count += 1
    else:
        spawn_timer.stop()