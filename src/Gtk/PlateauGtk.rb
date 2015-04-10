# encoding: UTF-8

class PlateauGtk

	attr_reader :table
	@btnArray
	@hypotheseArray
	@bleu
	@rouge
	@n
	
	def PlateauGtk.creer(fenetre,plateau,n)
		new(fenetre,plateau,n)
	end

	def initialize(fenetre,plateau,n)
		@table = Gtk::Table.new(n,n,true);
		@table.set_row_spacings(1);
		@table.set_column_spacings(1);
		@btnArray = Array.new(n){ |i| Array.new(n)}
		@bleu = "blue.png"
		@rouge = "red.png"
		@n=n
		pix_blue = Gdk::Pixbuf.new(PATH_IMG+@bleu,50,50)
		pix_red = Gdk::Pixbuf.new(PATH_IMG+@rouge,50,50)
		red = Gtk::Image.new(pix_red)
		blue = Gtk::Image.new(pix_blue)
		0.upto(n-1) do|x| 
			0.upto(n-1) {|y| 
				if plateau.getColorNum(x,y) == - 1 
					btn_tmp = Gtk::Button.new()
					btn_tmp.set_width_request(50);
					btn_tmp.set_height_request(50);
					@table.attach(btn_tmp,x,x+1,y,y+1)
					btn_tmp.signal_connect('clicked'){
						plateau.etatSuivant(x,y)
						if plateau.getColorNum(x,y) == 0
							btn_tmp.style = $optionGraphique.couleur1
						elsif plateau.getColorNum(x,y) == 1
							btn_tmp.style = $optionGraphique.couleur2
						else
							btn_tmp.style = nil
						end
					}
					@btnArray[x][y] = btn_tmp
				else
					if plateau.getColorNum(x,y) == 0
						btn_tmp = Gtk::Button.new()
						btn_tmp.style = $optionGraphique.couleur1
					else
						btn_tmp = Gtk::Button.new()
						btn_tmp.style = $optionGraphique.couleur2
					end
					@table.attach(btn_tmp,x,x+1,y,y+1)
				end
			}
		end
	end
	
	def changerImgBouton(x,y,couleur)
		if couleur == 1
			@btnArray[x][y].style = $optionGraphique.couleur2
		elsif couleur == 0
			@btnArray[x][y].style = $optionGraphique.couleur1
		else
			@btnArray[x][y].style = nil
		end
	end
	
	def debuterHypothese
		@hypotheseArray = Array.new(@n){ |i| Array.new(@n)}
		0.upto(@n-1) do|x| 
			0.upto(@n-1) {|y| 
				if @btnArray[x][y] != nil 
					@hypotheseArray[x][y] = @btnArray[x][y].image 
				else
					@hypotheseArray[x][y]='non'
				end
			}
		end
	end
	
	def annulerHypothese
		0.upto(@n-1) do|x| 
			0.upto(@n-1) {|y|
				if @hypotheseArray[x][y] != 'non'
					@btnArray[x][y].image = @hypotheseArray[x][y]
				end
			}
		end
	end
	
	def debutPause
	
	
	end
end
