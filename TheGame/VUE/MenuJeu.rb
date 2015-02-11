#COMOK
#!/usr/bin/env ruby

## 
# Fichier        : MenuJeu.rb 
# Auteur         : L3SPI - Groupe de projet B 
# Fait partie de : TheGame 
# 
#===Cette classe permet de crï¿½er le menu du jeu et contient :
#* Une fenêtre reprï¿½sentant la fenetre du menu 
#* Un boolï¿½en indiquant si le joueur est en cours de jeu ou non, ce qui modifiera les boutons du menu en consï¿½quence
#* Un contenu reprï¿½sentï¿½ par une box et qui contient les ï¿½lï¿½ments de chaque "sous-menu" (nouvelle partie, classement, ...)
#* Le controleur pour pouvoir y accéder
#* Le modèle pour pouvoir y accéder
# 

require 'gtk2'
require 'sdl'

require 'VUE/Classements.rb'
require 'XMLReader/XmlClassements.rb'
require 'XMLReader/XmlMultilingueReader.rb'

require 'VUE/BibliothequeSlot.rb'
require 'VUE/YamlSlot.rb'
require 'VUE/Slot.rb'

# On inclu le module Gtk, cela ï¿½vite de prï¿½fixer les classes par Gtk::
include Gtk

class MenuJeu
	
	@fenetreMenu
	@isInGame
	@contenu
	@controleur
	@modele
	
	attr_accessor :fenetreMenu
	
	attr_reader :contenu, :isInGame
	
	private_class_method :new
	
	
	##
   # Crée un nouveau Menu
   #
   #=== Paramètres
   #* <b>isEnJeu</b> : un boolï¿½en indiquant si le joueur est en jeu ou non
   #* <b>modele</b> : le modele
   #* <b>controleur</b> : le controleur
   #
	def initialize(isEnJeu, modele, controleur)
		
		@isInGame 		= isEnJeu
		@controleur 	= controleur
		@modele 			= modele
		
		#Configuration de l'aspect graphique de l'interface par un Gtkrc
		Gtk::RC.parse("gtkrc.rc")
		
	end
	
	
	##
   # Crée un nouveau Menu
   #
   #=== Paramètres
   #* <b>isEnJeu</b> : un boolï¿½en indiquant si le joueur est en jeu ou non
   #* <b>modele</b> : le modele
   #* <b>controleur</b> : le controleur
   #
   #===Retourne :
   #* <b>nouveauMenu</b> : le nouveau menu crée
   #
	def MenuJeu.creer(isEnJeu, modele, controleur)
		return new(isEnJeu, modele, controleur)
	end
	
	
	##
   # Initialise la fenï¿½tre du menu avec les boutons nï¿½cessaires
   #
	def afficherMenu()
	  	fenMenuPrincipal = Window.new()
	  	fenMenuPrincipal.name = "fenMenuPrincipal" # Rï¿½fï¿½rence pour le fichier gtkrc.rc
		fenMenuPrincipal.set_title(XmlMultilingueReader.lireTexte("nomMenu"))
		
		fenMenuPrincipal.set_width_request(669)
		fenMenuPrincipal.set_height_request(534)
		fenMenuPrincipal.set_resizable(false)
	
		@contenu = VBox.new(false, 0)
		
		# Crï¿½ation des boutons (eventBox)
		if(@isInGame == false)
						
			ebNewPartie = EventBox.new.add(Label.new(XmlMultilingueReader.lireTexte("NewPartie")))
			ebNewPartie.events = Gdk::Event::BUTTON_PRESS_MASK
			
			ebChargerPartie = EventBox.new.add(Label.new(XmlMultilingueReader.lireTexte("ChargerPartie")))
			ebChargerPartie.events = Gdk::Event::BUTTON_PRESS_MASK
			
			ebClassement = EventBox.new.add(Label.new(XmlMultilingueReader.lireTexte("Classement")))
			ebClassement.events = Gdk::Event::BUTTON_PRESS_MASK
			
			ebOptions = EventBox.new.add(Label.new(XmlMultilingueReader.lireTexte("Options")))
			ebOptions.events = Gdk::Event::BUTTON_PRESS_MASK
			
			ebAide = EventBox.new.add(Label.new(XmlMultilingueReader.lireTexte("Aide")))
			ebAide.events = Gdk::Event::BUTTON_PRESS_MASK
			
			ebQuitter = EventBox.new.add(Label.new(XmlMultilingueReader.lireTexte("Quitter")))
			ebQuitter.events = Gdk::Event::BUTTON_PRESS_MASK
			
			@contenu.add(ebNewPartie)
			@contenu.add(ebChargerPartie)
			@contenu.add(ebClassement)
			@contenu.add(ebOptions)
			@contenu.add(ebAide)
			@contenu.add(ebQuitter)
			
			# Alignement du menu suivant la langue
			if(XmlMultilingueReader.getLangue() == "FR")
				@contenu.set_spacing(6)
				align = Alignment.new(0.85, 0.9, 0, 0)
			else
				@contenu.set_spacing(6)
				align = Alignment.new(0.8, 0.9, 0, 0)
			end
			
		else
			ebContinuerPartie = EventBox.new.add(Label.new(XmlMultilingueReader.lireTexte("ContinuerPartie")))
			ebContinuerPartie.events = Gdk::Event::BUTTON_PRESS_MASK
			
			ebNewPartie = EventBox.new.add(Label.new(XmlMultilingueReader.lireTexte("NewPartie")))
			ebNewPartie.events = Gdk::Event::BUTTON_PRESS_MASK
			
			ebChargerPartie = EventBox.new.add(Label.new(XmlMultilingueReader.lireTexte("ChargerPartie")))
			ebChargerPartie.events = Gdk::Event::BUTTON_PRESS_MASK
			
			ebSauvegarderPartie = EventBox.new.add(Label.new(XmlMultilingueReader.lireTexte("SauvegarderPartie")))
			ebSauvegarderPartie.events = Gdk::Event::BUTTON_PRESS_MASK
			
			ebClassement = EventBox.new.add(Label.new(XmlMultilingueReader.lireTexte("Classement")))
			ebClassement.events = Gdk::Event::BUTTON_PRESS_MASK
			
			ebOptions = EventBox.new.add(Label.new(XmlMultilingueReader.lireTexte("Options")))
			ebOptions.events = Gdk::Event::BUTTON_PRESS_MASK
			
			ebAide = EventBox.new.add(Label.new(XmlMultilingueReader.lireTexte("Aide")))
			ebAide.events = Gdk::Event::BUTTON_PRESS_MASK
			
			ebQuitter = EventBox.new.add(Label.new(XmlMultilingueReader.lireTexte("Quitter")))
			ebQuitter.events = Gdk::Event::BUTTON_PRESS_MASK
			
			@contenu.add(ebContinuerPartie)
			@contenu.add(ebNewPartie)
			@contenu.add(ebChargerPartie)
			@contenu.add(ebSauvegarderPartie)
			@contenu.add(ebClassement)
			@contenu.add(ebOptions)
			@contenu.add(ebAide)
			@contenu.add(ebQuitter)
			
			# Alignement du menu suivant la langue
			if(XmlMultilingueReader.getLangue() == "FR")
				align = Alignment.new(0.85, 0.9, 0, 0)
			else
				align = Alignment.new(0.8, 0.9, 0, 0)
			end
		end
		
		align.add(@contenu)
		fenMenuPrincipal.add(align)
   	fenMenuPrincipal.set_window_position Gtk::Window::POS_CENTER
		fenMenuPrincipal.show_all
		
		# Association des actions aux eventBox
		if(@isInGame == true)
			ebContinuerPartie.realize # Crï¿½er la fenetre GDK (Gdk::Window) associï¿½es au widget
			ebContinuerPartie.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND1) # Change le curseur en forme de main
			@controleur.continuerPartieCreer(ebContinuerPartie,fenMenuPrincipal)
			
			ebSauvegarderPartie.realize # Crï¿½er la fenetre GDK (Gdk::Window) associï¿½es au widget
			ebSauvegarderPartie.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND1) # Change le curseur en forme de main
			@controleur.sauvegarderPartieCreer(ebSauvegarderPartie,fenMenuPrincipal)
		end
		
		ebNewPartie.realize # Crï¿½er la fenetre GDK (Gdk::Window) associï¿½es au widget
		ebNewPartie.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND1) # Change le curseur en forme de main
		@controleur.nouvellePartieCreer(ebNewPartie,fenMenuPrincipal)
		
		ebChargerPartie.realize # Crï¿½er la fenetre GDK (Gdk::Window) associï¿½es au widget
		ebChargerPartie.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND1) # Change le curseur en forme de main
		@controleur.chargerPartieCreer(ebChargerPartie,fenMenuPrincipal)
		
		ebClassement.realize # Crï¿½er la fenetre GDK (Gdk::Window) associï¿½es au widget
		ebClassement.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND1) # Change le curseur en forme de main
		@controleur.classementCreer(ebClassement,fenMenuPrincipal)
		
		ebOptions.realize # Crï¿½er la fenetre GDK (Gdk::Window) associï¿½es au widget
		ebOptions.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND1) # Change le curseur en forme de main
		@controleur.optionsCreer(ebOptions,fenMenuPrincipal)
		
		ebAide.realize # Crï¿½er la fenetre GDK (Gdk::Window) associï¿½es au widget
		ebAide.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND1) # Change le curseur en forme de main
		@controleur.aideCreer(ebAide,fenMenuPrincipal)
		
		ebQuitter.realize # Crï¿½er la fenetre GDK (Gdk::Window) associï¿½es au widget
		ebQuitter.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND1) # Change le curseur en forme de main
		@controleur.quitterPartieCreer(ebQuitter,fenMenuPrincipal)
		
		@controleur.destroyMenuCreer(fenMenuPrincipal)
		
	end
	
	
	##
   # Lorsque le joueur clique sur nouvelle partie, affiche un champ pour le nom du joueur, 
   # des boutons radio pour le choix de difficultï¿½ et un bouton lancer partie
   #
	def afficherNouvellePartie()		
		@fenetreMenu = Window.new
		@fenetreMenu.set_title(XmlMultilingueReader.lireTexte("NewPartie"))
		@fenetreMenu.resize(100,100)
		
		@contenu = VBox.new(true, 10)
		
		maHBoxNom 	= HBox.new(true, 10) # 10 => espace entre 2 "objets"
		labelNom 	= Label.new(XmlMultilingueReader.lireTexte("votreNom"))
		champNom 	= Entry.new()
		
		maHBoxNom.add(labelNom)
		maHBoxNom.add(champNom)
		
		maHboxDifficulte 	= HBox.new(true, 10)
		labelDiff 			= Label.new(XmlMultilingueReader.lireTexte("difficulte"))
		novice 				= RadioButton.new(XmlMultilingueReader.lireTexte("novice"))
		moyen 				= RadioButton.new(novice, XmlMultilingueReader.lireTexte("moyen"))
		expert 				= RadioButton.new(novice, XmlMultilingueReader.lireTexte("expert"))
		
		maHboxDifficulte.add(labelDiff)
		maHboxDifficulte.add(novice)
		maHboxDifficulte.add(moyen)
		maHboxDifficulte.add(expert)
		
		maHBoxBouton 				= HBox.new(true, 10)
		boutCommencerNewPartie 	= Button.new(XmlMultilingueReader.lireTexte("cestPartie"))
		boutRetour 					= Button.new(XmlMultilingueReader.lireTexte("retourMenu"))
		
		maHBoxBouton.add(boutCommencerNewPartie)
		maHBoxBouton.add(boutRetour)
		
		@contenu.add(maHBoxNom)	
		@contenu.add(maHboxDifficulte)		
		@contenu.add(maHBoxBouton)
		@contenu.set_border_width(20)		
		
    	@fenetreMenu.set_window_position Gtk::Window::POS_CENTER
		@fenetreMenu.add(@contenu)
		@fenetreMenu.show_all

		@controleur.commencerNewPartieCreer(boutCommencerNewPartie, champNom, novice, moyen, expert, @fenetreMenu)
		@controleur.retourCreer(boutRetour,@fenetreMenu)
		@controleur.destroyMenuCreer(@fenetreMenu)
		
	end
	

	##
   # Lorsque le joueur clique sur charger partie, affiche les slots de chargement d'une partie
   #
	def afficherChargerPartie()
    	@fenetreMenu  = Window.new()
		@fenetreMenu.set_title(XmlMultilingueReader.lireTexte("ChargerPartie"))
		
		@contenu = VBox.new(false, 20)
		# Tableau contenant des EventBox pouvant ï¿½tre cliquï¿½es pour charger une partie
		tabEventBox = Array.new
		
		# Tableau contenant les slots de sauvegarde
		tabSlot = Array.new
		
		# Remplissage des frames contenant les diffï¿½rentes EventBox
		# Ces EventBox contiennent elles-mï¿½mes des infos (contenus dans le fichier yaml) sur le slot de sauvegarde en question
		0.upto(4) do |i|
			frame = Frame.new(XmlMultilingueReader.lireTexte("emplacement") + " " + (i+1).to_s)
			nomFicYaml = "slot" + (i+1).to_s + ".yaml"
			
			if(File.exist?("YAMLSlot/" + nomFicYaml)) # Si le fichier yaml correspondant au slot existe
				YamlSlot.lireYaml(nomFicYaml)
				slot = BibliothequeSlot.getSlot(nomFicYaml)
				nom = slot.pseudo
				diff = slot.intituleDifficulte
				date = slot.date
			else # Pour l'affichage des slots vides
				nom = "..."
				diff = "..."
				date = "..."
			end
			
			lab = Label.new(XmlMultilingueReader.lireTexte("nom") + " : " + nom + 
							" | " + XmlMultilingueReader.lireTexte("difficulte") + " : " + XmlMultilingueReader.lireTexte(diff.downcase) + 
							" | " + XmlMultilingueReader.lireTexte("date") + " : " + date)
			lab.set_height_request(50)
			frame.add(lab)
			
			eventbox = EventBox.new.add(frame)
			eventbox.events = Gdk::Event::BUTTON_PRESS_MASK
			
			tabSlot[i] = slot
			tabEventBox[i] = eventbox
			
			@contenu.add(eventbox)
		end
		
		boutRetour = Button.new(XmlMultilingueReader.lireTexte("retourMenu"))
		
		@contenu.add(boutRetour)
		@contenu.set_border_width(20)
		
		@fenetreMenu.add(@contenu)
		
		# C'est une fois que les eventBox sont crï¿½es et ajoutï¿½es ï¿½ la fenetre qu'elles sont associï¿½es ï¿½ une Gdk::Window (et non Gtk::Window)
		# On peut donc appeler eventbox.window pour pouvoir modifier la zone correspondante ï¿½ cette eventBox
		tabEventBox.each_with_index{|eb, index|
			eb.realize # Crï¿½er la fenetre GDK (Gdk::Window) associï¿½es au widget
			if(tabSlot[index] != nil)	# Si le slot "existe"
				eb.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND1) # Change le curseur en forme de main
				eb.signal_connect('button_press_event') { 
					
					modeleCharger = tabSlot[index].modele
					Modele.majCpt(modeleCharger.compteurTour)
					
					# On reprend le temps de la save pour l'ajouter au temps de la session de jeu en cours
					modeleCharger.joueur.tempsTotal = tabSlot[index].temps
					modeleCharger.joueur.dateDebutJeu = Time.now
					
					@fenetreMenu.destroy
					
					if(@isInGame == true)
						#Destruction ancienne vue partie
						@modele.vue.window.destroy
					end
					
					# Pour detruire l'ancienne vue apres avoir charger une partie apres une mort
					if(@modele.joueur != nil)
						if(@modele.joueur.toujoursEnVie? == false)
							@modele.vue.window.destroy
						end
					end
					
					# Creation de la vue chargï¿½e
					vue = modeleCharger.vue
					
					controller = modeleCharger.vue.controller
				
					vue.defM(modeleCharger)
					vue.defC(controller)
					vue.initInterface()
					
					#vue.majEcouteClavier()
					#vue.zoneCtrl.majBoutons(modeleCharger)
					
				}
			end
		}
		
   	@fenetreMenu.set_window_position Gtk::Window::POS_CENTER
		@fenetreMenu.show_all

		@controleur.retourCreer(boutRetour,@fenetreMenu)
		@controleur.destroyMenuCreer(@fenetreMenu)
	end
	
	
	##
   # Lorsque le joueur clique sur sauvegarder partie, affiche les slots de sauvegarde d'une partie
   #
	def afficherSauvegarderPartie()		
    	@fenetreMenu  = Window.new()
		@fenetreMenu.set_title(XmlMultilingueReader.lireTexte("SauvegarderPartie"))
		
		@contenu = VBox.new(false, 20)
		# Tableau contenant des EventBox pouvant ï¿½tre cliquï¿½es pour sauvegarder une partie
		tabEventBox = Array.new
		
		# Tableau contenant les slots de sauvegarde
		tabSlot = Array.new
		
		# Remplissage des frames contenant les diffï¿½rentes EventBox
		# Ces EventBox contiennent elles-mï¿½mes des infos (contenus dans le fichier yaml) sur le slot de sauvegarde en question
		0.upto(4) do |i|
			frame = Frame.new(XmlMultilingueReader.lireTexte("emplacement") + " " + (i+1).to_s)
			nomFicYaml = "slot" + (i+1).to_s + ".yaml"
			
			if(File.exist?("YAMLSlot/" + nomFicYaml)) # Si le fichier yaml correspondant au slot existe
				YamlSlot.lireYaml(nomFicYaml)
				slot = BibliothequeSlot.getSlot(nomFicYaml)
				nom = slot.pseudo
				diff = slot.intituleDifficulte
				date = slot.date
			else # Pour l'affichage des slots vides
				nom = "..."
				diff = "..."
				date = "..."
			end
			
			lab = Label.new(XmlMultilingueReader.lireTexte("nom") + " : " + nom + 
							" | " + XmlMultilingueReader.lireTexte("difficulte") + " : " + XmlMultilingueReader.lireTexte(diff.downcase) + 
							" | " + XmlMultilingueReader.lireTexte("date") + " : " + date)
			lab.set_height_request(50)
			frame.add(lab)
			
			eventbox = EventBox.new.add(frame)
			eventbox.events = Gdk::Event::BUTTON_PRESS_MASK
			
			tabSlot[i] = slot
			tabEventBox[i] = eventbox
			
			@contenu.add(eventbox)
		end
		
		@fenetreMenu.add(@contenu)
				
		# C'est une fois que les eventBox sont crï¿½es et ajoutï¿½es ï¿½ la fenetre qu'elles sont associï¿½es ï¿½ une Gdk::Window (et non Gtk::Window)
		# On peut donc appeler eventbox.window pour pouvoir modifier la zone correspondante ï¿½ cette eventBox
		tabEventBox.each_with_index{|eb, index|
			eb.realize # Crï¿½er la fenetre GDK (Gdk::Window) associï¿½es au widget
			eb.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND2) # Change le curseur en forme de main
			
			eb.signal_connect('button_press_event') { 
				YamlSlot.ecrireYaml("slot" + (index+1).to_s + ".yaml", @modele)
				
				@fenetreMenu.destroy
				
				# MAJ de l'affichage des slots de sauvegarde
				afficherSauvegarderPartie()
			}
		}
		
		boutRetour = Button.new(XmlMultilingueReader.lireTexte("retourMenu"))
		
		@contenu.add(boutRetour)
		
		@contenu.set_border_width(20)
		@fenetreMenu.set_window_position Gtk::Window::POS_CENTER
		
		@fenetreMenu.show_all

		@controleur.retourCreer(boutRetour,@fenetreMenu)
		@controleur.destroyMenuCreer(@fenetreMenu)
	end
	
	
	##
   # Lorsque le joueur clique sur classement, affiche le classement des meilleurs joueurs
   # en rï¿½cupï¿½rant les donnï¿½es du fichier XML
   #
	def afficherClassement()	
    	@fenetreMenu  = Window.new()
		@fenetreMenu.set_title(XmlMultilingueReader.lireTexte("Classement"))
		@fenetreMenu.resize(300,390)
		
		@contenu = VBox.new(false, 10)
		
		labelInfo = Label.new(XmlMultilingueReader.lireTexte("infoClassement"))
		labelInfo.justify=Gtk::JUSTIFY_CENTER
  		labelInfo.wrap=true
		
		nb = Notebook.new()
		
		tabLabel 	= Array.new
		tabLabel[0] = Label.new("Novice")
		tabLabel[1] = Label.new("Moyen")
		tabLabel[2] = Label.new("Expert")
		
		# Rempli toutes les listes de joueurs de toutes les difficultes : retourne un classement
		c = remplirListeJoueur()		

		0.upto(2) do |i|
			# Crï¿½ation des treeView
			treeview = TreeView.new
			
			# Ajout des paramï¿½tres de rendu aux treeViews
			setup_tree_view(treeview)
			
			# Crï¿½ation et remplissage des ListStore
			store = remplirListStore(c.getListeJoueur(tabLabel[i].text))
			
			# Ajoute chacun des tree model au tree view correspondant
			treeview.model = store
			
			# Crï¿½ation et ajout des treeviews dans des scrolledWindows
			scrolled_win = ScrolledWindow.new.add(treeview)
			
			# Affichage ou non des scrollBars
			scrolled_win.set_policy(Gtk::POLICY_NEVER, Gtk::POLICY_AUTOMATIC)
			
			# Pour traduire les textes des onglets
			texteOnglet = XmlMultilingueReader.lireTexte(tabLabel[i].text.downcase)
			tabLabel[i].text = texteOnglet
			
			# Ajoute dans chaque page des onglets du notebook une ScrolledWindow
			nb.append_page(scrolled_win, tabLabel[i])
		end
		
		boutRetour = Button.new(XmlMultilingueReader.lireTexte("retourMenu"))
		
		@contenu.pack_start(labelInfo, false, false)
		@contenu.add(nb)
		@contenu.pack_start(boutRetour, false, false)
		
		@contenu.set_border_width(20)
    	@fenetreMenu.set_window_position Gtk::Window::POS_CENTER
		@fenetreMenu.add(@contenu)
		@fenetreMenu.show_all

		@controleur.retourCreer(boutRetour,@fenetreMenu)
		@controleur.destroyMenuCreer(@fenetreMenu)
	end
	
	
	##
	# Rempli une ListStore par l'intermï¿½diaire de la liste de joueur passï¿½e en paramï¿½tre.
	#=== Paramètres
   #* <b>listeJoueur :</b> un tableau de joueur
	#
	def remplirListStore(listeJoueur)
		# Crï¿½er un nouveau tree model comprenant 6 colonnes
		store = ListStore.new(String, Integer, Integer, Integer, String, Integer)
		
		# Ajoute toutes les statistiques des joueurs contenues dans "listeJoueur" ï¿½ la ListStore
		listeJoueur.each_with_index do |e, i|
			colonne = store.append
			
			colonne[0] = listeJoueur[i][0]	# Correspond au nom du joueur
			colonne[1] = listeJoueur[i][1]	# Correspond au nombre d'ennemis tuï¿½s pas le joueur
			colonne[2] = listeJoueur[i][2]	# Correspond ï¿½ la distance totale parcourue par le joueur
			colonne[3] = listeJoueur[i][3]	# Correspond ï¿½ l'or total accumulï¿½ par le joueur
			dureeTotale = listeJoueur[i][4]	# Correspond au temps de jeu total du joueur en secondes
			colonne[4] = @modele.convertirTemps(dureeTotale) # Renvoi une chaine sous la forme "h min sec"
			colonne[5] = listeJoueur[i][5]	# Correspond au score du joueur
		end
		
		store.set_sort_column_id(5, SORT_DESCENDING)
		
		return store
	end
	
	
	##
	# Ajoute 6 colonnes au treeview
	#=== Paramètres
   #* <b>treeview :</b> le treeview ï¿½ configurer
	#
	def setup_tree_view(treeview)
	  # Create a new GtkCellRendererText, add it to the tree
	  # view column and append the column to the tree view.
	  renderer = CellRendererText.new
	
	  # Les propriï¿½tï¿½s affectent la colonne entiï¿½re
	  # On utilise Pango pour obtenir le gras
     renderer.weight = Pango::FontDescription::WEIGHT_BOLD
    
	  column   = TreeViewColumn.new(XmlMultilingueReader.lireTexte("pseudo"), renderer,  :text => 0)
	  # ======= Pour pouvoir trier la colonne
	  column.sort_indicator=true
	  column.sort_column_id = 0
	  # ======= Fin du tri
	  treeview.append_column(column)
	  
	  renderer = CellRendererText.new
	  column   = TreeViewColumn.new(XmlMultilingueReader.lireTexte("ennemisTues"), renderer, :text => 1)
	  # ======= Pour pouvoir trier la colonne
	  column.sort_indicator=true
	  column.sort_column_id = 1
	  # ======= Fin du tri
	  treeview.append_column(column)
	  
	  column   = TreeViewColumn.new(XmlMultilingueReader.lireTexte("distanceParcourue"), renderer, :text => 2)
	  # ======= Pour pouvoir trier la colonne
	  column.sort_indicator=true
	  column.sort_column_id = 2
	  # ======= Fin du tri
	  treeview.append_column(column)
	  
	  column   = TreeViewColumn.new(XmlMultilingueReader.lireTexte("orTotal"), renderer, :text => 3)
	  # ======= Pour pouvoir trier la colonne
	  column.sort_indicator=true
	  column.sort_column_id = 3
	  # ======= Fin du tri
	  treeview.append_column(column)
	  
	  column   = TreeViewColumn.new(XmlMultilingueReader.lireTexte("tempsJeu"), renderer, :text => 4)
	  # ======= Pour pouvoir trier la colonne
	  column.sort_indicator=true
	  column.sort_column_id = 4
	  # ======= Fin du tri
	  treeview.append_column(column)
	  
	  renderer = CellRendererText.new
	  renderer.weight = Pango::FontDescription::WEIGHT_BOLD
	  column   = TreeViewColumn.new(XmlMultilingueReader.lireTexte("score"), renderer, :text => 5)
	  # ======= Pour pouvoir trier la colonne
	  column.sort_indicator=true
	  column.sort_column_id = 5
	  # ======= Fin du tri
	  treeview.append_column(column)
	  
	end
	
	
	##
	# Rempli et retourne une liste de statistiques de joueurs en fonction de la difficultï¿½
	#=== Paramètres
   # * <b>difficulte :</b> une chaine de caractï¿½res permettant de choisir la liste de joueur ï¿½ retourner en fonction de cette difficultï¿½
   #
   #=== Retourne :
   # * <b>c :<b> Retourne un classement
   #
	def remplirListeJoueur()
		c = Classements.new()
		
		if(File.exist?("XMLFile/classements.xml")) # Si le fichier xml correspondant aux classements des joueurs existe
			XmlClassements.lireXml(c)
		end
		
		return c
	end

	
	##
   # Lorsque le joueur clique sur options, permet de choisir la langue ou d'activer le son 
   #
	def afficherOptions()
    	@fenetreMenu  = Window.new()
		@fenetreMenu.set_title(XmlMultilingueReader.lireTexte("Options"))
		@fenetreMenu.resize(100,100)
		
		@contenu = VBox.new(true, 10)
		
		maHBoxSon 	= HBox.new(true, 10)
		labelSon 	= Label.new(XmlMultilingueReader.lireTexte("musique?"))
		oui 			= RadioButton.new(XmlMultilingueReader.lireTexte("oui"))
		non 			= RadioButton.new(oui, XmlMultilingueReader.lireTexte("non"))
		
		maHBoxSon.add(labelSon)
		maHBoxSon.add(oui)
		maHBoxSon.add(non)
		
      maHBoxBruitage   = HBox.new(true, 10)
      labelBruitage    = Label.new(XmlMultilingueReader.lireTexte("bruitage?"))
      ouiB             = RadioButton.new(XmlMultilingueReader.lireTexte("oui"))
      nonB             = RadioButton.new(ouiB, XmlMultilingueReader.lireTexte("non"))
        
      maHBoxBruitage.add(labelBruitage)
      maHBoxBruitage.add(ouiB)
      maHBoxBruitage.add(nonB)
		
		maHBoxLangue 	= HBox.new(true, 10)
		labelLangue 	= Label.new(XmlMultilingueReader.lireTexte("langue") + " : ")
		listeLangue 	= ComboBox.new(true)
		listeLangue.insert_text(0, XmlMultilingueReader.lireTexte("francais"))
		listeLangue.insert_text(1, XmlMultilingueReader.lireTexte("anglais"))
		listeLangue.active=(0)
		
		maHBoxLangue.add(labelLangue)
		maHBoxLangue.add(listeLangue)
		
		boutValider = Button.new(XmlMultilingueReader.lireTexte("valider"))
		
		@contenu.add(maHBoxSon)
      @contenu.add(maHBoxBruitage)
		@contenu.add(maHBoxLangue)
		@contenu.add(boutValider)
		@contenu.set_border_width(20)
    	@fenetreMenu.set_window_position Gtk::Window::POS_CENTER
		@fenetreMenu.add(@contenu)
		@fenetreMenu.show_all
		
      @controleur.validerOptionsCreer(boutValider, oui, non, ouiB, nonB, listeLangue, @fenetreMenu)
      @controleur.destroyMenuCreer(@fenetreMenu)
		
	end

	
	##
   # Lorsque le joueur clique sur aide, affiche l'aide sur le jeu
   #
	def afficherAide()
    	@fenetreMenu  = Window.new(Gtk::Window::TOPLEVEL)
		@fenetreMenu.set_title(XmlMultilingueReader.lireTexte("Aide"))
		@fenetreMenu.set_height_request(500)
		
		@contenu = VBox.new(false, 10)
		
		texteAide = ""
		
		fichier = File.open(XmlMultilingueReader.lireTexte("cheminFicAide"), "r")
		fichier.each_line { |ligne|
			texteAide = texteAide + ligne
		}
		fichier.close		
		
		labelAide = Label.new()
		labelAide.set_markup(texteAide)
		labelAide.wrap = true
		
		scrolled_win = ScrolledWindow.new
		scrolled_win.add_with_viewport(labelAide)
		
		# Affichage ou non des scrollBars
		scrolled_win.set_policy(Gtk::POLICY_NEVER, Gtk::POLICY_AUTOMATIC)
		
		boutRetour = Button.new(XmlMultilingueReader.lireTexte("retourMenu"))
		
		@contenu.add(scrolled_win)
		@contenu.pack_start(boutRetour, false, false)
		@contenu.set_border_width(20)
    	@fenetreMenu.set_window_position Gtk::Window::POS_CENTER
		@fenetreMenu.add(@contenu)
		@fenetreMenu.show_all

		@controleur.retourCreer(boutRetour,@fenetreMenu)
		@controleur.destroyMenuCreer(@fenetreMenu)
	end

	
end
