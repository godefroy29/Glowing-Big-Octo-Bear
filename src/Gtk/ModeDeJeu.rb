#ModeDeJeu
# encoding: UTF-8

class ModeDeJeu

	def ModeDeJeu.afficher(fenetre, langue)

		padding = 20

		boutonJouerRapide = Gtk::Button.new("Partie rapide")
		boutonChrono = Gtk::Button.new("Timed")
		boutonQuitter = Gtk::Button.new(langue.quitter)

		vbox = Gtk::VBox.new(false,10)

		boutonJouerRapide.signal_connect('clicked'){
			fenetre.remove(vbox)
			PartieRapide.afficher(fenetre, langue)
		}
		
		boutonChrono.signal_connect('clicked'){
			fenetre.remove(vbox)
			Jouer.afficher(fenetre, langue, "chrono", 0)
		}

		fenetre.signal_connect('destroy') {
  			 Gtk.main_quit
		}
		
		boutonQuitter.signal_connect('clicked'){Gtk.main_quit}
	
		vbox = Gtk::VBox.new(false,10)
		
		# Ajout des boutons a la vbox
		vbox.pack_start(boutonJouerRapide, false, false, padding)
		vbox.pack_start(boutonChrono, false, false, padding)
		vbox.pack_start(boutonQuitter, false, false, padding)

		fenetre.add(vbox)
		fenetre.show_all
		fenetre.reshow_with_initial_size
	end

end # Marqueur de fin de classe
