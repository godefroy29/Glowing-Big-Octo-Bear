#COMOK
#!/usr/bin/env ruby

##
# Fichier : Joueur.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de gérer le Joueur.
#Le Joueur se caractérise par :
#* Un intitule (permet a la vue de reconnaitre l'objet)
#* Un nombre de Repos representant le nombre de repos restant au joueur
#* Un niveau, correspondant au niveau actuel du joueur
#* Une valeur d'energie correspondant au niveau d'energie actuel du joueur
#* Un seuil d'energie, correspondant a la valeur maximal d'energie du joueur
#* Une valeur d'experience, correspondant a l'experience actuelle du joueur
#* Un seuil d'experience, correspondant au maximum d'experience pour le niveau actuel, s'il est franchi, le joueur prend un niveau et l'experience repart a 0
#* Un boolean tourDejaPasse indiquant si le joueur peut encore interagir ou non
#* Un inventaire , correspondant un objet de type inventaire
#* Une case, correspondant a la case ou se trouve actuellement le joueur
#* Un equipement (armure, arme, bottes), representant les objets équipés par le joueur
#* Un pseudo, correspondant au pseudo du joueur
#* Un nombre d'ennemis tué, pour les statistiques
#* Une distance parcourue, correspondant au nombre de déplacements, pour les statistiques
#* Un string representant la cause de l mort
#* Un boolean si le joueur peut s'equiper
#* Une date de debut de jeu
#* Une date de fin de jeu
#* Une durée de jeu totale
#
#

require "MODELE/Enum/EnumDirection.rb"
require 'MODELE/Enum/EnumStadePartie.rb'
require "MODELE/Enum/EnumMomentCombat.rb"
require "MODELE/Enum/EnumRarete.rb"
require "MODELE/Elem.rb"
require "MODELE/Personnage.rb"
require "MODELE/Interface/Deplacable.rb"
require "MODELE/Interface/Commercant.rb"
require "MODELE/Carte.rb"
require 'XMLReader/XmlClassements.rb'

