#COMOK
#!/usr/bin/env ruby

##
# Fichier : TypeMangeable.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
#===Cette classe représente un type d'objet que l'on peut manger. Un objet mangeable se défini par :
#* Un intitulé unique permettant de le distinguer
#* Une valeur représentant l'énergie que sa consommation apporte au personnage qui le mangera
#* Un cout d'achat/revente (prix)
#* Une valeur pour la rareté du TypeMangeable
#


class TypeMangeable

   @intitule
   @energieRendue
   @prix
   @rarete

   attr_reader :intitule, :energieRendue, :prix, :rarete
   
   
   ##
   #Crée un nouveau TypeTerrain à partir des informations passées en paramètre.
   #
   #===Paramètres:
   #* <b>intitule :</b> une chaine de caractères correspondant au nom courrament donné au type de nourriture à créer
   #* <b>energieRendue :</b> l'énergie que regagnera le personnage en consommant le mangeale
   #* <b>prix :</b> le prix à l'achat ou à la revente du mangeable
   #* <b>rarete :</b> le nombre représentant la rareté du TypeMangeable
   #
   def initialize(intitule, energieRendue, prix, rarete)
      @intitule      = intitule
      @energieRendue = energieRendue
      @prix          = prix
      @rarete        = rarete
   end
   
   
   ##
   #Appel de la méthode initialize.
   #
   #===Paramètres:
   #* <b>intitule :</b> une chaine de caractères correspondant au nom courrament donné au type de nourriture à créer
   #* <b>energieRendue :</b> l'énergie que regagnera le personnage en consommant le mangeale
   #* <b>prix :</b> le prix à l'achat ou à la revente du mangeable
   #* <b>rarete :</b> le nombre représentant la rareté du TypeMangeable
   #
   #===Retourne:
   #* <b>TypeMangeable :</b> une instance la la classe TypeMangeable
   #
   def TypeMangeable.creer(intitule, energieRendue, prix,rarete)
      return new(intitule, energieRendue, prix,rarete)
   end
   
   
   ##
   #Retourne une description de TypeMangeable
   #
   #===Retourne:
   #* <b>Chaine :</b> une description du TypeMangeable
   #
   def description
     s=XmlMultilingueReader.lireTexte("descTypeMangeable")
     s=s.gsub("INTITULE",@intitule).gsub("ENERGIE",@energieRendue.to_s).gsub("PRICE",@prix.to_s)
     return s
   end
   
   
   ##
   #Retourne l'intitulé du TypeMangeable
   #
   #===Retourne:
   #* <b>Chaine :</b> l'intitulé du TypeMangeable
   #
   def getIntitule
      return @intitule
   end
   
   
   ##
   #Permet de savoir si le TypeMangeable est équipable
   #
   #===Retourne:
   #* <b>Booléen :</b> faux
   #
   def estEquipable?
      return false
   end
   
   
   ##
   #Retourne une chaîne de caractères reprenant les différentes caractéristiques de l'objet TypeMangeable sur lequel la méthode est appellée.
   # 
   #===Retourne:
   #* <b>Chaine :</b> une chaine représentant le TypeMangeable
   #
   def to_s
      s= "[==TypeMangeable >>> | "
      s+= "Intitulé: #{@intitule} | "
      s+= "Energie délivrée: #{@energieRendue} | "
      s+= "Prix: #{@prix} | "
      s+= "<<< TypeMangeable==]"
      return s
   end
   
end
