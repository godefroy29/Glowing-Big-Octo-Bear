# encoding: UTF-8

class Options

	##
	# Méthode affichant le menu des options
	# Paramètres::
	# - fenetre : la fenetre dans laquelle afficher les elements
	# - langue : la langue de la fenetre
	def Options.afficher(fenetre, langue)
		padding = 40
		
		#Création des boutons
		boutonGraphique = Gtk::Button.new(langue.o_graphique)
		boutonProfil = Gtk::Button.new(langue.o_profil)
		boutonLangue = Gtk::Button.new(langue.o_lang)
		boutonScore = Gtk::Button.new(langue.o_score)
		boutonRetour = Gtk::Button.new(langue.retour)

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
			Score.afficher(fenetre, langue)
		}
		
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		# Ajout des boutons a la vbox
		vbox.pack_start(boutonGraphique, false, false, padding)
		vbox.pack_start(boutonProfil, false, false, padding)
		vbox.pack_start(boutonLangue, false, false, padding)
		vbox.pack_start(boutonScore, false, false, padding)
		vbox.pack_start(boutonRetour, false, false, padding)

		fenetre.add(vbox)
		fenetre.show_all
	end
	
end