# encoding: UTF-8

class Jouer

	@plateau
	@plateauGtk

	def Jouer.afficher(fenetre, langue)
		boutonRetour = Gtk::Button.new(langue.retour)
		vbox = Gtk::VBox.new(false,10)

		fichier = File.open(PATH_GRI, "r")

		@plateau = Plateau.new("__1_11_____10______0_0_0___0________","001011110100101010001101010101110010");
		@plateauGtk = PlateauGtk.creer(vbox,@plateau,6)
		
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}
		


		vbox.add(@plateauGtk.table)

		vbox.add(boutonRetour)
		
		fenetre.add(vbox)
		fenetre.show_all
	end

	


end
