# encoding: UTF-8

class Takuzu

	@builder

	##
	# Méthode lançant le jeu
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

	##
	# Méthode affichant la fenetre de partie rapide
	# Paramètres::
	# - s : le nom de la fenetre
	def Takuzu.set_title(s)
		@builder.set_title(s)
		@builder.show_all
	end

end