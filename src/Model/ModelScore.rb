class ModelScore


	##
	#Renvoie l'objet Score correspondant à l'id rentré en parametre
	# Paramètres::
	# - id : id du score voulu
	# Retour::
	# - score : le score ayant l'id voulu
	def ModelScore.getScoreById(id)
		ary = $database.execute "SELECT * FROM Score WHERE id_score = #{id}"

		score = Score.new(
			ary[0]['id_score'],
	    	ary[0]['id_joueur'],
	    	ary[0]['id_grille'],
	    	ary[0]['mode'],
	    	ary[0]['chrono'],
	    	ary[0]['nb_undo'],
	    	ary[0]['nb_pause'])
		return score;
	end

	##
	# Renvoie un objet score choisit par un joueur, une grille et un mode
	# Paramètres::
	# - joueur : id du joueur voulu
	# - grille : id de la grille voulu
	# - mode : id du mode voulu
	# Retour::
	# - score : le score attendu
	def ModelScore.getScoreByJoueurGrilleMode(joueur,grille,mode)
		ary = $database.execute "SELECT * FROM Score WHERE id_joueur = #{joueur} AND id_grille = #{grille} AND mode = #{mode} "

		if ary.empty?
			return nil
		end

		score = Score.new(
			ary[0]['id_score'],
	    	ary[0]['id_joueur'],
	    	ary[0]['id_grille'],
	    	ary[0]['mode'],
	    	ary[0]['chrono'],
	    	ary[0]['nb_undo'],
	    	ary[0]['nb_pause'])
		return score;
	end

	##
	#Renvoie l'objet Score correspondant à l'id rentré en parametre
	# Paramètres::
	# - joueur : id du joueur voulu
	# Retour::
	# - score : le score correspondant au joueur voulu
	def ModelScore.getScoreArrayByJoueur(joueur)
		ary = $database.execute "SELECT * FROM Score WHERE id_joueur = #{joueur}"

		if ary.empty?
			return nil
		end

		score = new Array

		0.upto ary.size-1 do |x|
		score[x] = Score.new(
			ary[x]['id_score'],
	    	ary[x]['id_joueur'],
	    	ary[x]['id_grille'],
	    	ary[x]['mode'],
	    	ary[x]['chrono'],
	    	ary[x]['nb_undo'],
	    	ary[x]['nb_pause'])
		end
		return score
	end

	##
	#Renvoie l'objet Score correspondant à l'id rentré en parametre
	# Paramètres::
	# - mode : id du mode voulu
	# Retour::
	# - score : le score correspondant au mode voulu
	def ModelScore.getScoreArrayByMode(mode)
		ary = $database.execute "SELECT * FROM Score WHERE mode = #{mode}"

		if ary.empty?
			return nil
		end

		score = new Array

		0.upto ary.size-1 do |x|
		score[x] = Score.new(
			ary[x]['id_score'],
	    	ary[x]['id_joueur'],
	    	ary[x]['id_grille'],
	    	ary[x]['mode'],
	    	ary[x]['chrono'],
	    	ary[x]['nb_undo'],
	    	ary[x]['nb_pause'])
		end
		return score
	end
 	
 	##
	#Renvoie l'objet Score correspondant à l'id rentré en parametre
	# Paramètres::
	# - grille : id de la grille voulu
	# Retour::
	# - score : le score correspondaant à la grille voulu
	def ModelScore.getScoreArrayByGrille(grille)
		ary = $database.execute "SELECT * FROM Score WHERE id_grille = #{grille}"

		if ary.empty?
			return nil
		end

		score = new Array

		0.upto ary.size-1 do |x|
		score[x] = Score.new(
			ary[x]['id_score'],
	    	ary[x]['id_joueur'],
	    	ary[x]['id_grille'],
	    	ary[x]['mode'],
	    	ary[x]['chrono'],
	    	ary[x]['nb_undo'],
	    	ary[x]['nb_pause'])
		end
		return score
	end

	##
	#Créé un objet Score
	# Paramètres::
	# - joueur : id du joueur créant ce score
	# - grille : id de la grille jouée
	# - mode : mode joué
	# - chrono : temps joué sur cette partie
	# - nb_undo : nombre de undo fait
	# - nb_pause : nombre de pause effectuée
	def ModelScore.createScore(joueur,grille,mode,chrono,nb_undo,nb_pause)
		#Test si le joueur dispose déjà d'un score sur cette grille
		score = ModelScore.getScoreByJoueurGrilleMode(joueur,grille,mode)

		if score == nil
			puts("Ajout")
			puts "INSERT INTO Score(id_joueur,id_grille,mode,chrono,nb_undo,nb_pause) 
			VALUES (#{joueur}, #{grille}, #{mode}, #{chrono}, #{nb_undo}, #{nb_pause})"
			$database.execute "INSERT INTO Score(id_joueur,id_grille,mode,chrono,nb_undo,nb_pause) 
			VALUES (#{joueur},
				#{grille},
				#{mode},
				#{chrono},
				#{nb_undo},
				#{nb_pause})"
			return score
		else
			puts("	#{score.calculScore} >= #{Score.calculScore(chrono,nb_undo,nb_pause)}")
			if score.calculScore >= Score.calculScore(chrono,nb_undo,nb_pause)
				puts("Pas de modif")
				return score
			else
				puts("Modif")
				puts "UPDATE Score 
				SET chrono = #{chrono}, nb_undo = #{nb_undo}, nb_pause = #{nb_pause} 
				WHERE  id_score = #{score.id}"
				$database.execute "UPDATE Score 
				SET chrono = #{chrono}, nb_undo = #{nb_undo}, nb_pause = #{nb_pause} 
				WHERE  id_score = #{score.id}"
				return ModelScore.getScoreByJoueurGrilleMode(joueur,grille,mode)
			end
		end
	end
end