class Score

	attr_reader :id
	attr_reader :joueur
	attr_reader :grille
	attr_reader :mode
	attr_reader :chrono
	attr_reader :nb_undo
	attr_reader :nb_pause

	def initialize(id,joueur,grille,mode,chrono,nb_undo,nb_pause)
		@id		=	id
		@joueur		=	joueur
		@grille		=	grille
		@mode		=	mode
		@chrono		=	chrono
		@nb_undo	=	nb_undo
		@nb_pause	=	nb_pause
	end

	##
	# Méthode qui permet de calculer un score
	def calculScore
		#TO-DO
		return Score.calculScore(@chrono,@nb_undo,@nb_pause)
	end

	##
	# Méthode qui permet de calculer un score
	def Score.calculScore(chrono,nb_undo,nb_pause)
		#TO-DO
		return 1000 - chrono - nb_undo * 10 - nb_pause * 5
	end

	##
	# Méthode qui ajoute un score dans la base de donnée
	def Score.ajouteScoreSauvegarde(joueur,grille,chrono,nb_undo,nb_pause)
		#On vérifie qu'il n'éxiste pas de score pour le joueur dans le mode 0
		old = ModelScore.getScoreByJoueurAndMode(joueur,0)
		# Si il en existe 1, on le supprime
		if old != nil
			ModelScore.suprScoreById(old.id)
		end
		#On ajoute le nouveau score
		ModelScore.createScore(joueur,grille,0,chrono,nb_undo,nb_pause)
	end

	##
	# Méthode qui ajoute un score de partie rapide dans la base de donnée
	def Score.ajouteScoreRapide(joueur,grille,chrono,nb_undo,nb_pause)
		ModelScore.createScore(joueur,grille,1,chrono,nb_undo,nb_pause)
	end

	##
	# Méthode qui ajoute un score de partie chrono dans la base de donnée
	def Score.ajouteScoreChrono(joueur,grille,chrono,nb_undo,nb_pause)
		ModelScore.createScore(joueur,grille,2,chrono,nb_undo,nb_pause)
	end

	def to_s	
		return "Score id = #{@id} , chrono = #{@chrono}"
	end

end
