#COMOK
#!/usr/bin/env ruby

##
# Fichier : Mangeable.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de représenter la Caractéristique Mangeable définie par
#* Un typeEquipable


require 'MODELE/Caracteristique.rb'
require 'MODELE/Type/TypeMangeable.rb'
require 'MODELE/Joueur.rb'

class Mangeable < Caracteristique
    

    #=== Variable d'instance ===
    @typeMangeable
    
    attr_reader :typeMangeable

    
    private_class_method :new #La construction se fera par la méhode de classe Mangeable.creer(typeMangeable)


    ##
    #Crée un nouveau Mangeable de TypeMangeable "typeMangeable"
    #
    #=== Paramètres:
    #* <b>typeMangeable</b> : le TypeMangeable du Mangeable créé
    #
    def initialize(typeMangeable)
       super()
       @typeMangeable=typeMangeable
    end
    
    
    ##
    #Permet de créer un nouveau Mangeable de TypeMangeable "typeMangeable"
    #
    #=== Paramètres:
    #* <b>typeMangeable</b> : le TypeMangeable du Mangeable créé
    #=== Retourne :
    #* <b>nouveauMangeable</b> : le nouveau Mangeable créé
    #
    def Mangeable.creer(typeMangeable)
        new(typeMangeable)
    end
    

    ##
    #Renvoie le nom commun du Mangeable courant (permet d'accéder à l'image lui correspondant dans la table de RefGraphiques)
    #
    #===Retourne :
    #* <b>intitule</b> : le nom commun du Mangeable courant
    #   
    def getIntitule()
        return typeMangeable.intitule
    end
    
    ##
    #Renvoie le prix du Mangeable courant.
    #
    #===Retourne :
    #* <b>prix</b> : le prix du Mangeable courant
    #   
    def prix
      return @typeMangeable.prix
    end


    ##
    #Fait en sorte que le Joueur utilise le Mangeable courant (le mange).
    #
    #===Paramètre :
    #* <b>joueur</b> : un objet Joueur corespondant au joueur qui utilise le Mangeable
    #
    def utiliseToi(joueur)
        if((joueur.energie+typeMangeable.energieRendue)>=joueur.energieMax)
            joueur.energie=joueur.energieMax
        else
            joueur.energie=joueur.energie+typeMangeable.energieRendue
        end
      str=XmlMultilingueReader.lireTexte("repas")
      str=str.gsub("REPAS",XmlMultilingueReader.lireDeterminant_Nom(self))
      joueur.modele.notifier(str)
    end
    
    
    ##
    #Retourne une chaîne de caractères représentant le Mangeable courant
    #
    #===Retourne :
    #* <b>s</b> : une chaîne de caractères représentant le Mangeable courant (description)
    #
    def to_s
      return @typeMangeable.description
    end
    
end
