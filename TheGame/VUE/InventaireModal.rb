#COMOK
#!/usr/bin/env ruby

##
# Fichier : InventaireModal.rb
# Auteur  : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de gérer le fenêtre d'Inventaire.
#Le fenêtre d'inventaire modale est caractérisée par :
#* Une fenêtre (Gtk Window)
#* Un contenu
#* La Vue à laquelle elle appartient
#* Un nombre de colonne maximal
#* Un bouton d'interaction (dont le texte et l'action est variable)
#* Un tableau d'images
#* Une fabrique à infobulles (tooltips)
#* Un Inventaire courant (l'Inventaire affiché par la fenêtre à un instant t)
#


require 'gtk2'

# On inclut le module Gtk : cela évite de préfixer les classes par 
include Gtk


class InventaireModal
  
   #=== Variable d'instance ===
   @fenetreInventaire
   @contenu
   @vue
   @nbColonnesMax
   @boutonInteraction
   @tabImages
   @tooltips
   @inventaireCourant

  
   attr_accessor :inventaireCourant
  
   private_class_method :new #La construction se fera par la méhode de classe InventaireModal.creer(vue)

   ##
   #Crée un nouvel InventaireModal qui appartiendra à la Vue passée en paramètre.
   #
   #===Paramètre :
   #* <b>vue :</b> la Vue qui affichera l'InventaireModal créé
   #
   def initialize(vue)
      @vue    = vue
      @nbColonnesMax = 5
      @tabImages     = Array.new() 
      @tooltips = Gtk::Tooltips.new
   end
  
  
   ##
   #Permet de créer un nouvel InventaireModal qui appartiendra à la Vue passée en paramètre.
   #
   #===Paramètre :
   #* <b>vue :</b> la Vue qui affichera l'InventaireModal créé
   #===Retourne :
   #* <b>nouvelInventaireModal :</b> le nouvel InventaireModal créé
   #
   def InventaireModal.creer(vue)
      return new(vue)
   end
  
  
  
   ##
   #Actualise la fenêtre d'InventaireModal pour y afficher l'inventaire du protagoniste "protagoniste" avec le mode d'affichage "modeAffichage".
   #
   #===Paramètres :
   #* <b>protagoniste :</b> le protagoniste dont on souhaite afficher l'Inventaire
   #* <b>modeAffichage :</b> le mode d'affichage l'InventaireModal (cf setModeAffichage(modeAffichage))
   #
   def afficherInventaire(protagoniste, modeAffichage)
      @fenetreInventaire = Window.new()
      @fenetreInventaire.set_default_size(100,100)
      @fenetreInventaire.set_title("Inventaire")
      @vue.window.modal=false

      setModeAffichage(modeAffichage)
      setBoutonInteractionActif(false)
            
      @contenu = VBox.new(false,10)
      
      #Récupération de l'inventaire à afficher      
      if modeAffichage == EnumStadePartie.INTERACTION_MARCHAND_ACHAT
         inventaireMarchand = protagoniste.listeItem.itemsStock
         #On supprime les items dont le prix est trop cher
         @inventaireCourant=inventaireMarchand.reject { |item| !@vue.modele.joueur.peutSePermettreAchat?(item) } 
      else
         @inventaireCourant = protagoniste.inventaire.items
      end

      #Création du tableau qui contiendra les items
      @tableauItems = Table.new(@inventaireCourant.count/@nbColonnesMax, @nbColonnesMax, true) 


      #On parcrous ensuite les items du protagoniste
      indice_ligne   = 0
      indice_colonne = 0

      @inventaireCourant.each_with_index do |item, indice| #Pour chaque item...
         #On crée l'image de l'item
         pixbufItemCourant = Gdk::Pixbuf.new(@vue.referencesGraphiques.getRefGraphique(item.getIntitule.downcase))
         pixbufItemCourant = pixbufItemCourant.scale(40,40,Gdk::Pixbuf::INTERP_BILINEAR)
         imageCourante = Image.new(pixbufItemCourant)

         #On ajoute cette image au tableau d'images
         @tabImages << imageCourante

         #On crée une EventBox avec l'image de l'item
         eventBoxCourante = EventBox.new.add(imageCourante)
         #eventBoxCourante.set_tooltip_text item.getIntitule + " (" + item.caracteristique.prix.to_s + ")"
         if modeAffichage == EnumStadePartie.INTERACTION_MARCHAND_ACHAT
            @tooltips.set_tip( eventBoxCourante, item.getIntitule + " (" + item.caracteristique.prix.to_s + ")", nil )
         else
            @tooltips.set_tip( eventBoxCourante, item.getIntitule + " (" + (item.caracteristique.prix/2).to_s + ")", nil )
         end
         #On lie l'événement de clic de l'eventBox au Controlleur
         @vue.controller.selectionnerItem(eventBoxCourante,indice)

         #On place l'EventBox dans le tableau destiné Ã  contenir les items
         @tableauItems.attach(eventBoxCourante, indice_colonne, (indice_colonne+1), indice_ligne, (indice_ligne+1) )
         
         #On gère les indices de placement
         indice_colonne +=1
         if indice != 0 && (indice+1)%@nbColonnesMax == 0
            indice_ligne  += 1
            indice_colonne = 0
         end 
      end
 
      #La dernière image du tableau est utilisée pour afficher l'image de l'item sélectionné
      pixbufItemCourant = Gdk::Pixbuf.new(@vue.referencesGraphiques.getRefGraphique("itemSelect")) #TODO : placer dans referencesGraphiques
      pixbufItemCourant = pixbufItemCourant.scale(40,40,Gdk::Pixbuf::INTERP_BILINEAR)
      @tabImages << Image.new(pixbufItemCourant) 
    

      @fenetreInventaire.signal_connect('delete_event') {onDestroy} 

      #On ajoute à la vbox les différents éléments
      @contenu.pack_start(@tableauItems,true,true,0)
      @contenu.pack_start(@tabImages.last,true,true,0)
      @contenu.pack_start(@boutonInteraction,true,true,0)
      
      #On ajoute la vbox à la fenêtre
      @fenetreInventaire.add(@contenu)
      @fenetreInventaire.transient_for=@vue.window
      @fenetreInventaire.modal = true
      @fenetreInventaire.set_window_position Gtk::Window::POS_CENTER
      @fenetreInventaire.show_all
      return @fenetreInventaire
  
    end
  
   ##
   #Permet de définir si le bouton d'interraction de l'InventaireModal doit être actif ou non (cliquable ou grisé)
   #
   #===Paramètre :
   #* <b>isActif :</b> un booléen à vrai (true) si le bouton d'interraction doit être actif, à faux (false) le cas contraire
   #
   def setBoutonInteractionActif(isActif)
      @boutonInteraction.set_sensitive(isActif)
   end
  

   ##
   #Fonction invoquée lorsque la popup de l'inventaire est fermée.
   #Cette fonction permet de faire un clear des éléments graphiques et du tableau des images et de masquer la fenêtre d'InventaireModale
   #
   def onDestroy
      @fenetreInventaire.modal = false
      @tabImages.clear
      @fenetreInventaire.destroy
   end



   ##
   #Fonction modifiant l'image de l'Item sélectionné par celle de l'item fraichement sélectionné
   #
   #===Paramètre :
   #* <b>indice :</b> l'indice de l'Item sélectionné
   #
   def setImageSelection(indice)
      pixbufElement = Gdk::Pixbuf.new(@vue.referencesGraphiques.getRefGraphique("itemSelect")) #TODO : placer dans referencesGraphiques
      pixbufElement = pixbufElement.scale(40,40,Gdk::Pixbuf::INTERP_BILINEAR)
      @tabImages[@tabImages.count-1].pixbuf = @tabImages[indice].pixbuf
   end



   ##
   #Fonction modifiant le mode d'affichage de l'InventaireModal pour le rendre adaptable aux différentes situations possibles.
   #Exemple : situation de rejet d'un Item, situation de vente d'un Item etc...
   #Le but principal ce cette fonction est donc de modifier le bouton d"interraction en conséquence du mode choisi
   #
   #===Paramètre :
   #* <b>modeAffichage :</b> le mode d'affichage de l'Inventaire (cf EnumStadePartie)
   #
   def setModeAffichage(modeAffichage)
      case modeAffichage
         when EnumStadePartie.INVENTAIRE_PLEIN then
            @boutonInteraction=Button.new(XmlMultilingueReader.lireTexte("boutonJeter"))
            @vue.controller.jeterItem(@boutonInteraction)
         when EnumStadePartie.INTERACTION_MARCHAND_ACHAT then
            @boutonInteraction=Button.new(XmlMultilingueReader.lireTexte("achat"))
            @vue.controller.acheterItem(@boutonInteraction)
         when EnumStadePartie.INTERACTION_MARCHAND_VENTE then
            @boutonInteraction=Button.new(XmlMultilingueReader.lireTexte("vendre"))
            @vue.controller.vendreItem(@boutonInteraction)
         when EnumStadePartie.INVENTAIRE_USAGE then
            @boutonInteraction=Button.new(XmlMultilingueReader.lireTexte("boutonUtiliser"))
            @vue.controller.utiliserItem(@boutonInteraction)
        end
   end


end #Fin de la classe InventaireModal

