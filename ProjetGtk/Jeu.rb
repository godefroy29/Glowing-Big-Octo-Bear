# encoding: UTF-8

# Permet de lancer une partie

load "ProjetGtk.rb"
load "Langue.rb"
load "Menu.rb"
load "Credits.rb"

#Lancement de la fenetre de jeu générée par Gtk
Gtk.init
builder = Gtk::Window.new()
builder.set_default_size(1024,768)
builder.set_title("TakuZu Deluxe")
langue = Langue.new()
Menu.afficher(builder, langue)

builder.show_all
Gtk.main