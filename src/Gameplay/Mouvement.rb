class Mouvement

	@coord
	@etatPrecedent
	
	attr_reader :coord
	attr_reader :etatPrecedent
	
	def initialize(numeroTuile, etat)
		@coord = numeroTuile
		@etatPrecedent = etat
	end
	
	def enreg(numtui,etat)
		new(numtui,etat)
	end
	

end
