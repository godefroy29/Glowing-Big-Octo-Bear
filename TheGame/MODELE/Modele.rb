#COMOK
#!/usr/bin/env ruby

##
# Fichier        : Modele.rb
# Auteur         : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
# Cette classe représente le modèle du jeu défini par :
# * Un compteur de tour statique
# * Une vue
# * Une difficulté
# * Une carte
# * Un joueur
# * Une liste des ennemis présents dans le jeu et qui évoluent à chaque tour
# * Un compteur de tour de jeu
# * Un pseudo pour la partie
# * Une liste de notifications pour la vue
# * Un message de défaite
# * Un item en attente d'ajout
# * Un PNJ d'aide en cours d'interaction
# * Un booléen indiquant si un tour a déjà été passé lorsque qu'on veut se déplacer
# * Un identifiant du terrain par défaut
# * Un nombre max de pisteur
#

require './AffichageDebug.rb'
require 'MODELE/Enum/EnumStadePartie.rb'
require "MODELE/Enum/EnumMomentCombat.rb"
require 'MODELE/Joueur.rb'
require 'MODELE/Inventaire.rb'
require 'MODELE/Guerisseur.rb'
require 'MODELE/Marchand.rb'
require 'MODELE/Pisteur.rb'
require 'MODELE/EnnemiNormal.rb'
require 'MODELE/Caracteristique.rb'
require 'MODELE/Encaissable.rb'
require 'MODELE/Mangeable.rb'
require 'MODELE/Equipable.rb'
require 'MODELE/Type/TypeEnnemi.rb'
require 'MODELE/Type/TypeEquipable.rb'
require 'MODELE/Type/TypeMangeable.rb'
require 'MODELE/Type/TypeTerrain.rb'
require 'MODELE/Type/Difficulte.rb'
require 'MODELE/StockMarchand.rb'
require 'MODELE/Bibliotheque/BibliothequeTypeEnnemi.rb'
require 'MODELE/Bibliotheque/BibliothequeTypeEquipable.rb'
require 'MODELE/Bibliotheque/BibliothequeTypeMangeable.rb'
require 'MODELE/Bibliotheque/BibliothequeTypeTerrain.rb'
require 'MODELE/Bibliotheque/BibliothequeDifficulte.rb'
require 'XMLReader/XmlDifficultesReader.rb'
require 'XMLReader/XmlEnnemisReader.rb'
require 'XMLReader/XmlEquipablesReader.rb'
require 'XMLReader/XmlMangeablesReader.rb'
require 'XMLReader/XmlTerrainsReader.rb'
require 'VUE/Vue.rb'

