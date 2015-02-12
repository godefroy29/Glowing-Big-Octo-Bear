#COMOK
#!/usr/bin/env ruby

##
# Fichier : EnumDirection.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
#===Cette classe représente les différents types de directions possibles définie par:
#* Une direction NORD
#* Une direction SUD
#* Une direction EST
#* Une direction OUEST
#

class EnumDirection
   
   @@NORD  = 1
   @@SUD   = 2
   @@EST   = 3
   @@OUEST = 4
   
   
   ##
   #Indique la direction NORD.
   #
   #===Retourne:
   #* <b>direction :</b> la direction NORD
   #
   def EnumDirection.NORD
      return @@NORD
   end

   
   ##
   #Indique la direction SUD.
   #
   #===Retourne:
   #* <b>direction :</b> la direction SUD
   #
   def EnumDirection.SUD
      return @@SUD
   end

   
   ##
   #Indique la direction EST.
   #
   #===Retourne:
   #* <b>direction :</b> la direction EST
   #
   def EnumDirection.EST
      return @@EST
   end

   
   ##
   #Indique la direction OUEST.
   #
   #===Retourne:
   #* <b>direction :</b> la direction OUEST
   #
   def EnumDirection.OUEST
      return @@OUEST
   end
   
end