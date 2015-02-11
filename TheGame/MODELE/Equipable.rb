#COMOK
#!/usr/bin/env ruby

##
# Fichier : Equipable.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de représenter la Caractéristique Equipable définie par
#* Un typeEquipable
#* Un nombre d'utilisation restantes



require 'MODELE/Caracteristique.rb'
require 'MODELE/Type/TypeEquipable.rb'
require 'MODELE/Joueur.rb'
require 'MODELE/Enum/EnumEmplacementEquipement.rb'

class Equipable < Caracteristique


   #=== Variable d'instance ===
   @typeEquipable
   @nbUtilisationsRestantes

   
   attr_reader :typeEquipable
   attr_accessor :nbUtilisationsRestantes

   private_class_method :new #La construction se fera par la méhode de classe Equipable.creer(typeEquipable)
   

   ##
   #Crée un nouvel Equipable de type typeEquipable
   #
   # == Paramètres:
   #* <b>typeEquipable</b> : le type d'équipable à créér
   #
   def initialize(typeEquipable)
      @typeEquipable = typeEquipable
      @nbUtilisationsRestantes = typeEquipable.nbTours #L'Equipable est utilisable typeEquipable.nbTours tours
   end

   
   ##
   #Permet de créer un nouvel Equipable de type typeEquipable
   #
   # == Paramètres:
   #* <b>typeEquipable</b> : le type d'équipable à créér
   #
   def Equipable.creer(typeEquipable)
      new(typeEquipable)
   end


   ##
   #Permet de déterminer si l'Equipable peut équiper le Joueur ou non.
   #
   #===Retourne :
   #* <b>isEquipable</b> : un booléen à vrai (true)
   #
   def estEquipable?()
      return true
   end
   

   ##
   #Renvoie le nom commun de l'Equipable courant (permet d'accéder à l'image lui correspondant dans la table de RefGraphiques).
   #
   #===Retourne :
   #* <b>intitule</b> : le nom commun de l'Equipable courant
   #   
   def getIntitule()
      return @typeEquipable.intitule
   end


   ##
   #Renvoie le prix de l'Equipable courant.
   #
   #===Retourne :
   #* <b>prix</b> : le prix de l'Equipable courant
   #   
   def prix
     return @typeEquipable.prix
   end
   

   ##
   #Fait en sorte que le Joueur utilise l'Equipable (s'en équipe).
   #
   #===Paramètre :
   #* <b>joueur</b> : un objet Joueur corespondant au joueur qui utilise l'Equipable
   #
   def utiliseToi(joueur)
      if(@typeEquipable.sePorteSur == EnumEmplacementEquipement.ARMURE)
         joueur.armure=self
      elsif(@typeEquipable.sePorteSur == EnumEmplacementEquipement.ARME)
         joueur.arme=self
      elsif(@typeEquipable.sePorteSur == EnumEmplacementEquipement.BOTTES)
         joueur.bottes=self
      end
     str=XmlMultilingueReader.lireTexte("equipement")
     str=str.gsub("EQUIPEMENT",XmlMultilingueReader.lireDeterminant_Nom(self))
     joueur.modele.notifier(str)
   end

   
   ##
   #Retourne une chaîne de caractères représentant l'Equipable courant
   #
   #===Retourne :
   #* <b>s</b> : une chaîne de caractères représentant l'Equipable courant (type et nombre d'utilisations restantes)
   #
   def to_s
      s=XmlMultilingueReader.lireTexte("to_sEquipable")
      s=s.gsub("TYPEEQUIP",@typeEquipable.description).gsub("NBUTIL",@nbUtilisationsRestantes.to_s)
      return s
   end

end
