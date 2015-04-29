#Classe qui permet au joueur de gerer ses profils
class Profil

	##
	#Méthode d'affichage de l'écran de sélection des profils
	def Profil.afficher(fenetre, langue)
		vbox = Gtk::VBox.new(false,40)

		#Création des différents boutons et labels
		boutonRetour = Gtk::Button.new(langue.retour)
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}
		boutonRetour.set_size_request(0,25)

		boutonNouveau = Gtk::Button.new(langue.nouveauProfil)
		boutonNouveau.signal_connect('clicked'){
			fenetre.remove(vbox)
			Profil.creer(fenetre, langue)
		}

		boutonConnection = Gtk::Button.new(langue.p_conn)
		boutonConnection.signal_connect('clicked'){
			fenetre.remove(vbox)
			Profil.connection(fenetre, langue)
		}

		boutonDeconnexion = Gtk::Button.new(langue.p_deco)
		boutonDeconnexion.signal_connect('clicked'){
			$joueur = ModelJoueur.getAnon
			Takuzu.set_title("Takuzu Deluxe - " + $joueur.pseudo)
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		boutonSupprimer = Gtk::Button.new(langue.p_supProf)
		boutonSupprimer.signal_connect('clicked'){
			fenetre.remove(vbox)
			Profil.supprimer(fenetre, langue)
		}

		labelConnexion = Gtk::Label.new()
		labelConnexion.set_markup(langue.p_lab1)
		labelCreer = Gtk::Label.new()
		labelCreer.set_markup(langue.p_lab2)

		labelDeconnection = Gtk::Label.new()
		labelDeconnection.set_markup(langue.p_lab3)
		labelSuppression = Gtk::Label.new()
		labelSuppression.set_markup(langue.p_lab4)

		#Si l'utilisateur est Anonyme, on ajoute les boutons dédié a la connexion
		if ModelJoueur.testAnon($joueur)
			vbox.add(labelConnexion)
			vbox.add(boutonConnection)
			vbox.add(labelCreer)
			vbox.add(boutonNouveau)
		#Sinon on lui affiche ses statistiques de jeu, on lui propose de se déconnecter, de supprimer son compte ou de retourner au menu
		else
			nbParties = ModelScore.getNombreScoreOfJoueur($joueur.id)
			scoreTotal = ModelScore.getScoreTotalOfJoueur($joueur.id)
			tempsTotal = ModelScore.getTempsTotalOfJoueur($joueur.id)
			nbUndoTotal = ModelScore.getNombreUndoOfJoueur($joueur.id)
			nbPauseTotal = ModelScore.getNombrePauseOfJoueur($joueur.id)
			messageStats = langue.p_mStat1 + nbParties.to_s  + langue.p_mStat2
			if nbParties > 0
				scoreMoyen = scoreTotal/nbParties
				tempsMoyen = tempsTotal/nbParties
				messageStats = messageStats + langue.p_mStat3 + scoreTotal.to_s + langue.p_mStat4 + scoreMoyen.to_s + "."
				messageStats = messageStats + langue.p_mStat5 + tempsTotal.to_s + langue.p_mStat6 + tempsMoyen.to_s + langue.p_mStat7
				messageStats = messageStats + langue.p_mStat8  + nbUndoTotal.to_s + langue.p_mStat9 + nbPauseTotal.to_s + langue.p_mStat10
			end
			vbox.add(Profil.afficherProfilJoueur(langue))
			vbox.add(Gtk::Label.new(messageStats))
			vbox.add(labelDeconnection)
			vbox.add(boutonDeconnexion)
			vbox.add(labelSuppression)
			vbox.add(boutonSupprimer)

		end
		vbox.add(boutonRetour)
		fenetre.add(vbox)
		fenetre.show_all
	end

	##
	#Méthode d'affichage qui permet de demander au joueur les informations nécessaires a la création d'un compte
	def Profil.creer(fenetre, langue)
		vbox = Gtk::VBox.new(false,10)

		boutonRetour = Gtk::Button.new(langue.retour)
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		vb = Gtk::VBox.new(true, 6)

		hb = Gtk::HBox.new(false, 6)
		hb.pack_start(Gtk::Label.new(langue.pc_nom), false, true, 6)
		nom = Gtk::Entry.new
		hb.pack_start(nom, true, true)
		vb.pack_start(hb)

		hb = Gtk::HBox.new(false, 6)
		hb.pack_start(Gtk::Label.new(langue.pc_mdp), false, true, 6)
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

	##
	#Méthode d'affichage qui permet de demander au joueur les informations nécessaires pour se connecter a son compte (pseudo, mot de passe)
	def Profil.connection(fenetre, langue)
		vbox = Gtk::VBox.new(false,10)

		boutonRetour = Gtk::Button.new(langue.retour)
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		vb = Gtk::VBox.new(true, 6)

		hb = Gtk::HBox.new(false, 6)
		hb.pack_start(Gtk::Label.new(langue.pc_nom), false, true, 6)
		nom = Gtk::Entry.new
		hb.pack_start(nom, true, true)
		vb.pack_start(hb)

		hb = Gtk::HBox.new(false, 6)
		hb.pack_start(Gtk::Label.new(langue.pc_mdp), false, true, 6)
		pass = Gtk::Entry.new
		pass.visibility = false
		hb.pack_start(pass, true, true)
		vb.pack_start(hb)

		boutonEnvoyer = Gtk::Button.new(langue.envoyer)
		boutonEnvoyer.signal_connect('clicked'){
			 j_tmp = ModelJoueur.getJoueurByUsername(nom.text)
			if j_tmp != nil && j_tmp.password == pass.text
				$joueur = j_tmp
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

	##
	#Méthode d'affichage qui permet au joueur de valider ou non la destruction de son compte
	def Profil.supprimer(fenetre, langue)
		vbox = Gtk::VBox.new(false,10)

		boutonRetour = Gtk::Button.new(langue.retour)
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		label = Gtk::Label.new(langue.p_supprConf)

		vbox.add(label)

		vb = Gtk::VBox.new(true, 6)

		hb = Gtk::HBox.new(false, 6)
		hb.pack_start(Gtk::Label.new(langue.p_enterPass), false, true, 6)
		pass = Gtk::Entry.new
		pass.visibility = false
		hb.pack_start(pass, true, true)
		vb.pack_start(hb)

		boutonEnvoyer = Gtk::Button.new(langue.envoyer)
		boutonEnvoyer.signal_connect('clicked'){
			if $joueur.password == pass.text
				ModelJoueur.suprJoueurById($joueur.id)
				$joueur = ModelJoueur.getAnon
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

	##
	#Méthode d'affichage du profil du joueur
	def Profil.afficherProfilJoueur(langue)
		label = Gtk::Label.new(langue.p_user+ $joueur.pseudo)
		return label
	end

end
