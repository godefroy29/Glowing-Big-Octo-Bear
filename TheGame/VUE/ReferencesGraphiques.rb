#COMOK
#!/usr/bin/env ruby 

## 
# Fichier        : ReferencesGraphiques.rb 
# Auteur         : L3SPI - Groupe de projet B 
# Fait partie de : TheGame 
# 
#===Cette classe représente la bibliothèque de références graphiques définie par:
#* Une table de hachage contenant les images d'éléments affichables (les clés sont des intitulés sous forme de chaine de caractères)
#

class ReferencesGraphiques

   @biblioGraphique

   
   ##
   #Constucteur : permet d'initialiser un Hash qui contiendra pour chaque intitulé unique d'élément affichable
   #la référence vers le fichier image qui le représente.
   #
   def initialize
      @biblioGraphique = Hash.new
   end


   ##
   #Permet d'ajouter une référence graphique à la bibliothèque
   #
   #===Paramètres:
   #* <b>intitule :</b> une chaine de caractères correspondant au nom courrament donné à l'objet affichable
   #* <b>cheminImg :</b> le chemin vers le fichier image représentant l'objet affichable dans l'IHM
   # 
   def addRefGraphique(intitule, cheminImg)
      @biblioGraphique[intitule] = cheminImg
      AffichageDebug.Afficher("Ajout dans du couple clé:#{intitule}, type:#{cheminImg} dans #{self}")
      return self
   end


   ##
   #Permet d'ajouter une référence graphique à la bibliothèque
   #
   #===Paramètres: 
   #* <b>intitule :</b> une chaine de caractères correspondant au nom courrament donné à l'objet affichable
   #
   #=== Retourne: 
   #* <b>fichierImg :</b> le chemin vers le fichier image représentant l'objet affichable dans l'IHM
   # 
   def getRefGraphique(intitule)
      return @biblioGraphique[intitule]
   end 


   ##
   #Permet de renvoyer une chaîne de caractères représentant la bibliothèque d'éléments graphiques
   # sous la forme d'une liste de lignes <intitutle> à pour image <fichier_image>
   #
   #===Retourne: 
   #* <b>s :</b> une chaîne de caractères représentant la bibliothèque d'éléments graphiques
   # 
   def to_s
      s = "[==ReferencesGraphiques >>> | "
      @biblioGraphique.each {|key, value| s += "#{key} à pour image #{value} |" }
      s+= " <<< ReferencesGraphiques==]"
      return s
   end

end
