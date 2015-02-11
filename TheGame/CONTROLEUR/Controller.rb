#COMOK
#!/usr/bin/env ruby

##
# Fichier        : Controller.rb
# Auteur         : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
#===Cette classe représente le Controlleur du jeu
# 

require 'VUE/Vue.rb'
require 'VUE/Audio.rb'
require 'XMLReader/XmlMultilingueReader.rb'


class Controller

   @modele
   @vue
   
   ##
   #Crée un nouveau Controlleur à partir de la Vue et du Modele passés en paramètre.
   #
   #=== paramètres :
   #* <b>modele</b> : le Modele du jeu
   #* <b>vue</b>    : la Vue du jeu
   #
   def initialize(modele, vue)
      @modele = modele
      @vue    = vue
      Audio.playSoundLoop("stable_boy")
   end
   
   
   ##
   #Crée un nouveau Controlleur à partir de la Vue et du Modele passés en paramètre.
   #
   #=== paramètres :
   #* <b>modele</b> : le Modele du jeu
   #* <b>vue</b>    : la Vue du jeu
   #
   #===Retourne :
   #* <b>nouveauControleur</b> : le nouveau controleur créé
   #
   def Controller.creer(modele,vue)
     new(modele,vue)
   end

    
   ##
   #Permet d'assigner des actions aux touches du clavier
   #
   #=== paramètres :
   #* <b>window</b> : la fenêtre à écouter
   #
   def ecouteClavierCreer(window)
     window.signal_connect("key-press-event") do |w, e|
       case Gdk::Keyval.to_name(e.keyval)
          when "Up"
            if @vue.ecouteUp
              deplacementHautAction()
            end
          when "Down"
            if @vue.ecouteDown
              deplacementBasAction()
            end
          when "Right"
            if @vue.ecouteRight
              deplacementDroiteAction()
            end
          when "Left"
            if @vue.ecouteLeft
              deplacementGaucheAction()
            end
          when XmlMultilingueReader.lireTexte("clavierRepos")
            if @vue.ecouteToucheRepos
              reposAction()
            end
          when XmlMultilingueReader.lireTexte("clavierInventaire")
            if @vue.ecouteToucheInventaire
              inventaireAction()
            end
          when XmlMultilingueReader.lireTexte("clavierInteraction")
            if @vue.ecouteToucheInteraction
              interactionAction()
            end
          when XmlMultilingueReader.lireTexte("clavierMenu")
            if @vue.ecouteToucheMenu
              menuAction()
            end
       end
     end
   end 
     
     
	##
	#Fait le lien entre un bouton et l'action liée au déplacement haut
	#
	#== paramètres :
	#* <b>btDeplacementHaut</b> : le gtkButton qu'il faudra lier à l'action d'un déplacement vers le haut
	#
	def deplacementHautCreer(btDeplacementHaut)
   	btDeplacementHaut.signal_connect('button_press_event'){
   		deplacementHautAction()
   	}
	end
      
              
	##
	#Action(s) à effectuer lors du clic sur le bouton de deplacement haut
	#
	def deplacementHautAction
	   Audio.playSound("deplacement")
	   @vue.zoneCtrl.bloquerBoutons(@modele)
	   Thread.new do
	   	@modele.joueur.deplacement(EnumDirection.NORD)
	   end
	end

    
	##
	#Fait le lien entre un bouton et l'action liée au deplacement bas
	#
	#=== paramètres :
	#* <b>btDeplacementBas</b> : le gtkButton qu'il faudra lier à l'action d'un déplacement vers le bas
	#
	def deplacementBasCreer(btDeplacementBas)
		btDeplacementBas.signal_connect('button_press_event'){
			deplacementBasAction()
		}
	end
        

	##
	#Action(s) à effectuer lors du clic sur le bouton deplacement bas
	#
	def deplacementBasAction
		Audio.playSound("deplacement")
		@vue.zoneCtrl.bloquerBoutons(@modele)
		Thread.new do
			@modele.joueur.deplacement(EnumDirection.SUD)
		end
	end
 
    
	##
	#Fait le lien entre un bouton et l'action liée au deplacement gauche
	#
	#=== paramètres :
	#* <b>btDeplacementGauche</b> : le gtkButton qu'il faudra lier à l'action d'un déplacement vers la gauche
	#
	def deplacementGaucheCreer(btDeplacementGauche)
		btDeplacementGauche.signal_connect('button_press_event'){
			deplacementGaucheAction()
		}
	end
        
        
	##
	#Action(s) à effectuer lors du clic sur le bouton de deplacement gauche
	#
	def deplacementGaucheAction
		Audio.playSound("deplacement")
		@vue.zoneCtrl.bloquerBoutons(@modele)
		Thread.new do
			@modele.joueur.deplacement(EnumDirection.OUEST)
		end
	end
        
        
	##
	#Fait le lien entre un bouton et l'action liée au deplacement droit
	#
	#=== paramètres :
	#* <b>btDeplacementDroite</b> : le gtkButton qu'il faudra lier à l'action d'un déplacement vers la droite
	#
	def deplacementDroiteCreer(btDeplacementDroite)
		btDeplacementDroite.signal_connect('button_press_event'){
			deplacementDroiteAction()
		}
	end
        
  
	##
	#Action(s) à effectuer lors du clic sur le bouton de deplacement droit
	#
	def deplacementDroiteAction
		Audio.playSound("deplacement")
		@vue.zoneCtrl.bloquerBoutons(@modele)
		Thread.new do
			@modele.joueur.deplacement(EnumDirection.EST)
		end
	end
        
        
	##
	#Fait le lien entre un bouton et l'action liée au repos
	#
	#=== paramètres :
	#* <b>btRepos</b> : le gtkButton qu'il faudra lier à l'action d'un repos
	#
	def reposCreer(btRepos)
		btRepos.signal_connect('clicked'){
			reposAction()
		}
	end
        
        
	##
	#Action(s) à effectuer lors du clic sur le bouton repos
	#
	def reposAction
		Audio.playSound("ronfle")
		Thread.new do
			@modele.joueur.utiliserRepos() 
			@modele.debutTour()
      @modele.changerStadePartie(EnumStadePartie.NO_ETAPE())
		end
	  
	end

        
	##
	#Fait le lien entre un bouton et l'action liée à l'affichage de l'inventaire
	#
	#=== paramètres :
	#* <b>btInventaire</b> : le gtkButton qu'il faudra lier à l'action du clic sur le bouton inventaire
	#
	def inventaireCreer(btInventaire)
		btInventaire.signal_connect('clicked'){
			inventaireAction()
		}
	end
        

	##
	#Action(s) à effectuer lors du clic sur le bouton inventaire
	#
	def inventaireAction
		@vue.window.modal = false
		@vue.inventaireModal.afficherInventaire(@modele.joueur, EnumStadePartie.INVENTAIRE_USAGE)
	end

  
	##
	#Fait le lien entre un bouton et l'action liée au choix Jeter
	#
	#=== paramètres :
	#* <b>btInventaire</b> : le gtkButton qu'il faudra lier à l'action du clic sur le bouton inventaire
	#* <b> dialog</b> : PopUp liée au bouton
	#
	def choixInventairePleinCreer(buttonJeter,dialog)
		buttonJeter.signal_connect('clicked'){
			dialog.destroy
			choixInventairePleinAction(buttonJeter)
		}
	end
       

	##
	#Action(s) à effectuer lors du clic sur le bouton Jeter (choix)
	#
	#=== paramètres :
	#* <b>buttonJeter</b> : le gtkButton qu'il faudra lier à l'action du clic sur le bouton Jeter
	#
	def choixInventairePleinAction(buttonJeter)
		@vue.window.modal = false
		@vue.inventaireModal.afficherInventaire(@modele.joueur, EnumStadePartie.INVENTAIRE_PLEIN)
	end
  

	##
	#Fait le lien entre un bouton et l'action liée à l'affichage du menu
	#
	#=== paramètres :
	#* <b>btMenu</b> : le gtkButton qu'il faudra lier aux actions d'affichage du menu
	#
	def menuCreer(btMenu)
		btMenu.signal_connect('clicked'){
		  menuAction()
		}
	end
        
        
	##
	#Action(s) à effectuer lors du clic sur le bouton menu
	#
	def menuAction
		if(!@modele.joueur.toujoursEnVie?()) # Si le joueur est mort, création menu avec moins de bouton
			@vue.menu = MenuJeu.creer(false, @modele, self)
		end
		
		@vue.window.modal = false;
		@vue.window.set_sensitive(false)
		@vue.menu.afficherMenu()
	end

    
	##
	#Fait le lien entre un bouton et l'action liée au menu d'interactions
	#
	#=== paramètres :
	#* <b>btInteraction</b> : le gtkButton qu'il faudra lier à l'action du clic sur le bouton interaction
	#
	def interactionCreer(btInteraction)
		btInteraction.signal_connect('clicked'){
			interactionAction()
		}
	end
        
   
	##
	#Action(s) à effectuer lors du clic sur le bouton interaction
	#
	def interactionAction()
		@vue.interactionModal.majInteractionModal()
	end


	##
	#Fait le lien entre un bouton et l'action liée a un element
	#
	#=== paramètres :
	#* <b>btInteraction</b> : le gtkButton qu'il faudra lier à l'action du clic sur le bouton interaction
	#* <b>elem</b> : element avec lequel on souhaite interagir
	#* <b>joueur</b> : afin d'effectuer l'action de l'element sur le joueur
	#* <b>dialog</b> : popup liée au bouton
	#
	def interactionElementCreer(btInteraction,elem,joueur,dialog)
		btInteraction.signal_connect('clicked'){
			dialog.destroy
			interactionElementAction(elem,joueur)
		}
	end
      
	      
	##
	#Action(s) à effectuer lors du clic sur un bouton <element>
	#
	#=== paramètres :
	#* <b>elem</b> : element avec lequel on souhaite interagir
	#* <b>joueur</b> : afin d'effectuer l'action de l'element sur le joueur
	#
	def interactionElementAction(elem,joueur)
		Audio.playSound("coin")
		Thread.new do
			elem.interaction(joueur)
		end
		@vue.window.modal=true
	end
  
  
	##
	#Fait le lien entre un bouton et l'action liée a un menu d'achat
	#
	#=== paramètres :
	#* <b>btInteraction</b> : le gtkButton qu'il faudra lier à l'action du clic sur le bouton interaction
	#* <b>dialog</b> : popup lié au bouton
	#
	def achatMarchandCreer(btInteraction,dialog)
		btInteraction.signal_connect('clicked'){
			dialog.destroy
			achatMarchandAction()
		}
	end
  
  
	##
	#Fait le lien entre un bouton et l'action liée a un menu de vente
	#
	#=== paramètres :
	#* <b>btInteraction</b> : le gtkButton qu'il faudra lier à l'action du clic sur le bouton interaction
	#* <b>dialog</b> : popup lié au bouton
	#
	def vendreMarchandCreer(btInteraction,dialog)
		btInteraction.signal_connect('clicked'){
			dialog.destroy
			vendreMarchandAction()
		}
	end
  
  
	##
	#Action(s) à effectuer lors du clic sur le bouton d'achat
	#
	def achatMarchandAction()
		if @modele.joueur.inventaire.estPlein?
			@vue.popUp.choixInventairePlein
		else 
			@vue.inventaireModal.afficherInventaire(@modele.pnjAideEnInteraction, EnumStadePartie.INTERACTION_MARCHAND_ACHAT)
		end
	end
  
  
	##
	#Action(s) à effectuer lors du clic sur le bouton de vente
	#
	def vendreMarchandAction() 
		@vue.inventaireModal.afficherInventaire(@modele.joueur, EnumStadePartie.INTERACTION_MARCHAND_VENTE)
	end
      
  
	##
	#Fait le lien entre un bouton et l'action liée au soin
	#
	#=== paramètres :
	#* <b>btInteraction</b> : le gtkButton qu'il faudra lier à l'action du clic sur le bouton interaction
	#* <b>joueur</b> : le joueur qui doit recevoir le soin
	#* <b>choix</b> : integer correspondant au soin choisi
	#* <b>guerisseur</b> : le guerisseur repondant a la demande de soin
	#* <b>dialog</b> : popup lié au bouton
	#
	def soinCreer(btInteraction,joueur, choix, guerisseur,dialog)
		btInteraction.signal_connect('clicked'){
			dialog.destroy
			soinAction(joueur,choix,guerisseur)
		}
	end
  
  
	##
	#Action(s) à effectuer lors du clic sur le bouton de soins
	#
	#=== paramètres :
	#* <b>joueur</b> : le joueur qui doit recevoir le soin
	#* <b>choix</b> : integer correspondant au soin choisi
	#* <b>guerisseur</b> : le guerisseur repondant a la demande de soin
	#
	def soinAction(joueur,choix,guerisseur)
		Thread.new do
			guerisseur.guerrir(joueur,choix)
			@vue.window.modal=true
			@modele.debutTour()
		end
	end
      
  
	##
	#Equipe un item lors de l'appuie sur le bouton correspondant
	#
	#=== paramètres :
	#* <b>joueur</b> : le joueur qui doit equiper l'item
	#* <b>elem</b> : element a equiper
	#* <b>dialog</b> : popup lié au bouton
	#* <b>momentCombat</b> : type Enum permettant de savoir à quel moment intervient le combat
	#
	def equiperItemCreer(btInteraction,elem,joueur,dialog,momentCombat)
		btInteraction.signal_connect('clicked'){
			equiperItemAction(joueur,elem,momentCombat)
			dialog.destroy
		}
	end
      
      
	##
	#Action(s) à effectuer lors du clic sur le bouton d'equipement d'element
	#
	#=== paramètres :
	#* <b>joueur</b> : le joueur qui doit equiper l'item
	#* <b>elem</b> : element a equiper
	#* <b>momentCombat</b> : type Enum permettant de savoir à quel moment intervient le combat
	#
	def equiperItemAction(joueur,elem,momentCombat)
		Thread.new do
		joueur.utiliserItem(elem)
		end
		 
		if(elem.caracteristique.typeEquipable.sePorteSur == EnumEmplacementEquipement.ARMURE)
			@modele.suiteEquipementChoixArme(momentCombat)
		else
			@modele.declencherCombat(momentCombat)
		end
		
		@vue.window.modal=true
	end
 
  
