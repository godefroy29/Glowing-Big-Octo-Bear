# encoding: UTF-8

class Credits

	##
	# Méthode affichant les crédits
	# Paramètres::
	# - fenetre : la fenetre dans laquelle afficher les elements
	# - langue : la langue de la fenetre
	def Credits.afficher(fenetre, langue)

		label = Gtk::Label.new(langue.texte)
		boutonRetour = Gtk::Button.new(langue.retour)
		vbox = Gtk::VBox.new(false,10)
		
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		vbox.add(label)
		vbox.add(boutonRetour)

		fenetre.add(vbox)
		fenetre.show_all
	end

end