# encoding: UTF-8

class PlateauGtk

	attr_reader :table


	def PlateauGtk.creer(fenetre,plateau,n)
		new(fenetre,plateau,n)
	end

	def initialize(fenetre,plateau,n)
		@table = Gtk::Table.new(n,n,true);

		pix_blue = Gdk::Pixbuf.new("blue.png",200,200)
		pix_red = Gdk::Pixbuf.new("red.png",200,200)
		red = Gtk::Image.new(pix_red)
		blue = Gtk::Image.new(pix_blue)

	
		0.upto(n-1) do|x| 
			0.upto(n-1) {|y| 
				if plateau.getColorNum(x+y*n) == - 1 
					btn_tmp = Gtk::Button.new("vide")
					@table.attach(btn_tmp,x,x+1,y,y+1)
					btn_tmp.signal_connect('clicked'){
						plateau.etatSuivant(x+y*n)
						btn_tmp.label  = plateau.getColorStr(x+y*n)
						if plateau.getColorNum(x+y*n) == 0
							btn_tmp = blue
						else
							btn_tmp = blue
						end
					}
				else
					if plateau.getColorNum(x+y*n) == 0
						btn_tmp = Gtk::Button.new("bleu")
						btn_tmp = blue
					else
						btn_tmp = Gtk::Button.new("rouge")
						btn_tmp = red
					end
					@table.attach(btn_tmp,x,x+1,y,y+1)
				end
			}
		
		end
	


		
	end




end

