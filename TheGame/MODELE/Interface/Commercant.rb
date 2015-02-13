#COMOK
#!/usr/bin/env ruby

##
# Fichier : Commercant.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
#===Cette interface definit les actions d'un Commercant.
#

require 'AbstractInterface.rb'

module Commercant
   include AbstractInterface
   
   
   ##
   #Permet au Commercant d'acheter un Item à un vendeur.
   #
   #===Paramètres:
   #* <b>vendeur :</b> le Personnage à qui on achéte l'Item
   #* <b>Item :</b> l'Item acheté
   #
   def acheter(vendeur, item)
      Commercant.api_not_implemented(self)
   end

   
   ##
   #Permet au Commercant de vendre un Item à un acheteur.
   #
   #===Paramètres:
   #* <b>acheteur :</b> le Personnage à qui on vend l'Item
   #* <b>Item :</b> l'Item vendu
   #
   def vendre(acheteur, item)
      Commercant.api_not_implemented(self)
   end

   
   ##
   #Permet au Commercant d'ajouter un Item à son stock.
   #
   #===Paramètres:
   #* <b>Item :</b> l'Item à ajouter au stock
   #
   def ajouterAuStock(item)
      Commercant.api_not_implemented(self)
   end

   
   ##
   #Permet au Commercant de retirer un Item de son stock.
   #
   #===Paramètres:
   #* <b>Item :</b> l'Item à retirer du stock
   #
   def retirerDuStock(item)
      Commercant.api_not_implemented(self)
   end

   
   ##
   #Encaisse une somme d'argent
   #
   #===Paramètres:
   #* <b>revenue :</b> le revenue à encaisser
   #
   def encaisser(revenue)
      Commercant.api_not_implemented(self)
   end

   
   ##
   #Debourse une somme d'argent
   #
   #===Paramètres:
   #* <b>revenue :</b> le revenue à debourser
   #
   def debourser(revenue)
      Commercant.api_not_implemented(self)
   end

end 