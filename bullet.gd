extends Area2D

const SPEED: float = 800.0
var dir: Vector2 = Vector2.RIGHT
var timer: Timer

func _ready():
    timer = Timer.new()
    timer.wait_time = 0.5
    timer.connect("timeout", _on_timer_timeout)
    add_child(timer)
    timer.start()


func _physics_process(delta):
    position += dir * SPEED * delta


func _on_body_entered(body: Node2D) -> void:
    if body.has_method("die"):
        body.call("die")
    queue_free()


func _on_timer_timeout():
    queue_free()
