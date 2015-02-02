# encoding: UTF-8

class Jouer

	@plateau
	@plateauGtk

	def Jouer.afficher(fenetre, langue)
		boutonRetour = Gtk::Button.new(langue.retour)
		vbox = Gtk::VBox.new(false,10)

	
		@plateau = Plateau.new("_1_0");
		@plateauGtk = PlateauGtk.creer(vbox,@plateau,2)
		
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		vbox.add(boutonRetour)
		
		fenetre.add(vbox)
		fenetre.show_all
	end

	


end
