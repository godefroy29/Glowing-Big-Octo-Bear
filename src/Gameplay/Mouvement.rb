class Mouvement

	@x
	@y
	@etatPrecedent
	
	attr_reader :x
	attr_reader :y
	attr_reader :etatPrecedent
	
	def initialize(x,y, etat)
		@x = x
		@y = y
		@etatPrecedent = etat
	end
	
	def Mouvement.enreg(x,y,etat)
		new(x,y,etat)
	end
	

end
