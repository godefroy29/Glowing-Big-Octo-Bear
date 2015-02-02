# encoding: UTF-8

class PlateauGtk

	attr_reader :table
	@plateau

	def PlateauGtk.new(fenetre,n)
		new(fenetre,n)
	end

	def intialize(fenetre,n)
		@table = Gtk::Table.new(n,n,true);
	
		@plateau = Plateau.new("0101");
		0.upto(n-1) do|x| 
			0.upto(n-1) {|y| 
				btn_tmp = Gtk::Button.new("vide")
				@table.attach(btn_tmp,x,x+1,y,y+1)
				btn_tmp.signal_connect('clicked'){
					@plateau.etatSuivant(x+y*n)
				}
			}

		
	end



		
	end




end

