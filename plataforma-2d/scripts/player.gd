extends CharacterBody2D


const SPEED: float = 150.0 
const JUMP_FORCE: float = -350.0

# onready para esperar o node ser carregado
@onready var animation: AnimatedSprite2D = $Animate

var is_jumping: bool = false


# função principal com o jogo rodando.
func _physics_process(delta: float) -> void:
	if not is_on_floor(): # Verifica se não colide com o chão para aplicar gravidade
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor(): # Pular
		velocity.y = JUMP_FORCE
		is_jumping = true
	elif is_on_floor():
		is_jumping = false

	var direction := Input.get_axis("ui_left", "ui_right") # Movimento 
	if direction:
		velocity.x = direction * SPEED
		animation.scale.x = direction
		if !is_jumping:
			animation.play('run') # Faz o flip da sprite para a posição de movimento
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play('idle')
	if is_jumping:
		animation.play('jump')

	move_and_slide()
