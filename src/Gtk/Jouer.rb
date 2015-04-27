# encoding: UTF-8

class Jouer

	@plateau
	@plateauGtk
	@timeDebut 
	@timeFinal
	@nb_indices = 0
	@nb_undo = 0
	@id_grille
	@hypothese


	def Jouer.afficher(fenetre, langue, mode, id_grille)
		boutonRetour = Gtk::Button.new(langue.retour)
		boutonSauvegarde = Gtk::Button.new("Sauvegarde rapide")
		boutonReset = Gtk::Button.new('Reset')
		boutonAide = Gtk::Button.new('Aide')
		boutonRedo = Gtk::Button.new('Redo')
		boutonUndo = Gtk::Button.new('Undo')
		boutonPause = Gtk::Button.new('Pause')
		boutonHypo = Gtk::Button.new('Débuter hypothese')
		boutonValHypo = Gtk::Button.new('Valider Hypothese')
		boutonTestGrille = Gtk::Button.new("Test")#a integrer dans la langue
		vbox = Gtk::VBox.new(false,10)
		hbox2 = Gtk::HBox.new(false,0)
		hbox = Gtk::HBox.new(false,0)
		labelTimer = Gtk::Label.new('Timer : '+'0')
		@hypothese=false



		
		if (mode == "rapide" && id_grille == 0)
			grille = ModelGrille.getGrilleById(Random.new(Time.now.sec).rand(1..7000))
		elsif (mode == "chrono" && id_grille == 0)
			grille = ModelGrille.getRandomGrille(1,6)
		elsif (id_grille < 0)
			grille = ModelGrille.getGrilleById(id_grille*(-1))
		else
			grille = ModelGrille.getGrilleById(id_grille)
		end
		
		#if (mode == "rapide" && !(ModelJoueur.testAnon($joueur)))
		#	old = ModelScore.getScoreByJoueurAndMode($joueur,0)
		#	if old != nil
		#		grille = ModelGrille.getGrilleById(old.id_grille)
		#	end
		#end
		
		@id_grille = grille.id

		stringDebut = grille.base
		stringFin = grille.solution
		len = Math.sqrt(stringFin.length).to_i
		@plateau = Plateau.new(stringDebut,stringFin,boutonUndo,boutonRedo)
		@plateauGtk = PlateauGtk.creer(vbox,@plateau,len)
		
		boutonValHypo.set_sensitive(false)
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
			
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		boutonSauvegarde.signal_connect('clicked'){
			Score.ajouteScoreSauvegarde($joueur.id,grille.id,temps.to_i,nb_undo,nb_indices)
			Thread.kill(t1)
			Thread.kill(t1)
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}


		boutonValHypo.signal_connect('clicked'){
			@hypothese=false
			boutonHypo.set_label('Débuter hypothese')
			boutonValHypo.set_sensitive(false)
			@plateauGtk.validerHypothese
		}
		
		boutonHypo.signal_connect('clicked'){
			if @hypothese 
				@hypothese=false
				boutonValHypo.set_sensitive(false)
				boutonHypo.set_label('Débuter hypothese')
				@plateau.annulerHypothese
				@plateauGtk.annulerHypothese
				
			else
				@hypothese=true
				boutonValHypo.set_sensitive(true)
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
		
		boutonPause.signal_connect('clicked'){
			fenetre.remove(vbox)
			timePause = Time.now
			md = Gtk::MessageDialog.new(fenetre,Gtk::Dialog::DESTROY_WITH_PARENT,Gtk::MessageDialog::QUESTION,Gtk::MessageDialog::BUTTONS_CLOSE,"  Les 3 règles du Takuzu sont les suivantes :\n_Il est interdit d'aligner plus de deux cases de la même couleur\n_Deux lignes ou colonnes ne doivent pas être identiques\n_Chaque colonne et ligne doivent comporter autant de cases des deux couleurs ")
			md.run
			md.destroy
			timePause = Time.now()-timePause
			@timeDebut = @timeDebut +timePause
			fenetre.add(vbox)
		}

		boutonReset.signal_connect('clicked'){
			#Thread.kill(t1)
			#@nb_indices = 0
			#@nb_undo = 0
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
			aide = @plateau.aide
			if aide.regle == 1
				s = "Regle 1 : Tuile x:#{aide.x+1},y:#{aide.y+1}"
			elsif aide.regle == 2
				s = "Regle 2 : #{aide.type} #{aide.x+1} "
			elsif aide.regle == 3
				s = "Regle 3 : #{aide.type} #{aide.x+1} et #{aide.type} #{aide.y+1}"
			end
			md = Gtk::MessageDialog.new(
				fenetre,
				Gtk::Dialog::DESTROY_WITH_PARENT,
				Gtk::MessageDialog::INFO,
				Gtk::MessageDialog::BUTTONS_CLOSE,
				s)
			md.run
			md.destroy
		}

		vbox.add(@plateauGtk.table)

		vbox.add(boutonAide)
		vbox.add(boutonTestGrille)
		vbox.add(boutonPause)
		hbox.add(boutonUndo)
		hbox.add(boutonRedo)
		vbox.add(hbox)
		hbox2.add(boutonHypo)
		hbox2.add(boutonValHypo)
		vbox.add(hbox2)
		vbox.add(boutonReset)
		if (mode == "rapide" && !(ModelJoueur.testAnon($joueur)))
			vbox.add(boutonSauvegarde)
		end
		vbox.add(boutonRetour)
		vbox.add(labelTimer)
		
		fenetre.add(vbox)
		fenetre.show_all
	end


end
