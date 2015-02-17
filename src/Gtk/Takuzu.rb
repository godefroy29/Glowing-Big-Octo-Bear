# encoding: UTF-8

# Permet de lancer une partie

#Lancement de la fenetre de jeu générée par Gtk
class Takuzu

	def Takuzu.launch()
		Gtk.init
		builder = Gtk::Window.new()
		builder.set_default_size(320,240)
		builder.set_title("TakuZu Deluxe")
		langue = Langue.new('fr')
		Menu.afficher(builder, langue)

		builder.show_all
		Gtk.main
	end

end