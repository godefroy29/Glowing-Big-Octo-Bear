#COMOK
#!/usr/bin/env ruby

##
# Fichier : Guerisseur.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de gérer des PNJ (Personnages Non Joueurs) Guerisseur.
#Les PNJ (Personnages Non Joueurs) Guerisseur sont caractérisés par :
#

require 'MODELE/Ami.rb'

class Guerisseur < Ami
  
   
   private_class_method :new #La construction se fera par la méhode de classe Guerisseur.creer(casePosition)


   ##
   #Crée un nouveau Guerisseur à partir des informations passées en paramètre.
   #
   #===Paramètre :
   #* <b>casePosition :</b> la case où se trouvera le PNJ Guerisseur
   #
   def initialize(casePosition)
      super(casePosition)
      @intitule = "Guerisseur"
   end
  

   ##
   #Permet de créer un nouveau Guerisseur qui se situera sur la Case "casePosition"
   #
   #===Paramètre :
   #* <b>casePosition</b> : la case où se trouvera le PNJ Guerisseur
   #===Retourne :
   #* <b>nouveauGuerisseur</b> : le nouveau Guerisseur créé
   #
   def Guerisseur.creer(casePosition)
      return new(casePosition)
   end
  

   ##
   #Permet au Guerisseur du guérir un joueur.
   #
   #===Paramètres :
   #* <b>joueur :</b> le joueur que l'on veut guerir
   #* <b>choix :</b> le numero de la formule de soins choisie (0=25%, 1=50%, 3=75% de guérison)
   #
   def guerrir(joueur, choix)
      case choix
         when 0
            energieG = joueur.energie + joueur.energieMax * 0.25
            joueur.debourser(30)
            joueur.modele.notifier("Vous avez été guérri de 25% de votre énergie maximale")
         when 1
            energieG = joueur.energie + joueur.energieMax * 0.5
            joueur.debourser(50)
            joueur.modele.notifier("Vous avez été guérri de 50% de votre énergie maximale")
         else
            energieG = joueur.energie + joueur.energieMax * 0.75
            joueur.debourser(70)
        joueur.modele.notifier("Vous avez été guérri de 75% de votre énergie maximale")
      end
    
      if(energieG > joueur.energieMax)
         joueur.energie = joueur.energieMax
      else
         joueur.energie = energieG
      end
      joueur.modele.tourPasse()
      return nil      
   end


   ##
   #Permet au Guerisseur d'interargir avec le Joueur "joueur" passé en paramètre (passer en mode soin)
   #
   #===Paramètre :
   #* <b>joueur</b> : le joueur avec lequel le Guerisseur doit interargir
   #
   def interaction(joueur)
     joueur.modele.pnjAideEnInteraction=self  
     joueur.modele.changerStadePartie(EnumStadePartie.INTERACTION_GUERISSEUR)
   end   


   ##
   #Renvoie une chaîne de caractères représentant ce que peux faire un Guerisseur (exemple : "Je peux vous soigner")
   #
   #===Retourne :
   #* <b>descGuerisseur</b> : une chaîne de caractères représentant ce que peux faire un Guerisseur
   #
   def description
     return  XmlMultilingueReader.lireTexte("descGuerisseur")
   end

   
   ##
   #Retourne une chaîne de caractères représentant le Guerisseur courant
   #
   #===Retourne :
   #* <b>s</b> : une chaîne de caractères représentant le Guerisseur courant (intitulé et position sur la Carte encadré de [==Guerisseur >>> | et <<< Guerisseur==])
   #
   def to_s
     s= "[==Guerisseur >>> | "
     s+= super()
     s+= "<<< Guerisseur==]"
   end

end
