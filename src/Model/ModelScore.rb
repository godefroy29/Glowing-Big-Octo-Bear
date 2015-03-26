class ModelScore


	##
	#Renvoie l'objet Score correspondant à l'id rentrée en parametre
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

	def ModelScore.getScoreByJoueurGrilleMode(joueur,grille,mode)


		ary = $database.execute "SELECT * FROM Score WHERE id_joueur = #{joueur} AND id_grille = #{grille} AND mode = #{mode} "

		if ary.isEmpty?
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

	def ModelScore.getScoreArrayByJoueur(joueur)


		ary = $database.execute "SELECT * FROM Score WHERE id_joueur = #{joueur}"

		if ary.isEmpty?
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

	def ModelScore.getScoreArrayByMode(mode)


		ary = $database.execute "SELECT * FROM Score WHERE mode = #{mode}"

		if ary.isEmpty?
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

	def ModelScore.getScoreArrayByGrille(grille)


		ary = $database.execute "SELECT * FROM Score WHERE id_grille = #{grille}"

		if ary.isEmpty?
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

	def ModelScore.createScore(joueur,grille,mode,chrono,nb_undo,nb_pause)
		#Test si le joueur dispose déjà d'un score sur cette grille
		score = ModelScore.getScoreByJoueurGrilleMode(joueur,grille,mode)

		if score == nil
			$database.execute "INSERT INTO Score(id_joueur,id_grille,mode,chrono,nb_undo,nb_pause) 
			VALUES (#{joueur},
				#{grille},
				#{mode},
				#{chrono},
				#{nb_undo},
				#{nb_pause})"
			return score
		else
			if score.calculScore > Score.calculScore(chrono,nb_undo,nb_pause)
				return score
			else
				$database.execute "UPDATE Score 
				SET chrono = #{chrono} AND nb_undo = #{nb_undo} AND nb_pause = #{nb_pause} 
				WHERE  id_joueur = #{joueur} AND id_grille = #{grille} AND mode = #{mode}"
				return ModelScore.getScoreByJoueurGrilleMode(joueur,grille,mode)
			end
		end

	end



end