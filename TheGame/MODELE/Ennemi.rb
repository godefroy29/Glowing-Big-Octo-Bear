#COMOK
#!/usr/bin/env ruby

##
# Fichier : Ennemi.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de gérer des PNJ (Personnages Non Joueurs) Ennemi.
#Les PNJ (Personnages Non Joueurs) Ennemi sont caractérisées par :
#* Un état de vit : vivant = vrai ou faux
#* Un type
#* Une énergie
#* Un niveau
#* Une référence vers le Modele qui le contient
#


require 'MODELE/PNJ.rb'
require 'MODELE/Type/TypeEnnemi.rb'
require 'MODELE/Enum/EnumDirection.rb'
require 'MODELE/Enum/EnumRarete.rb'
require 'MODELE/Interface/Deplacable.rb'

class Ennemi < PNJ
   include Deplacable
  
   #=== Variable d'instance ===
   @vivant
   @type
   @energie
   @niveau
   @modele #un ennemi connait desormais le modele puisqu'on veut qu'il prennent en charge sa mort (afin de lim. le nb de pisteur)
   
   attr_reader :energie, :type, :niveau, :vivant

   private_class_method :new #La construction se fera par la méhode de classe Ennemi.creer(casePosition, niveau, type,modele)
   
   ##
   # Crée un nouvel Ennemi à partir des informations passées en paramètre.
   #
   #===Paramètres :
   #* <b>casePosition :</b> la case où se trouvera le PNJ Ennemi
   #* <b>niveau :</b> le niveau du PNJ Ennemi
   #* <b>type :</b> le type de PNJ Ennemi
   #* <b>modele :</b> le modèle qui gère le PNJ Ennemi
   #
   def initialize(casePosition, niveau, type,modele)
     @vivant = true
	 @modele=modele
     @listeItem = Array.new
      fourchette=3
      super(casePosition)
      @niveau = niveau-fourchette + rand(niveau-fourchette+1)
      if(@niveau<1)
        @niveau=1
      end
      @type = type
      @energie = @type.energieBase * 1.2**(@niveau-1)
      case @niveau
        when 1..5
          remplirListeItems(0,2,EnumRarete.GROSSIER(),EnumRarete.GROSSIER())
        when 6..10
          remplirListeItems(0,2,EnumRarete.GROSSIER(),EnumRarete.INTERMEDIAIRE())
        when 11..15   
          remplirListeItems(0,2,EnumRarete.INTERMEDIAIRE(),EnumRarete.INTERMEDIAIRE())  
        when 16..20   
          remplirListeItems(0,2,EnumRarete.INTERMEDIAIRE(),EnumRarete.RAFFINE())
        when 21..25
          remplirListeItems(0,2,EnumRarete.RAFFINE(),EnumRarete.RAFFINE()) 
        else
          remplirListeItems(0,2,EnumRarete.MAITRE(),EnumRarete.MAITRE())     
      end
      
   end



   ##
   #Permet de créér nouvel Ennemi à partir des informations passées en paramètre.
   #
   #===Paramètres :
   #* <b>casePosition :</b> la case où se trouvera le PNJ Ennemi
   #* <b>niveau :</b> le niveau du PNJ Ennemi
   #* <b>type :</b> le type de PNJ Ennemi
   #* <b>modele :</b> le modèle qui gère le PNJ Ennemi
   #===Retourne :
   #* <b>nouvelEnnemi</b> : le nouvel Ennemi créé
   #
   def Ennemi.creer(casePosition, niveau, type,modele)
      if(self.class == Ennemi)
         raise "Subclass responsability"
      end
      return new(casePosition, niveau, type,modele)
   end


   
   ##
   #Permet de remplir aleatoirement la liste d'Item de l'Ennemi courant.
   #
   #===Paramètres :
   #* <b>min :</b> le nombre minimal d'Item à ajouter à la liste d'Item de l'Ennemi
   #* <b>min :</b> le nombre macimal d'Item à ajouter à la liste d'Item de l'Ennemi
   #* <b>rareteMin :</b> la rareté minimal des Item à ajouter à la liste d'Item de l'Ennemi
   #* <b>rareteMax :</b> la rareté macimal des Item à ajouter à la liste d'Item de l'Ennemi
   #===Retourne :
   #* <b>currEnnemi</b> : l'Ennemi courant
   #
   def remplirListeItems(min,max,rareteMin,rareteMax)
      nbItems = rand(max-min) + min
    
      for i in 1..nbItems
         # Choix du type
         type = rand(8)+1
      
         case type
            when 1..2 # TypeEquipable
               type = BibliothequeTypeEquipable.getTypeEquipableAuHasardRarete(rareteMin,rareteMax)
               caract = Equipable.creer(type)
            when 3..4# TypeMangeable
               type = BibliothequeTypeMangeable.getTypeMangeableAuHasardRarete(rareteMin,rareteMax)
               caract = Mangeable.creer(type)
            else
               quantiteOr=(rand(10)+1)*@niveau
               caract=Encaissable.creer(quantiteOr)
         end # Fin case type
      
         @listeItem.push(Item.creer(nil, caract))
      end # Fin for
    
      return self
   end
 

   ##
   #Permet de faire mourrir l'Ennemi courant.
   #  
   def meurt()
     @vivant = false
     @modele.listeEnnemis.delete(self)
   end
    

   ##
   #Permet de deplacer l'Ennemi en ciblant une direction donnée.
   #
   #===Paramètres :
   #* <b>cible :</b> la direction ciblée (EnumDirection.NORD, EnumDirection.SUD, EnumDirection.EST ou EnumDirection.OUEST)
   #
   def deplacement(cible)
     @ancienRangCase=@rangCase
     @anciennePositionX=@casePosition.coordonneeX
     @anciennePositionY=@casePosition.coordonneeY
     @direction=cible
       caseCible= @casePosition.getDestination(cible)
     nbElemCase=caseCible.listeElements.length+caseCible.listeEnnemis.length
     @rangCase=nbElemCase+1
        if(!@vivant)
		this.meurt
		return nil
		end
        if(!caseCible.isFull?() && caseCible.typeTerrain.isAccessible)
           @casePosition.retirerEnnemi(self)
          caseCible.ajouterEnnemi(self)
           @casePosition = caseCible
           AffichageDebug.Afficher("#{self} \ndéplacé dans \n#{caseCible}")
        else
			AffichageDebug.Afficher("#{self}\n pas déplacé")
        end
      return nil
   end
  

   ##
   #(Abstraite) Permet de deplacer l'Ennemi sur une cible calculée.
   #
   def deplacementIntelligent()
   end
  
   
   ##
   #Renvoie le nom commun de l'Ennemi courant (permet d'accéder à l'image lui correspondant dans la table de RefGraphiques)
   #
   #===Retourne :
   #* <b>intitule</b> : le nom commun de l'Ennemi courant
   #   
   def getIntitule()
      return @type.intitule
   end
  
   
   ##
   #Retourne une chaîne de caractères représentant l'Ennemi courant
   #
   #===Retourne :
   #* <b>s</b> : une chaîne de caractères représentant l'Ennemi courant (énergie, niveau, type)
   #
   def to_s
     s= "Energie: #{@energie} | "
     s+= "Niveau: #{@niveau} | "
     s+= "Type: #{@type} | "
     s+= super()
   end
   
end
