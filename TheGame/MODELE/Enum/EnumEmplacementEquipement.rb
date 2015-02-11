#COMOK
#!/usr/bin/env ruby

##
# Fichier : EnumEmplacementEquipement.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
#===Cette classe représente les différents emplacements d'équipements possibles définie par:
#* Un emplacement ARMURE
#* Un emplacement ARME
#* Un emplacement BOTTES
#

class EnumEmplacementEquipement
   
   @@ARMURE = 1
   @@ARME   = 2
   @@BOTTES = 3
   
   
   ##
   #Indique l'emplacement ARMURE.
   #
   #===Retourne:
   #* <b>emplacement :</b> l'emplacement ARMURE
   #
   def EnumEmplacementEquipement.ARMURE
      return @@ARMURE
   end

   
   ##
   #Indique l'emplacement ARME.
   #
   #===Retourne:
   #* <b>emplacement :</b> l'emplacement ARME
   #
   def EnumEmplacementEquipement.ARME
      return @@ARME
   end

   
   ##
   #Indique l'emplacement BOTTES.
   #
   #===Retourne:
   #* <b>emplacement :</b> l'emplacement BOTTES
   #
   def EnumEmplacementEquipement.BOTTES
      return @@BOTTES
   end

end
