class ProfilCreer

	##
	# Méthode affichant la fenetre de creation de profil
	# Paramètres::
	# - fenetre : la fenetre dans laquelle afficher les elements
	# - langue : la langue de la fenetre
	def ProfilCreer.afficher(fenetre, langue)
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