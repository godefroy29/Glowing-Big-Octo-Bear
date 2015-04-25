class Grille

	attr_reader :id
	attr_reader :taille
	attr_reader :difficulte
	attr_reader :base
	attr_reader :solution

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