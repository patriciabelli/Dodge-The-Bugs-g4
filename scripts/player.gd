extends Area2D

signal hit

const SPEED := 400

@onready var screen_size = get_viewport_rect().size
@onready var anim: AnimatedSprite2D = $anim
@onready var collision: CollisionShape2D = $collision

func _ready() -> void:
	hide()

 
func _process(delta: float) -> void:
	var veloccity = Input.get_vector("move_left", "move_right","move_up", "move_down")

	if veloccity.length() > 0:
		veloccity = veloccity.normalized() * SPEED
		
	if veloccity.x != 0:
		anim.play("move")
	elif veloccity.y > 0:
		anim.play("move_up")
	elif veloccity.y < 0:
		anim.play("move_down")
	else:
		anim.play("idle")
		
	anim.flip_h = true if veloccity.x > 0 else false
	
	position += veloccity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
		

#verificação da colisão do player com os Bugs
func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	collision.set_deferred("disabled", true)
	
func  start_pos(pos):
	position = pos
	show()
	collision.disabled = false
	
