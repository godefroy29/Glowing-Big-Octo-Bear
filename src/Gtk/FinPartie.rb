#FinPartie
# encoding: UTF-8

class FinPartie

	def FinPartie.afficher(fenetre, langue, score)
		score = Gtk::Label.new(score)
		boutonRetour = Gtk::Button.new(langue.retour)
		vbox = Gtk::VBox.new(false,10)
		
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		vbox.add(score)
		vbox.add(boutonRetour)
		vbox.add(btn_tmp)
	
		fenetre.add(vbox)
		fenetre.show_all
	end
end # Marqueur de fin de classe