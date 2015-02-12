#COMOK
#!/usr/bin/env ruby

##
# Fichier : Deplacable.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
#===Cette interface definit les deplacements.
#

require 'AbstractInterface.rb'

module Deplacable
   include AbstractInterface
  

   ##
   #Permet le deplacement sur une cible donnée.
   #
   #===Paramètres:
   #* <b>cible :</b> la direction du deplacement à réaliser
   #
   def deplacement(cible)
      Deplacable.api_not_implemented(self)
   end
  
   
   ##
   #Permet le deplacement intelligent.
   #
   def deplacementIntelligent()
      Deplacable.api_not_implemented(self)
   end
  
end