#COMOK
#!/usr/bin/env ruby

##
# Fichier         : Vue.rb
# Auteur          : L3SPI - Groupe de projet B
# Fait partie de  : TheGame
#
# Cette classe est responsable de l'affichage du jeu dan sa totalité et regroupe différents sous-éléments graphiques. Elle est définie par:
# * Une zone d'affichage
# * Un menu
# * Une zone de contrôle
# * Un pixbuf 'background' pour copier le contenu de la carte
# * Un pixbuf 'frame' pour les animations
# * Un drawingArea pour afficher la carte
# * Un combat modal
# * Une interaction modale
# * Une pop up
# * Une fenêtre
# * Un inventaire modal
# * Un modele
# * Une bibliothèque de référence graphique
# * Une carte (celle du modèle)
# * Un controleur
# * Une dimension de case
# * La même dimension en Float
# * Un 'delay':vitesse des animations
# * Un numero d'etape d'affichage des visualisations
# * Un nombre d'étape d'affichage des visualisations
# * Un 'timeout_id': la référence de l'animation en cours
# * les différentes positions occupable dans une case
# * les ennemis à animer (liste de structures d'informations)
# * les aides à animer (liste de structures d'informations)
# * Une hauteurVisible
# * Une largeurVisible
# * Une coordonnée x actuel du coin supérieur gauche
# * Une coordonnée y actuel du coin supérieur gauche
# * Un état d'initialisation de la vue
# * Un état d'activité d'une animation
# * 8 états d'écoutes pour les 8 touches ecoutées

require 'gtk2'
require 'VUE/Zaf.rb'
require 'VUE/MenuJeu.rb'
require 'VUE/ZoneCtrl.rb'
require 'VUE/ReferencesGraphiques.rb'
require 'VUE/InteractionModal.rb'
require 'VUE/CombatModal.rb'
require 'VUE/PopUp.rb'
require 'VUE/InventaireModal.rb'
require 'MODELE/Enum/EnumDirection.rb'
require 'MODELE/Carte.rb'
require 'XMLReader/XmlRefGraphiquesReader.rb'

