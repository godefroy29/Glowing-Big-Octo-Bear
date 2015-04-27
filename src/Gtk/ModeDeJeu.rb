#ModeDeJeu
# encoding: UTF-8

class ModeDeJeu

	def ModeDeJeu.afficher(fenetre, langue)

		padding = 20
		
		boutonJouerRapide = Gtk::Button.new("High Score")
		boutonChrono = Gtk::Button.new("Timed")
		boutonRetour = Gtk::Button.new("Retour")
		boutonQuitter = Gtk::Button.new(langue.quitter)

		vbox = Gtk::VBox.new(false,10)
		
		
		boutonJouerRapide.signal_connect('clicked'){
			fenetre.remove(vbox)
			PartieRapide.afficher(fenetre, langue, "rapide")
		}
		
		boutonChrono.signal_connect('clicked'){
			fenetre.remove(vbox)
			PartieRapide.afficher(fenetre, langue, "chrono")
		}

		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		fenetre.signal_connect('destroy') {
  			 Gtk.main_quit
		}
		
		boutonQuitter.signal_connect('clicked'){Gtk.main_quit}
	
		vbox = Gtk::VBox.new(false,10)
		
		# Ajout des boutons a la vbox
		vbox.pack_start(boutonJouerRapide, false, false, padding)
		vbox.pack_start(boutonChrono, false, false, padding)
		vbox.pack_start(boutonRetour, false, false, padding)
		vbox.pack_start(boutonQuitter, false, false, padding)

		fenetre.add(vbox)
		fenetre.show_all
		fenetre.reshow_with_initial_size
	end

end # Marqueur de fin de classe
