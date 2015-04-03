class Score

	attr_reader :id
	attr_reader :joueur
	attr_reader :grille
	attr_reader :mode
	attr_reader :chrono
	attr_reader :nb_undo
	attr_reader :nb_pause

	def initialize(id,joueur,grille,mode,chrono,nb_undo,nb_pause)
		@id			=	id
		@joueur		=	joueur
		@grille		=	grille
		@mode		=	mode
		@chrono		=	chrono
		@nb_undo	=	nb_undo
		@nb_pause	=	nb_pause
	end

	def calculScore
		#TO-DO
		return 10000 - @chrono - @nb_undo * 10 - @nb_pause * 5
	end

	def Score.calculScore(chrono,nb_undo,nb_pause)
		#TO-DO
		return 10000 - chrono - nb_undo * 10 - nb_pause * 5
	end

	def to_s	
		return "Score id = #{@id} , chrono = #{@chrono}"
	end

end