class Joueur < Personnage
   include Deplacable, Commercant


   #=== Variables d'instance ===
   @intitule
   @nombreRepos
   @enRepos
   @niveau
   @energie
   @energieMax
   @experience
   @experienceSeuil
   @inventaire
   @modele
   @casePosition
   @armure
   @bottes
   @arme
   @pseudo
   @nbEnnemiTues
   @distanceParcourue
   @causeMort
   @peutSEquiper
   @dateDebutJeu # VI de type Time
   @dateFinJeu   # VI de type Time
   @tempsTotal   # Temps de jeu total en secondes

   attr_reader :nombreRepos, :niveau, :experience,
               :experienceSeuil, :inventaire, :casePosition, :nbEnnemiTues, :distanceParcourue,
               :causeMort, :modele, :enRepos
   attr_accessor :armure, :arme, :bottes, :pseudo, :energie, :energieMax, :peutSEquiper,
   				:dateDebutJeu, :dateFinJeu, :tempsTotal
   


   private_class_method :new #La construction se fera par la méhode de classe Joueur.creer(casePosition)
   

   
   ##
   #Crée un nouveau Joueur à  partir des informations passées en paramètre.
   #
   #===Paramètres :
   #* <b>nbRepos :</b> le nombre de repos dont peut diposer le Joueur
   #* <b>energieDepart :</b> l'énergie de départ du Joueur
   #* <b>experienceSeuil :</b> l'expérience de départ du Joueur
   #* <b>inventaire :</b> l'Inventaire du Joueur
   #* <b>modele :</b> le Modele qui gère le joueur
   #* <b>casePosition :</b> la Case sur laquelle le Joueur se trouve
   #* <b>pseudo :</b> le pseudo du Joueur
   #
   def initialize(nbRepos,energieDepart,experienceSeuil,inventaire,modele,casePosition,pseudo)
      super(casePosition)
      @rangCase=0
      @intitule="Joueur"
      @nombreRepos = nbRepos
      @enRepos=false
      @niveau = 1
      @energie = energieDepart
      @energieMax = energieDepart
      @experience = 0
      @experienceSeuil = experienceSeuil
      @tourDejaPasse = false
      @inventaire = inventaire
      @modele = modele
      @armure=nil
      @arme=nil
      @bottes=nil
      @pseudo=pseudo
      @nbEnnemiTues=0
      @distanceParcourue=0
      @peutSEquiper=true
      @dateDebutJeu = Time.now # Debut du temps a la creation du joueur
      @tempsTotal = 0
      @cible
   end


   ##
   #Permet de créer un nouveau Joueur à  partir des informations passées en paramètre.
   #
   #===Paramètres :
   #* <b>nbRepos :</b> le nombre de repos dont peut diposer le Joueur
   #* <b>energieDepart :</b> l'énergie de départ du Joueur
   #* <b>experienceSeuil :</b> l'expérience de départ du Joueur
   #* <b>inventaire :</b> l'Inventaire du Joueur
   #* <b>modele :</b> le Modele qui gère le joueur
   #* <b>casePosition :</b> la Case sur laquelle le Joueur se trouve
   #* <b>pseudo :</b> le pseudo du Joueur
   #===Retourne :
   #* <b>nouveauJoueur</b> : le nouveau Joueur créé
   #
   def Joueur.creer(nbRepos,energieDepart,experienceSeuil,inventaire,modele,casePosition,pseudo)
      new(nbRepos,energieDepart,experienceSeuil,inventaire,modele,casePosition,pseudo)
   end

   
   ##
   #Renvoie le nom commun du Joueur
   #
   #===Retourne :
   #* <b>intitule</b> : le nom commun du Joueur
   #  
   def getIntitule()
      return @intitule
   end


   ##
   #Permet de deplacer le Joueur en ciblant une direction donnée.
   #
   #===Paramètres :
   #* <b>cible :</b> la direction ciblée (EnumDirection.NORD, EnumDirection.SUD, EnumDirection.EST ou EnumDirection.OUEST)
   #
   def deplacement(cible)
      @cible=cible
      @anciennePositionX=@casePosition.coordonneeX
      @anciennePositionY=@casePosition.coordonneeY
      @direction=cible
      if(@modele.tourDejaPasse == false)
         @modele.tourPasse()
      end
      if(casePosition.presenceEnnemis?())
         @modele.preparationHostilites(EnumMomentCombat.AVANT_DEPLACEMENT())
      else
        deplacementSuite()
      end

      return nil
   end
   
   def deplacementSuite()
     if(self.toujoursEnVie?())
             @modele.tourDejaPasse = false;
             dest = @casePosition.getDestination(@cible)
             if(dest != nil)
                dest.joueur = self
                @casePosition.joueur = nil
                @casePosition = dest
                 str=XmlMultilingueReader.lireTexte("deplacementJoueur")
                 str=str.gsub("CASEPOS",@casePosition.coordonneeX.to_s()).gsub("CASECOORD",@casePosition.coordonneeY.to_s).gsub("COUTDEP",(@casePosition.typeTerrain.coutDeplacement*@modele.difficulte.pourcentageTerrain).to_s)
                @modele.notifier(str)
                if(@bottes!=nil)
                  str=XmlMultilingueReader.lireTexte("enfilerBottes")
                  str=str.gsub("BOTTES",XmlMultilingueReader.lireDeterminant_Nom(@bottes)).gsub("PROTEC",(@bottes.typeEquipable.pourcentageProtection()*100).to_s)
                  @modele.notifier(str)
                  energiePerdue= (@casePosition.typeTerrain.coutDeplacement*@modele.difficulte.pourcentageTerrain()*(1-@bottes.typeEquipable.pourcentageProtection()))
                  str=XmlMultilingueReader.lireTexte("perteEnergie")
                  str=str.gsub("ENERGIE",energiePerdue.to_s)
                  @modele.notifier(str)              
                  @energie -= energiePerdue
                  @bottes.nbUtilisationsRestantes=@bottes.nbUtilisationsRestantes-1
                  if(@bottes.nbUtilisationsRestantes==0)
                     @bottes=nil
                     @modele.notifier(XmlMultilingueReader.lireTexte("perteBotte"))
                  else
                     str=XmlMultilingueReader.lireTexte("utilBotte")
                     str=str.gsub("NB",@bottes.nbUtilisationsRestantes.to_s)
                     @modele.notifier(str)
                  end
                else
                  energiePerdue= (@casePosition.typeTerrain.coutDeplacement*@modele.difficulte.pourcentageTerrain)
                  @energie -= energiePerdue
                  str=XmlMultilingueReader.lireTexte("perteEnergie")
                  str=str.gsub("ENERGIE",energiePerdue.to_s)
                  @modele.notifier(str)     
                end
                @distanceParcourue += 1
                @modele.changerStadePartie(EnumStadePartie.JOUEUR_MVT)
             end
             if(!toujoursEnVie?()) 
                @causeMort= XmlMultilingueReader.lireTexte("mortFatigue")
             end
           
          end
     @modele.debutTour()
   end


   ##
   #Fait combattre le joueur
   #Prend en compte les objets équipés 
   #Decremente l'energie a partir de la valeur d'energie du monstre
   #Demande au modele de supprimer l'ennemi mort si le combat est gagné, incremente nbEnnemiTues, fait gagner de l'experience renvoi une liste d'item
   #Si l'energie de l'ennemi est égale a celle du joueur, alors ils s'entretuent, memes actions que lors d'un combat remporté, on signal au modele la mort du joueur, retourne un tableau vide
   #Si le joueur avait moins d'energie, on specifie la mort du joueur, retourne un tableau vide
   #
   #===Paramètres :
   #* <b>ennemi :</b> l'Ennemi à combattre
   #
   def combattreEnnemi(ennemi)
	if(!ennemi.vivant)
		ennemi.meurt
		return
	end
     str=XmlMultilingueReader.lireTexte("combatEnCours")
     str=str.gsub("INTITULE",XmlMultilingueReader.lireDeterminant_Nom(ennemi)).gsub("NIVEAU",ennemi.niveau().to_s).gsub("ENERGIE",ennemi.energie().to_s)
     @modele.notifier(str)
     protection=0
      if(self.armureEquip?())
        protection=protection+@armure.typeEquipable.pourcentageProtection()
        str=XmlMultilingueReader.lireTexte("utiliserProtec")
        str=str.gsub("INTITULE",XmlMultilingueReader.lireDeterminant_Nom(@armure)).gsub("PROTEC",(@armure.typeEquipable.pourcentageProtection()*100).to_s)
        @modele.notifier(str)
        @armure=nil
      end
      if(self.armeEquip?())
        protection=protection+@arme.typeEquipable.pourcentageProtection()
        str=XmlMultilingueReader.lireTexte("utiliserProtec")
        str=str.gsub("INTITULE",XmlMultilingueReader.lireDeterminant_Nom(@arme)).gsub("PROTEC",(@arme.typeEquipable.pourcentageProtection()*100).to_s)
        @modele.notifier(str)
        @arme=nil
      end
      if(protection>1)
        protection=1
        @modele.notifier(XmlMultilingueReader.lireTexte("protectTotale"))
      end
      energiePerdue=ennemi.energie*(1-protection)
      @energie -= energiePerdue
      str=XmlMultilingueReader.lireTexte("perteEnergie")
      str=str.gsub("ENERGIE",energiePerdue.to_s)
      @modele.notifier(str)     
      if(@energie > 0)
         ennemi.meurt()
         gainExperience(ennemi.energie)
         @nbEnnemiTues += 1
         return ennemi.listeItem
      elsif(@energie == 0)
         ennemi.meurt()
         gainExperience(ennemi.energie)
         @nbEnnemiTues += 1
         @causeMort= XmlMultilingueReader.lireTexte("entretue")
      else
      	str = XmlMultilingueReader.lireTexte("mortCombat")
      	str = str.gsub("ENNEMI", XmlMultilingueReader.lireDeterminant_Nom(ennemi))
         @causeMort = str
      end
      ennemi.meurt()
      return Array.new()
   end


   ##
   #Verifie si le Joueur est equipé d'une armure
   #
   #=== Retourne:
   #* <b>hasArmure :</b> un booléen à vrai (true) si le Joueur est équipé d'une armure, à faux (false) le cas contraire
   #
   def armureEquip?()
      return @armure!=nil
   end


   ##
   #Verifie si le Joueur est equipé d'une arme
   #
   #=== Retourne:
   #* <b>hasArme :</b> un booléen à vrai (true) si le Joueur est équipé d'une arme, à faux (false) le cas contraire
   #
   def armeEquip?()
      return @arme!=nil
   end
   

   ##
   #Verifie si le joueur peut acheter l'Item "item"
   # 
   #=== Paramètre:
   #* <b>item :</b> l'Item dont on veux savoir si le Joueur peut l'acheter
   #=== Retourne:
   #* <b>canBuy :</b> un booléen à vrai (true) si le Joueur peut se permettre l'achat, à faux (false) le cas contraire
   #
   def peutSePermettreAchat?(item)
     #return @inventaire.capital>item.prix #AFR
     return @inventaire.capital>item.caracteristique.prix
   end
   

   ##
   #Verifie si le joueur peut débloquer l'Item "item"
   # 
   #=== Paramètre:
   #* <b>item :</b> l'Item dont on veux savoir si le Joueur peut le débloquer
   #=== Retourne:
   #* <b>canDebloc :</b> un booléen à vrai (true) si le joueur a un niveau suffisant par rapport à la rarete de l'item, 
   #                                à faux (false) le cas contraire
   # 
   def peutDebloquer?(item)
      case item.rarete
         when EnumRarete.GROSSIER()
            return @niveau>=5
         when EnumRarete.INTERMEDIAIRE()
            return @niveau>=10
         when EnumRarete.INTERMEDIAIRE()
            return @niveau>=15
         when EnumRarete.MAITRE() 
            return @niveau>=20
      end
   end


   ##
   #Permet au Joueur d'utiliser l'Item "item"
   #
   #=== Paramètre:
   #* <b>item :</b> l'Item que le Joueur souhaite utiliser
   #
   def utiliserItem(item)
      item.utiliseToi(self)
      return nil
   end


   ##
   #Definit la methode _deplacementIntelligent_.
   #non utilisée pour le joueur
   #
   def deplacementIntelligent()
     return nil
   end


   ##
   #Fait passer un niveau au joueur
   #
   def passeNiveau()
      @niveau += 1
      @experienceSeuil *= 1.2
      @energieMax*=1.2
      @energie=energieMax
      str=XmlMultilingueReader.lireTexte("passageNiveau")
      str=str.gsub("NIVEAU",@niveau.to_s())
      @modele.notifier(str)
      if(@niveau%5 == 0)
         @nombreRepos += 1
         @modele.notifier(XmlMultilingueReader.lireTexte("gainRepos"))
      end
      return nil
   end

   ##
   #Fait gagner de l'experience au joueur, si le Seuil d'experience est depassé, fait gagner un niveau
   #
   #=== Paramètre:
   #* <b>xp :</b> float representant l'experience à ajouter
   #
   def gainExperience(xp)
      @experience=@experience+(xp/2)
      @modele.notifier("+ #{xp/2}XP")
     
     while(@experience>=@experienceSeuil) do
       @experience=@experience-@experienceSeuil  
       passeNiveau()
         
      end
      
      return nil
   end
   

   ##
   #Permet au Joueur d'acheter l'Item "item"
   #Transfert un item du vendeur vers le joueur
   #Perte d'argent du joueur
   #
   #=== Paramètre:
   #* <b>item :</b> l'Item que le Joueur souhaite acheter
   #
   def acheter(item)
      ajouterAuStock(item.clone)
      debourser(item.caracteristique.prix())
      str=XmlMultilingueReader.lireTexte("achete")
      str=str.gsub("INTITULE",XmlMultilingueReader.lireDeterminant_Nom(item))
      @modele.notifier(str)
   end

   ##
   #Permet au Joueur de vendre l'Item d'indice "i" de son Inventaire
   #Gain d'argent du joueur
   #
   #=== Paramètre:
   #* <b>i :</b> l'indice dans l'Inventaire du Joueur de l'Item à vendre
   #
   def vendre(i)
      item=@inventaire.getItem(i)
      retirerDuStock(item)
      encaisser(item.caracteristique.prix()/2)
      str=XmlMultilingueReader.lireTexte("vendu")
      str=str.gsub("INTITULE",XmlMultilingueReader.lireDeterminant_Nom(item))
      @modele.notifier(str)
   end


   ##
   #Ajoute un item dans l'inventaire
   #
   #=== Paramètre:
   #* <b>item :</b> l'Item à ajouter à l'Inventaire
   #
   def ajouterAuStock(item)
      @inventaire.ajouter(item)
   end


   ##
   #Retire un item dans l'inventaire
   #
   #=== Paramètre:
   #* <b>item :</b> l'Item à retirer de l'Inventaire
   #
   def retirerDuStock(item)
      @inventaire.retirer(item)
       #tourPasse()
   end

   ##
   #Permet au Joueur d'encaisser une somme d'argent "revenu"
   #
   #===Paramètre :
   #* <b>revenu :</b> la somme d'argent à encaisser
   #
   def encaisser(revenu)
      @inventaire.capital+=revenu
      str=XmlMultilingueReader.lireTexte("empocher")
      str=str.gsub("REVENUE",revenu.to_s)
      @modele.notifier(str)
   end


   ##
   #Permet au Joueur de debourser une somme d'argent "somme"
   #
   #===Paramètre :
   #* <b>somme :</b> la somme d'argent à débourser
   #
   def debourser(somme)
      @inventaire.capital-=somme
      str=XmlMultilingueReader.lireTexte("debourser")
      str=str.gsub("REVENUE",somme.to_s)
      @modele.notifier(str)
   end


   ##
   #Verifie si le joueur est toujours en vie
   #
   #=== Retourne:
   #* <b>life :</b> un booléen à vrai (true) si le Joueur est toujours en vie, à faux (false) le cas contraire
   #
   def toujoursEnVie?()
      return @energie > 0
   end


   ##
   #Permert au Joueur de consommer un de ses repos
   #
   def utiliserRepos()
     @enRepos=true
     @peutSEquiper=true
     @nombreRepos=@nombreRepos-1
     @modele.notifier(XmlMultilingueReader.lireTexte("utiliserRepos"))
      i=10
      begin
         @energie=@energie+@energieMax*0.1
         if(@energie>@energieMax)
            @energie=@energieMax
         end
         i=i-1
         @modele.tourPasse()
         if(@casePosition.presenceEnnemis?())
           str=XmlMultilingueReader.lireTexte("attackRepos")
           str=str.gsub("TOURS",(10-i).to_s)
           @modele.notifier(str)
           @peutSEquiper=false
           break
         end
      end while(i>0)
      if(i==10)
        @modele.notifier(XmlMultilingueReader.lireTexte("reposOK"))
      end
      @enRepos=false
   end


   ##
   #Ramasse un Item
   #
   #=== Paramètre:
   #* <b>item :</b> l'Item à ramasser
   #
   def ramasserItem(item)
     @itemAttenteAjout=item
     if(@inventaire.estPlein?())
        @modele.changerStadePartie(EnumStadePartie.INVENTAIRE_PLEIN)
        @modele.vue.popUp.choixInventairePlein#AFR 
     else
        @inventaire.ajouter(item)
        @modele.notifier(XmlMultilingueReader.lireTexte("ramasserItem")+"#{XmlMultilingueReader.lireDeterminant_Nom(item)}.")
        @casePosition.retirerElement(item) #AFR (était après le end à la base)
     end
     @modele.tourPasse()
   end
   
   
   ##
   #Calcule le temps de jeu total du joueur, en prenant en compte le temps pass� sur une session de jeu pr�c�dente (sauvegarde)
   #
   def calculerTempsTotal
   	@tempsTotal = @tempsTotal + (@dateFinJeu - @dateDebutJeu)
   	@modele.convertirTemps(@tempsTotal)
   end

   
   ##
   #Fait mourir le joueur, arrete le temps de jeu, ecrit le score du joueur dans le classement et affiche un popup de mort
   #
   #=== Paramètre:
   #* <b>messageDefaite :</b> le message de mort à afficher
   #
   def meurt(messageDefaite)
     sleep(2)
   	@modele.changerStadePartie(EnumStadePartie.PERDU)
         
      # Arret du temps de jeu
		@dateFinJeu = Time.now
		calculerTempsTotal
		
		XmlClassements.ecrireXml(@modele)
		@modele.vue.popUp.affichePopUpMort(messageDefaite)
   end
   
   

   ##
   #Retourne une chaîne de caractères représentant le Joueur
   #
   #===Retourne :
   #* <b>s</b> : une chaîne de caractères représentant le Joueur (entourée par [==Joueur >>> | et <<< Joueur==])
   #
   def to_s
      s= "[==Joueur >>> | "
      s+= super()
      s+= "Intitulé: #{@intitule} | "
      s+= "Nb de repos: #{@nombreRepos} | "
      s+= "Niveau: #{@niveau} | "
      s+= "Energie #{@energie} | "
      s+= "EnergieMax #{@energieMax} | "
      s+= "Experience #{@experience} | "
      s+= "ExperienceSeuil #{@experienceSeuil} | "
      s+= "Inventaire #{@inventaire} | "
      s+= "Armure #{@armure} | "
      s+= "Arme #{@arme} | "
      s+= "Bottes #{@bottes} | "
      s+= "Pseudo #{@pseudo} | "
      s+= "Nb ennemi tués #{@nbEnnemiTues} | "
      s+= "Distance parcourue #{@distanceParcourue} | "
      s+= "Message cause mort: #{@causeMort} | "
      if(@peutSEquiper)
        s+= "Peut s'équiper | "
      else
        s+= "Ne peut pas s'équiper | "
      end
      s+= "<<< Joueur==]"
      return s
   end

end
