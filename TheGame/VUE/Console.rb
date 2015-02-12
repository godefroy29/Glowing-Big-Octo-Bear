#COMOK
#!/usr/bin/env ruby

##
# Fichier            : Console.rb
# Auteur            : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
# Cette classe représente la console du jeu, elle permet d'afficher les différents message du jeu
#

require 'gtk2'

class Console < Gtk::ScrolledWindow

  @console #la console
  
  ##
  #Constructeur de la console
  #
  def initialize()
    super()
    initInterface();
  end

  ##
  #Creation de la console (visuel)
  #
  def initInterface()
    #editeur de texte
    @console = Gtk::TextView.new();
    #pas editable
    @console.set_editable(false);
    #masque le curseur
    @console.set_cursor_visible(false);
    #bloque le texte a la largeur de la fenetre
    @console.set_wrap_mode(Gtk::TextTag::WRAP_WORD);
    #masque les barres de defilement
    set_policy(Gtk::POLICY_AUTOMATIC,Gtk::POLICY_AUTOMATIC);
    #scrollbar
    add(@console);
    #creation d'un buffer
    buffer=@console.buffer();
    #on ajoute le texte au buffer
    buffer.set_text("Bienvenue dans the game");
    #on affiche la console
    show();
    @console.show();
  end

  ##
  #Permet l'affichage d'un texte dans la console
  #
  #===Paramètres :
  #* <b>texte</b> : le message à afficher dans la console
  #
  def afficherTexte(texte)
    nomMarque="finTxt"
    #on recupere le buffer du textview
    buffer=@console.buffer()
    if(buffer.get_mark(nomMarque)!=nil)
      buffer.delete_mark(nomMarque)
    end
    #on ajoute le texte au buffer
    buffer.set_text(buffer.get_text+"\n"+texte)
    iter_fin=buffer.end_iter()
    mark_fin=buffer.create_mark(nomMarque, iter_fin, true)
    @console.scroll_mark_onscreen(mark_fin)
  end

end
