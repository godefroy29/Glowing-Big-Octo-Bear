#COMPAR
#!/usr/bin/env ruby

##
# Fichier : Carte.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de représenter la Carte du jeu.
#La Carte est caractérisée par :
#* Sa longueur
#* Sa largeur
#* Son tableau de Case
#* L'identifiant du typeTerrain par défaut (chaîne de caractères)
#


require 'MODELE/Case.rb'
require 'MODELE/Type/TypeTerrain.rb'
require 'MODELE/Enum/EnumDirection.rb'
require 'MODELE/Bibliotheque/BibliothequeTypeTerrain.rb'

class Carte

   #=== Variables d'instance ===
   @longueur
   @largeur
   @cases
   #@joueur #AFR : à supprimer (ie : n'a pas été pris en compte dans les comms)
   @id_terrainParDefaut

   attr_reader :longueur, :largeur

   private_class_method :new #La construction se fera par la méhode de classe Carte.nouvelle(long,larg,id_terrainDef)
   
   
   ##
   #Crée une nouvelle Carte à partir des informations passées en paramètres.
   #
   # == Paramètres :
   #* <b>long :</b> la longueur de la Carte (en nombre de Case)
   #* <b>larg :</b> la largeur  de la Carte (en nombre de Case)
   #* <b>id_terrainDef :</b> l'identifiant du typeTerrain par défaut
   #
   def initialize(long,larg,id_terrainDef)
      @longueur = long
      @largeur = larg
      @cases = Array.new()
      @id_terrainParDefaut=id_terrainDef
      for i in 0..long-1
         for j in 0..larg-1
            @cases.push(Case.nouvelle(i,j,self,@id_terrainParDefaut))
         end
      end
      generationMapSemiAleatoire()
   end


   ##
   #Permet de créer une nouvelle Carte à partir des informations passées en paramètres.
   #
   # == Paramètres :
   #* <b>long :</b> la longueur de la Carte (en nombre de Case)
   #* <b>larg :</b> la largeur  de la Carte (en nombre de Case)
   #* <b>id_terrainDef :</b> l'identifiant du typeTerrain par défaut
   #
   #===Retourne :
   #* <b>nouvelleCarte</b> : la nouvelle Carte créée
   #
   def Carte.nouvelle(long,larg,id_terrainDef)
      return new(long,larg,id_terrainDef)
   end


   ##
   #Permet de générer une map en posant des points centraux de génération d'environnement puis l'environnement se répartit selon une probabilité de répartition
   #
   def generationMapSemiAleatoire()
      0.upto((@longueur+@largeur)*2){
	Thread.new do
         tt = BibliothequeTypeTerrain.getTypeTerrainAuHasard
	repartitionType(tt,tt.probaRepartition,rand(@longueur),rand(@largeur))
      	end
	}
     return nil
   end


   ##
   #Permet la répartition du type d'environnement passé en paramètre
   #== Paramètres :
   #* <b>proba :</b> Probabilité de répartition de l'environnement
   #* <b>type :</b> Type de terrain à poser et à propager sur la carte
   #* <b>coordX :</b> Coordonnée en X du point de génération d'environnement a poser
   #* <b>coordY :</b> Coordonnée en Y du point de génération d'environnement a poser
   def repartitionType(type, proba, coordX, coordY)  
      if(coordX >= @longueur || coordY >= @largeur || coordX < 0 || coordY < 0)
         return
      elsif(getCaseAt(coordX,coordY).typeTerrain == type)
         return
      else
         getCaseAt(coordX,coordY).typeTerrain = type
         (rand(100)<proba)?(repartitionType(type,proba-5,coordX-1,coordY)):(return)
         (rand(100)<proba)?(repartitionType(type,proba-5,coordX,coordY-1)):(return)
         (rand(100)<proba)?(repartitionType(type,proba-5,coordX+1,coordY)):(return)
         (rand(100)<proba)?(repartitionType(type,proba-5,coordX,coordY+1)):(return)
      end
      return
   end


   ##
   #Renvoie la Case situées aux coordonnée x et y passées en paramètres
   #
   #===Paramètres :
   #* <b>x</b> : l'abscisse de la Case
   #* <b>y</b> : l'ordonnée de la Case
   #===Retourne :
   #* <b>case</b> : la Case situées aux coordonnée x et y passées en paramètres
   #
   def getCaseAt(x,y)
      return @cases[y%@largeur+(x%@longueur)*@largeur]
   end

   
   ##
   #Retourne une chaîne de caractères représentant la Carte courante
   #
   #===Retourne :
   #* <b>s</b> : une chaîne de caractères représentant la Carte courante (longueur, largeur, Cases)
   #
   def to_s()
     s= "[==Carte >>> | "
     s+= "Longueur: #{@longueur} | "
     s+= "Largeur: #{@largeur} | "
     #s+= "Joueur: #{@joueur} | "#AFR : à supprimer
     s+= "Cases: "
     for c in @cases
      s+= "#{c} ,"
     end
     s+="| "
     s+= "<<< Carte==]"
     return s
   end

end

