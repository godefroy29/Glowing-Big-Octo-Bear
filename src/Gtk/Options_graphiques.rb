#Options_graphiques.rb


class Graphique

	def Graphique.afficher(fenetre, langue)
		vbox = Gtk::VBox.new(false,10)

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

		vbox.add(boutonOptions)
		vbox.add(boutonRetour)
		fenetre.add(vbox)
		fenetre.show_all
	end
end