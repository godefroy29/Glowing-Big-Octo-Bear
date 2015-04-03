require 'sqlite3'


load "./Gtk/ProjetGtk.rb"
load "./Gtk/Langue.rb"
load "./Gtk/Menu.rb"
load "./Gtk/Credits.rb"
load "./Gtk/PlateauGtk.rb"
load "./Gtk/Takuzu.rb"
load "./Gtk/Jouer.rb"
load "./Gtk/Options.rb"
load "./Gtk/Options_graphiques.rb"
load "./Gtk/Options_profil.rb"
load "./Gtk/Options_langue.rb"
load "./Gtk/Options_score.rb"




load "./Gameplay/Plateau.rb"
load "./Gameplay/Tuile.rb"
load "./Gameplay/Mouvement.rb"

load "./Model/Grille.rb"
load "./Model/ModelGrille.rb"
load "./Model/Joueur.rb"
load "./Model/ModelJoueur.rb"
load "./Model/Score.rb"
load "./Model/ModelScore.rb"


#==FOR DEV

load "./dev/GenerateGrille.rb"
load "./dev/GenerateJoueur.rb"
load "./dev/GenerateScore.rb"





#PATH

PATH_RSRC = "../ressources/"
PATH_IMG = PATH_RSRC + "img/"
PATH_GRI = PATH_RSRC + "BaseBineroParNiveau.txt"
PATH_DATABASE = PATH_RSRC + "data.sqlite"

#GLOBAL

$default_avatar = "default.png"

$database = SQLite3::Database.open(PATH_DATABASE)
$database.results_as_hash = true;

$joueur =  ModelJoueur.getAnon