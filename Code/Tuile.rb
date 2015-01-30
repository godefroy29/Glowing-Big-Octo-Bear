#[Classe Tuile]	Permet d'instancier des Tuiles de couleur fixe
class Tuile

	#[<i>int</i> couleur] Couleur actuelle de la tuile 
	#<b>value :</b>
	#* -1 : vide
	#* 0 : bleu
	#* 1 : rouge
	attr_reader :couleur

	#[new] Constructeur de la classe Tuile
	#<b>paramètre : </b>
	#* [<i> couleur </i>] couleur de la case 
	def initialize(couleur)
		@couleur=couleur
	end
end # Marqueur de fin de classe

#[Classe Tuile]	Permet d'instancier des Tuiles de couleur pouvant changer de couleur
class TuileJouable < Tuile

	#[new] Constructeur de la classe Tuile
	#couleur est initalisé à -1
	def initialize()
		@couleur=-1
	end

	#Change la couleur de la tuile en rouge
	def changerEnRouge
		@couleur=1
	end

	#Change la couleur de la tuile en bleu
	def changerEnBleu
		@couleur=0
	end

	#Change la couleur de la tuile en vide
	def changerEnVide
		@couleur=-1
	end

	#Change la couleur en couleur suivante R->B->V->R
	def changerEnSuivant #-1=>1=>0>-1
		@couleur=@couleur%3-1
	end
end
