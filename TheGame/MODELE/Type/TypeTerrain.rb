#COMOK
#!/usr/bin/env ruby

##
# Fichier : TypeTerrain.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
#===Cette classe représente un type de terrain. Un type de terrain de défini par :
#* Un intitulé unique permettant de le distinguer
#* Un booléen indiquant si le terrain est accessible ou non (ie si le joueur peut le traverser)
#* Un cout de déplacement (énergie pompée au joueur lorsqu'il franchit le terrain)
#* Une valeur de probabilité pour la répartition du TypeTerrain
#* Un niveau de priorité pour l'affichage de ses bordures
#


class TypeTerrain

   @intitule
   @isAccessible
   @coutDeplacement
   @probaRepartition
   @niveau

    attr_reader :intitule, :isAccessible, :coutDeplacement, :probaRepartition, :niveau

    
   ##
   #Crée un nouveau TypeTerrain à partir des informations passées en paramètre.
   #
   #===Paramètres:
   #* <b>intitule :</b> une chaine de caractères correspondant au nom courrament donné au type de terrain à créer
   #* <b>isAccessible :</b> un booléen indiquant si le terrain peut être franchit ou non
   #* <b>cout :</b> le cout en énergie que devra consommer le joueur pour franchir le terrain
   #* <b>proba :</b> la valeur de probabilité pour la répartition du TypeTerrain
   #* <b>niv :</b> le niveau de priorité du terrain pour imposer ses bordures aux autres
   #
   def initialize(intitule, isAccessible, cout, proba, niv)
      @intitule        = intitule
      @isAccessible    = isAccessible
      @coutDeplacement = cout
      @probaRepartition= proba
      @niveau          = niv
   end


   ##
   #Appel de la méthode initialize.
   #
   #===Paramètres:
   #* <b>intitule :</b> une chaine de caractères correspondant au nom courrament donné au type de terrain à créer
   #* <b>isAccessible :</b> un booléen indiquant si le terrain peut être franchit ou non
   #* <b>cout :</b> le cout en énergie que devra consommer le joueur pour franchir le terrain
   #* <b>proba :</b> la valeur de probabilité pour la répartition du TypeTerrain
   #
   #===Retourne:
   #* <b>TypeTerrain :</b> une instance la la classe TypeTerrain
   #
   def TypeTerrain.creer(intitule, isAccessible, cout, proba, niv)
      return new(intitule, isAccessible, cout, proba, niv)
   end
   
   
   ##
   #Retourne une chaîne de caractères reprenant les différentes caractéristiques de l'objet TypeTerrain sur lequel la méthode est appellée.
   # 
   #===Retourne:
   #* <b>Chaine :</b> une chaine représentant le TypeTerrain
   #
   def to_s
      s= "[==TypeTerrain >>> | "
      s+= "Intitulé: #{@intitule} | "
      if(@isAccessible)
         s+= "Accessible | "
      else 
         s+= "Non Accessible | "
      end
      s+= "Cout de déplacement: #{@coutDeplacement} | "
      s+= "<<< TypeTerrain==]"
      return s
   end

end


