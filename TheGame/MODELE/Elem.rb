#COMOK
#!/usr/bin/env ruby

##
# Fichier : Elem.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de gérer des éléments Elt.
#Un élément Elt est caractérisé par :
#* Une Case courante : la Case sur laquelle il se trouve à un instant t
#* Un  rang : le rang qu'il occupe dans sa Case (déterminé par la chronologie des créations) 
#* Un  ancien rang : le rang qu'il occupait précédement dans sa Case
#* Une anciennePositionX : l'ancien abscisse dont disposait l'élément Elt
#* Une anciennePositionY : l'ancien ordonnée dont disposait l'élément Elt
#* Un  tourDeCreation : le tour de génération durant lequel a été créé l'élément Elt
#

class Elem
    
   #=== Variables d'instance ===
   @casePosition
   @rangCase
   @ancienRangCase
   @anciennePositionX
   @anciennePositionY
   @tourDeCreation
    
   attr_reader :casePosition, :rangCase, :anciennePositionX, :anciennePositionY, :ancienRangCase
    
   private_class_method :new #La construction se fera par la méhode de classe Elem.creer(casePosition)
    
    
   ##
   #Crée un nouvel élément Elem à partir des informations passées en paramètre.
   #
   #===Paramètre :
   #* <b>casePosition :</b> la case où se trouvera l'élément Elt
   #
   def initialize(casePosition)
      if(casePosition!=nil)
         nbElemCase=casePosition.listeElements.length+casePosition.listeEnnemis.length
         @rangCase=nbElemCase+1
      else
         @rangCase=-1
      end
      @anciennePositionX=-1
      @anciennePositionY=-1
      @ancienRangCase=-1
      @casePosition=casePosition
      @tourDeCreation=Modele.Cpt
   end
    
    
   ##
   #Permet de créer un élément Elem qui se situera sur la Case "casePosition"
   #
   #===Paramètre :
   #* <b>casePosition :</b> la case où se trouvera l'élément Elt nouvelElem
   #===Retourne :
   #* <b>nouvelElem</b> : le nouvel élément Elem créé
   #
    def Elem.creer(casePosition)
        if(self.class==Elem)
          raise "Subclass responsability"
        end
        return new(casePosition)
    end
    
    def vientDEtreGenere?()
      return (@tourDeCreation==Modele.Cpt)
    end


   ##
   #(Abstraite) Renvoie le nom commun de l'élément Elt courant (permet d'accéder à l'image lui correspondant dans la table de RefGraphiques)
   #
   #===Retourne :
   #* <b>intitule</b> : le nom commun de l'élément Elt courant
   #
   def getIntitule()
   end


   ##
   #(Abstraite) Renvoi une chaine de caractères adaptée à l'affichae d'infobulles sur l'élément Elt courant
   #
   #===Retourne :
   #* <b>strInfobulles</b> : une chaîne de caractères pour l'affichage d'une infobulle concernant l'élément Elt courant
   #
   def description()
   end
    


   ##
   #Retourne une chaîne de caractères représentant les différentes caractéristiques de l'élément Elt courant
   #
   #===Retourne :
   #* <b>s</b> : une chaîne de caractères représentant l'élément Elt courant (position sur la Carte)
   #
   def to_s()
      if(@casePosition==nil)
        return "Position: n'est pas sur la carte | "
      else
        return "Position: (#{@casePosition.coordonneeX};#{@casePosition.coordonneeY}) | "
      end
   end
    

end