##### Pour le menu ######
  
  
	##
	#Liaison de l'action sur le bouton Continuer partie
	#
	#=== paramètres :
	#* <b>btContinuerPartie</b> : le gtkButton qu'il faudra lier à l'action d'un clic sur Continuer partie
	#* <b>fenetre</b> : la gtkWindow à détruire
	#
	def continuerPartieCreer(btContinuerPartie,fenetre)
		btContinuerPartie.signal_connect('button_press_event'){
			continuerPartieAction()
			fenetre.destroy()
		}
	end
   
          
	##
	#Action(s) à effectuer lors du clic sur le bouton ContinuerPartie
	#
	def continuerPartieAction()
		@vue.window.set_sensitive(true)
	end
  
  
	##
   #Liaison de l'action sur le bouton NouvellePartie
   #
   #=== paramètres :
   #* <b>btNewPartie</b> : le gtkButton qu'il faudra lier à l'action d'un clic sur NouvellePartie
   #* <b>fenetre</b> : la gtkWindow à détruire
   #
   def nouvellePartieCreer(btNewPartie,fenetre)
		btNewPartie.signal_connect('button_press_event'){
			nouvellePartieAction()
			fenetre.destroy()
		}
   end
     
          
	##
	#Action(s) à effectuer lors du clic sur le bouton NouvellePartie
	#
	def nouvellePartieAction
		@vue.menu.afficherNouvellePartie()
	end

      
   ##
   #Liaison de l'action sur le bouton ChargerPartie
   #
   #=== paramètres :
   #* <b>btChargerPartie</b> : le gtkButton qu'il faudra lier à l'action d'un clic sur ChargerPartie
   #* <b>fenetre</b> : la gtkWindow à détruire
   #
   def chargerPartieCreer(btChargerPartie,fenetre)
		btChargerPartie.signal_connect('button_press_event'){
			chargerPartieAction()
			fenetre.destroy()
		}
   end  
          
	##
	#Action(s) à effectuer lors du clic sur le bouton ChargerPartie
	#
	def chargerPartieAction
		@vue.menu.afficherChargerPartie()
	end

   
   ##
   #Liaison de l'action sur le bouton SauvegarderPartie
   #
   #=== paramètres :
   #* <b>btSauvegarderPartie</b> : le gtkButton qu'il faudra lier à l'action d'un clic sur SauvegarderPartie
   #* <b>fenetre</b> : la gtkWindow à détruire
   #
   def sauvegarderPartieCreer(btSauvegarderPartie,fenetre)
		btSauvegarderPartie.signal_connect('button_press_event'){
			sauvegarderPartieAction()
			fenetre.destroy()
		}
   end
 
          
	##
	#Action(s) à effectuer lors du clic sur le bouton SauvegarderPartie
	#
	def sauvegarderPartieAction
		@vue.menu.afficherSauvegarderPartie()
	end


   ##
   #Liaison de l'action sur le bouton Classement
   #
   #=== paramètres :
   #* <b>btClassement</b> : le gtkButton qu'il faudra lier à l'action d'un clic sur Classement
   #* <b>fenetre</b> : la gtkWindow à détruire
   #
   def classementCreer(btClassement,fenetre)
		btClassement.signal_connect('button_press_event'){
			classementAction()
			fenetre.destroy()
		}
   end
   
          
	##
	#Action(s) à effectuer lors du clic sur le bouton Classement
	#
	def classementAction
		@vue.menu.afficherClassement()
	end


   ##
   #Liaison de l'action sur le bouton Options
   #
   #=== paramètres :
   #* <b>btOptions</b> : le gtkButton qu'il faudra lier à l'action d'un clic sur Options
   #* <b>fenetre</b> : la gtkWindow à détruire
   #
   def optionsCreer(btOptions,fenetre)
		btOptions.signal_connect('button_press_event'){
			optionsAction()
			fenetre.destroy()
		}
   end
 
  
	##
	#Action(s) à effectuer lors du clic sur le bouton Options
	#
	def optionsAction
		@vue.menu.afficherOptions()
	end


   ##
   #Liaison de l'action sur le bouton Aide
   #
   #=== paramètres :
   #* <b>btAide</b> : le gtkButton qu'il faudra lier à l'action d'un clic sur Aide
   #* <b>fenetre</b> : la gtkWindow à détruire
   #
   def aideCreer(btAide,fenetre)
		btAide.signal_connect('button_press_event'){
			aideAction()
			fenetre.destroy()
		}
   end
    
          
	##
	#Action(s) à effectuer lors du clic sur le bouton Aide
	#
	def aideAction
		@vue.menu.afficherAide()
	end
	
	
	##
   #Liaison de l'action sur le bouton "C'est Parti" dans nouvelle partie
   #
   #=== paramètres :
   #* <b>btCommencerNewPartie</b> : le gtkButton qu'il faudra lier à l'action d'un clic sur "C'est Parti" dans nouvelle partie
   #* <b>entryPseudo</b> : le gtkEntry où le joueur entre son pseudo
   #* <b>boutRadioNovice</b> : le gtkRadioButton correspondant à la difficulté Novice
   #* <b>boutRadioMoyen</b> : le gtkRadioButton correspondant à la difficulté Moyen
   #* <b>boutRadioExpert</b> : le gtkRadioButton correspondant à la difficulté Expert
   #* <b>fenetre</b> : la gtkWindow à détruire
   #
   def commencerNewPartieCreer(btCommencerNewPartie, entryPseudo, boutRadioNovice, boutRadioMoyen, boutRadioExpert,fenetre)
      btCommencerNewPartie.signal_connect('clicked'){
			entryPseudo.activate # Appel le signal_connect 'activate' sur l'entry du pseudo
      }
      entryPseudo.signal_connect('activate'){
			commencerNewPartieAction(entryPseudo.text, boutRadioNovice, boutRadioMoyen, boutRadioExpert, fenetre)
		}
   end
 
 
	##
	#Action(s) a effectuer lors du clic sur le bouton "C'est Parti" dans nouvelle partie
	#
	#=== paramètres :
   #* <b>pseudo</b> : la chaine de caracteres correspondant au pseudo du joueur
   #* <b>boutRadioNovice</b> : le gtkRadioButton correspondant à la difficulté Novice
   #* <b>boutRadioMoyen</b> : le gtkRadioButton correspondant à la difficulté Moyen
   #* <b>boutRadioExpert</b> : le gtkRadioButton correspondant à la difficulté Expert
   #* <b>fenetre</b> : la gtkWindow à détruire
   #
	def commencerNewPartieAction(pseudo, boutRadioNovice, boutRadioMoyen, boutRadioExpert, fenetre)
		if(pseudo == "")
			pseudo = "JoueurInconnu"
		end
		
		if(boutRadioNovice.active?)
			difficulte = BibliothequeDifficulte.getDifficulte("Novice")
		elsif(boutRadioMoyen.active?)
			difficulte = BibliothequeDifficulte.getDifficulte("Moyen")
		elsif(boutRadioExpert.active?)
			difficulte = BibliothequeDifficulte.getDifficulte("Expert")
		end
		
		# Pour supprimer ancienne vue avant démarrage nouvelle partie
		if(@vue.menu.isInGame == true)
			@vue.window.destroy
		end
		
		# Pour detruire l'ancienne vue apres avoir recommencer une partie apres une mort
		if(@modele.joueur != nil)
			if(@modele.joueur.toujoursEnVie? == false)
				@vue.window.destroy
			end
		end
		
		# Destruction sous-menu nouvelle partie
		fenetre.destroy
		
		quitterPartieAction()
	
		# Creation de la vue
		vue=Vue.creer()
		
		# Creation du modele
		modele = Modele.creer(vue,difficulte,pseudo)
		
		# Creation du controller
		controller=Controller.creer(modele,vue)
		vue.defM(modele)
		vue.defC(controller)
		modele.initialiseToi() # Debut du temps à la création d'un joueur
		vue.initInterface()
	end


	##
   #Liaison de l'action sur le bouton Valider (dans options)
   #
   #=== paramètres :
   #* <b>btValiderOptions</b> : le gtkButton qu'il faudra lier à l'action d'un clic sur Valider (dans options)
   #* <b>radioButtonOui</b> : le gtkRadioButton correspondant à l'activation du son
   #* <b>radioButtonNon</b> : le gtkRadioButton correspondant à la nonactivation du son
   #* <b>radioBO2</b> : le gtkRadioButton correspondant à l'activation des bruitages
   #* <b>radioBN2</b> : le gtkRadioButton correspondant à la non activation des bruitages
   #* <b>comboBoxListeLangue</b> : le gtkComboBox correspondant au choix de la langue
   #* <b>fenetre</b> : la gtkWindow à détruire
   #
   def validerOptionsCreer(btValiderOptions, radioButtonOui, radioButtonNon, radioBO2, radioBN2, comboBoxListeLangue, fenetre)
      btValiderOptions.signal_connect('clicked'){
          validerOptionsAction(radioButtonOui, radioButtonNon, radioBO2, radioBN2, comboBoxListeLangue)
          fenetre.destroy()
      }
   end
 
 
	##
	#Action(s) à effectuer lors du clic sur le bouton Valider (dans options)
	#
	#=== paramètres :
   #* <b>radioButtonOui</b> : le gtkRadioButton correspondant à l'activation du son
   #* <b>radioButtonNon</b> : le gtkRadioButton correspondant à la nonactivation du son
   #* <b>radioBO2</b> : le gtkRadioButton correspondant à l'activation des bruitages
   #* <b>radioBN2</b> : le gtkRadioButton correspondant à la non activation des bruitages
   #* <b>comboBoxListeLangue</b> : le gtkComboBox correspondant au choix de la langue
   #
   def validerOptionsAction(radioButtonOui, radioButtonNon, radioBO2, radioBN2, comboBoxListeLangue)		
		if(radioButtonOui.active?)
			Audio.resumeSoundLoop()
		elsif(radioButtonNon.active?)
			Audio.muteSoundLoop()
		end
		
      if(radioBO2.active?)
        Audio.resumeBruitage()
      elsif(radioBN2.active?)
        Audio.muteBruitage()
      end

		if(comboBoxListeLangue.active == 0)
			XmlMultilingueReader.setLangue("FR")
		elsif(comboBoxListeLangue.active == 1)
			XmlMultilingueReader.setLangue("EN")
		end
		
		if(@vue.menu.isInGame == true)
			@vue.majLangue()
		end

		@vue.menu.afficherMenu()
	end


   ##
   #Liaison de l'action sur le bouton Retour
   #
   #=== paramètres :
   #* <b>btRetour</b> : le gtkButton qu'il faudra lier à l'action d'un clic sur Retour
   #* <b>fenetre</b> : la gtkWindow à détruire
   #
   def retourCreer(btRetour,fenetre)
      btRetour.signal_connect('clicked'){
          fenetre.destroy()
          retourAction()
      }
   end
 
 
	##
	#Action(s) à effectuer lors du clic sur le bouton Retour
	#
	def retourAction
		@vue.menu.afficherMenu()
	end
	
	
	##
	#Liaison de l'action sur le bouton Quitter Partie
	#
	#=== paramètres :
	#* <b>btQuitter</b> : le gtkButton qu'il faudra lier à l'action d'un clic sur Quitter Partie
	#* <b>fenetre</b> : la gtkWindow à détruire
	#
	def quitterPartieCreer(btQuitter,fenetre)
		btQuitter.signal_connect('button_press_event'){
			quitterPartieAction()
			fenetre.destroy()
		}
	end
 
 
	##
	#Action(s) à effectuer lors du clic sur le bouton Quitter Partie
	#
	def quitterPartieAction
		Gtk.main_quit
	end
	
	
	##
   #Liaison de l'action sur le bouton
   #
   #=== paramètres :
   #* <b>fenetre</b> : la gtkWindow à détruire lors d'un clic sur la croix de fermeture (croix rouge sous windows)
   #
   def destroyMenuCreer(fenetre)
      fenetre.signal_connect('delete_event'){
          destroyMenuAction(fenetre)
      }
   end
 
 
	##
	#Action(s) à effectuer lors du clic sur la croix de fermeture (croix rouge sous windows)
	#
	#=== paramètres :
   #* <b>fenetre</b> : la gtkWindow à détruire lors d'un clic sur la croix de fermeture (croix rouge sous windows)
	#
	def destroyMenuAction(fenetre)
		if(@vue.menu.isInGame == true)
			@modele.vue.window.set_sensitive(true)
		else
			Gtk.main_quit
		end
		fenetre.destroy
	end
	

