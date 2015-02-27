include Math

class Plateau
	# new(string s_tab)

	attr_accessor :plateauJoueur #grille de Plateau
	attr_reader :plateauSolution #memorise la solution

	@@CouleurVide=-1
	@@CouleurBleu=0
	@@CouleurRouge=1

	@n
	@memstack

	def initialize(s_tab, grilleSolution)#s_tab et solution sont des chaines de caracteres
	@memstack = Array.new
		@n = Math.sqrt(s_tab.length).to_i
		@plateauJoueur=Array.new(@n) { |i| Array.new(@n)}
		@plateauSolution=Array.new(@n) { |i| Array.new(@n)}
		0.upto (@n-1) do |x|
			0.upto (@n-1) do |y|
				if s_tab[x+y*@n]=='_' #remplace un "_" par une TuileJouable
					@plateauJoueur[x][y]=TuileJouable.new
				elsif s_tab[x+y*@n]=="0"
					@plateauJoueur[x][y]=Tuile.new(0)
				elsif s_tab[x+y*@n]=="1"
					@plateauJoueur[x][y]=Tuile.new(1)
				end
			end
		end
		0.upto (@n-1) do |x|	
			0.upto (@n-1) do |y|
				if grilleSolution[x+y*@n]=="0"
					@plateauSolution[x][y]=Tuile.new(0)
				elsif grilleSolution[x+y*@n]=="1"
					@plateauSolution[x][y]=Tuile.new(1)
				end
			end
		end
	end
###############################################
# Etat #
###############################################
	def etatSuivant(x,y)
		@memstack.push(Mouvement.enreg(x,y,@plateauJoueur[x][y].couleur))
		@plateauJoueur[x][y].changerEnSuivant
		#valeurs possibles -1,0,1
	end

	def etatBleu(x,y)
		@memstack.push(Mouvement.enreg(x,y,@plateauJoueur[x][y].couleur))
		@plateauJoueur[x][y].changerEnBleu
	end

	def etatRouge(x,y)
		@memstack.push(Mouvement.enreg(x,y,@plateauJoueur[x][y].couleur))
		@plateauJoueur[x][y].changerEnRouge
	end

	def etatVide(x,y)
		@memstack.push(Mouvement.enreg(x,y,@plateauJoueur[x][y].couleur))
		@plateauJoueur[x][y].changerEnVide
	end
	
	def undo
		u=@memstack.pop
		@plateauJoueur[u.x][u.y].changerVers(u.etatPrecedent)		
	end

###############################################
# Test sur grille #
###############################################
	def testGrille
		0.upto (@n-1) do |y|	
			0.upto (@n-1) do |x|
				if(@plateauJoueur[x][y].couleur != plateauSolution[x][y].couleur)
					return false
				end
			end
		end
		return true
	end

	def getColorStr(x,y)
		if @plateauJoueur[x][y].couleur == 1
			return "rouge"
		end
		if @plateauJoueur[x][y].couleur == 0
			return "bleu"
		end
		return "vide"
	end

	def getColorNum(x,y)
		@plateauJoueur[x][y].couleur
	end

	def affichagePlateauJoueur
		0.upto (@n) do |y|	
			0.upto (@n) do |x|
				print "#{@plateauJoueur[x][y]} => #{getColorStr(x,y)}"
			end
		end
	end
end
