#COMOK
#!/usr/bin/env ruby

##
# Fichier : EnnemiNormal.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de gérer des PNJ (Personnages Non Joueurs) EnnemiNormal.


require 'MODELE/Ennemi.rb'
require 'MODELE/Enum/EnumDirection.rb'

class EnnemiNormal < Ennemi
  

   private_class_method :new #La construction se fera par la méhode de classe EnnemiNormal.creer(casePosition, niveau, type,modele)
     

   ##
   #Crée un nouvel EnnemiNormal à partir des informations passées en paramètre.
   #
   #===Paramètres :
   #* <b>casePosition :</b> la case où se trouvera le PNJ EnnemiNormal
   #* <b>niveau :</b> le niveau du PNJ EnnemiNormal
   #* <b>type :</b> le type de PNJ EnnemiNormal
   #* <b>modele :</b> le modèle qui gère le PNJ EnnemiNormal
   #
   def initialize(casePosition, niveau, type, modele)
      super(casePosition, niveau, type,modele)
   end
  

   ##
   #Permet de créér nouvel EnnemiNormal à partir des informations passées en paramètre.
   #
   #===Paramètres :
   #* <b>casePosition :</b> la case où se trouvera le PNJ EnnemiNormal
   #* <b>niveau :</b> le niveau du PNJ EnnemiNormal
   #* <b>type :</b> le type de PNJ EnnemiNormal
   #* <b>modele :</b> le modèle qui gère le PNJ EnnemiNormal
   #===Retourne :
   #* <b>nouvelEnnemiNormal</b> : le nouvel EnnemiNormal créé
   #
   def EnnemiNormal.creer(casePosition, niveau, type,modele)
      return new(casePosition, niveau, type,modele)
   end
   

   ##
   #Permet de deplacer l'Ennemi sur une cible calculée de manière aléatoire.
   #
   def deplacementIntelligent()
      cible = rand(3)
    
      case cible
         when 0
            cible = EnumDirection.NORD
            if(!@casePosition.caseNord.isFull?() && @casePosition.caseNord.typeTerrain.isAccessible)
               deplacement(cible)
            else
              deplacement(EnumDirection.SUD)
            end
         when 1
            cible = EnumDirection.SUD
            if(!@casePosition.caseSud.isFull?() && @casePosition.caseSud.typeTerrain.isAccessible)
               deplacement(cible)
              else
                deplacement(EnumDirection.EST)
              end
         when 2
            cible = EnumDirection.EST
            if(!@casePosition.caseEst.isFull?() && @casePosition.caseEst.typeTerrain.isAccessible)
               deplacement(cible)
              else
                deplacement(EnumDirection.OUEST)
              end
         else
            cible = EnumDirection.OUEST
            if(!@casePosition.caseOuest.isFull?() && @casePosition.caseOuest.typeTerrain.isAccessible)
               deplacement(cible)
            end
      end 
   end
   

   ##
   #Retourne une chaîne de caractères représentant l'EnnemiNormal courant
   #
   #===Retourne :
   #* <b>s</b> : une chaîne de caractères représentant l'EnnemiNormal courant (énergie, niveau, type encadré de [==EnnemiNormal >>> | <<< EnnemiNormal==])
   #
   def to_s
     s= "[==EnnemiNormal >>> | "
     s+= super()
     s+= "<<< EnnemiNormal==]"
   end
  
end
