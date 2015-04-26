class Score

	def Score.afficher(fenetre, langue)
		vbox = Gtk::VBox.new(false,10)

		score = ModelScore.getScoreArrayByJoueur($joueur.id)
		scoreAff = ""
		0.upto score.size-1 do |x|
			scoreAff = scoreAff +
			scoreAff[x]['id_score'].to_s + "|" +
	    	scoreAff[x].to_s + "|" +
	    	scoreAff[x].to_s + "|" +
	    	scoreAff[x].to_s + "|" +
	    	scoreAff[x].to_s + "|" +
	    	scoreAff[x].to_s + "|" +
	    	scoreAff[x].to_s + "\n\n"
		end

		scoreJoueur = Gtk::Label.new()
		scoreJoueur.set_markup("<big>"+scoreAff+"</big>")

		boutonRetour = Gtk::Button.new(langue.retour)
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		boutonOptions = Gtk::Button.new(langue.options)
		boutonOptions.signal_connect('clicked'){
			fenetre.remove(vbox)
			Options.afficher(fenetre, langue)
		}

		vbox.add(scoreJoueur)
		vbox.add(boutonOptions)
		vbox.add(boutonRetour)
		fenetre.add(vbox)
		fenetre.show_all
	end
end