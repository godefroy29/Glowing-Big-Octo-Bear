# encoding: UTF-8

# Permet de lancer une partie

#Lancement de la fenetre de jeu générée par Gtk
class Takuzu

	def Takuzu.launch(lang)
		Gtk.init
		builder = Gtk::Window.new()
		builder.set_default_size(1024,768)
		builder.set_title("TakuZu Deluxe")
		langue = Langue.new(lang)
		Menu.afficher(builder, langue)

		builder.show_all
		Gtk.main
	end

end