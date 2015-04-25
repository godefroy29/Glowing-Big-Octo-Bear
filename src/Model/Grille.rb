class Grille

	attr_reader :id
	attr_reader :taille
	attr_reader :difficulte
	attr_reader :base
	attr_reader :solution

	##
	# Constructeur
	# Paramètres::
	# - id : l'id de la grille
	# - taille : la taille de la grille
	# - difficulte : difficulte de la grille
	# - base : l'état de base
	# - soltuion : l'état final
	def initialize(id,taille,difficulte,base,solution)
		@id			=	id
		@taille		=	taille
		@difficulte	=	difficulte
		@base		=	base
		@solution	=	solution
	end

	def to_s
		return "Grille id = #{@id} , solution = #{@solution}"
	end

end