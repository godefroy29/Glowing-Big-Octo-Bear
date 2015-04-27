# encoding: UTF-8

##
# Auteur PHILIPPE ARMANGER
# Version 0.1 : Date : Wed Jan 21 15:35:38 CET 2015
#

class Credits

	def Credits.afficher(fenetre, langue)
		#label = Gtk::Label.new(langue.texte)
		label = Gtk::Label.new()
		label.set_markup("<big>Takuzu Deluxe</big>\n\n<small>Version 0.1</small>\n\n<b>L'equipe :</b>\n<i>Chef de projet :</i>\n\tGodefroy Poirier\n<i>Sans denomination fixe :</i>\n\tEtienne Offredi\n\tBenoit Letay\n\tSylvain Loizeau\n\t<s>Philippe Armanger</s>\n<i>Documentaliste :</i>\n\t<s>Pierre Kunkel</s>")
		boutonRetour = Gtk::Button.new(langue.retour)
		vbox = Gtk::VBox.new(false,10)

		label.set_size_request(0,600)
		boutonRetour.set_size_request(0,25)
		
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		vbox.add(label)
		vbox.add(boutonRetour)

		fenetre.add(vbox)
		fenetre.show_all
	end

	


end # Marqueur de fin de classe
