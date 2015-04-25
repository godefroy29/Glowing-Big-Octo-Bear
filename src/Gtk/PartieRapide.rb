# encoding: UTF-8

##
# Auteur LOIZEAU Sylvain
# Version 0.1 : Date : Wed Jan 21 13:47:35 CET 2015
#

class PartieRapide

	def PartieRapide.afficher(fenetre, langue)

		padding = 20
		vbox = Gtk::VBox.new(false,10)

		boutonJouer = Gtk::Button.new("Jouer !")
		boutonQuitter = Gtk::Button.new(langue.quitter)
		labelDifficulte = Gtk::Label.new("Difficulte")
		comboBoxDifficulte = Gtk::ComboBox.new()
		labelTaille = Gtk::Label.new("Taille")
		comboBoxTaille = Gtk::ComboBox.new()
		id_grille = nil

		ModelGrille.getDifficulte().each{ |x|
			comboBoxDifficulte.append_text(x.to_s)
		}

		ModelGrille.getTaille().each{ |x|
			comboBoxTaille.append_text(x.to_s)
		}

		comboBoxDifficulte.signal_connect('changed'){
			id_grille = ModelGrille.getGrilleByDifficulteAndTaille(comboBoxDifficulte.active_text.to_i, comboBoxTaille.active_text.to_i)
			if(id_grille != nil)
				boutonJouer.set_sensitive(true)
			else
				boutonJouer.set_sensitive(false)
			end
		}

		comboBoxTaille.signal_connect('changed'){
			id_grille = ModelGrille.getGrilleByDifficulteAndTaille(comboBoxDifficulte.active_text.to_i, comboBoxTaille.active_text.to_i)
			if(id_grille != nil)
				boutonJouer.set_sensitive(true)
			else
				boutonJouer.set_sensitive(false)
			end
			
		}

		boutonJouer.signal_connect('clicked'){
			fenetre.remove(vbox)
			Jouer.afficher(fenetre, langue, "rapide", id_grille)
		}

		boutonQuitter.signal_connect('clicked') {
			fenetre.remove(vbox)
  			Menu.afficher(fenetre, langue)
		}
		
		boutonQuitter.signal_connect('clicked'){Gtk.main_quit}
	
		vbox = Gtk::VBox.new(false,10)
		
		comboBoxDifficulte.set_active(0);
		comboBoxTaille.set_active(0);
		# Ajout des boutons a la vbox
		vbox.pack_start(labelDifficulte, false, false, padding)
		vbox.pack_start(comboBoxDifficulte, false, false, padding)
		vbox.pack_start(labelTaille, false, false, padding)
		vbox.pack_start(comboBoxTaille, false, false, padding)
		vbox.pack_start(boutonJouer, false, false, padding)
		vbox.pack_start(boutonQuitter, false, false, padding)

		fenetre.add(vbox)
		fenetre.show_all
		fenetre.reshow_with_initial_size
	end

end # Marqueur de fin de classe
