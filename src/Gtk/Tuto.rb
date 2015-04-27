# encoding: UTF-8

class Tuto

	@plateau
	@plateauGtk
	@nb_indices = 0
	@nb_undo = 0
	@id_grille
	@hypothese


	def Tuto.afficher(fenetre, langue)
		boutonRetour = Gtk::Button.new(langue.retour)
		boutonRedo = Gtk::Button.new('Redo')
		boutonUndo = Gtk::Button.new('Undo')
		boutonPause = Gtk::Button.new('Pause')
		boutonHypo = Gtk::Button.new('Débuter hypothese')
		boutonValHypo = Gtk::Button.new('Valider Hypothese')
		boutonTestGrille = Gtk::Button.new("Test")#a integrer dans la langue
		vbox = Gtk::VBox.new(false,10)
		hbox2 = Gtk::HBox.new(false,0)
		hbox = Gtk::HBox.new(false,0)
		@hypothese=false

		stringDebut = "11__0_0________0"
		stringFin = "1100010100111010"
		len = Math.sqrt(stringFin.length).to_i
		@plateau = Plateau.new(stringDebut,stringFin,boutonUndo,boutonRedo)
		@plateauGtk = PlateauGtk.creer(vbox,@plateau,len)
		
		boutonValHypo.set_sensitive(false)
		boutonUndo.set_sensitive(false)
		boutonRedo.set_sensitive(false)
		
		t1 = Thread.new do
			n = false
			boutonClose1 = Gtk::Button.new("OK")
			
			boutonClose1.signal_connect('clicked'){
				n=true
			}
			boutonClose2 = Gtk::Button.new("OK")
			
			boutonClose2.signal_connect('clicked'){
				n=true
			}
			boutonClose3 = Gtk::Button.new("OK")
			
			boutonClose3.signal_connect('clicked'){
				n=true
			}
			boutonClose4 = Gtk::Button.new("OK")
			
			boutonClose4.signal_connect('clicked'){
				n=true
			}
			boutonClose5 = Gtk::Button.new("OK")
			
			boutonClose5.signal_connect('clicked'){
				n=true
			}
			sleep 0.5
			md1 = Gtk::MessageDialog.new(fenetre,Gtk::Dialog::DESTROY_WITH_PARENT,Gtk::MessageDialog::QUESTION,Gtk::MessageDialog::BUTTONS_NONE,"Bienvenue dans le tutoriel du jeu de Takuzu\nLe but est de compléter la grille\nIl est interdit d'avoir trois tuiles de même couleur adjacentes ")
			md1.action_area.pack_start(boutonClose1)
			md1.show_all
			while !n
				sleep 0.1
			end
			n=false
			md1.destroy
			md2 = Gtk::MessageDialog.new(fenetre,Gtk::Dialog::DESTROY_WITH_PARENT,Gtk::MessageDialog::QUESTION,Gtk::MessageDialog::BUTTONS_NONE,"Pour changer la couleur d'une tuile, cliquez une fois dessous pour la rendre rouge, et deux fois pour bleu ")
			md2.action_area.pack_start(boutonClose2)
			md2.show_all
			while !n
				sleep 0.1
			end
			n=false
			md2.destroy
			
			while(@plateau.getColorStr(2,0)!="bleu" && @plateau.getColorStr(1,1)!="rouge" )
				sleep 0.1
			end
			
			md3 = Gtk::MessageDialog.new(fenetre,Gtk::Dialog::DESTROY_WITH_PARENT,Gtk::MessageDialog::QUESTION,Gtk::MessageDialog::BUTTONS_NONE,"La deuxième règle stipule que chaque ligne et colonne doivent contenir le même nombre de tuiles bleues et rouges\nCombinez cette règle et la première pour continuer à avancer")
			md3.action_area.pack_start(boutonClose3)
			md3.show_all
			while !n
				sleep 0.1
			end
			n=false
			md3.destroy
			
			while(@plateau.getColorStr(1,3)!="bleu" && @plateau.getColorStr(2,3)!="rouge" )
				sleep 0.1
			end
			
			md4 = Gtk::MessageDialog.new(fenetre,Gtk::Dialog::DESTROY_WITH_PARENT,Gtk::MessageDialog::QUESTION,Gtk::MessageDialog::BUTTONS_NONE,"La dernière règle stipule que deux lignes ou colonnes ne doivent pas être identiques \nAvec ces trois règles, vous êtes maintenant en mesure de finir toute partie de Takuzu")
			md4.action_area.pack_start(boutonClose4)
			md4.show_all
			while !n
				sleep 0.1
			end
			n=false
			md4.destroy

			while (!@plateau.testGrille)
				sleep 0.1
			end

			md5 = Gtk::MessageDialog.new(fenetre,Gtk::Dialog::DESTROY_WITH_PARENT,Gtk::MessageDialog::QUESTION,Gtk::MessageDialog::BUTTONS_NONE,"Félicitations ! \nVous pouvez relire les règles à tout moment en mettant le jeu en pause.")
			md5.action_area.pack_start(boutonClose5)
			md5.show_all
			while !n
				sleep 0.1
			end
			n=false
			md5.destroy
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)

		end
		
		boutonRetour.signal_connect('clicked'){
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
			md = Gtk::MessageDialog.new(fenetre,Gtk::Dialog::DESTROY_WITH_PARENT,Gtk::MessageDialog::QUESTION,Gtk::MessageDialog::BUTTONS_CLOSE,"  Les 3 règles du Takuzu sont les suivantes :\n_Il est interdit d'aligner plus de deux cases de la même couleur\n_Deux lignes ou colonnes ne doivent pas être identiques\n_Chaque colonne et ligne doivent comporter autant de cases des deux couleurs ")
			md.run
			md.destroy
			fenetre.add(vbox)
		}


		boutonTestGrille.signal_connect('clicked'){
			@nb_indices = @nb_indices + 1
			md = Gtk::MessageDialog.new(fenetre,Gtk::Dialog::DESTROY_WITH_PARENT,Gtk::MessageDialog::INFO,Gtk::MessageDialog::BUTTONS_CLOSE,"Nombre d'erreurs : " + @plateau.testCurrentGrille.to_s)
			md.run
			md.destroy
		}
		
		vbox.add(@plateauGtk.table)

		vbox.add(boutonTestGrille)
		vbox.add(boutonPause)
		hbox.add(boutonUndo)
		hbox.add(boutonRedo)
		vbox.add(hbox)
		hbox2.add(boutonHypo)
		hbox2.add(boutonValHypo)
		vbox.add(hbox2)
		vbox.add(boutonRetour)
		
		fenetre.add(vbox)
		fenetre.show_all
	end
end

