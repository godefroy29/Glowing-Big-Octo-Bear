#COMOK

##
# Fichier           : CombatModal.rb
# Auteur           : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
# Cette classe reprÃ©sente un CombatModal. Un CombatModal est dÃ©fini par :
# * Une vue auquel il est liÃ©
# * Un modele sur lequel l'objet ira chercher les informations
# * Un enum representant le moment du combat en cours (avant/apres deplacement)
#

require 'gtk2'
require 'XMLReader/XmlMultilingueReader.rb'
require 'CONTROLEUR/Controller.rb'
require "MODELE/Enum/EnumMomentCombat.rb"
require 'VUE/Audio.rb'


class CombatModal
  private_class_method :new
  @vue
  @modele
  @momentCombat
  attr_reader :vue, :modele
  
  
  ##
  # CrÃ©e un nouveau CombatModal Ã  partir des informations passÃ©es en paramÃ¨tre.
  #
  # == Parameters:
  # * <b>vue :</b> represente la vue auquel la fenetre de CombatModal est attachÃ©e
  # * <b>modele :</b> represente le modele sur lequel l'objet ira chercher les informations
  #
  def initialize(vue,modele)
    @vue=vue
    @modele=modele
  end

  
  ##
  #Instancie un CombatModal
  #
  # == Parameters:
  # * <b>vue :</b> representant la vue auquel la fenetre de CombatModal est attachÃ©e
  # * <b>modele :</b> represente le modele sur lequel l'objet ira chercher les informations
  #
  
  def CombatModal.creer(vue,modele)
    new(vue,modele)
  end

  
  ##
  # Cree un PopUp avec les informations sur les ennemis a combattre
  #
  # == Parameters:
  # * <b>momentCombat :</b> le moment oÃ¹ intervient le combat
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def majCombatModal(momentCombat)
    @momentCombat=momentCombat
    @vue.window.modal=false
    ennemis=@modele.joueur.casePosition.listeEnnemis
    str=XmlMultilingueReader.lireTexte("popupCombatEnnemi_avertissement")
    
    case momentCombat
    when EnumMomentCombat.APRES_ACTION()
      id="momentApresAction"
    when EnumMomentCombat.APRES_DEPLACEMENT()
      id="momentApresDepl"
    when EnumMomentCombat.AVANT_DEPLACEMENT()
      id="momentAvantDepl"
    end
    
    str=str+" ["+XmlMultilingueReader.lireTexte(id)+"]"
    for e in ennemis
      str=str+"\n   * "
      str_ennemis=XmlMultilingueReader.lireTexte("popupCombatEnnemi_ennemi")
      str_ennemis=str_ennemis.gsub("INTITULE",XmlMultilingueReader.lireDeterminant_Nom(e)).gsub("NIVEAU",e.niveau().to_s).gsub("ENERGIE",e.energie().to_s)
      str=str+str_ennemis
    end
    
    Audio.playSound("preCombat")
    Gtk.idle_add do
      @vue.window.modal=false
      dialog = Gtk::Dialog.new(XmlMultilingueReader.lireTexte("popupAttention"), @vue.window,
      Gtk::Dialog::MODAL | Gtk::Dialog::DESTROY_WITH_PARENT,
      [Gtk::Stock::OK, Gtk::Dialog::RESPONSE_ACCEPT])
      
      dialog.signal_connect('response') {
        dialog.destroy
        if(@modele.joueur.peutSEquiper && @modele.joueur.peutSEquiper==true)
          @modele.choixEquipementAvantCombat(@momentCombat)
        elsif(@modele.joueur.casePosition.presenceEnnemis?() && !@modele.joueur.peutSEquiper)
          @modele.declencherCombat(@momentCombat)
        end }
        
      dialog.vbox.add(Gtk::Label.new(str))
      dialog.show_all
      dialog.run do |response|
      end
      false
    end
    return nil
  end

  
  ##
  # Cree un PopUp contenant des boutons liÃ©s aux objets equipable defensifs
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def majEquipementDefensif()
    Gtk.idle_add do
      @vue.window.modal=false
      tooltips = Gtk::Tooltips.new
      listeArmure=Array.new()

      for i in @modele.joueur.inventaire.items
        if(i.estEquipable?() && i.caracteristique.typeEquipable.sePorteSur == EnumEmplacementEquipement.ARMURE)
          listeArmure.push(i)
        end
      end

      dialog = Gtk::Dialog.new(XmlMultilingueReader.lireTexte("popupCombat"), @vue.window,
      Gtk::Dialog::MODAL | Gtk::Dialog::DESTROY_WITH_PARENT)
      dialog.signal_connect('response') { dialog.destroy }
      dialog.signal_connect('delete_event') {
        @modele.suiteEquipementChoixArme(@momentCombat)
        dialog.destroy}
      dialog.vbox.add(Gtk::Label.new(XmlMultilingueReader.lireTexte("equipArmure")))

      listeArmure.each{ |item|
        button=Gtk::Button.new()
        image= Gtk::Image.new()
        pixbufElement = Gdk::Pixbuf.new(@vue.referencesGraphiques.getRefGraphique(item.getIntitule().downcase))
        pixbufElement=pixbufElement.scale(40,40,Gdk::Pixbuf::INTERP_BILINEAR)
        image.set_pixbuf(pixbufElement)
        button.image = image
        tooltips.set_tip( button, item.description, nil )

        @vue.controller.equiperItemCreer(button,item,@modele.joueur,dialog,@momentCombat)
        dialog.vbox.add(button)
      }
      buttonCancel=Gtk::Button.new()
      buttonCancel.set_label("Cancel")
      buttonCancel.signal_connect('clicked'){
        @modele.suiteEquipementChoixArme(@momentCombat)
        dialog.destroy
      }
      dialog.vbox.add(buttonCancel)
      dialog.show_all
      dialog.run do |response|
      end
      false
    end
    return nil
  end

  
  ##
  # Cree un PopUp contenant des boutons liÃ©s aux objets equipable offensifs
  #
  # == Returns :
  # * <b> nil: </b> default value
  #
  def majEquipementOffensif()
    Gtk.idle_add do
      @vue.window.modal=false
      tooltips = Gtk::Tooltips.new
      listeArme=Array.new()

      for i in @modele.joueur.inventaire.items
        if(i.estEquipable?() && i.caracteristique.typeEquipable.sePorteSur == EnumEmplacementEquipement.ARME)
          listeArme.push(i)
        end
      end

      dialog = Gtk::Dialog.new(XmlMultilingueReader.lireTexte("popupCombat"), @vue.window,
      Gtk::Dialog::MODAL | Gtk::Dialog::DESTROY_WITH_PARENT)
      dialog.signal_connect('response') { dialog.destroy }
      dialog.vbox.add(Gtk::Label.new(XmlMultilingueReader.lireTexte("equipArme")))
      dialog.signal_connect('delete_event') {      @modele.declencherCombat(@momentCombat)
        dialog.destroy}

      listeArme.each{ |item|
        button=Gtk::Button.new()
        image= Gtk::Image.new()
        pixbufElement = Gdk::Pixbuf.new(@vue.referencesGraphiques.getRefGraphique(item.getIntitule().downcase))
        pixbufElement=pixbufElement.scale(40,40,Gdk::Pixbuf::INTERP_BILINEAR)
        image.set_pixbuf(pixbufElement)
        button.image = image
        tooltips.set_tip( button, item.description, nil )

        @vue.controller.equiperItemCreer(button,item,@modele.joueur,dialog,@momentCombat)
        dialog.vbox.add(button)
      }
      buttonCancel=Gtk::Button.new()
      buttonCancel.set_label("Cancel")
      buttonCancel.signal_connect('clicked'){
        @modele.declencherCombat(@momentCombat)
        dialog.destroy
      }
      dialog.vbox.add(buttonCancel)
      dialog.show_all
      dialog.run do |response|
      end
      false
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
    return XmlMultilingueReader.lireTexte("popupCombatModal")
  end

end

