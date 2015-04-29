#[Classe Mouvement]	Permet d'instancier des changements de couleur de tuile afin de pouvoir les défaire.
class Mouvement

	@x
	@y
	@etatPrecedent #Contient une couleur de tuile, spécifiquement la couleur de la case avant son changement
	@flag #Sert à indiquer (si valant true) que le mouvement est le premier de la pile où il se trouve.
	
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
	
	#[new] Constructeur de la classe Mouvement
	#<b>paramètre : </b>
	#* [<i> x </i>] position du changement de couleur
	#* [<i> y </i>] position du changement de couleur
	#* [<i> etat </i>] précédente couleur 
	def Mouvement.enreg(x,y,etat)
		new(x,y,etat)
	end
	
	#Passe la variable flag à True.
	def raiseFlag
		@flag = true
	end
	

end
