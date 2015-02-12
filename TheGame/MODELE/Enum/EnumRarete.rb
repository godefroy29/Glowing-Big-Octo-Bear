#COMOK
#!/usr/bin/env ruby

##
# Fichier : EnumRarete.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
# Cette classe représente les différents types de raretes possibles définie par:
#* Une rarete GROSSIER
#* Une rarete INTERMEDIAIRE
#* Une rarete RAFFINE
#* Une rarete MAITRE
#

class EnumRarete
   
   @@GROSSIER        = 1
   @@INTERMEDIAIRE   = 2
   @@RAFFINE         = 3
   @@MAITRE          = 4
   
   
   ##
   #Indique la rarete GROSSIER.
   #
   #===Retourne:
   #* <b>rarete :</b> la rarete GROSSIER
   #
   def EnumRarete.GROSSIER
      return @@GROSSIER
   end

   
   ##
   #Indique la rarete INTERMEDIAIRE.
   #
   #===Retourne:
   #* <b>rarete :</b> la rarete INTERMEDIAIRE
   #
   def EnumRarete.INTERMEDIAIRE
      return @@INTERMEDIAIRE
   end

   
   ##
   #Indique la rarete RAFFINE.
   #
   #===Retourne:
   #* <b>rarete :</b> la rarete RAFFINE
   #
   def EnumRarete.RAFFINE
      return @@RAFFINE
   end

   
   ##
   #Indique la rarete MAITRE.
   #
   #===Retourne:
   #* <b>rarete :</b> la rarete MAITRE
   #
   def EnumRarete.MAITRE
      return @@MAITRE
   end
   
end