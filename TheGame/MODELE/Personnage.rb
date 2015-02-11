#COMOK
#!/usr/bin/env ruby

##
# Fichier : Personnage.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de gérer des Personnage.
#Les Personnage sont caractérisées par :
#* Une direction : la direction vers laquelle le Personnage est orienté
#


require 'MODELE/Elem.rb'
require 'MODELE/Enum/EnumDirection.rb'


class Personnage < Elem

   #=== Variable d'instance ===
   @direction
  
   attr_reader :direction

   private_class_method :new #La construction se fera par la méhode de classe Personnage.creer(casePosition)
  
   ##
   #Crée un nouveau Personnage à partir des informations passées en paramètre.
   #
   # == Paramètre :
   #* <b>casePosition :</b> la case où se trouvera le PNJ
   #
   def initialize(casePosition)
     super(casePosition)
     @direction=EnumDirection.SUD()
   end


   ##
   #Permet de créer un nouveau Personnage qui se situera sur la Case "casePosition"
   #
   #===Paramètre :
   #* <b>casePosition</b> : la case où se trouvera le Personnage
   #===Retourne :
   #* <b>nouveuPersonnage</b> : le nouveau Personnage créé
   #
  def Personnage.creer(casePosition)
    new(casePosition)
  end


end
