#Classe qui permet de stocker les informations des joueurs en entrée et sortie de la base de donnée
class Joueur

	attr_reader :id		#id du joueur
	attr_reader :pseudo	#pseudo du joueur
	attr_reader :password	#mot de passe du joueur
	attr_reader :avatar	#avatar du joueur

	def initialize(id,pseudo,password,avatar)
		@id		=	id
		@pseudo		=	pseudo
		@password	=	password
		@avatar		=	avatar
	end

	##
	#Méthode d'affichage de la classe
	def to_s
		return "Joueur id = #{@id}"
	end

end
