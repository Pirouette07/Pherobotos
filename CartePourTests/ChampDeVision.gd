@tool
extends Camera3D

# réglages par défaut du zoom (propriété fov (Field Of View - Champ De Vision)
@export var fov_ident: float = 5.0
@export var fov_min: float = 10.0
@export var fov_max: float = 120.0
@export var fov_rotation: float = 0.005
@export var fov_pan: float = 0.01

var rotating: bool = false
var last_mouse_pos: Vector2

## cible caméra pour effet de ciblage d'un objet
#export var vitesse ciblage := 5.0
#var cible_courante: Node3D

func _ready():
	print(self.name, " _ready")

	make_current()
	if Engine.is_editor_hint():
		global_position = Vector3(150, 150, 150)
		look_at(Vector3.ZERO, Vector3.UP)
		fov = 60

## Définit la cible de la caméra lors de la sélection d'un objet
#func set_CibleCamera(objet_selectionne: Node3D) :
#	cible_courante = objet_selectionne
#
## Suit l'objet ciblé de manière progressive (Lerp)
#func _process(delta: float):
#	if cible_courante:
#		global_position = global_position.lerp(
#			cible_courante.global_position + Vector3(0, 10, -10),
#			vitesse ciblage * delta
#		)
#	look_at(cible_courante.global_position, Vector3.UP)

func _input(event):
	print (self.name, " ", event.as_text())
#	$SpotSelection.visible = not $SpotSelection.visible 
#	print ($SpotSelection.visible)
	# Zoom molette
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			fov = max(fov_min, fov - fov_ident)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			fov = min(fov_max, fov + fov_ident)
	# Clic droit : rotation + pan
	elif event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			if not rotating:
				last_mouse_pos = get_viewport().get_mouse_position()
				rotating = true
			
			var delta = event.position - last_mouse_pos
			# Rotation orbitale autour de 0,0,0
			rotate_y(-delta.x * fov_rotation)
			rotate_object_local(Vector3(1,0,0), -delta.y * fov_rotation)
			
			# Pan caméra
			var pan_dir = -global_transform.basis.z * delta.x * fov_pan + global_transform.basis.x * delta.y * fov_pan
			global_position += pan_dir
			
			last_mouse_pos = event.position
		else:
			rotating = false
	# Sélection Batiment/unité
	#elif  Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
	##cherche l'élément cliqué et l'affecte comme cible pour la caméra	
		#$SpotSelection.light_color = Color.GREEN
