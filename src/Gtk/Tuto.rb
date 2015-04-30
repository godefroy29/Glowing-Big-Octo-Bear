#Classe qui permet au joueur de jouer au tutoriel
class Tuto

	@plateau	#plateau de jeu
	@plateauGtk	#représentation graphique du plateau de jeu
	@nb_indices = 0	#le nombre d'indices utilisés par le joueur durant le tuto
	@nb_undo = 0	#le nombre d'indices utilisés par le joueur durant le tuto
	@id_grille	#id de la grille de tuto
	@hypothese	#le nombre d'hypothese utilisé

	##
	#Méthode permettant de jouer au tuto
	def Tuto.afficher(fenetre, langue)
		boutonRetour = Gtk::Button.new(langue.retour)
		boutonRedo = Gtk::Button.new(langue.j_redo)
		boutonUndo = Gtk::Button.new(langue.j_undo)
		boutonPause = Gtk::Button.new(langue.j_pause)
		boutonHypo = Gtk::Button.new(langue.j_debHypo)
		boutonValHypo = Gtk::Button.new(langue.j_debHypo)
		boutonTestGrille = Gtk::Button.new("Test")#a integrer dans la langue
		vbox = Gtk::VBox.new(false,10)
		hbox2 = Gtk::HBox.new(false,0)
		hbox = Gtk::HBox.new(false,0)
		@hypothese=false

		stringDebut = "11__0_0________0"
		stringFin = "1100010100111010"
		len = Math.sqrt(stringFin.length).to_i #a remplacé par la taille de la grille de la BdD
		
		#Initialise le plateau et sa représentation graphique
		@plateau = Plateau.new(stringDebut,stringFin,boutonUndo,boutonRedo)
		@plateauGtk = PlateauGtk.creer(vbox,@plateau,len)
		
		boutonValHypo.set_sensitive(false)
		boutonUndo.set_sensitive(false)
		boutonRedo.set_sensitive(false)
		
		#Thread qui gére le tuto
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
			md1 = Gtk::MessageDialog.new(fenetre,Gtk::Dialog::DESTROY_WITH_PARENT,Gtk::MessageDialog::QUESTION,Gtk::MessageDialog::BUTTONS_NONE,langue.d_1)
			md1.action_area.pack_start(boutonClose1)
			md1.show_all
			fenetre.set_sensitive(false)
			while !n
				sleep 0.1
			end
			n=false
			fenetre.set_sensitive(true)
			md1.destroy
			md2 = Gtk::MessageDialog.new(fenetre,Gtk::Dialog::DESTROY_WITH_PARENT,Gtk::MessageDialog::QUESTION,Gtk::MessageDialog::BUTTONS_NONE,langue.d_2)
			md2.action_area.pack_start(boutonClose2)
			md2.show_all
			fenetre.set_sensitive(false)
			while !n
				sleep 0.1
			end
			n=false
			fenetre.set_sensitive(true)
			md2.destroy
			
			while(@plateau.getColorStr(2,0)!="bleu" && @plateau.getColorStr(1,1)!="rouge" )
				sleep 0.1
			end
			
			md3 = Gtk::MessageDialog.new(fenetre,Gtk::Dialog::DESTROY_WITH_PARENT,Gtk::MessageDialog::QUESTION,Gtk::MessageDialog::BUTTONS_NONE,langue.d_3)
			md3.action_area.pack_start(boutonClose3)
			md3.show_all
			fenetre.set_sensitive(false)
			while !n
				sleep 0.1
			end
			n=false
			fenetre.set_sensitive(true)
			md3.destroy
			
			while(@plateau.getColorStr(1,3)!="bleu" && @plateau.getColorStr(2,3)!="rouge" )
				sleep 0.1
			end
			
			md4 = Gtk::MessageDialog.new(fenetre,Gtk::Dialog::DESTROY_WITH_PARENT,Gtk::MessageDialog::QUESTION,Gtk::MessageDialog::BUTTONS_NONE,langue.d_4)
			md4.action_area.pack_start(boutonClose4)
			md4.show_all
			fenetre.set_sensitive(false)
			while !n
				sleep 0.1
			end
			n=false
			fenetre.set_sensitive(true)
			md4.destroy

			while (!@plateau.testGrille)
				sleep 0.1
			end

			md5 = Gtk::MessageDialog.new(fenetre,Gtk::Dialog::DESTROY_WITH_PARENT,Gtk::MessageDialog::QUESTION,Gtk::MessageDialog::BUTTONS_NONE,langue.d_5)
			md5.action_area.pack_start(boutonClose5)
			md5.show_all
			fenetre.set_sensitive(false)
			while !n
				sleep 0.1
			end
			n=false
			fenetre.set_sensitive(true)
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
			boutonHypo.set_label(langue.j_debHypo)
			boutonValHypo.set_sensitive(false)
			@plateauGtk.validerHypothese
		}
		
		boutonHypo.signal_connect('clicked'){
			if @hypothese 
				@hypothese=false
				boutonValHypo.set_sensitive(false)
				boutonHypo.set_label(langue.j_debHypo)
				@plateau.annulerHypothese
				@plateauGtk.annulerHypothese
				
			else
				@hypothese=true
				boutonValHypo.set_sensitive(true)
				boutonHypo.set_label(langue.j_annHypo)
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
			md = Gtk::MessageDialog.new(fenetre,Gtk::Dialog::DESTROY_WITH_PARENT,Gtk::MessageDialog::QUESTION,Gtk::MessageDialog::BUTTONS_CLOSE,t.regle)
			md.run
			md.destroy
			fenetre.add(vbox)
		}


		boutonTestGrille.signal_connect('clicked'){
			@nb_indices = @nb_indices + 1
			md = Gtk::MessageDialog.new(fenetre,Gtk::Dialog::DESTROY_WITH_PARENT,Gtk::MessageDialog::INFO,Gtk::MessageDialog::BUTTONS_CLOSE,t.help + @plateau.testCurrentGrille.to_s)
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

