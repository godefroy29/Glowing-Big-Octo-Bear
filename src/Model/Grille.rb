#Classe qui permet de stocker les informations concernant les grilles de la base de donnée
class Grille

	attr_reader :id			#id de la grille
	attr_reader :taille		#taille de la grille (longueur et largeur)
	attr_reader :difficulte		#difficulte de la grille (entier)
	attr_reader :base		#état initial de la grille (string)
	attr_reader :solution		#état final de la grille (string)

	def initialize(id,taille,difficulte,base,solution)
		@id		=	id
		@taille		=	taille
		@difficulte	=	difficulte
		@base		=	base
		@solution	=	solution
	end

	##
	#Méthode d'affichage de la classe
	def to_s
		return "Grille id = #{@id} , solution = #{@solution}"
	end

end
