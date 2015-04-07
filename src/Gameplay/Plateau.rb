include Math

class Plateau
	# new(string s_tab)

	attr_accessor :plateauJoueur #grille de Plateau
	attr_reader :plateauSolution #memorise la solution

	@@CouleurVide=-1
	@@CouleurBleu=0
	@@CouleurRouge=1

	@n
	@memStack
	@undoStack
	@hypothese
	
	@boutonUndo
	@boutonRedo

	def initialize(s_tab, grilleSolution,undoB,redoB)#s_tab et solution sont des chaines de caracteres
		@memStack = Array.new
		@undoStack = Array.new
		@boutonUndo = undoB
		@boutonRedo = redoB
		@n = Math.sqrt(s_tab.length).to_i
		@plateauJoueur=Array.new(@n) { |i| Array.new(@n)}
		@hypothese=Array.new(@n) { |i| Array.new(@n)}
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
		@memStack.push(Mouvement.enreg(x,y,@plateauJoueur[x][y].couleur))
		@boutonUndo.set_sensitive(true)
		@boutonRedo.set_sensitive(false)
		@plateauJoueur[x][y].changerEnSuivant
		@undoStack.clear
		#valeurs possibles -1,0,1
	end

	def etatBleu(x,y)
		@memStack.push(Mouvement.enreg(x,y,@plateauJoueur[x][y].couleur))
		@boutonUndo.set_sensitive(true)
		@boutonRedo.set_sensitive(false)
		@plateauJoueur[x][y].changerEnBleu
		@undoStack.clear
	end

	def etatRouge(x,y)
		@memStack.push(Mouvement.enreg(x,y,@plateauJoueur[x][y].couleur))
		@boutonUndo.set_sensitive(true)
		@boutonRedo.set_sensitive(false)
		@plateauJoueur[x][y].changerEnRouge
		@undoStack.clear
	end

	def etatVide(x,y)
		@memStack.push(Mouvement.enreg(x,y,@plateauJoueur[x][y].couleur))
		@boutonUndo.set_sensitive(true)
		@boutonRedo.set_sensitive(false)
		@plateauJoueur[x][y].changerEnVide
		@undoStack.clear
	end
	
	def undo

			u=@memStack.pop
			@undoStack.push(Mouvement.enreg(u.x,u.y,@plateauJoueur[u.x][u.y].couleur))
			@plateauJoueur[u.x][u.y].changerVers(u.etatPrecedent)
			if @memStack.empty?
				u.raiseFlag
			end
			return u
	end
	
	def unundo
		u=@undoStack.pop
		@memStack.push(Mouvement.enreg(u.x,u.y,@plateauJoueur[u.x][u.y].couleur))
		@plateauJoueur[u.x][u.y].changerVers(u.etatPrecedent)
		if @undoStack.empty?
			u.raiseFlag
		end
		return u
		
	end
	
	
	def debuterHypothese
		0.upto(@n-1) do|x| 
			0.upto(@n-1) {|y| 
				@hypothese[x][y] = @plateauJoueur[x][y].couleur
			}
		end
	end
	
	
	def annulerHypothese
		0.upto(@n-1) do|x| 
			0.upto(@n-1) {|y| 
				@plateauJoueur[x][y].changerVers(@hypothese[x][y])
			}
		end
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

	def testCurrentGrille
		nb_error = 0
			0.upto (@n-1) do |y|
				0.upto (@n-1) do |x|
					if(@plateauJoueur[x][y].couleur != @@CouleurVide) && (@plateauJoueur[x][y].couleur != plateauSolution[x][y].couleur)
				 	nb_error += 1
					end
				end
			end
		return nb_error
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

	def plateauJoueurToS
		str = ""
		0.upto (@n-1) do |y|	
			0.upto (@n-1) do |x|
				str + getColorNum(x,y).to_s
			end
		end
		return str
	end
end
