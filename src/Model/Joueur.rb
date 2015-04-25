class Joueur

	attr_reader :id
	attr_reader :pseudo
	attr_reader :password
	attr_reader :avatar

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