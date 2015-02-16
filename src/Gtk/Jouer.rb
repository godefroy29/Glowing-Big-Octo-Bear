# encoding: UTF-8

class Jouer

	@plateau
	@plateauGtk

	def Jouer.afficher(fenetre, langue)
		boutonRetour = Gtk::Button.new(langue.retour)
		boutonTestGrille = Gtk::Button.new("Test")#a integrer dans la langue
		vbox = Gtk::VBox.new(false,10)

		fichier = File.open(PATH_GRI, "r")
#00_________1____0___11_______0_0_1__;001011010011110100001101110010101100
		@plateau = Plateau.new("00101101001111010000110111001010_100","001011010011110100001101110010101100");
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
