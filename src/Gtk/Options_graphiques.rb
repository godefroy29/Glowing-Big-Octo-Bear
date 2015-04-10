#Options_graphiques.rb


class Graphique

	#Couleur de jeu (de base rouge/bleu)
	@@couleur1
	@@couleur2
	@@c1
	@@c2

	def initialize()
		@@c1 = Gdk::Color.parse("#2222EE")
		@@c2 = Gdk::Color.parse("#EE2222")
		@@couleur1 = Gtk::Style.new	
		@@couleur2 = Gtk::Style.new
		@@couleur1.set_bg(Gtk::STATE_PRELIGHT, @@c1.red, @@c1.green, @@c1.blue)
		@@couleur1.set_bg(Gtk::STATE_NORMAL, @@c1.red, @@c1.green, @@c1.blue)
		@@couleur2.set_bg(Gtk::STATE_PRELIGHT, @@c2.red, @@c2.green, @@c2.blue)
		@@couleur2.set_bg(Gtk::STATE_NORMAL, @@c2.red, @@c2.green, @@c2.blue)

	end

	def couleur1
		return @@couleur1
	end

	def couleur2
		return @@couleur2
	end

	def Graphique.afficher(fenetre, langue)
		
		vbox = Gtk::VBox.new(false,10)

		boutonCouleur1 = Gtk::ColorButton.new(@@c1)
		boutonCouleur1.signal_connect('color-set'){
			@@c1 = boutonCouleur1.color
			@@couleur1.set_bg(Gtk::STATE_PRELIGHT, @@c1.red, @@c1.green, @@c1.blue)
			@@couleur1.set_bg(Gtk::STATE_NORMAL, @@c1.red, @@c1.green, @@c1.blue)
		}
		boutonCouleur2 = Gtk::ColorButton.new(@@c2)
		boutonCouleur2.signal_connect('color-set'){
			@@c2 = boutonCouleur2.color
			@@couleur2.set_bg(Gtk::STATE_PRELIGHT, @@c2.red, @@c2.green, @@c2.blue)
			@@couleur2.set_bg(Gtk::STATE_NORMAL, @@c2.red, @@c2.green, @@c2.blue)
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
		vbox.add(boutonCouleur1)
		vbox.add(boutonCouleur2)
		vbox.add(boutonOptions)
		vbox.add(boutonRetour)
		fenetre.add(vbox)
		fenetre.show_all
	end
end
