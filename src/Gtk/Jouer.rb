# encoding: UTF-8

class Jouer

	@plateau
	@plateauGtk

	def Jouer.afficher(fenetre, langue)
		boutonRetour = Gtk::Button.new(langue.retour)
		boutonTestGrille = Gtk::Button.new("Test")#a integrer dans la langue
		vbox = Gtk::VBox.new(false,10)

		fichier = File.open(PATH_GRI, "r")
#"__1_11_____10______0_0_0___0________"
		@plateau = Plateau.new("001011110100101010001101010101110010","001011110100101010001101010101110010");
		@plateauGtk = PlateauGtk.creer(vbox,@plateau,6)
		
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		boutonTestGrille.signal_connect('clicked'){ #a voir avec la fonction dans plateau.rb
			if(@plateau.testGrille)
				fenetre.remove(vbox)
				Credits.afficher(fenetre, langue)
			end
		}

		vbox.add(@plateauGtk.table)

		vbox.add(boutonTestGrille)
		vbox.add(boutonRetour)
		
		fenetre.add(vbox)
		fenetre.show_all
	end

	


end