### Gestion des événements de la fenêtre d'inventaire ###
 
	##
	#sélectionne un item lors de l'appuie sur le bouton qui lui correspond dans l'inventaire
	#
	#=== paramètres :
   #* <b>btItem</b> : la gtkButton correspondant à l'item cliqué
   #* <b>indiceItem</b> : int représentant le numéro de l'item sélectionné
	#
	def selectionnerItem(btItem,indiceItem)
		btItem.signal_connect('button_press_event'){
			@vue.inventaireModal.setImageSelection(indiceItem)
			@vue.inventaireModal.setBoutonInteractionActif(true)
			@modele.indiceItemSelectionne = indiceItem
		}
	end
	
	##
	#Achète l'item sélectionné lors de l'appuie sur le bouton "Acheter" dans l'inventaire
	#
	#=== paramètres :
   #* <b>btAcheter</b> : la gtkButton correspondant au bouton "Acheter"
	#
	def acheterItem(btAcheter)
		btAcheter.signal_connect('clicked'){
			Thread.new do
				marchand = @modele.pnjAideEnInteraction
				#Le marchand vend l'item sélectionné par le joueur à ce dernier
				marchand.vendre(@modele.joueur, @vue.inventaireModal.inventaireCourant[@modele.indiceItemSelectionne])
				@vue.inventaireModal.onDestroy()
				@vue.window.modal=true
        @modele.tourPasse()
				@modele.debutTour()
			end
		}
	end
	
	##
	#Vends l'item sélectionné lors de l'appuie sur le bouton "Vendre" dans l'inventaire
	#
	#=== paramètres :
   #* <b>btVendre</b> : la gtkButton correspondant au bouton "Vendre"
	#
	def vendreItem(btVendre)
		btVendre.signal_connect('clicked'){
			Thread.new do
				@modele.joueur.vendre(@modele.indiceItemSelectionne)
				@vue.inventaireModal.onDestroy()
				@vue.window.modal=true
				@modele.tourPasse()
				@modele.debutTour()
			end
		}
	end
	
	##
	#Jette l'item sélectionné lors de l'appuie sur le bouton "Jeter" dans l'inventaire
	#
	#=== paramètres :
   #* <b>btVendre</b> : la gtkButton correspondant au bouton "Jeter"
	#
	def jeterItem(btJeter)
		btJeter.signal_connect('clicked'){
			Thread.new do
				@modele.joueur.retirerDuStock(@modele.joueur.inventaire.getItem(@modele.indiceItemSelectionne))
				@vue.inventaireModal.onDestroy
				@modele.debutTour()
				@vue.window.modal=true
				@vue.actualiser
			end
		}
	end
	
	
    ##
	#Utiliser l'item sélectionné au profit du joueur lors de l'appuie sur le bouton "Utiliser" dans l'inventaire
	#
	#=== paramètres :
   #* <b>btVendre</b> : la gtkButton correspondant au bouton "Utiliser"
	#
	def utiliserItem(btUtiliser)
		btUtiliser.signal_connect('clicked'){
			Thread.new do 
				@modele.joueur.utiliserItem(@modele.joueur.inventaire.getItem(@modele.indiceItemSelectionne))
				@vue.window.modal=true
				@vue.inventaireModal.onDestroy
        @vue.actualiser()
        @modele.debutTour()        
			end
		}
	end
	
	
	##
	#Permet de lancer un tour de jeu
	#
	def lancerTour()
		Thread.new do 
			@modele.debutTour()
		end
	end
	
end
