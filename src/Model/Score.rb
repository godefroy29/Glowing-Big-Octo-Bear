#Classe qui s'occupe de gérer les scores
#elle permet d'ajouter et de calculer des scores
class Score

	attr_reader :id		#id de la grille
	attr_reader :joueur	#joueur auquel appartient le score
	attr_reader :grille	#grille sur lequel la partie a été joué
	attr_reader :mode	#mode de jeu
	attr_reader :chrono	#temps pour finir la grille
	attr_reader :nb_undo	#le nombre de fois que le joueur a utilisé la fonction undo durant la partie
	attr_reader :nb_pause	#le nombre de fois que le joueur a utilisé la fonction undo durant la partie
	attr_reader :etat	#permet de savoir si la partie est fini ou non
	attr_reader :nb_test	#le nombre de fois que le joueur a vérifié si ses cases placées étaient bonnes durant la partie
	attr_reader :nb_aide	#le nombre de fois que le joueur a demandé de l'aide durant la partie

	def initialize(id,joueur,grille,mode,chrono,nb_undo,nb_pause,nb_test,nb_aide,etat)
		@id		=	id
		@joueur		=	joueur
		@grille		=	grille
		@mode		=	mode
		@chrono		=	chrono
		@nb_undo	=	nb_undo
		@nb_pause	=	nb_pause
		@nb_test	=	nb_test
		@nb_aide 	=	nb_aide
		@etat		=	etat
	end

	##
	# Méthode qui permet de calculer un score
	def calculScore
		#TO-DO
		return Score.calculScore(@chrono,@nb_undo,@nb_pause,nb_test,nb_aide)
	end

	##
	# Méthode qui permet de calculer un score
	def Score.calculScore(chrono,nb_undo,nb_pause,nb_test,nb_aide)
		#TO-DO
		return 1000 - chrono - nb_undo * 10 - nb_pause * 5 - nb_test * 20 - nb_aide * 50
	end

	##
	# Méthode qui ajoute un score dans la base de donnée
	def Score.ajouteScoreSauvegarde(joueur,grille,chrono,nb_undo,nb_pause,nb_test,nb_aide,etat)
		#On vérifie qu'il n'éxiste pas de score pour le joueur dans le mode 0
		old = ModelScore.getScoreByJoueurAndMode(joueur,0)
		# Si il en existe 1, on le supprime
		if old != nil
			ModelScore.suprScoreById(old.id)
		end
		#On ajoute le nouveau score
		ModelScore.createSave(joueur,grille,chrono,nb_undo,nb_pause,nb_test,nb_aide,etat)
	end

	def Score.suprSauvergarde(joueur)
		old = ModelScore.getScoreByJoueurAndMode(joueur,0)
		if old != nil
			ModelScore.suprScoreById(old.id)
		end
		nil
	end

	##
	# Méthode qui ajoute un score de partie rapide dans la base de donnée
	def Score.ajouteScoreRapide(joueur,grille,chrono,nb_undo,nb_pause,nb_test,nb_aide)
		ModelScore.createScore(joueur,grille,1,chrono,nb_undo,nb_pause,nb_test,nb_aide)
	end

	##
	# Méthode qui ajoute un score de partie chrono dans la base de donnée
	def Score.ajouteScoreChrono(joueur,grille,chrono,nb_undo,nb_pause,nb_test,nb_aide)
		ModelScore.createScore(joueur,grille,2,chrono,nb_undo,nb_pause,nb_test,nb_aide)
	end

	##
	#Méthode d'affichage de la classe
	def to_s	
		return "Score id = #{@id} , chrono = #{@chrono}"
	end

end
