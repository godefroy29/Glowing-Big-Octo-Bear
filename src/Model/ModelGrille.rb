class ModelGrille


	##
	#==Renvoie un objet grille aléatoirement choisit sur les critères de fifficulte et de taille passé en parametre
	def ModelGrille.getRandomGrille(difficulte,taille)


		ary = $database.execute "SELECT * FROM Grille WHERE difficulte = #{difficulte} AND taille = #{taille} ORDER BY RANDOM() LIMIT 1"

		if ary.empty?
			return nil
		end


		grille = Grille.new(
	    	ary[0]["id_grille"],
	    	ary[0]['taille'],
	    	ary[0]['difficulte'],
	    	ary[0]['base'],
	    	ary[0]['solution'])

		return grille;

	end

	##
	#Renvoie l'objet Grille correspondant à l'id rentrée en parametre
	def ModelGrille.getGrilleById(id)


		ary = $database.execute "SELECT * FROM Grille WHERE id_grille = #{id}"

		if ary.empty?
			return nil
		end

		grille = Grille.new(
	    	ary[0]["id_grille"],
	    	ary[0]['taille'],
	    	ary[0]['difficulte'],
	    	ary[0]['base'],
	    	ary[0]['solution'])

		return grille;

	end



end

