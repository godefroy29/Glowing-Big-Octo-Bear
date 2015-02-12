#COMOK
#!/usr/bin/env ruby

##
# Fichier            : Zaf.rb
# Auteur            : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
# Cette classe représente la zone d'affichage qui est en bas de la vue
#

require 'gtk2'
require 'VUE/Console.rb'
require 'VUE/Jauges.rb'
require 'XMLReader/XmlMultilingueReader.rb'

#affiche console + jauges

class Zaf < Gtk::Frame
  @console #la console
  @jauges #les jauges d'affichage
  @niveau #le niveau du joueur
  @vue #la vue
  
  
  ##
  #Constructeur de la zone d'affichage
  #===Paramètres :
  #* <b>vue</b> : la vue du jeu
  #
  def initialize(vue)
    super();
    @vue = vue;
    @console = Console.new();
    @jauges = Jauges.new();
    initInterface();
  end

  ##
  #Permet la création des différentes jauges
  #
  def initInterface()
    
    hbox = Gtk::HBox.new(true, 2);
    #ajout console
    hbox.add(@console);
    #bas de la vue
    hbox2 = Gtk::HBox.new(true, 4);
    tabNiveau = Gtk::Table.new(1,6,true)
    vbox = Gtk::VBox.new(true,4);
    vbox.add(hbox2);

    #ajout jauges
    hbox2.add(@jauges.getJaugeNbRepos());
    hbox2.add(Gtk::Image.new(@vue.referencesGraphiques.getRefGraphique("repos")));
    hbox2.add(@jauges.getJaugeOr());
    hbox2.add(Gtk::Image.new(@vue.referencesGraphiques.getRefGraphique("icone or")));
    vbox.add(@jauges.getJaugeEnergie());
    vbox.add(@jauges.getJaugeExperience());
    @niveau = Gtk::Label.new(XmlMultilingueReader.lireTexte("niveau")+" : ");
    tabNiveau.attach(@niveau,2,3,0,1)
    tabNiveau.attach(@jauges.getNiveau(),3,4,0,1)
    vbox.add(tabNiveau);

    hbox.add(vbox);
    add(hbox);

    show_all();
  end

  ##
  #Permet la mise à jour de l'affichage grace au joueur
  #
  #===Paramètres :
  #* <b>joueur</b> : le joueur
  #
  def majZaf(joueur)
    @jauges.majJauge(joueur)
    while(!joueur.modele.notifications.empty?)
      @console.afficherTexte("-->"+joueur.modele.lireNotification()+"\n")
    end
  end

  ##
  #Permet la mise à jour de la langue lors d'un changement
  #
  def majLangue()
    @niveau.label=XmlMultilingueReader.lireTexte("niveau");
  end

end
