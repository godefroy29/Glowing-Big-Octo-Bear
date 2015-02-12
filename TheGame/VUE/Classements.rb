#COMOK
#!/usr/bin/env ruby 

## 
# Fichier        : Classements.rb 
# Auteur         : L3SPI - Groupe de projet B 
# Fait partie de : TheGame 
# 
#===Cette classe permet de créer une liste de statistiques des joueurs et ce pour chaque difficulté. Elle contient donc :
#* Une liste représentant les statistiques des joueurs novices
#* Une liste représentant les statistiques des joueurs moyens
#* Une liste représentant les statistiques des joueurs experts
# Chaque joueur a un nom, un nombre d'ennmis tués, une distance total parcourue, un total d'or, un temps total de jeu, un score et un niveau de difficulté
#

class Classements

   @listeStatsNovice
   @listeStatsMoyen
   @listeStatsExpert

   ##
   # Constucteur : permet d'initialiser chaque liste en créant un tableau pour chacune d'entres elles
   #
   def initialize
      @listeStatsNovice = Array.new
      @listeStatsMoyen = Array.new
      @listeStatsExpert = Array.new
   end


   ##
   # Permet d'ajouter un joueur et ses statistiques à la liste correspondant à sa difficulté
   #=== Paramètres : 
   #* <b>nom :</b> une chaine de caractères correspondant au nom du joueur
   #* <b>nbEnnemisTues :</b> un entier correspondant au nombre d'ennemis tués par le joueur
   #* <b>distance :</b> un entier correspondant à la distance totale parcourue par le joueur
   #* <b>orTotal :</b> un entier correspondant à l'or total accumulé par le joueur
   #* <b>temps :</b> un entier correspondant au temps de jeu total du joueur en secondes
   #* <b>score :</b> un entier correspondant au score obtenu par le joueur au cours de sa partie
   #* <b>difficulte :</b> une chaine de caractères correspondant à la difficulté du joueur qui permet de choisir la liste à laquelle il faut ajouter les statistiques
   # 
   def addJoueur(nom, nbEnnemisTues, distance, orTotal, temps, score, difficulte)
   	
   	if(difficulte == "Novice")
			@listeStatsNovice.push([nom, nbEnnemisTues, distance, orTotal, temps, score])
		elsif(difficulte == "Moyen")
			@listeStatsMoyen.push([nom, nbEnnemisTues, distance, orTotal, temps, score])
		elsif(difficulte == "Expert")
			@listeStatsExpert.push([nom, nbEnnemisTues, distance, orTotal, temps, score])
		end
		
   end


   ##
   # Permet de récupérer la liste des statistiques des joueurs en fonction de la difficulté
   #
   #=== Paramètres : 
   #* <b>difficulte :</b> une chaine de caractères correspondant à la difficulté du joueur qui permet de choisir la liste à retourner
   #
   #===Retourne : 
   #* <b>@listeStatsX :</b> un tableau contenant les statistiques des joueurs ayant la difficulté X
   # 
   def getListeJoueur(difficulte)
   	
   	if(difficulte == "Novice")
			return @listeStatsNovice
		elsif(difficulte == "Moyen")
			return @listeStatsMoyen
		elsif(difficulte == "Expert")
			return @listeStatsExpert
		end
      
   end 

end

