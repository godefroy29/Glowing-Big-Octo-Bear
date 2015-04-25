class Joueur

	attr_reader :id
	attr_reader :pseudo
	attr_reader :password
	attr_reader :avatar

	##
	# Constructeur
	# Paramètres::
	# - id : id du joueur
	# - pseudo : pseudo du joueur
	# - password : password du joueur
	# - avatar : avatar du joueur
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