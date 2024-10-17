extends StaticBody2D

var win_height: int
var p_height: int
var win_width: int
var p_width: int

var hideTrue: bool

var domainActive: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	win_height = get_viewport_rect().size.y
	win_width = get_viewport_rect().size.x
	p_height = $NormalColorRect.get_size().y
	p_width = $NormalColorRect.get_size().x
	hideTrue = false
	domainActive = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	renderDomain()
	
	if Input.is_action_pressed("ui_up"):
		position.y -= get_parent().PADDLE_SPEED * delta
	elif Input.is_action_pressed("ui_down"):
		position.y += get_parent().PADDLE_SPEED * delta
	elif Input.is_action_pressed("ui_left"):
		if int($"../Hud/CPUScore".text) > 2:
			position.x -= 1600 * delta
	elif Input.is_action_pressed("ui_right"):
		if int($"../Hud/CPUScore".text) > 2:
			position.x += 700 * delta
		
	if Input.is_action_pressed("LeftDrift"): #a
		rotate(-10 * delta)
	elif Input.is_action_pressed("RightDrift"): #d
		rotate(10 * delta)
	elif Input.is_action_pressed("BigLeftDrift"): #q
		rotate(-100 * delta)
	elif Input.is_action_pressed("BigRightDrift"): #e
		rotate(100 * delta)
	elif Input.is_action_pressed("BiggerRightDrift"): #3
		rotate(1000 * delta)
	elif Input.is_action_pressed("BiggerLeftDrift"): #1
		rotate(-1000 * delta)
	elif Input.is_action_pressed("BiggestLeftDrift"): #Esc
		rotate(-5000 * delta)
	elif Input.is_action_pressed("BiggestRightDrift"): #F2
		rotate(5000 * delta)
	if Input.is_action_pressed("ResetDrift"): # S
		set_rotation(0)
	
	
	
	if Input.is_action_pressed("DomainExpansion"):
		if int($"../Hud/PlayerScore".text) > 2:
			domainActive = true
	if Input.is_action_just_released("DomainExpansion"):
		if int($"../Hud/PlayerScore".text) > 2:
			domainActive = false
	
	#limit paddle movement to window
	position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)
	position.x = clamp(position.x, p_width / 2, win_width - p_width / 2)

func renderDomain():
	if domainActive != true: # if domain is not active, render normally
		hideAllPieces()
		$NormalColorRect.show()
		$NormalCollisionShape2D.show()
		$NormalCollisionShape2D.set_disabled(false)
	else:
		hideAllPieces()
		
		$DomainColor1.show()
		$CollisionShape1.show()
		$CollisionShape1.set_disabled(false)
		
		$DomainColor2.show()
		$CollisionShape2.show()
		$CollisionShape2.set_disabled(false)
		
		$DomainColor3.show()
		$CollisionShape3.show()
		$CollisionShape3.set_disabled(false)
		
		$DomainColor4.show()
		$CollisionShape4.show()
		$CollisionShape4.set_disabled(false)



#ok, this func sucks because the way i bulit this isnt
#modular. its almost done though so i wont improve it.
#same thing with renderDomain()
func hideAllPieces():
	$NormalColorRect.hide()
	$NormalCollisionShape2D.hide()
	$NormalCollisionShape2D.set_disabled(true)
	
	$DomainColor1.hide()
	$CollisionShape1.hide()
	$CollisionShape1.set_disabled(true)
	
	$DomainColor2.hide()
	$CollisionShape2.hide()
	$CollisionShape2.set_disabled(true)
	
	$DomainColor3.hide()
	$CollisionShape3.hide()
	$CollisionShape3.set_disabled(true)
	
	$DomainColor4.hide()
	$CollisionShape4.hide()
	$CollisionShape4.set_disabled(true)
