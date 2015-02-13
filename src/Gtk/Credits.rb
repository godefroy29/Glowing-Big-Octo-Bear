# encoding: UTF-8

##
# Auteur PHILIPPE ARMANGER
# Version 0.1 : Date : Wed Jan 21 15:35:38 CET 2015
#

class Credits

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



		pix_blue = Gdk::Pixbuf.new("blue.png",200,200)
		pix_red = Gdk::Pixbuf.new("red.png",200,200)
		red = Gtk::Image.new(pix_red)
		blue = Gtk::Image.new(pix_blue)

		btn_tmp = Gtk::Button.new("vide")
		btn_tmp.image = blue

		vbox.add(btn_tmp)













		
		fenetre.add(vbox)
		fenetre.show_all
	end

	


end # Marqueur de fin de classe
