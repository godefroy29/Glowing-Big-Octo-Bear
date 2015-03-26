# encoding: UTF-8

class Jouer

	@plateau
	@plateauGtk

	def Jouer.afficher(fenetre, langue)
		boutonRetour = Gtk::Button.new(langue.retour)
		boutonReset = Gtk::Button.new('Reset')
		boutonRedo = Gtk::Button.new('Redo')
		boutonUndo = Gtk::Button.new('Undo')
		boutonTestGrille = Gtk::Button.new("Test")#a integrer dans la langue
		vbox = Gtk::VBox.new(false,10)


		grille = ModelGrille.getRandomGrille(1,6)
		stringDebut = grille.base
		stringFin = grille.solution
		len = Math.sqrt(stringFin.length).to_i
		@plateau = Plateau.new(stringDebut,stringFin,boutonUndo,boutonRedo)
		@plateauGtk = PlateauGtk.creer(vbox,@plateau,len)
		
		boutonUndo.set_sensitive(false)
		boutonRedo.set_sensitive(false)
		
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}
		
		boutonUndo.signal_connect('clicked'){
			mouv=@plateau.undo
			if mouv.flag
				boutonUndo.set_sensitive(false)
			else
				boutonRedo.set_sensitive(true)
			end
			@plateauGtk.changerImgBouton(mouv.x,mouv.y,mouv.etatPrecedent)
		}
		
		boutonRedo.signal_connect('clicked'){
			mouv=@plateau.unundo
			if mouv.flag
				boutonRedo.set_sensitive(false)
			else
				boutonUndo.set_sensitive(true)
			end
			@plateauGtk.changerImgBouton(mouv.x,mouv.y,mouv.etatPrecedent)
		}

		boutonReset.signal_connect('clicked'){
			fenetre.remove(vbox)
			Jouer.afficher(fenetre, langue)
		}


		boutonTestGrille.signal_connect('clicked'){
			if(@plateau.testGrille)
				fenetre.remove(vbox)
				Credits.afficher(fenetre, langue)
			end
		}

		vbox.add(@plateauGtk.table)

		vbox.add(boutonTestGrille)
		vbox.add(boutonUndo)
		vbox.add(boutonRedo)
		vbox.add(boutonReset)
		vbox.add(boutonRetour)
		
		fenetre.add(vbox)
		fenetre.show_all
	end

	


end