class Modele

  @@compteurTourGlob=0
  @vue
  @listeEnnemis
  @compteurTour
  @difficulte
  @carte
  @joueur
  @pseudoPartie
  @stadePartie
  @notifications
  @messageDefaite
  @itemAttenteAjout
  @pnjAideEnInteraction
  @tourDejaPasse
  @id_terrainParDefaut
  @nbMaxPisteur
  @nbPisteur
  @indiceItemSelectionne

  private_class_method :new

  attr_reader :difficulte, :carte, :joueur, :listeEnnemis, :stadePartie, :messageDefaite, :vue, :id_terrainParDefaut
  attr_accessor :compteurTour, :itemAttenteAjout, :pnjAideEnInteraction, :tourDejaPasse, :notifications, :nbPisteur, :indiceItemSelectionne
  
  ##
  # Initialise toutes les bibliothèques
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def Modele.initialisationBibliotheques()
    XmlDifficultesReader.lireXml()
    XmlEnnemisReader.lireXml()
    XmlEquipablesReader.lireXml()
    XmlMangeablesReader.lireXml()
    XmlTerrainsReader.lireXml()
    XmlMultilingueReader.lireXml()
    return nil
  end

  ##
  # Creer un nouveau modèle.
  #
  # == Parameters:
  #* <b>vue :</b> la vue du jeu
  #* <b>difficulte :</b> la difficulte du jeu
  #* <b>pseudo :</b> le pseudo de la partie
  #
  # == Returns :
  # * <b> modele: </b> Un nouveau modèle
  #
  def Modele.creer(vue,difficulte,pseudo)
    return new(vue,difficulte,pseudo)
  end

  ##
  # méthode initialize
  #
  # == Parameters:
  #* <b>vue :</b> la vue du jeu
  #* <b>difficulte :</b> la difficulte du jeu
  #* <b>pseudo :</b> le pseudo de la partie
  #
  # == Returns :
  # * <b> modele: </b> Un nouveau modèle
  #
  def initialize(vue,difficulte,pseudo)
    @vue = vue
    @difficulte=difficulte
    @pseudoPartie=pseudo
  end

  ##
  # Accesseur sur le compteur static de tour
  #
  # == Returns :
  # * <b> compteur: </b> Le compteur statique
  #
  def Modele.Cpt()
    return @@compteurTourGlob
  end

  ##
  # Modificateur sur le compteur static de tour
  #
  # == Parameters:
  # * <b> compteurTour :</b> la nouvelle valeur
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def Modele.majCpt(compteurTour)
    @@compteurTourGlob=compteurTour
    return nil
  end

  ##
  # Méthode d'initialisation du modèle
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def initialiseToi()

    @nbPisteur=0
    @nbMaxPisteur=10
    @compteurTour = 0
    @tourDejaPasse=false

    @notifications=Array.new()
    @notifications.push("Debut de partie")

    # Creation de la carte
    @id_terrainParDefaut="plaine"
    @carte = Carte.nouvelle(@difficulte.longueurCarte, @difficulte.largeurCarte, @id_terrainParDefaut)

    # Initialisation de la case du joueur
    pasTrouver = true
    while(pasTrouver)
      larg_cj = rand(@carte.largeur-1)
      long_cj = rand(@carte.longueur-1)
      caseJoueur = @carte.getCaseAt(larg_cj, long_cj)
      if(caseJoueur.typeTerrain.isAccessible)
        pasTrouver = false
      end
    end

    # Creation du joueur
    @joueur = Joueur.creer(@difficulte.nbRepos, @difficulte.energieDepart, 100, Inventaire.creer(12), self, caseJoueur, @pseudoPartie)
    caseJoueur.joueur = @joueur # Attribution du joueur à la case

    # Creation des PNJ Amis de depart
    stockItemsJeu=StockMarchand.creer()
    for i in 0..@difficulte.pnjAmisDepart-1
      # Recuperation d'une case aleatoire
      begin
        caseAleatoire = @carte.getCaseAt(rand(@carte.longueur)-1, rand(@carte.largeur)-1)
      end while(!(caseAleatoire.typeTerrain.isAccessible && !caseAleatoire.isFull?()))

      # Choix du type de PNJ Ami
      choix = rand(2)-1 # Nb aleatoire -1 ou 0
      if(choix == 0)
        element = Marchand.creer(caseAleatoire,stockItemsJeu)
      else
        element = Guerisseur.creer(caseAleatoire)
      end

      # Ajout du PNJ Ami dans la case aleatoire
      caseAleatoire.ajouterElement(element)
    end

    @listeEnnemis = Array.new()
    # Creation des PNJ ennemis de depart
    ajoutEnnemis(@difficulte.pnjEnnemisDepart)

    # Creation des items disséminer sur la carte
    ajoutItems(@difficulte.objetsDepart)
    return nil
  end

  ##
  # Méthode changeant le stade de la partie et actualisant la vue par la suite
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def changerStadePartie(nouveauStade)
    @stadePartie=nouveauStade
    AffichageDebug.Afficher("Stade Partie=#{nouveauStade}")
    @vue.actualiser()
    @stadePartie=EnumStadePartie.NO_ETAPE
    AffichageDebug.Afficher("Stade Partie Terminé")
    return nil
  end

  ##
  # Méthode pour ajouter une notification
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def notifier(notification)
    @notifications.push(notification)
    return nil
  end

  ##
  # Méthode pour lire les notifications, ce qui les vide également
  #
  # == Returns :
  # * <b> notifications: </b> Un tableau de String
  #
  def lireNotification()
    return @notifications.shift
  end

  ##
  # Méthode pour ajouter des ennemis
  #
  # == Parameters:
  # * <b> nombre :</b> le nombre à ajouter
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def ajoutEnnemis(nombre)
    for i in 0..nombre-1
      # Recuperation d'une case aleatoire
      begin
        caseAleatoire = @carte.getCaseAt(rand(@carte.longueur)-1, rand(@carte.largeur)-1)
      end while(!(caseAleatoire.typeTerrain.isAccessible && !caseAleatoire.isFull?()))

      if(@nbPisteur<@nbMaxPisteur)
        # Choix du type de PNJ Ennemi
        choix = rand(2)-1 #Nb aleatoire -1 ou 0
        if(choix == 0)
          ennemi = EnnemiNormal.creer(caseAleatoire, @joueur.niveau, BibliothequeTypeEnnemi.getTypeEnnemiAuHasard(),self)
        else
          ennemi = Pisteur.creer(caseAleatoire, @joueur.niveau, BibliothequeTypeEnnemi.getTypeEnnemiAuHasard(),self, @joueur)
          @nbPisteur=@nbPisteur+1
        end
      else
        ennemi = EnnemiNormal.creer(caseAleatoire, @joueur.niveau, BibliothequeTypeEnnemi.getTypeEnnemiAuHasard(),self)
      end

      # Ajout du PNJ Ennemi dans la case aleatoire et dans la listeEnnemis
      caseAleatoire.ajouterEnnemi(ennemi)
      @listeEnnemis.push(ennemi)
    end
    return nil
  end

  ##
  # Méthode pour ajouter des items
  #
  # == Parameters:
  # * <b> nombre :</b> le nombre à ajouter
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def ajoutItems(nombre)
    for i in 0 .. nombre-1
      # Recuperation d'une case aleatoire
      begin
        caseAleatoire = @carte.getCaseAt(rand(@carte.longueur)-1,rand(@carte.largeur)-1)
      end while(!(caseAleatoire.typeTerrain.isAccessible && !caseAleatoire.isFull?()))

      # Choix du type d'item
      choix = rand(3)-1 #Nb aleatoire -1, 0 ou 1
      if(choix == 0)
        caracteristique = Mangeable.creer(BibliothequeTypeMangeable.getTypeMangeableAuHasard())
      elsif(choix == 1)
        caracteristique = Equipable.creer(BibliothequeTypeEquipable.getTypeEquipableAuHasard())
      else
        montant = rand(50)+1
        caracteristique = Encaissable.creer(montant)
      end
      element = Item.creer(caseAleatoire, caracteristique)
      caseAleatoire.ajouterElement(element)
    end
    return nil
  end

  #METHODE POUR GERER LES ACTION DU JOUEUR ETAPES APRES ETAPES
  @@pileExecution = Array.new()

  ##
  # Méthode pour faire évoluer le monde
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def tourPasse()
    notifier(XmlMultilingueReader.lireTexte("tourPasse"))
    @tourDejaPasse=true
    @compteurTour += 1
    @@compteurTourGlob +=1

    for e in @listeEnnemis
      e.deplacementIntelligent()
    end

    # Ajouts
    if(@compteurTour % @difficulte.nbToursInterGenerations == 0)
      ajoutEnnemis(@difficulte.pnjEnnemisParGeneration)
      ajoutItems(@difficulte.objetsParGeneration)
    end

    changerStadePartie(EnumStadePartie.TOUR_PASSE)
    return nil
  end

  ##
  # Méthode pour débuter un tour
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def debutTour()
    changerStadePartie(EnumStadePartie.DEB_TOUR)
    if(!@joueur.toujoursEnVie?())
      @messageDefaite=@joueur.causeMort
      @joueur.meurt(@messageDefaite)
    else
      if(@joueur.casePosition.presenceEnnemis?())
        if(@tourDejaPasse)
          preparationHostilites(EnumMomentCombat.APRES_ACTION)
        else
          preparationHostilites(EnumMomentCombat.APRES_DEPLACEMENT)
        end
      end
      if(@joueur.toujoursEnVie?())
        choixLibre()
      end
    end
    return nil
  end

  ##
  # Méthode pour déclencher les préparatifs de combat
  #
  # == Parameters:
  # * <b> momentCombat :</b> le moment ou intervient le combat
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def preparationHostilites(momentCombat)
    @vue.combatModal.majCombatModal(momentCombat)
    return nil
  end

  ##
  # Méthode pour déclencher les choix d'équipement
  #
  # == Parameters:
  # * <b> momentCombat :</b> le moment ou intervient le combat
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def choixEquipementAvantCombat(momentCombat)
    #on commence par les armures
    compteurArmures=0

    if(!@joueur.armureEquip?())
      for i in @joueur.inventaire.items
        if(i.estEquipable?() && i.caracteristique.typeEquipable.sePorteSur == EnumEmplacementEquipement.ARMURE)
          compteurArmures+=1
        end
      end

      AffichageDebug.Afficher("compteurArmures=#{compteurArmures}")
      if(compteurArmures!=0)
        changerStadePartie(EnumStadePartie.EQUIPEMENT_ARMURE)
        @vue.actualiser()
      else
        suiteEquipementChoixArme(momentCombat)
      end
    else
      suiteEquipementChoixArme(momentCombat)
    end
    return nil
  end

  ##
  # Suite des choix d'équipement
  #
  # == Parameters:
  # * <b> momentCombat :</b> le moment ou intervient le combat
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def suiteEquipementChoixArme(momentCombat)
    compteurArmes=0

    if(!@joueur.armeEquip?())
      for i in @joueur.inventaire.items
        if(i.estEquipable?() && i.caracteristique.typeEquipable.sePorteSur == EnumEmplacementEquipement.ARME)
          compteurArmes+=1
        end
      end

      AffichageDebug.Afficher("compteurArmes=#{compteurArmes}")
      if(compteurArmes != 0)
        changerStadePartie(EnumStadePartie.EQUIPEMENT_ARME)
        @vue.actualiser
      else
        declencherCombat(momentCombat)
      end
    else
      declencherCombat(momentCombat)
    end
    return nil
  end

  ##
  # Méthode pour déclencher les combats
  #
  # == Parameters:
  # * <b> momentCombat :</b> le moment ou intervient le combat
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def declencherCombat(momentCombat)
    itemsEnnemis = Array.new()
    ancienneCase=carte.getCaseAt(@joueur.anciennePositionX,@joueur.anciennePositionY)
    if(momentCombat==EnumMomentCombat.AVANT_DEPLACEMENT())
      for ennemi in ancienneCase.listeEnnemis
        itemsUnEnnemi = Array.new()
        itemsUnEnnemi += @joueur.combattreEnnemi(ennemi)

        if(@joueur.toujoursEnVie?())
          itemsEnnemis += itemsUnEnnemi
        else
          break
        end
      end
      ancienneCase.listeEnnemis.clear
      @joueur.deplacementSuite()
    else
      for ennemi in @joueur.casePosition.listeEnnemis
        itemsUnEnnemi = Array.new()
        itemsUnEnnemi += @joueur.combattreEnnemi(ennemi)

        if(@joueur.toujoursEnVie?())
          itemsEnnemis += itemsUnEnnemi
        else
          break
        end
      end
      @joueur.casePosition.listeEnnemis.clear
    end

    if(@joueur.toujoursEnVie?())
      # Recuperation des items gagnés du/des combat(s)
      for i in itemsEnnemis
        if(@joueur.inventaire.estPlein?())
          @itemAttenteAjout
          changerStadePartie(EnumStadePartie.INVENTAIRE_PLEIN)
        else
          if(i.estStockable?())
            @joueur.inventaire.ajouter(i)
          else
            i.caracteristique.utiliseToi(joueur)
          end

          str=XmlMultilingueReader.lireTexte("recupCombat")
          str=str.gsub("ITEM",XmlMultilingueReader.lireDeterminant_Nom(i))
          notifier(str)
        end
      end
      @joueur.peutSEquiper=true
    end
    if(momentCombat!=EnumMomentCombat.AVANT_DEPLACEMENT())
      changerStadePartie(EnumStadePartie.NO_ETAPE)
    end
    return nil
  end

  ##
  # Méthode appelé une fois les combats (éventuels) finis
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def choixLibre()
    changerStadePartie(EnumStadePartie.CHOIX_LIBRE)
    AffichageDebug.Afficher("Fin de 'choixLibre'")
    return nil
  end

  ##
  # Convertit un temps (en secondes) en heures, minutes, secondes
  #
  # == Parameters
  # <b>temps<b> : Le temps en secondes a convertir
  #
  # == Returns:
  # <b>tempsTot<b> : Une chaine repr�sentant le temps sous la forme h min sec
  #
  def convertirTemps(temps)
    dureeSec = "%02.0i" % (temps % 60)
    dureeMinutes = "%02.0i" % ((temps / 60) % 60) # "%02.0f" => affiche 2 chiffres avant la virgule
    # et 0 apr�s => pour trier les strings correctement
    dureeHeures = "%02.0i" % (temps / 3600)

    tempsTot = "#{dureeHeures} h #{dureeMinutes} min #{dureeSec} sec"
    puts tempsTot
    return tempsTot
  end

  ##
  # Méthode afficher cet objet modele
  #
  # == Returns :
  # * <b> s </b> String contenant la description
  #
  def to_s
    return "[MODELE] : ListeEnnemis = #{@listeEnnemis}\n *****Joueur #{@joueur}"
  end

end
