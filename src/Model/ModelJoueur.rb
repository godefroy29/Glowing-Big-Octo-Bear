class ModelJoueur

	##
	#Renvoie l'objet Utilisateur correspondant à l'id rentrée en parametre
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
	#Renvoie l'objet Utilisateur correspondant au pseudo rentrée en parametre
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

	def ModelJoueur.getAnon
		ModelJoueur.getJoueurById(0)
	end

	def ModelJoueur.testAnon(j)
		return(j.id ==0)
	end



end