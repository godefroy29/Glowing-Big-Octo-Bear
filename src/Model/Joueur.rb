class Joueur

	@id
	@pseudo
	@password
	@avatar

	def initialize(id,pseudo,password,avatar)
		@id			=	id
		@pseudo		=	pseudo
		@password	=	password
		@avatar		=	avatar
	end

	def to_s
		return "Joueur id = #{@id}"
	end

end