#COMOK
#!/usr/bin/env ruby

##
# Fichier : TypeEquipable.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
#===Cette classe représente un type d'objet dont on peux s'équiper. Un objet équipable se défini par :
#* Un intitulé unique permettant de le distinguer
#* Une valeur représentant le pourcentage de protection apporté par le port de l'équipement
#* Une valeur représentant le nombre de tour où l'on conservera l'équipement
#* Un cout d'achat/revente (prix)
#* Une valeur pour l'endrois du port de l'équipement
#* Une valeur pour la rareté de l'équipement
#


class TypeEquipable

   @intitule
   @pourcentageProtection
   @nbTours
   @prix
   @sePorteSur
   @rarete

   attr_reader :intitule, :sePorteSur, :pourcentageProtection, :nbTours, :prix, :rarete

   
   ##
   #Crée un nouveau TypeEquipable à partir des informations passées en paramètre.
   #
   #===Paramètres:
   #* <b>intitule :</b> une chaine de caractères correspondant au nom courrament donné au type de nourriture à créer
   #* <b>pourcentageProtection :</b> le proucentage de protection apporté par le port de l'équipement
   #* <b>nbTours :</b> le nombre de tours durant lequel le personnage conservera l'équipement avant qu'il ne disparaisse
   #* <b>prix :</b> le prix à l'achat ou à la revente de l'équipement
   #* <b>endroisDePort :</b> le numeros représentant l'endrois de port de l'objet
   #* <b>rarete :</b> le nombre représentant la rareté de l'équipement
   #
   def initialize(intitule, pourcentageProtection, nbTours, prix, endroisDePort,rarete)
      @intitule              = intitule
      @sePorteSur            = endroisDePort
      @pourcentageProtection = pourcentageProtection
      @nbTours               = nbTours
      @prix                  = prix
      @rarete                = rarete
   end
   
   
   ##
   #Appel de la méthode initialize.
   #
   #===Paramètres:
   #* <b>intitule :</b> une chaine de caractères correspondant au nom courrament donné au type de nourriture à créer
   #* <b>pourcentageProtection :</b> le proucentage de protection apporté par le port de l'équipement
   #* <b>nbTours :</b> le nombre de tours durant lequel le personnage conservera l'équipement avant qu'il ne disparaisse
   #* <b>prix :</b> le prix à l'achat ou à la revente de l'équipement
   #* <b>endroisDePort :</b> le numeros représentant l'endrois de port de l'objet
   #* <b>rarete :</b> le nombre représentant la rareté de l'équipement
   #
   #===Retourne:
   #* <b>TypeEquipable :</b> une instance la la classe TypeEquipable
   #
   def TypeEquipable.creer(intitule, pourcentageProtection, nbTours, prix, endroisDePort,rarete)
      return new(intitule, pourcentageProtection, nbTours, prix, endroisDePort,rarete)
   end

   
   ##
   #Retourne une description de l'equipement
   #
   #===Retourne:
   #* <b>Chaine :</b> une description de l'equipement
   #
   def description
     s=XmlMultilingueReader.lireTexte("descTypeEquipable")
     s=s.gsub("INTITULE",@intitule).gsub("PROTEC",(@pourcentageProtection*100).to_s).gsub("PRICE",@prix.to_s)
     #s= " #{@intitule} | "
     #s+= "Protection: #{@pourcentageProtection*100}% | "
     #s+= "Prix: #{@prix} | "
     return s
   end
   
   
   ##
   #Retourne l'intitulé du TypeEquipable
   #
   #===Retourne:
   #* <b>Chaine :</b> l'intitulé du TypeEquipable
   #
   def getIntitule
      return @intitule
   end
   
   
   ##
   #Retourne une chaîne de caractères reprenant les différentes caractéristiques de l'objet TypeEquipable sur lequel la méthode est appellée.
   # 
   #===Retourne:
   #* <b>Chaine :</b> une chaine représentant le TypeEquipable
   #
   def to_s
     s= "[==TypeEquipable >>> | "
     s+= "Intitulé: #{@intitule} | "
     s+= "Se porte sur: #{@sePorteSur} | "
     s+= "Rarete: #{@rarete} | "
     s+= "Pourcentage de protection: #{@pourcentageProtection*100}% | "
     s+= "Valable pour #{@nbTours} tours | "
     s+= "Prix: #{@prix} | "
     s+= "<<< TypeEquipable==]"
     return s
   end

end

