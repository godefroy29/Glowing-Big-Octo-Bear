#Classe qui permet au joueur de consulté ses derniers scores enregistrés
class Options_score

	##
	#Méthode d'affichage
	def Options_score.afficher(fenetre, langue)

	padding = 40
	
	#Création des boutons
	boutonRetour = Gtk::Button.new(langue.retour)

	#Création d'une vbox
	vbox = Gtk::VBox.new(false,10)

	#On récupere les derniers score du joueur
	ary = ModelScore.getScoreArrayByJoueur($joueur.id)

	#On affiche les scores, un message d'indication apparait s'il y ne possède aucun score
	if ary == nil
		message = langue.os_nil
	else
		ary.each do |x|
		message = langue.os_score + x.calculScore.to_s + 
			langue.os_grille + x.grille.to_s + 
			langue.os_mode + x.mode.to_s + 
			langue.os_chrono  + x.chrono.to_s +
			langue.os_pause  + x.nb_pause.to_s + 
			langue.os_undo  + x.nb_undo.to_s

		lbl = Gtk::Label.new(message)
		vbox.pack_start(lbl, false, false, padding)
		end
	end


	boutonRetour.signal_connect('clicked'){
		fenetre.remove(vbox)
		Options.afficher(fenetre, langue)
	}
	
	# Ajout des boutons a la vbox
	vbox.pack_start(boutonRetour, false, false, padding)

	fenetre.add(vbox)
	fenetre.show_all
	
	end
	
end
