class Score

	attr_reader :id
	attr_reader :joueur
	attr_reader :grille
	attr_reader :mode
	attr_reader :chrono
	attr_reader :nb_undo
	attr_reader :nb_pause

	def initialize(id,joueur,grille,mode,chrono,nb_undo,nb_pause)
		@id			=	id
		@joueur		=	joueur
		@grille		=	grille
		@mode		=	mode
		@chrono		=	chrono
		@nb_undo	=	nb_undo
		@nb_pause	=	nb_pause
	end

	##
	# Calcul le score
	# Retour::
	# - le score
	def calculScore
		#TO-DO
		return 10000 - @chrono - @nb_undo * 10 - @nb_pause * 5
	end

	##
	# Calcul le score
	# Paramètres::
	# - chrono : le nombre de secondes écoulées
	# - nb_undo : le nombre de undo fait
	# - nb_pause : le nombre de pause effectuées
	# Retour::
	# - le score
	def Score.calculScore(chrono,nb_undo,nb_pause)
		#TO-DO
		return 10000 - chrono - nb_undo * 10 - nb_pause * 5
	end

	##
	# Ajoute le score d'une partie jouée en mode rapide
	# Paramètres::
	# - joueur : id du joueur ayant joué la partie
	# - grille : id de la grille jouée
	# - chrono : seconde écoulées
	# - nb_undo : nombre de undo effectués
	# - nb_pause : nombre de pause effectuées
	def Score.ajouteScoreRapide(joueur,grille,chrono,nb_undo,nb_pause)
		ModelScore.createScore(joueur,grille,1,chrono,nb_undo,nb_pause)
	end

	##
	# Ajoute le score d'une partie jouée en mode chrono
	# Paramètres::
	# - joueur : id du joueur ayant joué la partie
	# - grille : id de la grille jouée
	# - chrono : seconde écoulées
	# - nb_undo : nombre de undo effectués
	# - nb_pause : nombre de pause effectuées
	def Score.ajouteScoreChrono(joueur,grille,chrono,nb_undo,nb_pause)
		ModelScore.createScore(joueur,grille,2,chrono,nb_undo,nb_pause)
	end

	def to_s	
		return "Score id = #{@id} , chrono = #{@chrono}"
	end

end