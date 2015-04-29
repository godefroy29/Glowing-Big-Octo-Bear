#Classe permettant au joueur de sélectionner l'option dans laquelle il souhaite aller
class Options

	def Options.afficher(fenetre, langue)

	padding = 40
	
	#Création des boutons
	boutonGraphique = Gtk::Button.new(langue.o_graphique)
	boutonProfil = Gtk::Button.new(langue.o_profil)
	boutonLangue = Gtk::Button.new(langue.o_lang)
	boutonScore = Gtk::Button.new(langue.o_score)
	boutonRetour = Gtk::Button.new(langue.retour)
	#boutonQuitter = Gtk::Button.new(langue.quitter)

	#Création d'une vbox
	vbox = Gtk::VBox.new(false,10)
	
	boutonGraphique.signal_connect('clicked'){
		fenetre.remove(vbox)
		Graphique.afficher(fenetre, langue)
	}
	
	boutonProfil.signal_connect('clicked'){
		fenetre.remove(vbox)
		Profil.afficher(fenetre, langue)
	}
	
	boutonLangue.signal_connect('clicked'){
		fenetre.remove(vbox)
		Langue.afficher(fenetre, langue)
	}
	
	boutonScore.signal_connect('clicked'){
		fenetre.remove(vbox)
		Options_score.afficher(fenetre, langue)
	}
	
	boutonRetour.signal_connect('clicked'){
		fenetre.remove(vbox)
		Menu.afficher(fenetre, langue)
	}
	
	#susceptible d'être supprimé
	#fenetre.signal_connect('destroy') {
	#	Gtk.main_quit
	#}
	#
	#boutonQuitter.signal_connect('clicked'){
	#	Gtk.main_quit
	#}

	# Ajout des boutons a la vbox
	vbox.pack_start(boutonGraphique, false, false, padding)
	vbox.pack_start(boutonProfil, false, false, padding)
	vbox.pack_start(boutonLangue, false, false, padding)
	vbox.pack_start(boutonScore, false, false, padding)
	vbox.pack_start(boutonRetour, false, false, padding)

	fenetre.add(vbox)
	fenetre.show_all
	
	end
	
end # Marqueur de fin de classe






















