# encoding: UTF-8

class Jouer

	@plateau
	@plateauGtk

	def Jouer.afficher(fenetre, langue)
		boutonRetour = Gtk::Button.new(langue.retour)
		vbox = Gtk::VBox.new(false,10)

	
		@plateau = Plateau.new("___1____1_1____________000_____________1____0_________0_____1______0__1_1___0____11________1_0__1__0_1_______0____0________0___0__0_1___0___1___");
		@plateauGtk = PlateauGtk.creer(vbox,@plateau,12)
		
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
