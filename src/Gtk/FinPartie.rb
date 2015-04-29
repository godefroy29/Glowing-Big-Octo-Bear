#FinPartie
# encoding: UTF-8

class FinPartie

	def FinPartie.afficher(fenetre, langue, temps, mode, grille, nb_undo, nb_indices)
		if mode == "rapide"
			winText = langue.f_rapide1+"#{temps.to_i.to_s}"+langue.f_rapide2+"#{Score.calculScore(temps,nb_undo,nb_indices).to_i}"
			Score.ajouteScoreRapide($joueur.id,grille.id,temps.to_i,nb_undo,nb_indices)
		elsif mode == "chrono"
			winText = winText = langue.f_chrono1+"#{temps.to_i.to_s}"+langue.f_chrono2
			Score.ajouteScoreChrono($joueur.id,grille.id,temps.to_i,nb_undo,nb_indices)
		else
			winText = langue.f_rapide1+"#{temps.to_i.to_s}"+langue.f_rapide2+" #{Score.calculScore(temps,nb_undo,nb_indices).to_i}"
			Score.ajouteScoreRapide($joueur.id,grille.id,temps.to_i,nb_undo,nb_indices)
		end

		#Score.ajouteScoreRapide(joueur.id,grille.id,chrono,nb_undo,nb_indices)
		

		label = Gtk::Label.new(winText)
		boutonRetour = Gtk::Button.new(langue.retour)
		vbox = Gtk::VBox.new(false,10)
		
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		vbox.add(label)
		vbox.add(boutonRetour)

		fenetre.add(vbox)
		fenetre.show_all
	end

	


end # Marqueur de fin de classe
