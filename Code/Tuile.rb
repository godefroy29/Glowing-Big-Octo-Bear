class Tuile

	attr_reader :couleur

	def initialize(couleur)
		@couleur=couleur
	end
end # Marqueur de fin de classe

class TuileJouable < Tuile

	def initialize()
		@couleur=-1
	end

	def changerEnRouge
		@couleur=1
	end

	def changerEnBleu
		@couleur=0
	end

	def changerEnVide
		@couleur=-1
	end

	def changerEnSuivant #-1=>1=>0>-1
		@couleur=@couleur%3-1
	end
end
