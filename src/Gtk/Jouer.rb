# encoding: UTF-8

class Jouer

	@plateau
	@plateauGtk
	@timeDebut = Time.now
	@timeFinal
	


	def Jouer.afficher(fenetre, langue, mode)
		boutonRetour = Gtk::Button.new(langue.retour)
		boutonReset = Gtk::Button.new('Reset')
		boutonRedo = Gtk::Button.new('Redo')
		boutonUndo = Gtk::Button.new('Undo')
		boutonHypo = Gtk::Button.new('Débuter hypothese')
		boutonTestGrille = Gtk::Button.new("Test")#a integrer dans la langue
		vbox = Gtk::VBox.new(false,10)
		hbox = Gtk::HBox.new(false,0)
		labelTimer = Gtk::Label.new('Timer : '+'0')

		if mode == "rapide"
			grille = ModelGrille.getGrilleById(Random.new(Time.now.sec).rand(1..7000))
		else
			grille = ModelGrille.getRandomGrille(1,6)
		end

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
			FinPartie.afficher(fenetre, langue, @timeFinal)

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
			fenetre.remove(vbox)
			@timeDebut = Time.now
			Jouer.afficher(fenetre, langue, mode)
		}


		boutonTestGrille.signal_connect('clicked'){
			md = Gtk::MessageDialog.new(fenetre,Gtk::Dialog::DESTROY_WITH_PARENT,Gtk::MessageDialog::INFO,Gtk::MessageDialog::BUTTONS_CLOSE,"Nombre d'erreurs : " + @plateau.testCurrentGrille.to_s)
			md.run
			md.destroy
		}

		vbox.add(@plateauGtk.table)

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
