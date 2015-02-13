#COMOK
#!/usr/bin/env ruby

##
# Fichier : PNJ.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de gérer des PNJ (Personnages Non Joueurs).
#Les PNJ (Personnages Non Joueurs) sont caractérisées par :
#* Une liste d'éléments : liste d'Items dont ils disposent
#


require 'MODELE/Personnage.rb'


class PNJ < Personnage
  
   #=== Variable d'instance ===
   @listeItem
  
   attr_accessor :listeItem
   
   private_class_method :new #La construction se fera par la méhode de classe PNJ.creer(casePosition)
  
   ##
   #Crée un nouveau PNJ à partir des informations passées en paramètre.
   #
   # == Paramètre:
   #* <b>casePosition :</b> la case où se trouvera le PNJ
   #
   def initialize(casePosition)
      super(casePosition)
   end
  

   ##
   #Permet de créer un nouveau PNJ qui se situera sur la Case "casePosition"
   #
   #===Paramètre :
   #* <b>casePosition</b> : la case où se trouvera le PNJ
   #===Retourne :
   #* <b>nouveuPNJ</b> : le nouveau PNJ créé
   #
   def PNJ.creer(casePosition)
      if(self.class == PNJ)
         raise "Subclass responsability"
      end
      return new(casePosition)
   end
  

end
