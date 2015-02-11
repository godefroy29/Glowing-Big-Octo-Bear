#COMOK
#!/usr/bin/env ruby

##
# Fichier : Difficulte.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
#===Cette classe permet de représenter une Difficulte de jeu. La Difficulté de jeu comprend :
#* Un intitule : l'intitulé de la difficulté
#* Une longueur de carte (en nombre de cases)
#* Une largeur  de carte (en nombre de cases)
#* Une énergie de départ pour le joueur
#* Un nombre de repos initial pour le joueur
#* Une quantité de PNJ amis de départ
#* Une quantité de PNJ ennemis de départ
#* Une quantité de PNJ ennemis pour génération : nombre d'ennemis supplémentaires par génération
#* Une quantité d'objets de départ
#* Une quantité d'objets pour génération : nombre d'objets supplémentaires par génération
#* Un nombre de tours pour génération : nombre de tours entre chaque nouvelle génération de PNJ et d'objets
#* Un pourcentage de coût de terrain : pourcentage de l'énergie des terrain qui sera effectivement consommée lorsque le joueur marchera dessus
#

class Difficulte

   private_class_method :new

   @intitule
   @longueurCarte
   @largeurCarte
   @energieDepart
   @nbRepos
   @pnjAmisDepart
   @pnjEnnemisDepart
   @pnjEnnemisParGeneration
   @objetsDepart
   @objetsParGeneration
   @nbToursInterGenerations
   @pourcentageTerrain

   attr_reader :intitule, :longueurCarte, :largeurCarte, :energieDepart,
   :nbRepos, :pnjAmisDepart, :pnjEnnemisDepart, :pnjEnnemisParGeneration,
   :objetsDepart, :objetsParGeneration, :nbToursInterGenerations, :pourcentageTerrain
   
   
   ##
   #Construit une nouvelle Difficulté à partir des informations passées en paramètre.
   #
   #===Paramètres:
   #* <b>intitule :</b> l'intitulé de la difficulté
   #* <b>longueurCarte :</b> la longueur de la carte
   #* <b>largeurCarte :</b> la largeur de la carte
   #* <b>energieDepart :</b> l'énergie de départ pour le joueur
   #* <b>nbRepos :</b> le nombre de repos initial pour le joueur
   #* <b>pnjAmisDepart :</b> la quantité de PNJ amis de départ
   #* <b>pnjEnnemisDepart :</b> la quantité de PNJ ennemis de départ
   #* <b>pnjEnnemisParGeneration :</b> la quantité de PNJ ennemis pour génération
   #* <b>objetsDepart :</b> la quantité d'objets de départ
   #* <b>objetsParGeneration :</b> la quantité d'objets pour génération
   #* <b>nbToursInterGenerations :</b> le nombre de tours pour génération
   #* <b>pourcentageTerrain :</b> le pourcentage de coût de terrain
   #
   def initialize(intitule, longueurCarte, largeurCarte, energieDepart, nbRepos, pnjAmisDepart, pnjEnnemisDepart, pnjEnnemisParGeneration, objetsDepart, objetsParGeneration, nbToursInterGenerations, pourcentageTerrain)
      @intitule=intitule
      @longueurCarte = longueurCarte
      @largeurCarte = largeurCarte
      @energieDepart = energieDepart
      @nbRepos = nbRepos
      @pnjAmisDepart = pnjAmisDepart
      @pnjEnnemisDepart = pnjEnnemisDepart
      @pnjEnnemisParGeneration = pnjEnnemisParGeneration
      @objetsDepart = objetsDepart
      @objetsParGeneration = objetsParGeneration
      @nbToursInterGenerations = nbToursInterGenerations
      @pourcentageTerrain = pourcentageTerrain
   end

   
   ##
   #Appel de la méthode initialize.
   #
   #===Paramètres:
   #* <b>intitule :</b> l'intitulé de la difficulté
   #* <b>longueurCarte :</b> la longueur de la carte
   #* <b>largeurCarte :</b> la largeur de la carte
   #* <b>energieDepart :</b> l'énergie de départ pour le joueur
   #* <b>nbRepos :</b> le nombre de repos initial pour le joueur
   #* <b>pnjAmisDepart :</b> la quantité de PNJ amis de départ
   #* <b>pnjEnnemisDepart :</b> la quantité de PNJ ennemis de départ
   #* <b>pnjEnnemisParGeneration :</b> la quantité de PNJ ennemis pour génération
   #* <b>objetsDepart :</b> la quantité d'objets de départ
   #* <b>objetsParGeneration :</b> la quantité d'objets pour génération
   #* <b>nbToursInterGenerations :</b> le nombre de tours pour génération
   #* <b>pourcentageTerrain :</b> le pourcentage de coût de terrain
   #
   #===Retourne:
   #* <b>Difficulte :</b> une instance la la classe Difficulté
   #
   def Difficulte.creer(intitule, longueurCarte, largeurCarte, energieDepart, nbRepos, pnjAmisDepart, pnjEnnemisDepart, pnjEnnemisParGeneration, objetsDepart, objetsParGeneration, nbToursInterGenerations, pourcentageTerrain)
      return new(intitule, longueurCarte, largeurCarte, energieDepart, nbRepos, pnjAmisDepart, pnjEnnemisDepart, pnjEnnemisParGeneration, objetsDepart, objetsParGeneration, nbToursInterGenerations, pourcentageTerrain)
   end

   
   ##
   #Retourne une chaîne de caractères reprenant les différentes caractéristiques de l'objet Difficulte sur lequel la méthode est appellée.
   #
   #===Retourne:
   #* <b>Chaine :</b> une chaine représentant la difficulté
   #
   def to_s
      s= "[==Difficulte >>> | "
      s+= "Intitulé: #{@intitule} | "
      s+= "Longueur carte: #{@longueurCarte} | "
      s+= "Largeur carte: #{@largeurCarte} | "
      s+= "Energie depart: #{@energieDepart} | "
      s+= "Nb repos: #{@nbRepos} | "
      s+= "Nb PNJ amis: #{@pnjAmisDepart} | "
      s+= "Nb PNJ ennemis: #{@pnjEnnemisDepart} | "
      s+= "+#{@pnjEnnemisParGeneration}/généraion | "
      s+= "Nb objets: #{@objetsDepart} | "
      s+= "+#{@objetsParGeneration}/généraion | "
      s+= "Nb tours entre générations:  #{@nbToursInterGenerations} | "
      s+= "Pourcentage conso. terrain: #{@pourcentageTerrain*100}% | "
      s+= "<<< Difficulte==]"
      return s
   end

end

