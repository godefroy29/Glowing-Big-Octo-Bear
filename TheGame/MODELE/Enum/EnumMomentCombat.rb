#COMOK
#!/usr/bin/env ruby

##
# Fichier        : EnumMomentCombat.rb
# Auteur         : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
#===Cette classe représente les différents moments où intervient un combat définie par:
#* Un moment AVANT_DEPLACEMENT
#* Un moment APRES_DEPLACEMENT
#* Un moment APRES_ACTION
#

class EnumMomentCombat
   
   @@AVANT_DEPLACEMENT  = 1
   @@APRES_DEPLACEMENT  = 2
   @@APRES_ACTION       = 3
   
   
   ##
   #Indique le moment AVANT_DEPLACEMENT.
   #
   #===Retourne:
   #* <b>moment :</b> le moment AVANT_DEPLACEMENT
   #
   def EnumMomentCombat.AVANT_DEPLACEMENT
      return @@AVANT_DEPLACEMENT
   end

   
   ##
   #Indique le moment APRES_DEPLACEMENT.
   #
   #===Retourne:
   #* <b>moment :</b> le moment APRES_DEPLACEMENT
   #
   def EnumMomentCombat.APRES_DEPLACEMENT
      return @@APRES_DEPLACEMENT
   end

   
   ##
   #Indique le moment APRES_ACTION.
   #
   #===Retourne:
   #* <b>moment :</b> le moment APRES_ACTION
   #
   def EnumMomentCombat.APRES_ACTION
      return @@APRES_ACTION
   end
   
end