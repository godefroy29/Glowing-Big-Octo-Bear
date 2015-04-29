class ModelJoueur

	##
	#Méthode qui renvoie l'objet Utilisateur correspondant à l'id rentrée en parametre
	def ModelJoueur.getJoueurById(id)


		ary = $database.execute "SELECT * FROM Joueur WHERE id_joueur = #{id}"

		if ary.empty?
			return nil
		end

		joueur = Joueur.new(
	    	ary[0]["id_joueur"], 
	    	ary[0]['pseudo'],
	    	ary[0]['password'],
	    	ary[0]['avatar'])

		return joueur;

	end

	##
	#Méthode qui renvoie l'objet Utilisateur correspondant au pseudo rentrée en parametre
	def ModelJoueur.getJoueurByUsername(username)


		ary = $database.execute "SELECT * FROM Joueur WHERE pseudo = '#{username}'"

		if ary.empty?
			return nil
		end

		joueur = Joueur.new(
	    	ary[0]["id_joueur"],
	    	ary[0]['pseudo'],
	    	ary[0]['password'],
	    	ary[0]['avatar'])

		return joueur;

	end

	##
	#Methode qui ajoute le joueur dans la base de donnée
	#return nil si username déjà utilisé
	def ModelJoueur.createJoueur(username,password)
		joueur = ModelJoueur.getJoueurByUsername(username)
		if joueur == nil
			$database.execute "INSERT INTO Joueur(pseudo,password,avatar) VALUES ('#{username}','#{password}','#{$default_avatar}')"
			return ModelJoueur.getJoueurByUsername(username)
		else
			return nil
		end
		
	end

	##
	#Méthode qui supprime le joueur grace a son id
	def ModelJoueur.suprJoueurById(id)
		ary = $database.execute "DELETE FROM Joueur WHERE id_joueur = #{id}"
		return nil;
	end

	##
	#Méthode qui retourne le joueur par défaut
	def ModelJoueur.getAnon
		ModelJoueur.getJoueurById(0)
	end

	##
	#Méthode de test du joueur par défaut
	def ModelJoueur.testAnon(j)
		return(j.id ==0)
	end

end
