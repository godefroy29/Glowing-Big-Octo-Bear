class Profil

	def Profil.afficher(fenetre, langue)
		vbox = Gtk::VBox.new(false,10)

		boutonRetour = Gtk::Button.new(langue.retour)
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		boutonNouveau = Gtk::Button.new(langue.nouveauProfil)
		boutonNouveau.signal_connect('clicked'){
			fenetre.remove(vbox)
			Profil.creer(fenetre, langue)
		}

		boutonConnection = Gtk::Button.new("Connexion")
		boutonConnection.signal_connect('clicked'){
			fenetre.remove(vbox)
			Profil.connection(fenetre, langue)
		}

		boutonDeconnexion = Gtk::Button.new("Deconnexion")
		boutonDeconnexion.signal_connect('clicked'){
			$joueur = ModelJoueur.getAnon
			Takuzu.set_title("Takuzu Deluxe - " + $joueur.pseudo)
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		if ModelJoueur.testAnon($joueur)
			vbox.add(boutonConnection)
			vbox.add(boutonNouveau)
		else
			vbox.add(Profil.afficherProfilJoueur)
			vbox.add(boutonDeconnexion)

		end
		vbox.add(boutonRetour)
		fenetre.add(vbox)
		fenetre.show_all
	end


	def Profil.creer(fenetre, langue)
		vbox = Gtk::VBox.new(false,10)

		boutonRetour = Gtk::Button.new(langue.retour)
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}


		vb = Gtk::VBox.new(true, 6)

		hb = Gtk::HBox.new(false, 6)
		hb.pack_start(Gtk::Label.new('Nom'), false, true, 6)
		nom = Gtk::Entry.new
		hb.pack_start(nom, true, true)
		vb.pack_start(hb)

		hb = Gtk::HBox.new(false, 6)
		hb.pack_start(Gtk::Label.new('Mot de passe'), false, true, 6)
		pass = Gtk::Entry.new
		pass.visibility = false
		hb.pack_start(pass, true, true)
		vb.pack_start(hb)

		boutonEnvoyer = Gtk::Button.new(langue.envoyer)
		boutonEnvoyer.signal_connect('clicked'){
			j_tmp =  ModelJoueur.createJoueur(nom.text,pass.text)
			if j_tmp != nil
				$joueur = j_tmp
				fenetre.remove(vbox)
				Takuzu.set_title("Takuzu Deluxe - " + $joueur.pseudo)
				Menu.afficher(fenetre, langue)
			else
				fenetre.remove(vbox)
				Profil.afficher(fenetre, langue)
			end
		}



		vb.add(boutonEnvoyer)

		vbox.add(vb)
		vbox.add(boutonRetour)
		fenetre.add(vbox)
		fenetre.show_all
	end

	def Profil.connection(fenetre, langue)
		vbox = Gtk::VBox.new(false,10)

		boutonRetour = Gtk::Button.new(langue.retour)
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}


		vb = Gtk::VBox.new(true, 6)

		hb = Gtk::HBox.new(false, 6)
		hb.pack_start(Gtk::Label.new('Nom'), false, true, 6)
		nom = Gtk::Entry.new
		hb.pack_start(nom, true, true)
		vb.pack_start(hb)

		hb = Gtk::HBox.new(false, 6)
		hb.pack_start(Gtk::Label.new('Mot de passe'), false, true, 6)
		pass = Gtk::Entry.new
		pass.visibility = false
		hb.pack_start(pass, true, true)
		vb.pack_start(hb)

		boutonEnvoyer = Gtk::Button.new(langue.envoyer)
		boutonEnvoyer.signal_connect('clicked'){
			 j_tmp = ModelJoueur.getJoueurByUsername(nom.text)
			if j_tmp != nil && j_tmp.password == pass.text
				$joueur = j_tmp
				p $joueur.pseudo
			end
			fenetre.remove(vbox)
			Takuzu.set_title("Takuzu Deluxe - " + $joueur.pseudo)
			Menu.afficher(fenetre, langue)
		}




		vb.add(boutonEnvoyer)

		vbox.add(vb)
		vbox.add(boutonRetour)
		fenetre.add(vbox)
		fenetre.show_all
	end

	def Profil.afficherProfilJoueur
		label = Gtk::Label.new("Utilisateur : "+ $joueur.pseudo)
		return label
	
	end


end