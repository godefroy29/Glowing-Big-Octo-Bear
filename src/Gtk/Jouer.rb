# encoding: UTF-8

class Jouer

	@plateauGtk

	def Jouer.afficher(fenetre, langue)
		boutonRetour = Gtk::Button.new(langue.retour)
		vbox = Gtk::VBox.new(false,10)

		n = 2
		table = Gtk::Table.new(n,n,true);
	
		plateau = Plateau.new("____");
		0.upto(n-1) do|x| 
			0.upto(n-1) {|y| 
				btn_tmp = Gtk::Button.new("vide")
				table.attach(btn_tmp,x,x+1,y,y+1)
				btn_tmp.signal_connect('clicked'){
					plateau.etatSuivant(x+y*n)
					btn_tmp.label = plateau.getColorStr(x+y*n);
				}
			}

		
		

		end




		vbox.add(table)





		#@plateauGtk = PlateauGtk.new(vbox,4)
		
		boutonRetour.signal_connect('clicked'){
			fenetre.remove(vbox)
			Menu.afficher(fenetre, langue)
		}

		vbox.add(boutonRetour)
		
		fenetre.add(vbox)
		fenetre.show_all
	end

	


end
