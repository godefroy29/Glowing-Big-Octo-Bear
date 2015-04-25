# encoding: UTF-8

class FinPartie


	##
	# Méthode affichant la fenetre de fin de partie
	# Paramètres::
	# - fenetre : la fenetre dans laquelle afficher les elements
	# - langue : la langue de la fenetre
	# - temps : le temps de jeu une fois la partie finie
	# - mode : le mode de jeu que le joueur a choisit en lançant la partie
	# - grille : l'id de la grille jouée
	# - nb_undo : nombre de undo fait par le joueur
	# - nb_indices : nombre d'indices utilisés apr le joueur
	
	def FinPartie.afficher(fenetre, langue, temps, mode, grille, nb_undo, nb_indices)
		if mode == "rapide"
			winText = "Vous avez fait une partie rapide\nVous avez mis #{temps.to_i.to_s} secondes pour reussir la grille !\nVotre score est de #{Score.calculScore(temps,nb_undo,nb_indices).to_i}"
			Score.ajouteScoreRapide($joueur.id,grille.id,temps.to_i,nb_undo,nb_indices)
		elsif mode == "chrono"
			winText = winText = "Vous avez fait une partie rapide\nVous avez mis #{temps.to_i.to_s} secondes pour reussir la grille !\nVotre temps va etre enregistre"
			Score.ajouteScoreChrono($joueur.id,grille.id,temps.to_i,nb_undo,nb_indices)
		else
			winText = winText = "Vous avez fait une partie rapide\nVous avez mis #{temps.to_i.to_s} secondes pour reussir la grille !\nVotre score est de #{Score.calculScore(temps,nb_undo,nb_indices).to_i}"
			Score.ajouteScoreRapide($joueur.id,grille.id,temps.to_i,nb_undo,nb_indices)
		end

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

end