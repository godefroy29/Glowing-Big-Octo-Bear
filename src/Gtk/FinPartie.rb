#Classe qui permet l'affichage de fin de partie.
class FinPartie
	
	##
	#Méthode d'affichage et de gestion de fin de partie
	def FinPartie.afficher(fenetre, langue, temps, mode, grille, nb_undo, nb_pause,nb_test,nb_aide)
		#Ajoute le score dans la base de donnée et affiche le resultat à l'écran en fonction du mode de jeu
		if mode == "rapide"
			winText = langue.f_rapide1+"#{temps.to_i.to_s}"+langue.f_rapide2+"#{Score.calculScore(temps,nb_undo,nb_pause,nb_test,nb_aide).to_i}"
			Score.ajouteScoreRapide($joueur.id,grille.id,temps.to_i,nb_undo,nb_pause,nb_test,nb_aide)
		elsif mode == "chrono"
			winText = langue.f_chrono1+"#{temps.to_i.to_s}"+langue.f_chrono2
			Score.ajouteScoreChrono($joueur.id,grille.id,temps.to_i,nb_undo,nb_pause,nb_test,nb_aide)
		else
			winText = langue.f_rapide1+"#{temps.to_i.to_s}"+langue.f_rapide2+" #{Score.calculScore(temps,nb_undo,nb_pause,nb_test,nb_aide).to_i}"
			Score.ajouteScoreRapide($joueur.id,grille.id,temps.to_i,nb_undo,nb_pause,nb_test,nb_aide)
		end

		#Score.ajouteScoreRapide(joueur.id,grille.id,chrono,nb_undo,nb_pause,nb_test,nb_aide)
		
		label = Gtk::Label.new(winText)
		boutonRetour = Gtk::Button.new(langue.retour)
		vbox = Gtk::VBox.new(false,10)
		
		vbox.add(label)
		vbox.add(boutonRetour)
		
		#Ajout du signal pour retourner au menu
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		fenetre.add(vbox)
		fenetre.show_all
	end

end
