class Mouvement

	@x
	@y
	@etatPrecedent
	@flag
	
	attr_reader :x
	attr_reader :y
	attr_reader :etatPrecedent
	attr_reader :flag
	
	def initialize(x,y, etat)
		@x = x
		@y = y
		@etatPrecedent = etat
		@flag = false
	end
	
	def Mouvement.enreg(x,y,etat)
		new(x,y,etat)
	end
	
	def raiseFlag
		@flag = true
	end
	

end