class Vue


  @zaf
  @menu
  @zoneCtrl
  @background
  @frame
  @carteVue
  @combatModal
  @interactionModal
  @popUp
  @window
  @inventaireModal
  @carte
  @referencesGraphiques  
  @modele
  @controller
  @tailleCase
  @tailleCase_f
  @delay  
  @numEtapeAffichage
  @nbEtapeAffichage 
  @timeout_id 
  @positions  
  @structureEnnemisDeplacement 
  @structureAidesGenere
  @hauteurAfficheCarte 
  @largeurAfficheCarte 
  @x 
  @y 
  @finInit
  @transitionFini
  @ecouteUp
  @ecouteDown
  @ecouteLeft
  @ecouteRight
  @ecouteToucheRepos
  @ecouteToucheInventaire
  @ecouteToucheMenu
  @ecouteToucheInteraction

  attr_reader :referencesGraphiques, :modele, :hauteurAfficheCarte, :largeurAfficheCarte, :ecouteUp, :ecouteDown, :ecouteLeft, :ecouteRight, :ecouteToucheRepos, :ecouteToucheInventaire, :ecouteToucheMenu, :ecouteToucheInteraction, :inventaireModal, :transitionFini
  attr_accessor :x , :y, :menu, :interactionModal, :popUp, :combatModal, :controller, :zoneCtrl, :window
  
  private_class_method :new
  
  ##
  #Permet de créer une nouvelle vue
  #
  # == Returns :
  # * <b> vue: </b> une nouvelle vue
  #
  def Vue.creer()
    new()
  end

  ##
  #Permet de définir le modèle de la vue
  #
  #===Paramètres :
  #* <b>modele</b> : Le modèle
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def defM(modele)
    @modele = modele
    return nil
  end

  ##
  #Permet de définir le contrôleur de la vue
  #
  #===Paramètres :
  #* <b>controller</b> : Le contrôleur
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def defC(controller)
    @controller=controller
    return nil
  end

  ##
  #Initialise la vue
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def initInterface()
    Gtk.init()

    @finInit = false
    
    @referencesGraphiques = ReferencesGraphiques.new()
    XmlRefGraphiquesReader.lireXml(@referencesGraphiques)
    
    @tailleCase=130
    @tailleCase_f=@tailleCase.to_f
    @hauteurAfficheCarte = 4
    @largeurAfficheCarte = 10
    @timeout_id=nil
    @delay=20
    @numEtapeAffichage=0
    @nbEtapeAffichage=40
    @positions=Array.new([[@tailleCase_f/3,@tailleCase_f/3],[@tailleCase_f/3,0.1],[0.1,@tailleCase_f/3],
      [2*@tailleCase_f/3,@tailleCase_f/3],[@tailleCase_f/3,2*@tailleCase_f/3],[0.1,0.1]])
    @structureEnnemisDeplacement  = Array.new()
    @structureAidesGenere = Array.new()
    @x=@modele.joueur.casePosition.coordonneeX-@hauteurAfficheCarte/2
    @y=@modele.joueur.casePosition.coordonneeY-@largeurAfficheCarte/2
    @carte = @modele.carte
    
    @inventaireModal=InventaireModal.creer(self)
    @zaf = Zaf.new(self)
    @menu = MenuJeu.creer(true, @modele, @controller)
    @zoneCtrl = ZoneCtrl.creer(self,@controller)
    @popUp=PopUp.creer(self)
    @interactionModal=InteractionModal.creer(@modele,self)
    @combatModal=CombatModal.creer(self,@modele)
    @window = Gtk::Window.new()
    
    @window.signal_connect('destroy') {
      if(@timeout_id!=nil)
        Gtk.timeout_remove(@timeout_id)
      end
      Gtk.main_quit()
    }
    
    @background = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique("blanc"))
    @background=@background.scale(@tailleCase*@largeurAfficheCarte, @tailleCase*@hauteurAfficheCarte,Gdk::Pixbuf::INTERP_BILINEAR)
    @frame = Gdk::Pixbuf.new(Gdk::Pixbuf::COLORSPACE_RGB,false, 8,@background.width, @background.height)
    @carteVue = Gtk::DrawingArea.new
    @carteVue.set_size_request(@background.width, @background.height)
   
    @carteVue.signal_connect('expose_event') do |w, e|
      expose(w, e)
    end
    
    bloquerEcouteClavier()
    @controller.ecouteClavierCreer(@window)
    
    tabBot = Gtk::Table.new(1,3,true)
    tabBot.attach(@zaf,0,2,0,1)
    tabBot.attach(@zoneCtrl,2,3,0,1)
    vbox = Gtk::VBox.new()
    vbox.add(@carteVue)
    valignBot = Alignment.new(0.5,1,1,0)
    valignBot.add(tabBot)
    vbox.add(valignBot)

    window.set_resizable(false)
    @window.add(vbox)
    @window.set_title("THE GAME")
    @window.show_all()

    @controller.lancerTour();
    
    @finInit = true;
    Gtk.main();
    return nil
  end

  ##
  #Dessine dans la vue de la carte l'état actuel du jeu dans cette zone
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def afficheCarte()
    0.upto(@hauteurAfficheCarte-1) do |x|
      0.upto(@largeurAfficheCarte-1)do |y|
        @carte.getCaseAt(x+@x,y+@y).verifEnnemis 
        afficheCase(y*@tailleCase,x*@tailleCase,@carte.getCaseAt(x+@x,y+@y),true,@background) # nos axe x et y sont inversés par rapport à ceux de gtk/gdk
      end
    end
    @carteVue.window.draw_pixbuf(nil, @background, 0, 0, 0, 0, @background.width, @background.height, Gdk::RGB::DITHER_NORMAL, 0, 0)
    return nil
  end

  ##
  #Entraine une animation des déplacments/création des PNJ
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def afficheCarteDyn()
    @structureEnnemisDeplacement.clear()
    @structureAidesGenere.clear()

    0.upto(@hauteurAfficheCarte-1) do |x|
      0.upto(@largeurAfficheCarte-1)do |y|
        @carte.getCaseAt(x+@x,y+@y).verifEnnemis 
        afficheCaseDyn(y*@tailleCase,x*@tailleCase,@carte.getCaseAt(x+@x,y+@y))
      end
    end

    if(@timeout_id==nil)
      bloquerEcouteClavier()
      @zoneCtrl.bloquerBoutons(@modele)
      @timeout_id = Gtk.timeout_add(@delay) do
        timeout()
      end
    end
    return nil
  end

  ##
  #Entraine une animation pour le déplacement du joueur
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def afficheCarteMvt()
    if(@modele.joueur.direction==EnumDirection.NORD||@modele.joueur.direction==EnumDirection.SUD)
      h=1
      l=0
    elsif(@modele.joueur.direction==EnumDirection.EST||@modele.joueur.direction==EnumDirection.OUEST)
      h=0
      l=1
    end
    if(@modele.joueur.direction==EnumDirection.SUD)
      hDec=-1
      lDec=0
    elsif(@modele.joueur.direction==EnumDirection.EST)
      hDec=0
      lDec=-1
    else
      hDec=0
      lDec=0
    end

    @pixFond=pixbufTerrain = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique("blanc"))
    @pixFond=@pixFond.scale(@tailleCase*(@largeurAfficheCarte+l), @tailleCase*(@hauteurAfficheCarte+h),Gdk::Pixbuf::INTERP_BILINEAR)
    0.upto(@hauteurAfficheCarte-1+h) do |x|
      0.upto(@largeurAfficheCarte-1+l)do |y|
        afficheCase(y*@tailleCase,x*@tailleCase,@carte.getCaseAt(x+@x+hDec,y+@y+lDec),false,@pixFond)
      end
    end

    case @modele.joueur.direction
    when EnumDirection.NORD
      pixbufJoueur = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(@modele.joueur.getIntitule().downcase+"N"))
      pixbufJoueurb = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(@modele.joueur.getIntitule().downcase+"Nb"))
    when EnumDirection.SUD
      pixbufJoueur = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(@modele.joueur.getIntitule().downcase+"S"))
      pixbufJoueurb = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(@modele.joueur.getIntitule().downcase+"Sb"))
    when EnumDirection.EST
      pixbufJoueur = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(@modele.joueur.getIntitule().downcase+"E"))
      pixbufJoueurb = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(@modele.joueur.getIntitule().downcase+"Eb"))
    when EnumDirection.OUEST
      pixbufJoueur = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(@modele.joueur.getIntitule().downcase+"O"))
      pixbufJoueurb = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(@modele.joueur.getIntitule().downcase+"Ob"))
    end
    pixbufJoueur=pixbufJoueur.scale(@tailleCase_f/3, @tailleCase_f/3,Gdk::Pixbuf::INTERP_BILINEAR)
    pixbufJoueurb=pixbufJoueurb.scale(@tailleCase_f/3, @tailleCase_f/3,Gdk::Pixbuf::INTERP_BILINEAR)

    if(@timeout_id==nil)
      bloquerEcouteClavier()
      @zoneCtrl.bloquerBoutons(@modele)
      @timeout_id = Gtk.timeout_add(@delay) do
        timeoutMvt(pixbufJoueur,pixbufJoueurb)
      end
    end
    return nil
  end
 
  ##
  #Affiche le contenu d'une case dans un pixbuf
  #
  #===Paramètres :
  #* <b>xAff</b> : L'abscisse de la case à afficher dans le pixbuf
  #* <b>yAff</b> : L'ordonnée de la case à afficher dans le pixbuf
  #* <b>caseAffiche</b> : La case à afficher
  #* <b>afficheJoueur</b> : Booléen indiquant si on doit afficher le joueur ou non (même si présent dans la case)
  #* <b>pixbufBase</b> : Le pixbuf dans lequel on affiche la case
  #  
  # == Returns :
  # * <b> nil: </b> default value
  #
  def afficheCase(xAff,yAff,caseAffiche,afficherJoueur,pixbufBase)
    #terrain
    pixbufTerrain = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(caseAffiche.getIntitule().downcase))
    pixbufTerrain=pixbufTerrain.scale(@tailleCase, @tailleCase,Gdk::Pixbuf::INTERP_BILINEAR)
    
    if(caseAffiche.getNumTerrain()<caseAffiche.caseNord.getNumTerrain())
      idImage=caseAffiche.caseNord.getIntitule()+"_bordureN"
      pixbufTerrainSurcouche = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(idImage))
      pixbufTerrainSurcouche=pixbufTerrainSurcouche.scale(@tailleCase, @tailleCase,Gdk::Pixbuf::INTERP_BILINEAR)
      pixbufTerrain.composite!(pixbufTerrainSurcouche, 0,0, pixbufTerrainSurcouche.width, pixbufTerrainSurcouche.height,0, 0,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)
    end
    if(caseAffiche.getNumTerrain()<caseAffiche.caseEst.getNumTerrain())
      idImage=caseAffiche.caseEst.getIntitule()+"_bordureE"
      pixbufTerrainSurcouche = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(idImage))
      pixbufTerrainSurcouche=pixbufTerrainSurcouche.scale(@tailleCase, @tailleCase,Gdk::Pixbuf::INTERP_BILINEAR)
      pixbufTerrain.composite!(pixbufTerrainSurcouche, 0,0, pixbufTerrainSurcouche.width, pixbufTerrainSurcouche.height,0, 0,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)
    end
    if(caseAffiche.getNumTerrain()<caseAffiche.caseSud.getNumTerrain())
      idImage=caseAffiche.caseSud.getIntitule()+"_bordureS"
      pixbufTerrainSurcouche = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(idImage))
      pixbufTerrainSurcouche=pixbufTerrainSurcouche.scale(@tailleCase, @tailleCase,Gdk::Pixbuf::INTERP_BILINEAR)
      pixbufTerrain.composite!(pixbufTerrainSurcouche, 0,0, pixbufTerrainSurcouche.width, pixbufTerrainSurcouche.height,0, 0,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)
    end
    if(caseAffiche.getNumTerrain()<caseAffiche.caseOuest.getNumTerrain())
      idImage=caseAffiche.caseOuest.getIntitule()+"_bordureO"
      pixbufTerrainSurcouche = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(idImage))
      pixbufTerrainSurcouche=pixbufTerrainSurcouche.scale(@tailleCase, @tailleCase,Gdk::Pixbuf::INTERP_BILINEAR)
      pixbufTerrain.composite!(pixbufTerrainSurcouche, 0,0, pixbufTerrainSurcouche.width, pixbufTerrainSurcouche.height,0, 0,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)
    end

    pixbufBase.composite!(pixbufTerrain, xAff,yAff, pixbufTerrain.width, pixbufTerrain.height,xAff, yAff,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)

    #joueur
    if(caseAffiche.joueur!=nil && afficherJoueur)
      if(caseAffiche.joueur.toujoursEnVie?())
        case caseAffiche.joueur.direction
        when EnumDirection.NORD
          pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(caseAffiche.joueur.getIntitule().downcase+"N"))
        when EnumDirection.SUD
          pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(caseAffiche.joueur.getIntitule().downcase+"S"))
        when EnumDirection.EST
          pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(caseAffiche.joueur.getIntitule().downcase+"E"))
        when EnumDirection.OUEST
          pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(caseAffiche.joueur.getIntitule().downcase+"O"))
        end
      else
        pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique("tombe"))
      end
      pixbufElement=pixbufElement.scale(@tailleCase_f/3, @tailleCase_f/3,Gdk::Pixbuf::INTERP_BILINEAR)
      rg=caseAffiche.joueur.rangCase
      x=@positions[rg][0]
      y=@positions[rg][1]
      pixbufBase.composite!(pixbufElement, xAff+x,yAff+y, pixbufElement.width, pixbufElement.height,xAff+x, yAff+y,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)
    end

    #aides
    aides=caseAffiche.listeElements
    for a in aides
      rg=a.rangCase
      x=@positions[rg][0]
      y=@positions[rg][1]
      pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(a.getIntitule().downcase))
      pixbufElement=pixbufElement.scale(@tailleCase_f/3, @tailleCase_f/3,Gdk::Pixbuf::INTERP_BILINEAR)
      pixbufBase.composite!(pixbufElement, xAff+x,yAff+y, pixbufElement.width, pixbufElement.height,xAff+x, yAff+y,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)
    end

    #ennemis
    ennemis=caseAffiche.listeEnnemis
    for e in ennemis

      case e.direction
      when EnumDirection.NORD
        pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(e.getIntitule().downcase+"N"))
      when EnumDirection.SUD
        pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(e.getIntitule().downcase+"S"))
      when EnumDirection.EST
        pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(e.getIntitule().downcase+"E"))
      when EnumDirection.OUEST
        pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(e.getIntitule().downcase+"O"))
      end
      pixbufElement=pixbufElement.scale(@tailleCase_f/3, @tailleCase_f/3,Gdk::Pixbuf::INTERP_BILINEAR)

      rg=e.rangCase
      xPos=@positions[rg][0]
      yPos=@positions[rg][1]

      xArr=xAff+xPos
      yArr=yAff+yPos

      pixbufBase.composite!(pixbufElement, xArr,yArr, pixbufElement.width, pixbufElement.height,xArr,yArr,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)
    end
    return nil
  end

  ##
  #Prépare l'animation des activités PNJ, en mettant de coté dans des listes, des structures contenant les informations sur les PNJ se créant dans la case donnée.
  #
  #===Paramètres :
  #* <b>xAff</b> : L'abscisse de la case à afficher dans le pixbuf
  #* <b>yAff</b> : L'ordonnée de la case à afficher dans le pixbuf
  #* <b>caseAffiche</b> : La case à afficher
  #  
  # == Returns :
  # * <b> nil: </b> default value
  #
  def afficheCaseDyn(xAff,yAff,caseAffiche)

    #terrain
    pixbufTerrain = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(caseAffiche.getIntitule().downcase))
    pixbufTerrain=pixbufTerrain.scale(@tailleCase, @tailleCase,Gdk::Pixbuf::INTERP_BILINEAR)

    if(caseAffiche.getNumTerrain()<caseAffiche.caseNord.getNumTerrain())
      idImage=caseAffiche.caseNord.getIntitule()+"_bordureN"
      pixbufTerrainSurcouche = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(idImage))
      pixbufTerrainSurcouche=pixbufTerrainSurcouche.scale(@tailleCase, @tailleCase,Gdk::Pixbuf::INTERP_BILINEAR)
      pixbufTerrain.composite!(pixbufTerrainSurcouche, 0,0, pixbufTerrainSurcouche.width, pixbufTerrainSurcouche.height,0, 0,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)
    end
    if(caseAffiche.getNumTerrain()<caseAffiche.caseEst.getNumTerrain())
      idImage=caseAffiche.caseEst.getIntitule()+"_bordureE"
      pixbufTerrainSurcouche = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(idImage))
      pixbufTerrainSurcouche=pixbufTerrainSurcouche.scale(@tailleCase, @tailleCase,Gdk::Pixbuf::INTERP_BILINEAR)
      pixbufTerrain.composite!(pixbufTerrainSurcouche, 0,0, pixbufTerrainSurcouche.width, pixbufTerrainSurcouche.height,0, 0,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)
    end
    if(caseAffiche.getNumTerrain()<caseAffiche.caseSud.getNumTerrain())
      idImage=caseAffiche.caseSud.getIntitule()+"_bordureS"
      pixbufTerrainSurcouche = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(idImage))
      pixbufTerrainSurcouche=pixbufTerrainSurcouche.scale(@tailleCase, @tailleCase,Gdk::Pixbuf::INTERP_BILINEAR)
      pixbufTerrain.composite!(pixbufTerrainSurcouche, 0,0, pixbufTerrainSurcouche.width, pixbufTerrainSurcouche.height,0, 0,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)
    end
    if(caseAffiche.getNumTerrain()<caseAffiche.caseOuest.getNumTerrain())
      idImage=caseAffiche.caseOuest.getIntitule()+"_bordureO"
      pixbufTerrainSurcouche = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(idImage))
      pixbufTerrainSurcouche=pixbufTerrainSurcouche.scale(@tailleCase, @tailleCase,Gdk::Pixbuf::INTERP_BILINEAR)
      pixbufTerrain.composite!(pixbufTerrainSurcouche, 0,0, pixbufTerrainSurcouche.width, pixbufTerrainSurcouche.height,0, 0,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)
    end

    @background.composite!(pixbufTerrain, xAff,yAff, pixbufTerrain.width, pixbufTerrain.height,xAff, yAff,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)

    #joueur
    if(caseAffiche.joueur!=nil)
      if(caseAffiche.joueur.toujoursEnVie?())
        if(caseAffiche.joueur.enRepos)
          pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique("dormeur"))
        else
          case caseAffiche.joueur.direction
          when EnumDirection.NORD
            pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(caseAffiche.joueur.getIntitule().downcase+"N"))
          when EnumDirection.SUD
            pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(caseAffiche.joueur.getIntitule().downcase+"S"))
          when EnumDirection.EST
            pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(caseAffiche.joueur.getIntitule().downcase+"E"))
          when EnumDirection.OUEST
            pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(caseAffiche.joueur.getIntitule().downcase+"O"))
          end
        end
      else
        pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique("tombe"))
      end
      pixbufElement=pixbufElement.scale(@tailleCase_f/3, @tailleCase_f/3,Gdk::Pixbuf::INTERP_BILINEAR)
      rg=caseAffiche.joueur.rangCase
      x=@positions[rg][0]
      y=@positions[rg][1]
      @background.composite!(pixbufElement, xAff+x,yAff+y, pixbufElement.width, pixbufElement.height,xAff+x, yAff+y,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)
    end

    #aides
    aides=caseAffiche.listeElements
    for a in aides
      rg=a.rangCase
      x=@positions[rg][0]
      y=@positions[rg][1]
      pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(a.getIntitule().downcase))
      pixbufElement=pixbufElement.scale(@tailleCase_f/3, @tailleCase_f/3,Gdk::Pixbuf::INTERP_BILINEAR)
      if(!a.vientDEtreGenere?())
        @background.composite!(pixbufElement, xAff+x,yAff+y, pixbufElement.width, pixbufElement.height,xAff+x, yAff+y,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)
      else
        @structureAidesGenere.push([xAff+x,yAff+y,pixbufElement])
      end
    end

    #ennemis
    ennemis=caseAffiche.listeEnnemis
    for e in ennemis

      case e.direction
      when EnumDirection.NORD
        pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(e.getIntitule().downcase+"N"))
        pixbufElementb = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(e.getIntitule().downcase+"Nb"))
      when EnumDirection.SUD
        pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(e.getIntitule().downcase+"S"))
        pixbufElementb = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(e.getIntitule().downcase+"Sb"))
      when EnumDirection.EST
        pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(e.getIntitule().downcase+"E"))
        pixbufElementb = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(e.getIntitule().downcase+"Eb"))
      when EnumDirection.OUEST
        pixbufElement = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(e.getIntitule().downcase+"O"))
        pixbufElementb = Gdk::Pixbuf.new(@referencesGraphiques.getRefGraphique(e.getIntitule().downcase+"Ob"))
      end
      pixbufElement=pixbufElement.scale(@tailleCase_f/3, @tailleCase_f/3,Gdk::Pixbuf::INTERP_BILINEAR)
      pixbufElementb=pixbufElementb.scale(@tailleCase_f/3, @tailleCase_f/3,Gdk::Pixbuf::INTERP_BILINEAR)

      rg=e.rangCase
      xPos=@positions[rg][0]
      yPos=@positions[rg][1]
      
      xAncien=e.anciennePositionX
      yAncien=e.anciennePositionY

      xArr=xAff
      yArr=yAff

      if(e.vientDEtreGenere?())
        if(!(xAncien==-1 && yAncien==-1))
          raise "err1"
        end
        traitement="zoom"
        xArr=xArr+xPos
        yArr=yArr+yPos
        @structureEnnemisDeplacement.push([traitement,nil,nil,xArr,yArr,pixbufElement,nil])
      else
        ancienneCase=@modele.carte().getCaseAt(xAncien,yAncien)

       if(ancienneCase==e.casePosition)
          @background.composite!(pixbufElement, xAff+xPos,yAff+yPos, pixbufElement.width, pixbufElement.height,xAff+xPos, yAff+yPos,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)
        else
          traitement="depl"
          rgAncien=e.ancienRangCase
          xPosAncien=@positions[rgAncien][0]
          yPosAncien=@positions[rgAncien][1]

          if(ancienneCase==e.casePosition.caseNord())
            xDep=xArr
            yDep=yArr-@tailleCase
          elsif(ancienneCase==e.casePosition.caseSud())
            xDep=xArr
            yDep=yArr+@tailleCase
          elsif(ancienneCase==e.casePosition.caseEst())
            xDep=xArr+@tailleCase
            yDep=yArr
          elsif(ancienneCase==e.casePosition.caseOuest())
            xDep=xArr-@tailleCase
            yDep=yArr
          end

          if(xDep==nil)
            puts e.getIntitule+" "+xAncien.to_s+" "+yAncien.to_s()
            puts e.getIntitule+" "+e.casePosition.coordonneeX.to_s+" "+e.casePosition.coordonneeY.to_s
            raise "err2"
          end

          if(xDep<0)
            xDep=0
          end
          if(xDep>(@largeurAfficheCarte-1)*@tailleCase)
            xDep=(@largeurAfficheCarte-1)*@tailleCase
          end
          if(yDep<0)
            yDep=0
          end
          if(yDep>(@hauteurAfficheCarte-1)*@tailleCase)
            yDep=(@hauteurAfficheCarte-1)*@tailleCase
          end
          xDep=xDep+xPosAncien
          yDep=yDep+yPosAncien
        end
        xArr=xArr+xPos
        yArr=yArr+yPos

        @structureEnnemisDeplacement.push([traitement,xDep,yDep,xArr,yArr,pixbufElement,pixbufElementb])
      end
    end
    return nil
  end

  
  ##
  #Accesseur sur la zone d'affichage
  #
  # == Returns :
  # * <b> zaf: </b> La zaf
  #
  def getZaf()
    return @zaf
  end

  ##
  #Méthode d'actualisation de la vue. Elle s'oriente par rapport au stade de partie du modèle. Grâce à ce stade elle sait quel genre d'affichage elle fournit(statique,dynamique pour les PNJ, mouvement du joueur) et quelles interactions elle doit proposer pour le joueur.
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def actualiser()
    @x=@modele.joueur.casePosition.coordonneeX-@hauteurAfficheCarte/2
    @y=@modele.joueur.casePosition.coordonneeY-@largeurAfficheCarte/2
    
    if(@modele.stadePartie==EnumStadePartie.TOUR_PASSE || (@modele.compteurTour==0 && @modele.stadePartie==EnumStadePartie.DEB_TOUR))
      @transitionFini=false
      afficheCarteDyn()
      while(!@transitionFini) do
        sleep(0.1)
      end
    elsif(@modele.stadePartie==EnumStadePartie.JOUEUR_MVT)
      @transitionFini=false
      afficheCarteMvt()
      sleep(0.5)
    else
      afficheCarte()
    end

    @zaf.majZaf(@modele.joueur)
    
    case @modele.stadePartie

    when EnumStadePartie.CHOIX_LIBRE
      majEcouteClavier()
      @zoneCtrl.majBoutons(@modele)  
     
    when EnumStadePartie.CHOIX_LIBRE
      @zoneCtrl.bloquerBoutons(@modele)
      bloquerEcouteClavier()  
    
    when EnumStadePartie.PERDU
      @zoneCtrl.bloquerBoutons(@modele)
      bloquerEcouteClavier()
 
    when EnumStadePartie.EQUIPEMENT_ARMURE
      @combatModal.majEquipementDefensif()
      
    when EnumStadePartie.EQUIPEMENT_ARME
      @combatModal.majEquipementOffensif()
      
    when EnumStadePartie.INTERACTION_MARCHAND
      @popUp.afficheChoixMarchand()
      
    when EnumStadePartie.INTERACTION_GUERISSEUR
      @popUp.afficheChoixGuerisseur(@modele.joueur, @modele.pnjAideEnInteraction)
    end #fin case
    return nil
  end

  ##
  #Mise à jour des touches clavier interargissant avec le jeu.
  #  
  # == Returns :
  # * <b> nil: </b> default value
  #
  def majEcouteClavier()
    @ecouteUp=@modele.joueur.casePosition.caseNord.estAccessible?()
    @ecouteDown=@modele.joueur.casePosition.caseSud.estAccessible?()
    @ecouteLeft=@modele.joueur.casePosition.caseOuest.estAccessible?()
    @ecouteRight=@modele.joueur.casePosition.caseEst.estAccessible?()
    @ecouteToucheRepos=@modele.joueur.nombreRepos!=0
    @ecouteToucheInventaire=!@modele.joueur.inventaire.items.empty?()
    @ecouteToucheMenu=true
    @ecouteToucheInteraction=@modele.joueur.casePosition.presenceAides?()
    return nil
  end

  ##
  #Bloque toute écoute du clavier.
  #  
  # == Returns :
  # * <b> nil: </b> default value
  #
  def bloquerEcouteClavier()
    @ecouteUp=false
    @ecouteDown=false
    @ecouteLeft=false
    @ecouteRight=false
    @ecouteToucheRepos=false
    @ecouteToucheInventaire=false
    #@ecouteToucheMenu=false
    @ecouteToucheInteraction=false
    return nil
  end

  ##
  #Mise a jour de la langue
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def majLangue()
    @zaf.majLangue();
    @zoneCtrl.majLangue();
    return nil
  end

  ##
  #  Méthode pour le signal expose des animations.
  #
  #===Paramètres :
  #* <b>widget</b> : Le widget relié au signal
  #* <b>event</b> : L'évenement
  #  
  # == Returns :
  # * <b> true: </b> default value
  #
  def expose(widget, event)
    rowstride = @frame.rowstride

    pixels = @frame.pixels
    pixels[0, rowstride * event.area.y + event.area.x * 3] = ''

    Gdk::RGB.draw_rgb_image(widget.window,
    widget.style.black_gc,
    event.area.x, event.area.y,
    event.area.width, event.area.height,
    Gdk::RGB::Dither::NORMAL,
    pixels, rowstride,
    event.area.x, event.area.y)
    true
  end

  ##
  # Timeout pour régénérer la frame pour les animation d'action PNJ
  #
  # == Returns :
  # * <b> true: </b> default value
  #
  def timeout()
    @background.copy_area(0, 0, @background.width, @background.height,
    @frame, 0, 0)
    @numEtapeAffichage+=1

    if(@structureAidesGenere.empty? && @structureEnnemisDeplacement.empty?)
      @numEtapeAffichage=@nbEtapeAffichage
    end
    
    for a in @structureAidesGenere
      xArr=a[0]
      yArr=a[1]
      pixbuf=a[2]
      w= (pixbuf.width*(@numEtapeAffichage.to_f()/@nbEtapeAffichage)).to_i
      h= (pixbuf.height*(@numEtapeAffichage.to_f()/@nbEtapeAffichage)).to_i
      if w==0
        w=1
      end
      if h==0
        h=1
      end
      zoomPix=pixbuf.scale(w,h,Gdk::Pixbuf::INTERP_BILINEAR)
      @frame.composite!(zoomPix,xArr,yArr,zoomPix.width, zoomPix.height,xArr,yArr,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)
    end

    for e in @structureEnnemisDeplacement
      traitement=e[0]
      xDep=e[1]
      yDep=e[2]
      xArr=e[3]
      yArr=e[4]
      pixbuf=e[5]
      pixbufb=e[6]

      if(traitement=="zoom")
        w= (pixbuf.width*(@numEtapeAffichage.to_f()/@nbEtapeAffichage)).to_i
        h= (pixbuf.height*(@numEtapeAffichage.to_f()/@nbEtapeAffichage)).to_i
        if w==0
          w=1
        end
        if h==0
          h=1
        end
        zoomPix=pixbuf.scale(w,h,Gdk::Pixbuf::INTERP_BILINEAR)
        @frame.composite!(zoomPix,xArr,yArr,zoomPix.width, zoomPix.height,xArr,yArr,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)
      elsif(traitement=="depl")
        if(
        (   @numEtapeAffichage<=@nbEtapeAffichage*(1.0/6) )  ||
        (   @numEtapeAffichage> @nbEtapeAffichage*(1.0/3) && @numEtapeAffichage<=@nbEtapeAffichage*0.5  )   ||
        (   @numEtapeAffichage> @nbEtapeAffichage*(2.0/3) && @numEtapeAffichage<=@nbEtapeAffichage*(5.0/6)   )
          )
          pixbufActuel=pixbuf
        else
          pixbufActuel=pixbufb
        end

        x=xDep+@numEtapeAffichage*(xArr-xDep)/@nbEtapeAffichage
        y=yDep+@numEtapeAffichage*(yArr-yDep)/@nbEtapeAffichage
        @frame.composite!(pixbufActuel,x,y,pixbufActuel.width, pixbufActuel.height,x, y,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)
      end
    end

    @carteVue.queue_draw
    if(@numEtapeAffichage==@nbEtapeAffichage)
      Gtk.timeout_remove(@timeout_id)
      @numEtapeAffichage=0
      @timeout_id=nil
      #majEcouteClavier()
      #@zoneCtrl.majBoutons(@modele)
      @transitionFini=true
    end
    true
  end

  ##
  # Timeout pour régénérer la frame pour les mouvements du joueur
  #
  # == Returns :
  # * <b> true: </b> default value
  #
  def timeoutMvt(pix,pixb)
    @background.copy_area(0, 0, @background.width, @background.height,
    @frame, 0, 0)
    @numEtapeAffichage+=1

    case @modele.joueur.direction
    when EnumDirection.NORD
      parcours=@pixFond.height-@background.height
      ecartH=-((@nbEtapeAffichage-@numEtapeAffichage)*((parcours).to_f)/@nbEtapeAffichage).to_i
      x=0
      y=ecartH
    when EnumDirection.SUD
      parcours=@pixFond.height-@background.height
      ecartH=((@nbEtapeAffichage-@numEtapeAffichage)*((parcours).to_f)/@nbEtapeAffichage).to_i - @tailleCase
      x=0
      y=ecartH
    when EnumDirection.EST
      parcours=@pixFond.width-@background.width
      ecartL=((@nbEtapeAffichage-@numEtapeAffichage)*((parcours).to_f)/@nbEtapeAffichage).to_i - @tailleCase
      x=ecartL
      y=0
    when EnumDirection.OUEST
      parcours=@pixFond.width-@background.width
      ecartL=-((@nbEtapeAffichage-@numEtapeAffichage)*((parcours).to_f)/@nbEtapeAffichage).to_i
      x=ecartL
      y=0
    end

    if(
    (   @numEtapeAffichage<=@nbEtapeAffichage*(1.0/6) )  ||
    (   @numEtapeAffichage> @nbEtapeAffichage*(1.0/3) && @numEtapeAffichage<=@nbEtapeAffichage*0.5  )   ||
    (   @numEtapeAffichage> @nbEtapeAffichage*(2.0/3) && @numEtapeAffichage<=@nbEtapeAffichage*(5.0/6)   )
      )
      pixActuel=pix
    else
      pixActuel=pixb
    end

    xJ=@tailleCase*@largeurAfficheCarte/2+@positions[0][0]
    yJ=@tailleCase*@hauteurAfficheCarte/2+@positions[0][1]
    @frame.composite!(@pixFond,0,0,@background.width, @background.height,x, y,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)
    @frame.composite!(pixActuel,xJ, yJ,pixActuel.width, pixActuel.height,xJ, yJ,1, 1, Gdk::Pixbuf::INTERP_NEAREST,255)

    @carteVue.queue_draw
    if(@numEtapeAffichage==@nbEtapeAffichage)
      Gtk.timeout_remove(@timeout_id)
      @numEtapeAffichage=0
      @timeout_id=nil
      #majEcouteClavier()
      #@zoneCtrl.majBoutons(@modele)
      @transitionFini=true
    end
    true
  end

end

