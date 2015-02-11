#COMOK
#!/usr/bin/env ruby

##
# Fichier : EnumStadePartie.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
# Cette classe représente les différents stades de la partie définie par:
#* Un stade NO_ETAPE
#* Un stade CHOIX_LIBRE
#* Un stade PERDU
#* Un stade EQUIPEMENT_ARMURE
#* Un stade EQUIPEMENT_ARME
#* Un stade INVENTAIRE_PLEIN
#* Un stade INTERACTION_MARCHAND
#* Un stade INTERACTION_GUERISSEUR
#* Un stade INTERACTION_MARCHAND_ACHAT
#* Un stade INTERACTION_MARCHAND_VENTE
#* Un stade TOUR_PASSE
#* Un stade JOUEUR_MVT
#* Un stade DEB_TOUR
#

class EnumStadePartie
   
   @@NO_ETAPE                   = 1
   @@CHOIX_LIBRE                = 2
   @@PERDU                      = 3
   @@EQUIPEMENT_ARMURE          = 4
   @@EQUIPEMENT_ARME            = 5
   @@INVENTAIRE_PLEIN           = 6
   @@INTERACTION_MARCHAND       = 7
   @@INTERACTION_GUERISSEUR     = 8
   @@INTERACTION_MARCHAND_ACHAT = 9
   @@INTERACTION_MARCHAND_VENTE = 10
   @@INVENTAIRE_USAGE           = 11
   @@TOUR_PASSE                 = 12
   @@JOUEUR_MVT                 = 13
   @@DEB_TOUR                 = 14
   
   
   ##
   #Indique le stade NO_ETAPE.
   #
   #===Retourne:
   #* <b>stade :</b> le stade NO_ETAPE
   #
   def EnumStadePartie.NO_ETAPE
      return @@NO_ETAPE
   end

   
   ##
   #Indique le stade CHOIX_LIBRE.
   #
   #===Retourne:
   #* <b>stade :</b> le stade CHOIX_LIBRE
   #
   def EnumStadePartie.CHOIX_LIBRE
      return @@CHOIX_LIBRE
   end

   
   ##
   #Indique le stade PERDU.
   #
   #===Retourne:
   #* <b>stade :</b> le stade PERDU
   #
   def EnumStadePartie.PERDU
      return @@PERDU
   end

   
   ##
   #Indique le stade EQUIPEMENT_ARMURE.
   #
   #===Retourne:
   #* <b>stade :</b> le stade EQUIPEMENT_ARMURE
   #
   def EnumStadePartie.EQUIPEMENT_ARMURE
      return @@EQUIPEMENT_ARMURE
   end

   
   ##
   #Indique le stade EQUIPEMENT_ARME.
   #
   #===Retourne:
   #* <b>stade :</b> le stade EQUIPEMENT_ARME
   #
   def EnumStadePartie.EQUIPEMENT_ARME
      return @@EQUIPEMENT_ARME
   end

   
   ##
   #Indique le stade INVENTAIRE_PLEIN.
   #
   #===Retourne:
   #* <b>stade :</b> le stade INVENTAIRE_PLEIN
   #
   def EnumStadePartie.INVENTAIRE_PLEIN
      return @@INVENTAIRE_PLEIN
   end

   
   ##
   #Indique le stade INTERACTION_MARCHAND.
   #
   #===Retourne:
   #* <b>stade :</b> le stade INTERACTION_MARCHAND
   #
   def EnumStadePartie.INTERACTION_MARCHAND
      return @@INTERACTION_MARCHAND
   end

   
   ##
   #Indique le stade INTERACTION_GUERISSEUR.
   #
   #===Retourne:
   #* <b>stade :</b> le stade INTERACTION_GUERISSEUR
   #
   def EnumStadePartie.INTERACTION_GUERISSEUR
      return @@INTERACTION_GUERISSEUR
   end

   
   ##
   #Indique le stade INTERACTION_MARCHAND_ACHAT.
   #
   #===Retourne:
   #* <b>stade :</b> le stade INTERACTION_MARCHAND_ACHAT
   #
   def EnumStadePartie.INTERACTION_MARCHAND_ACHAT
      return @@INTERACTION_MARCHAND_ACHAT
   end

   
   ##
   #Indique le stade INTERACTION_MARCHAND_VENTE.
   #
   #===Retourne:
   #* <b>stade :</b> le stade INTERACTION_MARCHAND_VENTE
   #
   def EnumStadePartie.INTERACTION_MARCHAND_VENTE
      return @@INTERACTION_MARCHAND_VENTE
   end
   
   
   ##
   #Indique le stade INTERACTION_MARCHAND_VENTE.
   #
   #===Retourne:
   #* <b>stade :</b> le stade INTERACTION_MARCHAND_VENTE
   #
   def EnumStadePartie.INVENTAIRE_USAGE
      return @@INVENTAIRE_USAGE
   end
   
   ##
   #Indique le stade TOUR_PASSE.
   #
   #===Retourne:
   #* <b>stade :</b> le stade TOUR_PASSE
   #
   def EnumStadePartie.TOUR_PASSE
      return @@TOUR_PASSE
   end
   
   ##
   #Indique le stade JOUEUR_MVT.
   #
   #===Retourne:
   #* <b>stade :</b> le stade JOUEUR_MVT
   #
   def EnumStadePartie.JOUEUR_MVT
      return @@JOUEUR_MVT
   end
   
    ##
    #Indique le stade DEB_TOUR.
    #
    #===Retourne:
    #* <b>stade :</b> le stade DEB_TOUR
    #
    def EnumStadePartie.DEB_TOUR
       return @@DEB_TOUR
    end

end
