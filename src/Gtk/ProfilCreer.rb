#Classe qui petmet à l'utilisateur de se créer un profil de jeu
class ProfilCreer
	
	##
	#Méthode d'affichagde de la classe
	def ProfilCreer.afficher(fenetre, langue)
		vbox = Gtk::VBox.new(false,10)

		#Ajout du signal de retour au menu principal
		boutonRetour = Gtk::Button.new(langue.retour)
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		vb = Gtk::VBox.new(true, 6)

		hb = Gtk::HBox.new(false, 6)
		hb.pack_start(Gtk::Label.new('Nom'), false, true, 6)
		
		#Champ de saisie de texte correspondant au pseudo
		nom = Gtk::Entry.new
		
		hb.pack_start(nom, true, true)
		vb.pack_start(hb)

		hb = Gtk::HBox.new(false, 6)
		hb.pack_start(Gtk::Label.new('Mot de passe'), false, true, 6)
		
		#Champ de saisie de texte correspondant au mot de passe
		pass = Gtk::Entry.new
		pass.visibility = false
		
		hb.pack_start(pass, true, true)
		vb.pack_start(hb)

		boutonEnvoyer = Gtk::Button.new(langue.envoyer)
		
		#Ajout du signal permettant au joueur de valider son inscription
		boutonEnvoyer.signal_connect('clicked'){
			#Ajoute le joueur dans la base de donnée
			ModelJoueur.createJoueur(nom.text,pass.text)
			fenetre.remove(vbox)
			Profil.afficher(fenetre, langue)
		}

		vb.add(boutonEnvoyer)

		vbox.add(vb)
		vbox.add(boutonRetour)
		
		fenetre.add(vbox)
		fenetre.show_all
	end

end
