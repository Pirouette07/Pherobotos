extends Node3D
#Un batiment est composé de	
#positionner
#- d'un asset pour le représenter, 
#- doit pouvoir être cliqué pour l'interaction (collisionneur caméra 
#logique d'utilisation
#- s'intégrer dans le jeu (donc au chemin Flux)
#- afficher des trucs
#construction
##- ressources requises (temps etc ...)
func _ready():print(self.name, " _ready")
func _input(event): print (self.name, " ", event.as_text())
	
