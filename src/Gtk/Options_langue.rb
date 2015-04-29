#Classe qui permet au joueur de changer la langue de l'interface
class Langue

	##
	#Méthode d'affichage de la sélection de la langue
	def Langue.afficher(fenetre, langue)
		vbox = Gtk::VBox.new(false,10)

		boutonFr = Gtk::Button.new('Fr')
		boutonFr.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, Langue.new('fr'))
		}

		boutonEn = Gtk::Button.new('En')
		boutonEn.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, Langue.new('en'))
		}

		boutonRetour = Gtk::Button.new(langue.retour)
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		boutonOptions = Gtk::Button.new(langue.options)
		boutonOptions.signal_connect('clicked'){
			fenetre.remove(vbox)
			Options.afficher(fenetre, langue)
		}

		vbox.add(boutonFr)
		vbox.add(boutonEn)
		vbox.add(boutonOptions)
		vbox.add(boutonRetour)
		fenetre.add(vbox)
		fenetre.show_all
	end
end
