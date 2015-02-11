#COMOK
#!/usr/bin/env ruby

##
# Fichier            : Jauges.rb
# Auteur            : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
# Cette classe représente les jauges du joueur
#

require 'gtk2'
require 'XMLReader/XmlMultilingueReader.rb'

class Jauges
  @or #l'or du joueur
  @nbRepos #nombre de repos du joueur
  @niveau #niveau actuel du joueur
  
  
  ##
  #Constructeur des jauges
  #
  def initialize()
    @or = Gtk::Label.new("0");
    @nbRepos = Gtk::Label.new("0");
    @niveau = Gtk::Label.new("0");
    initInterface();
  end

  ##
  #Permet d'initialiser les jauges d'experience et d'énergie
  #
  def initInterface()
    @barExperience = Gtk::ProgressBar.new();
    @barEnergie = Gtk::ProgressBar.new();
    @barExperience.show();
    @barEnergie.show();
  end

  ##
  #Mise à jour de toutes les jauges avec le joueur en parametre
  #
  #===Paramètres :
  #* <b>joueur</b> : le joueur afin de récupérer sont or,nbRepos,energie,experience,niveau
  #
  def majJauge(joueur)
    majJaugeOr(joueur.inventaire().capital());
    majJaugeNbRepos(joueur.nombreRepos());
    majJaugeEnergie((joueur.energie()>0)?(joueur.energie):(0),joueur.energieMax());
    majJaugeExperience(joueur.experience(),joueur.experienceSeuil());
    majNiveau(joueur.niveau());
  end

  ##
  #Mise à jour de l'or
  #
  #===Paramètres :
  #* <b>quantite</b> : la quantite d'or à afficher
  #
  def majJaugeOr(quantite)
    @or.set_text(quantite.to_s());
  end
  
  ##
  #Mise à jour du nomdre de repos
  # 
  #===Paramètres :
  #* <b>nbRepos</b> : le nombre de repos à afficher
  #
  def majJaugeNbRepos(nbRepos)
    @nbRepos.set_text(nbRepos.to_s());
  end

  ##
  #Mise à jour  de l'energie
  #
  #===Paramètres :
  #* <b>quantite</b> : la quantite d'energie à afficher
  #* <b>max</b> : le maximum d'enerigie que peux avoir le joueur à afficher
  #
  def majJaugeEnergie(quantite,max)
    @barEnergie.fraction = quantite/max.to_f();
    @barEnergie.set_text(XmlMultilingueReader.lireTexte("energie")+ " : " +sprintf("%.2f",quantite.to_s) + " / " + sprintf("%.2f",max.to_s()));
  end

  ##
  #Mise à jour de l'experience
  #
  #===Paramètres :
  #* <b>quantite</b> : la quantite d'energie à afficher
  #* <b>max</b> : le maximum d'enerigie que peux avoir le joueur à afficher
  #
  def majJaugeExperience(quantite,max)
    @barExperience.fraction = quantite/max.to_f();
    @barExperience.set_text(XmlMultilingueReader.lireTexte("experience")+ " : " +sprintf("%.2f",quantite.to_s) + " / " + sprintf("%.2f",max.to_s()));
  end

  ##
  #Met à jour le niveau du joueur
  #===Paramètres :
  #* <b>niveau/b> : le niveau à afficher
  #
  def majNiveau(niveau)
    @niveau.set_text(niveau.to_s());
  end

  ##
  #Retourne le niveau du joueur
  #
  def getNiveau()
    return @niveau;
  end

  ##
  #Retourne le nombre d'or
  #
  def getJaugeOr()
    return @or
  end

  ##
  #Retourne le nombre de repos
  #
  def getJaugeNbRepos()
    return @nbRepos;
  end

  ##
  #Retourne la jauge d'energie
  #
  def getJaugeEnergie()
    return @barEnergie;
  end

  ##
  #Retourne la jauge d'experience
  #
  def getJaugeExperience()
    return @barExperience
  end

end

