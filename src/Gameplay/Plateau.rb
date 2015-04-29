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

	def aide
		
		list = Array.new
		0.upto (@n-1) do |y|
			compteurBleu = 0
			compteurRouge = 0	

			0.upto (@n-2) do |x|
				if (@plateauJoueur[x][y].couleur != Tuile.getCouleurVide ) &&@plateauJoueur[x][y].couleur == @plateauJoueur[x+1][y].couleur #Première regle
					if x > 0 && ( @plateauJoueur[x-1][y].couleur != Tuile.oppositeColor(@plateauJoueur[x][y].couleur) )
						list.push(Aide.new(1,nil,x-1,y))
						#p "#Aide X: case x:#{x-1}/y:#{y} "
		 			end
					if x+1 < @n-1 && ( @plateauJoueur[x+2][y].couleur != Tuile.oppositeColor(@plateauJoueur[x][y].couleur))
						list.push(Aide.new(1,nil,x+2,y))
						#p "#Aide  X: case x:#{x+2}/y:#{y} "
					end
				end
				if  x > 0 && x < @n &&(@plateauJoueur[x-1][y].couleur != Tuile.getCouleurVide ) && (@plateauJoueur[x-1][y].couleur == @plateauJoueur[x+1][y].couleur ) #Première regle
					list.push(Aide.new(1,nil,x,y))
					#p "#Aide  X-2: case x:#{x}/y:#{y} "
				end
				if @plateauJoueur[x][y].isBlue 
					compteurBleu += 1
				elsif @plateauJoueur[x][y].isRed
					compteurRouge += 1
				end

				

				
			end
			if @plateauJoueur[@n-1][y].isBlue 
					compteurBleu += 1
			elsif @plateauJoueur[@n-1][y].isRed
					compteurRouge += 1
			end
			#regle 2
				if compteurBleu >= @n/2 || compteurRouge >= @n/2
					list.push(Aide.new(2,"ligne",y,nil))
					#p "Aide Regle 2 : ligne #{y}"
				end
			#regle 3
			if compteurBleu + compteurRouge == @n-2 #2 tuiles vides	
				0.upto(@n-1) do |z|
					if z != y && testLigneContient(getLigne(z),getLigne(y))
						list.push(Aide.new(3,"ligne",y,z))
						#p "#Aide Regle 3 : ligne #{y} et ligne :#{z} "
					end
				end
					
			end
				
		end
		
		0.upto (@n-1) do |x|
			compteurBleu = 0
			compteurRouge = 0	

			0.upto (@n-2) do |y|
			
				if (@plateauJoueur[x][y].couleur != Tuile.getCouleurVide ) && (@plateauJoueur[x][y].couleur == @plateauJoueur[x][y+1].couleur) #Première regle
					if y > 0 && (@plateauJoueur[x][y-1].couleur != Tuile.oppositeColor(@plateauJoueur[x][y].couleur)) 
						list.push(Aide.new(1,nil,x,y-1))
						#p "#Aide Y: case x:#{x}/y:#{y-1} "
					end
					if y+1 < @n-1 && ( @plateauJoueur[x][y+1].couleur != Tuile.oppositeColor(@plateauJoueur[x][y].couleur ))
						list.push(Aide.new(1,nil,x,y+2))
						#p 	"#Aide Y: case x:#{x}/y:#{y+2} "
						
					end
				end
				if  y > 0 && y < @n &&(@plateauJoueur[x][y-1].couleur != Tuile.getCouleurVide ) && (@plateauJoueur[x][y-1].couleur == @plateauJoueur[x][y+1].couleur ) #Première regle
					list.push(Aide.new(1,nil,x,y))
					#p "#Aide  Y-2: case x:#{x}/y:#{y} "
				end
				if @plateauJoueur[x][y].isBlue 
					compteurBleu += 1
				elsif @plateauJoueur[x][y].isRed
					compteurRouge += 1
				end

				
			end
			if @plateauJoueur[x][@n-1].isBlue 
					compteurBleu += 1
			elsif @plateauJoueur[x][@n-1].isRed
					compteurRouge += 1
			end
			#regle 2
				if compteurBleu >= @n/2 || compteurRouge >= @n/2
					list.push(Aide.new(2,"colonne",x,nil))
					#p "Aide Regle 2 : colonne #{x}"
				end
			#regle 3
			if compteurBleu + compteurRouge == @n-2 #2 tuiles vides
				0.upto(@n-1) do |z|
					if z != x && testLigneContient(getColonne(z),getColonne(x))
						list.push(Aide.new(3,"colonne",x,z))
						#p "#Aide Regle 3 : colonne #{x} et colonne :#{z} "
					end
				end
			end
		end
			
		list[Random.new(Time.now.sec).rand(0..(list.size-1))]
	end

	#parametre : Array

	#return true si a contient a2
	def testLigneContient(a,a2)
		0.upto(a.size-1) do |x|
			if  a[x].couleur != a2[x].couleur && a2[x].couleur != Tuile.getCouleurVide 
				return false
			end
		end
		return true

	end

	def getColonne(i)
		return @plateauJoueur[i]
	end

	def getLigne(i)
		ligne = []
		0.upto(@n-1) do |x|
			ligne += [@plateauJoueur[x][i]]
		end
		ligne
	end	

	def getEtatCourant
		s = String.new
		0.upto (@n-1) do |y|
			0.upto (@n-1) do |x|
				if(@plateauJoueur[x][y].couleur == @@CouleurBleu)
					s+= "0"
				elsif(@plateauJoueur[x][y].couleur == @@CouleurRouge)
					s+= "1"
				elsif(@plateauJoueur[x][y].couleur == @@CouleurVide)
					s+= "_"
				end
			end
		end
		return s
	end

	
end

##
#regle : numero de la regle a utiliser
#type : colonne ou ligne ( utilisé uniquement pour la regle 2 et 3)
#x : regle 1 : position x de la tuile , regle 2 et 3 : numero de la premiere colonne ou ligne ( voir type)
#Y : regle 1 : position y de la tuile , regle 2 et 3 : numero de la seconde colonne ou ligne ( voir type)
class Aide
	attr_reader :regle
	attr_reader :type
	attr_reader :x
	attr_reader :y

	def initialize(regle,type,x,y)
		@regle = regle
		@type = type
		@x = x
		@y = y
	end

end