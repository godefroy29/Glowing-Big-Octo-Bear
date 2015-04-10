# encoding: UTF-8

class Jouer

	@plateau
	@plateauGtk
	@timeDebut 
	@timeFinal
	@nb_indices = 0
	@nb_undo = 0
	@id_grille


	def Jouer.afficher(fenetre, langue, mode, id_grille)
		boutonRetour = Gtk::Button.new(langue.retour)
		boutonReset = Gtk::Button.new('Reset')
		boutonAide = Gtk::Button.new('Aide')
		boutonRedo = Gtk::Button.new('Redo')
		boutonUndo = Gtk::Button.new('Undo')
		boutonHypo = Gtk::Button.new('Débuter hypothese')
		boutonTestGrille = Gtk::Button.new("Test")#a integrer dans la langue
		vbox = Gtk::VBox.new(false,10)
		hbox = Gtk::HBox.new(false,0)
		labelTimer = Gtk::Label.new('Timer : '+'0')

		if (mode == "rapide" && id_grille == 0)
			grille = ModelGrille.getGrilleById(Random.new(Time.now.sec).rand(1..7000))
		elsif (mode == "chrono" && id_grille == 0)
			grille = ModelGrille.getRandomGrille(1,6)
		elsif (id_grille < 0)
			grille = ModelGrille.getGrilleById(id_grille*(-1))
		else
			grille = ModelGrille.getRandomGrille(1,6)
		end
		@id_grille = grille.id

		stringDebut = grille.base
		stringFin = grille.solution
		len = Math.sqrt(stringFin.length).to_i
		@plateau = Plateau.new(stringDebut,stringFin,boutonUndo,boutonRedo)
		@plateauGtk = PlateauGtk.creer(vbox,@plateau,len)
		
		boutonUndo.set_sensitive(false)
		boutonRedo.set_sensitive(false)
		
		t1 = Thread.new do
			@timeDebut = Time.now
			while (!@plateau.testGrille)
				sleep 0.1
				labelTimer.label=('Timer : '+ (Time.now-@timeDebut).to_i.to_s)
			end
			@timeFinal = (Time.now-@timeDebut)
			fenetre.remove(vbox)
			FinPartie.afficher(fenetre, langue, @timeFinal, mode, grille, @nb_undo, @nb_indices)

			#enregistrer score dans bdd
		end
		
		boutonRetour.signal_connect('clicked'){
			Thread.kill(t1)
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		boutonHypo.signal_connect('clicked'){
			if @hypothese 
				@hypothese=false
				boutonHypo.set_label('Débuter hypothese')
				@plateau.annulerHypothese
				@plateauGtk.annulerHypothese
				
			else
				@hypothese=true
				boutonHypo.set_label('Abandonner hypothese')
				@plateau.debuterHypothese
				@plateauGtk.debuterHypothese
			end
		}
		
		boutonUndo.signal_connect('clicked'){
			@nb_undo = @nb_undo + 1
			mouv=@plateau.undo
			if mouv.flag
				boutonUndo.set_sensitive(false)
			end
			boutonRedo.set_sensitive(true)
			@plateauGtk.changerImgBouton(mouv.x,mouv.y,mouv.etatPrecedent)
		}
		
		boutonRedo.signal_connect('clicked'){
			mouv=@plateau.unundo
			if mouv.flag
				boutonRedo.set_sensitive(false)
			end
			boutonUndo.set_sensitive(true)
			@plateauGtk.changerImgBouton(mouv.x,mouv.y,mouv.etatPrecedent)
		}

		boutonReset.signal_connect('clicked'){
			Thread.kill(t1)
			@nb_indices = 0
			@nb_undo = 0
			fenetre.remove(vbox)
			Jouer.afficher(fenetre, langue, mode, @id_grille*(-1))
		}


		boutonTestGrille.signal_connect('clicked'){
			@nb_indices = @nb_indices + 1
			md = Gtk::MessageDialog.new(fenetre,Gtk::Dialog::DESTROY_WITH_PARENT,Gtk::MessageDialog::INFO,Gtk::MessageDialog::BUTTONS_CLOSE,"Nombre d'erreurs : " + @plateau.testCurrentGrille.to_s)
			md.run
			md.destroy
		}

		boutonAide.signal_connect('clicked'){
			@plateau.aide
		}

		vbox.add(@plateauGtk.table)

		vbox.add(boutonAide)
		vbox.add(boutonTestGrille)
		hbox.add(boutonUndo)
		hbox.add(boutonRedo)
		vbox.add(hbox)
		vbox.add(boutonHypo)
		vbox.add(boutonReset)
		vbox.add(boutonRetour)
		vbox.add(labelTimer)
		
		fenetre.add(vbox)
		fenetre.show_all
	end


end
