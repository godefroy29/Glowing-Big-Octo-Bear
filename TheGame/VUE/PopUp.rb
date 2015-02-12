#COMOK

##
# Fichier           : PopUp.rb
# Auteur           : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
# Cette classe represente un PopUp. Un PopUp est defini par :
# * Une vue auquel il est liee
#

require 'gtk2'
require 'XMLReader/XmlMultilingueReader.rb'


class PopUp
  private_class_method :new
  @vue
  attr_reader :vue, :message
  ##
  # CrÃƒÂ©e un nouveau PopUp.
  #
  # == Parameters:
  # * <b>vue :</b> representant la vue auquel la fenetre de CombatModal est attachÃƒÂ©e
  #
  def initialize(vue)
    @vue=vue
    @message=message
  end

  
  ##
  # Instancie un PopUp
  #
  # == Parameters:
  # * <b>vue :</b> representant la vue auquel la fenetre de CombatModal est attachÃƒÂ©e
  #
  def PopUp.creer(vue)
    new(vue)
  end

  
  ##
  # Affiche le PopUp contenant le message
  #
  # == Parameters:
  # * <b>message :</b> representant le message a afficher
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def affichePopUp(message)
    # @vue.window.modal=false
    Gtk.idle_add do
      @vue.window.modal=false
      dialog = Gtk::Dialog.new(XmlMultilingueReader.lireTexte("popupAttention"), @vue.window,
      Gtk::Dialog::MODAL | Gtk::Dialog::DESTROY_WITH_PARENT,
      [Gtk::Stock::OK, Gtk::Dialog::RESPONSE_ACCEPT])
      
      dialog.signal_connect('response') { dialog.destroy }
      dialog.vbox.add(Gtk::Label.new(message))
        
      dialog.show_all
      dialog.run do |response|
      end
      false
    end
    return nil
  end

  
  ##
  # Affiche le PopUp contenant le message
  #
  # == Parameters:
  # * <b>message :</b> representant le message a afficher
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def affichePopUpMort(message)
    Gtk.idle_add do
      @vue.window.modal=false
      dialog = Gtk::Dialog.new(XmlMultilingueReader.lireTexte("popupAttention"), @vue.window,
      Gtk::Dialog::MODAL | Gtk::Dialog::DESTROY_WITH_PARENT,
      [Gtk::Stock::OK, Gtk::Dialog::RESPONSE_ACCEPT])
      
      dialog.signal_connect('response') {
        dialog.destroy
		  @vue.actualiser()
        @vue.menu = MenuJeu.creer(false, @vue.modele, @vue.controller)
        @vue.window.set_sensitive(false)
        @vue.controller.classementAction
      }
      dialog.vbox.add(Gtk::Label.new(message))
      dialog.show_all
      dialog.run do |response|
      end
      false
    end
    return nil
  end

  
  ##
  # Affiche le PopUp contenant un choix entre le menu d'achat ou le menu de vente d'un marchand
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def afficheChoixMarchand()
    @vue.window.modal=false
    Gtk.idle_add do
      dialog = Gtk::Dialog.new(XmlMultilingueReader.lireTexte("popupCommerce"), @vue.window,
      Gtk::Dialog::MODAL | Gtk::Dialog::DESTROY_WITH_PARENT,
      [Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_REJECT])
      dialog.signal_connect('response') { dialog.destroy }
        
      dialog.vbox.add(Gtk::Label.new(XmlMultilingueReader.lireTexte("commerceChoix")))
      buttonAchat=Gtk::Button.new(XmlMultilingueReader.lireTexte("achat"))
      buttonVendre=Gtk::Button.new(XmlMultilingueReader.lireTexte("vendre"))
        
      @vue.controller.achatMarchandCreer(buttonAchat,dialog)
      dialog.vbox.add(buttonAchat)
      @vue.controller.vendreMarchandCreer(buttonVendre,dialog)
      dialog.vbox.add(buttonVendre)

      dialog.show_all
      dialog.run do |response|
      end
      false
    end
    return nil
  end

  
  ##
  # Affiche le PopUp contenant un choix entre les diffÃƒÂ©rentes options de soins
  #
  # == Parameters:
  # * <b> joueur : </b> afin qu'il puisse acheter/recevoir des soins
  # * <b> guerisseur : </b> PNJ qui fourni un service de type soin
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def afficheChoixGuerisseur(joueur,guerisseur)
    @vue.window.modal=false
    Gtk.idle_add do
      dialog = Gtk::Dialog.new(XmlMultilingueReader.lireTexte("popupSoigneur"), @vue.window,
      Gtk::Dialog::MODAL | Gtk::Dialog::DESTROY_WITH_PARENT,
      [Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_REJECT])
      dialog.signal_connect('response') { dialog.destroy }
      dialog.vbox.add(Gtk::Label.new(XmlMultilingueReader.lireTexte("soinChoix")))

      if(joueur.inventaire.capital>=30)
        buttonSoinMini=Gtk::Button.new(XmlMultilingueReader.lireTexte("soinChoix0"))
        @vue.controller.soinCreer(buttonSoinMini,joueur,0,guerisseur,dialog)
        dialog.vbox.add(buttonSoinMini)
      else
        dialog.vbox.add(Gtk::Label.new(XmlMultilingueReader.lireTexte("sansLeSous")))
      end
      if(joueur.inventaire.capital>=50)
        buttonSoinMoyen=Gtk::Button.new(XmlMultilingueReader.lireTexte("soinChoix1"))
        @vue.controller.soinCreer(buttonSoinMoyen,joueur,1,guerisseur,dialog)
        dialog.vbox.add(buttonSoinMoyen)
      end
      if(joueur.inventaire.capital>=70)
        buttonSoinMax=Gtk::Button.new(XmlMultilingueReader.lireTexte("soinChoix2"))
        @vue.controller.soinCreer(buttonSoinMax,joueur,2,guerisseur,dialog)
        dialog.vbox.add(buttonSoinMax)
      end
      dialog.show_all
      dialog.run do |response|
      end
      false
    end
    return nil
  end

  
  ##
  # Affiche le PopUp contenant un choix entre le menu d'achat ou le menu de vente d'un marchand
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def choixInventairePlein()
    @vue.window.modal=false
    
    dialog = Gtk::Dialog.new(XmlMultilingueReader.lireTexte("fenetreInventairePlein"), @vue.window,
    Gtk::Dialog::MODAL | Gtk::Dialog::DESTROY_WITH_PARENT,
    [Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_REJECT])
    dialog.signal_connect('response') { dialog.destroy }
      
    dialog.vbox.add(Gtk::Label.new(XmlMultilingueReader.lireTexte("choixInventairePlein")))
    buttonJeter=Gtk::Button.new(XmlMultilingueReader.lireTexte("boutonJeter"))
    @vue.controller.choixInventairePleinCreer(buttonJeter,dialog)
    dialog.vbox.add(buttonJeter)

    dialog.show_all
    dialog.run do |response|
    end
    return nil
  end

  
  ##
  # Retourne une chaÃƒÂ®ne de caractÃƒÂ¨res  permettant l'identification de l'objet.
  #
  # == Returns :
  # * <b> string: </b> message indiquant la nature de l'objet
  #
  def to_s
    return XmlMultilingueReader.lireTexte("popUp")
  end

end
