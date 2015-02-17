# encoding: UTF-8

class PlateauGtk

	attr_reader :table

	def PlateauGtk.creer(fenetre,plateau,n)
		new(fenetre,plateau,n)
	end

	def initialize(fenetre,plateau,n)
		@table = Gtk::Table.new(n,n,true);

		pix_blue = Gdk::Pixbuf.new(PATH_IMG+"blue.png",50,50)
		pix_red = Gdk::Pixbuf.new(PATH_IMG+"red.png",50,50)
		red = Gtk::Image.new(pix_red)
		blue = Gtk::Image.new(pix_blue)
		0.upto(n-1) do|x| 
			0.upto(n-1) {|y| 
				if plateau.getColorNum(x,y) == - 1 
					btn_tmp = Gtk::Button.new()
					@table.attach(btn_tmp,x,x+1,y,y+1)
					btn_tmp.signal_connect('clicked'){
						plateau.etatSuivant(x,y)
						if plateau.getColorNum(x,y) == 0
							btn_tmp.image = Gtk::Image.new(pix_blue)
						elsif plateau.getColorNum(x,y) == 1
							btn_tmp.image = Gtk::Image.new(pix_red)						
						else
							btn_tmp.image = nil
						end
					}
				else
					if plateau.getColorNum(x,y) == 0
						btn_tmp = Gtk::Button.new()
						btn_tmp.image = Gtk::Image.new(pix_blue)
					else
						btn_tmp = Gtk::Button.new()
						btn_tmp.image = Gtk::Image.new(pix_red)
					end
					@table.attach(btn_tmp,x,x+1,y,y+1)
				end
			}
		end
	end
end