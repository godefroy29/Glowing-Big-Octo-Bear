#COMOK
#!/usr/bin/env ruby

##
# Fichier : BibliothequeTypeTerrain.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
#===Cette classe représente la bibliothèque des types de terrain définie par:
#* Une table de hachage statique contenant les TypeTerrain (les clés sont des intitulés sous forme de chaine de caractères)
#

class BibliothequeTypeTerrain

   @@tableType = Hash.new()

   private_class_method :new
   
   
   ##
   #===Ajouter un TypeTerrain dans la bibliothèque (écrase si déjà présente).
   #
   #===Paramètres:
   #* <b>cle :</b> la clé du TypeTerrain à ajouter
   #* <b>type :</b> le type du TypeTerrain à ajouter
   #
   def BibliothequeTypeTerrain.ajouter(cle,type)
      AffichageDebug.Afficher("Ajout dans BibliothequeTypeTerrain-> clé:#{cle}, type:#{type}")
      @@tableType[cle] = type
      return self
   end

   
   ##
   # Retirer un TypeTerrain de la bibliothèque.
   #
   #===Paramètres:
   #* <b>cle :</b> la clé du TypeTerrain à retirer
   #
   def BibliothequeTypeTerrain.retirer(cle)
      AffichageDebug.Afficher("Suppression dans BibliothequeTypeTerrain-> clé:#{cle}")
      @@tableType.delete(cle)
      return self
   end

   
   ##
   #===Permet de recuperer un TypeTerrain de la bibliothèque.
   #
   #===Paramètres:
   #* <b>cle :</b> la clé du TypeTerrain souhaité
   #
   #===Retourne:
   #* <b>TypeTerrain :</b> le TypeTerrain souhaité
   #
   def BibliothequeTypeTerrain.getTypeTerrain(cle)
      return @@tableType[cle]
   end

   
   ##
   #===Permet de recuperer un TypeTerrain de la bibliothèque au hasard. 
   #
   #===Retourne:
   #* <b>TypeTerrain :</b> un TypeTerrain au hasard
   #
   def BibliothequeTypeTerrain.getTypeTerrainAuHasard()
      valeurs=@@tableType.values()
      val=rand(valeurs.length-1)
      while(valeurs[val]==BibliothequeTypeTerrain.getTypeTerrain("plaine")) do
        val = rand(valeurs.length)
      end
      return valeurs[val]
   end

end
