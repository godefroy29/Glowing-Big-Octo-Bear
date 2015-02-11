#COMOK
#!/usr/bin/env ruby

##
# Fichier : AffichageDebug.rb
# Auteur  : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de gérer un affichage de debugage.
#L'AffichageDebug se caractérisé par :
#* Un état d'activation : un booléen à vrai (true) si l'affichage de debugage doit être actif, à faux (false) le cas contraire
#

class AffichageDebug

  #=== Variable d'instance ===
  @@DebugOn=false
  
  ##
  # Permet d'activer l'affichage de debugage
  #
  def AffichageDebug.On()
    @@DebugOn=true
    return nil
  end
  
  ##
  # Permet de désactiver l'affichage de debugage
  #
  def AffichageDebug.Off()
    @@DebugOn=false
    return nil
  end
  
  
  ##
  # Permet d'afficher le message de debugage "message" si le debugage est actif
  #===Paramètre :
  #* <b>message :</b> le message de debugage à afficher si le debugage est actif
  #
  def AffichageDebug.Afficher(message)
    if(@@DebugOn)
      puts "AffichageDebug-next?"
      gets
      puts "Debug: "+message+"\n\t********\n"
    end
    return nil
  end
  
end
