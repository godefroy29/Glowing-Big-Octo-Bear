#COMOK
#!/usr/bin/env ruby

##
# Fichier : TypeEnnemi.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
#===Cette classe représente un type d'ennemi. Un TypeEnnemi se défini par :
#* Un intitulé unique permettant de le distinguer
#* Une energie de base représentant l'energie de base du TypeEnnemi
#


class TypeEnnemi

   @intitule
   @energieBase

   attr_reader :intitule, :energieBase

   private_class_method :new
   

   ##
   #Crée un nouveau TypeEnnemi à partir des informations passées en paramètre.
   #
   #===Paramètres:
   #* <b>intitule :</b> une chaine de caractères correspondant au nom courrament donné au type d'ennemi à créer
   #* <b>energieBase :</b> l'énergie de base du TypeEnnemi
   #
   def initialize(intitule, energieBase)
      @intitule = intitule
      @energieBase = energieBase
   end

   
   ##
   #Appel de la méthode initialize.
   #
   #===Paramètres:
   #* <b>intitule :</b> une chaine de caractères correspondant au nom courrament donné au type d'ennemi à créer
   #* <b>energieBase :</b> l'énergie de base du TypeEnnemi
   #
   #===Retourne:
   #* <b>TypeEnnemi :</b> une instance la la classe TypeEnnemi
   #
   def TypeEnnemi.creer(intitule, energieBase)
      return new(intitule, energieBase)
   end

   
   ##
   #Retourne une chaîne de caractères reprenant les différentes caractéristiques de l'objet TypeEnnemi sur lequel la méthode est appellée.
   # 
   #===Retourne:
   #* <b>Chaine :</b> une chaine représentant le TypeEnnemi
   #
   def to_s
      s= "[==TypeEnnemi >>> | "
      s+= "Intitulé: #{@intitule}  | "
      s+= "Energie de base: #{@energieBase} | "
      s+= "<<< TypeEnnemi==]"
      return s
   end
   
end

