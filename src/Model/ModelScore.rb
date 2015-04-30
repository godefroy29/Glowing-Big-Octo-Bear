#Classe qui permet d'interagir avec la table "score" de la base de donnée
class ModelScore

	##
	#Renvoie l'objet Score correspondant à l'id rentrée en parametre
	def ModelScore.getScoreById(id)
		
		ary = $database.execute "SELECT * FROM Score WHERE id_score = #{id}"

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
			ary[0]['nb_pause'],
			ary[0]['nb_test'],
			ary[0]['nb_aide'],
		    	ary[0]['etat'])
		    	
		return score;
	end

	##
	# Methode qui retourne tous les scores d'un joueur correspondant a un mode donné
	def ModelScore.getScoreByJoueurAndMode(joueur,mode)

		ary = $database.execute "SELECT * FROM Score WHERE id_joueur = #{joueur} AND mode = #{mode} "

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
	    			ary[0]['nb_pause'],
			 	ary[0]['nb_test'],
			 	ary[0]['nb_aide'],
	    			ary[0]['etat'])
	
		return score;
	end

	##
	# Methode qui retourne tous les scores d'un joueur correspondant a un mode donné et a une grille précise
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
	    		ary[0]['nb_pause'],
			ary[0]['nb_test'],
			ary[0]['nb_aide'],
	    		ary[0]['etat'])

		return score;
	end

	##
	# Methode qui retourne les 5 derniers score d'un joueur
	def ModelScore.getScoreArrayByJoueur(joueur)

		ary = $database.execute "SELECT * FROM Score WHERE id_joueur = #{joueur} ORDER BY id_score DESC LIMIT 5"

		if ary.empty?
			return nil
		end

		score = Array.new

		0.upto ary.size-1 do |x|
			score[x] = Score.new(
				ary[x]['id_score'],
    				ary[x]['id_joueur'],
    				ary[x]['id_grille'],
    				ary[x]['mode'],
			 	ary[x]['chrono'],
			 	ary[x]['nb_undo'],
			 	ary[x]['nb_pause'],
			 	ary[0]['nb_test'],
			 	ary[0]['nb_aide'],
	    			ary[0]['etat'])
		end

		return score
	end

	##
	# Methode qui retourne tous les scores correspondant a un mode
	def ModelScore.getScoreArrayByMode(mode)

		ary = $database.execute "SELECT * FROM Score WHERE mode = #{mode}"

		if ary.empty?
			return nil
		end

		score = Array.new

		0.upto ary.size-1 do |x|
			score[x] = Score.new(
				ary[x]['id_score'],
			   	ary[x]['id_joueur'],
			   	ary[x]['id_grille'],
			  	ary[x]['mode'],
			   	ary[x]['chrono'],
			   	ary[x]['nb_undo'],
			  	ary[x]['nb_pause'],
			 	ary[0]['nb_test'],
			 	ary[0]['nb_aide'],
    				ary[0]['etat'])
		end

		return score
	end

	##
	# Methode qui retourne tous les scores qui ont été fait sur une grille donnée
	def ModelScore.getScoreArrayByGrille(grille)

		ary = $database.execute "SELECT * FROM Score WHERE id_grille = #{grille}"

		if ary.empty?
			return nil
		end

		score = Array.new

		0.upto ary.size-1 do |x|
			score[x] = Score.new(
				ary[x]['id_score'],
		    		ary[x]['id_joueur'],
			  	ary[x]['id_grille'],
			  	ary[x]['mode'],
			   	ary[x]['chrono'],
			   	ary[x]['nb_undo'],
			   	ary[x]['nb_pause'],
			 	ary[0]['nb_test'],
			 	ary[0]['nb_aide'],
	    			ary[0]['etat'])
		end

		return score
	end

	##
	# Methode d'ajout de score dans la base de donnée
	# Si il existe déjà un score pour le joueur sur la grille et le mode choisit, on les remplace
	def ModelScore.createScore(joueur,grille,mode,chrono,nb_undo,nb_pause,nb_test,nb_aide)
		#Test si le joueur dispose déjà d'un score sur cette grille
		score = ModelScore.getScoreByJoueurGrilleMode(joueur,grille,mode)

		#Si il ne dispose pas de score sur cete grille dans ce mode, alors on l'insere
		if score == nil
			$database.execute "INSERT INTO Score(id_joueur,id_grille,mode,chrono,nb_undo,nb_pause,nb_test,nb_aide) 
				VALUES (#{joueur},
					#{grille},
					#{mode},
					#{chrono},
					#{nb_undo},
					#{nb_pause},
					#{nb_test},
					#{nb_aide})"
			return score
		else
			#Sinon si le score présent dans la base de donnée est plus grand que celui que le joueur veut inserer on ne fait rien
			if score.calculScore >= Score.calculScore(chrono,nb_undo,nb_pause,nb_test,nb_aide)
				return score
			#Sinon on remplace le score déjà présent
			else
				$database.execute "UPDATE Score 
					SET chrono = #{chrono}, nb_undo = #{nb_undo}, nb_pause = #{nb_pause} ,nb_test = #{nb_test} ,nb_aide = #{nb_aide}
					WHERE  id_score = #{score.id}"
				return ModelScore.getScoreByJoueurGrilleMode(joueur,grille,mode)
			end
		end

	end

	##
	# Méhode qui supprime le score correspondant a l'id mit en parametre
	def ModelScore.suprScoreById(id)

		ary = $database.execute "DELETE FROM Score WHERE id_score = #{id}"

		return nil;

	end

	##
	# Méthode qui retourne le nombre de partie qu'a fini le joueur
	def ModelScore.getNombreScoreOfJoueur(joueur)

		ary = $database.execute "SELECT COUNT(*) FROM Score WHERE id_joueur = #{joueur}"
		return ary[0]['COUNT(*)'];

	end
	##
	# Méthode qui retourne le temps total qu'a passe le joueur a joue
	def ModelScore.getTempsTotalOfJoueur(joueur)

		ary = $database.execute "SELECT SUM(chrono) FROM Score WHERE id_joueur = #{joueur}"
		return ary[0]['SUM(chrono)'];

	end
	##
	# Méthode qui retourne le nombre pause qu'a effecte le joueur
	def ModelScore.getNombrePauseOfJoueur(joueur)

		ary = $database.execute "SELECT SUM(nb_pause) FROM Score WHERE id_joueur = #{joueur}"
		return ary[0]['SUM(nb_pause)'];

	end
	##
	# Méthode qui retourne le nombre de partie qu'a fini le joueur
	def ModelScore.getNombreUndoOfJoueur(joueur)

		ary = $database.execute "SELECT SUM(nb_undo) FROM Score WHERE id_joueur = #{joueur}"
		return ary[0]['SUM(nb_undo)'];

	end

	##
	# Méthode qui retourne la somme de tous les score du joueur
	def ModelScore.getScoreTotalOfJoueur(joueur)

		ary = $database.execute "SELECT * FROM Score WHERE id_joueur = #{joueur}"
		scoreTotal = 0
		
		if ary != nil
			0.upto ary.size-1 do |x|
				scoreTotal = scoreTotal + Score.calculScore(ary[x]['chrono'],ary[x]['nb_undo'],ary[x]['nb_pause'],ary[x]['nb_test'],ary[x]['nb_aide'])
			end
		end

		return scoreTotal;
	end

	##
	#Méthode qui permet d'ajoute une sauvegarde temporaire dans la base de donnée
	def ModelScore.createSave(joueur,grille,chrono,nb_undo,nb_pause,nb_test,nb_aide,etat)
		#Test si le joueur dispose déjà d'un score sur cette grille
		mode = 0
		puts("Ajout")
		puts "INSERT INTO Score(id_joueur,id_grille,mode,chrono,nb_undo,nb_pause,nb_test,nb_aide,etat) VALUES (#{joueur}, #{grille}, #{mode}, #{chrono}, #{nb_undo}, #{nb_pause}, #{nb_test},
				#{nb_aide}, #{etat} )"
		$database.execute "INSERT INTO Score(id_joueur,id_grille,mode,chrono,nb_undo,nb_pause,nb_test,nb_aide,etat) 
			VALUES (#{joueur},
				#{grille},
				#{mode},
				#{chrono},
				#{nb_undo},
				#{nb_pause},
				#{nb_test},
				#{nb_aide},
				'#{etat}')"
			
	end
	
end
