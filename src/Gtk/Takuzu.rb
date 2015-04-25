# encoding: UTF-8

# Permet de lancer une partie

#Lancement de la fenetre de jeu générée par Gtk
class Takuzu

	@builder

	def Takuzu.launch()
		Gtk.init
		@builder = Gtk::Window.new()
		@builder.set_default_size(320,240)
		@builder.set_title("Takuzu Deluxe - " + $joueur.pseudo)
		
		langue = Langue.new('fr')
		Menu.afficher(@builder, langue)

		@builder.show_all
		Gtk.main
	end

	def Takuzu.set_title(s)
		@builder.set_title(s)
		@builder.show_all
	end

end