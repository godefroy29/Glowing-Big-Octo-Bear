#COMOK

## 
# Fichier           : InteractionModal.rb 
# Auteur           : L3SPI - Groupe de projet B 
# Fait partie de : TheGame 
# 
# Cette classe reprÃ©sente une InteractionModal. Un InteractionModal est dÃ©fini par : 
# * Une vue auquel il est liÃ©
# * Des references Graphiques representant la base de donnÃ©e image
# * Un modele sur lequel l'objet ira chercher les informations
# 


require 'gtk2'
require 'XMLReader/XmlMultilingueReader.rb'
require 'CONTROLEUR/Controller.rb'

##
# Classe qui instancie un popup permettant de faire un choix sur les interactions possibles
# Depend de la vue
#
class InteractionModal
  private_class_method :new
  @vue
  @modele
  
  ## 
  # CrÃ©e une nouvelle InteractionModal Ã  partir des informations passÃ©es en paramÃ¨tre. 
  # 
  # == Parameters: 
  # * <b>vue :</b> represente la vue auquel la fenetre de CombatModal est attachÃ©e
  # * <b>modele :</b> represente le modele sur lequel l'objet ira chercher les informations
  # 
  def initialize(modele,vue)
    @vue=vue
    @modele=modele
  end
  
  
  ## 
  # Instancie une InterfaceModal
  # 
  # == Parameters: 
  # * <b>vue :</b> representant la vue auquel la fenetre de CombatModal est attachÃ©e
  # * <b>modele :</b> represente le modele sur lequel l'objet ira chercher les informations
  # 
  def InteractionModal.creer(modele,vue)
    new(modele,vue)
  end
  
  
  ## 
  # Cree un PopUp affichant les choix disponibles sur la case actuelle du joueur
  # affiche qu'il n'y a rien a faire s'il n'y a rien sur la case
  # 
  # == Returns :
  # * <b> nil: </b> default value
  #
  def majInteractionModal()
    @vue.window.modal=false
    tooltips = Gtk::Tooltips.new
    if(@modele.joueur.casePosition.presenceAides?())
      
      listeElements=@modele.joueur.casePosition.listeElements()

      # Creation du popup
      Gtk.idle_add do
        dialog = Gtk::Dialog.new(XmlMultilingueReader.lireTexte("popupInteraction"), @vue.window,
                           Gtk::Dialog::MODAL | Gtk::Dialog::DESTROY_WITH_PARENT)
        dialog.signal_connect('response') { dialog.destroy }
        dialog.vbox.add(Gtk::Label.new(XmlMultilingueReader.lireTexte("choixInteraction")))
        #Creation des boutons
        listeElements.each{ |element|
          button=Gtk::Button.new()
          image= Gtk::Image.new()
          pixbufElement = Gdk::Pixbuf.new(@vue.referencesGraphiques.getRefGraphique(element.getIntitule().downcase))
          pixbufElement=pixbufElement.scale(40,40,Gdk::Pixbuf::INTERP_BILINEAR)
          image.set_pixbuf(pixbufElement)
          button.image = image
          #ajout d'infobulles
          tooltips.set_tip( button, element.description(), nil )
  
          @vue.controller.interactionElementCreer(button,element,@modele.joueur,dialog)
          dialog.vbox.add(button)
         }
        dialog.show_all
        dialog.run do |response|
        end
        false
      end  
    # S'il n'y a pas d'Ã©lÃ©ments, alors on affiche un popup affichant qu'il n'y a rien a faire (cas normalement inexistant, le bouton etant bloquÃ© s'il n'y a rien)
    else
       dialog = Gtk::Dialog.new(XmlMultilingueReader.lireTexte("popupInteraction"), @vue.window,
                         Gtk::Dialog::MODAL | Gtk::Dialog::DESTROY_WITH_PARENT,
                         [Gtk::Stock::OK, Gtk::Dialog::RESPONSE_ACCEPT])
      dialog.signal_connect('response') { dialog.destroy }
      dialog.vbox.add(Gtk::Label.new(XmlMultilingueReader.lireTexte("nothingToDoInteraction")))
      dialog.show_all
    end
    return nil
  end
  
  
  ## 
  # Retourne une chaÃ®ne de caractÃ¨res  permettant l'identification de l'objet. 
  # 
  # == Returns :
  # * <b> string: </b> message indiquant la nature de l'objet
  #
  def to_s
    return XmlMultilingueReader.lireTexte("interactionModal")
  end
  
end
