#FinPartie
# encoding: UTF-8

class FinPartie

	def FinPartie.afficher(fenetre, langue, temps, mode, grille, nb_undo, nb_indices)
		if mode == "rapide"
			winText = "Vous avez fait une partie rapide\nVous avez mis #{temps.to_i.to_s} secondes pour reussir la grille !\nVotre score est de (algo de calcul de score pas code)"
			Score.ajouteScoreRapide($joueur.id,grille.id,temps.to_i,nb_undo,nb_indices)
		elsif mode == "chrono"
			winText = winText = "Vous avez fait une partie rapide\nVous avez mis #{temps.to_i.to_s} secondes pour reussir la grille !\nVotre temps va etre enregistre"
			Score.ajouteScoreChrono($joueur.id,grille.id,temps.to_i,nb_undo,nb_indices)
		else
			winText = winText = "Vous avez fait une partie rapide\nVous avez mis #{temps.to_i.to_s} secondes pour reussir la grille !\nVotre score est de (algo de calcul de score pas code)"
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
