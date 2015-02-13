#COMOK
#!/usr/bin/env ruby

##
# Fichier : Ami.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de gérer des PNJ (Personnages Non Joueurs) Ami.
#Les PNJ (Personnages Non Joueurs) Amis sont caractérisées par :
#* Un intitule : le nom commun de l'Ami (exemple : Guerisseur)
#


require 'MODELE/PNJ.rb'


class Ami < PNJ 
  
   #=== Variable d'instance ===
   @intitule
  

   private_class_method :new #La construction se fera par la méhode de classe Ami.creer(casePosition)
  
  
   ##
   #Crée un nouvel Ami à partir des informations passées en paramètre.
   #
   #===Paramètre :
   #* <b>casePosition :</b> la case où se trouvera le PNJ Ami
   #
   def initialize(casePosition)
      super(casePosition)
   end
  

   ##
   #Permet de créer un nouvel Ami qui se situera sur la Case "casePosition"
   #
   #===Paramètre :
   #* <b>casePosition</b> : la case où se trouvera le PNJ Ami
   #===Retourne :
   #* <b>nouvelAmi</b> : le nouvel Ami créé
   #
   def Ami.creer(casePosition)
      if(self.class == Ami)
         raise "Subclass responsability"
      end
      return new(casePosition)
   end
  
  
   ##
   #Renvoie le nom commun de l'Ami courant (permet d'accéder à l'image lui correspondant dans la table de RefGraphiques)
   #
   #===Retourne :
   #* <b>intitule</b> : le nom commun de l'Ami courant
   #
   def getIntitule()
      return @intitule
   end
  
  
   ##
   #Permet à l'Ami d'interargir avec le Joueur "joueur" passé en paramètre
   #
   #===Paramètre :
   #* <b>joueur</b> : le joueur avec lequel l'Ami doit interargir
   #
   def interaction(joueur)
      #Ne fait rien
   end
   

   ##
   #Retourne une chaîne de caractères représentant l'Ami courant
   #
   #===Retourne :
   #* <b>s</b> : une chaîne de caractères représentant l'Ami courant (intitulé et position sur la Carte)
   #
   def to_s
     s= "Intitule: #{@intitule} | "
     s+= super()
     return s
   end


end
