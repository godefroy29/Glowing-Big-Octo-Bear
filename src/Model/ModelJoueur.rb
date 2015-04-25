class ModelJoueur

	##
	# Renvoie un objet joueur choisit par un id
	# Paramètres::
	# - id : id du joueur voulu
	# Retour::
	# - joueur : le joueur ayant l'id voulu
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
	# Renvoie un objet joueur choisit par un username
	# Paramètres::
	# - username : username du joueur
	# Retour::
	# - joueur : le joueur ayant lusername choisi
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
	# Créé un joueur
	# Paramètres::
	# - username : username désiré
	# - password : password désiré
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
	# Supprime un objet joueur choisit par un id
	# Paramètres::
	# - id : id du joueur voulu
	def ModelJoueur.suprJoueurById(id)
		ary = $database.execute "DELETE FROM Joueur WHERE id_joueur = #{id}"
		return nil;
	end

	##
	# Appel de ModelJoueur.getJoueurById pour l'id de l'anonyme
	def ModelJoueur.getAnon
		ModelJoueur.getJoueurById(0)
	end

##
# Test si le joueur est le joueur anonyme
# Paramètres::
# - j : l'id du joueur actuel
# Retour :
# - estAnonyme : true si le joueur l'anonyme, false sinon
	def ModelJoueur.testAnon(j)
		estAnonyme = j.id == 0
		return(estAnonyme)
	end

end