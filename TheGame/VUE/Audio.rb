#COMOK
#!/usr/bin/env ruby

##
# Fichier : Audio.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
#===Cette classe représente la gestion des sons du jeu définie par :
#* Une liste des sons chargés en mémoire
#* Une liste contenant la référence du channel de chacun des sons
#* Une variable contenant la musique de fond du jeu
#

require 'sdl'
require 'XMLReader/XmlRefSonsReader.rb'

class Audio
   
   @@listSoundLoad = Hash.new()
   @@listRefChannel = Hash.new()
   @firstSound
   
   private_class_method :new
   
   
   ##
   #Permet de charger tous les sons en mémoire
   #
   def Audio.load()
      SDL::init(SDL::INIT_AUDIO) # Initialisation de l'audio SDL
      SDL::Mixer.open(22050, SDL::Mixer::DEFAULT_FORMAT, 2, 1024) # Ouverture du Mixer SDL
      XmlRefSonsReader.lireXml(@@listSoundLoad, @@listRefChannel) # Chargement des sons
      @firstSound = ""
      return self
   end
   
   
   ##
   #Permet de jouer un son
   #
   #===Paramètres:
   #* <b>intitule :</b> une chaine de caractères correspondant au nom du son à jouer
   #
   def Audio.playSound(intitule)
      SDL::Mixer.play_channel(@@listRefChannel[intitule], @@listSoundLoad[intitule], 0)
      return self
   end
   
   
   ##
   #Permet de jouer un son en boucle (Musique de fond)
   #
   #===Paramètres:
   #* <b>intitule :</b> une chaine de caractères correspondant au nom du son à jouer en boucle
   #
   def Audio.playSoundLoop(intitule)
      @firstSound = intitule
      SDL::Mixer.play_channel(@@listRefChannel[intitule], @@listSoundLoad[intitule], -1)
      return self
   end
   
   
   ##
   #Permet de desactiver la musique de fond
   #
   def Audio.muteSoundLoop()
      if(@firstSound != "")
         SDL::Mixer.set_volume(@@listRefChannel[@firstSound], 0)
      end
      return self
   end
   
   
   ##
   #Permet de reactiver la musique de fond
   #
   def Audio.resumeSoundLoop()
      if(@firstSound != "")
         SDL::Mixer.set_volume(@@listRefChannel[@firstSound], 128)
      end
      return self
   end
   
   
   ##
   #Permet de desactiver les bruitages
   #
   def Audio.muteBruitage()
      @@listSoundLoad.each {|key, s| 
         if(key != @firstSound)
            SDL::Mixer.set_volume(@@listRefChannel[key], 0)
         end
      }
      return self
   end
   
   
   ##
   #Permet de reactiver les bruitages
   #
   def Audio.resumeBruitage()
      @@listSoundLoad.each {|key, s| 
         if(key != @firstSound)
            SDL::Mixer.set_volume(@@listRefChannel[key], 128)
         end
      }
      return self
   end
   
   
   ##
   #Permet de réactiver tous les sons (Musique de fond + bruitages)
   #
   def Audio.activeSound()
      SDL::Mixer.set_volume(-1, 128)
      return self
   end 
   
   
   ##
   #Permet de désactiver tous les sons (Musique de fond + bruitages)
   #
   def Audio.mute()
      SDL::Mixer.set_volume(-1, 0)
      return self
   end
    
     
   ##
   #Permet de mettre en pause tous les sons (Musique de fond + bruitages)
   #
   def Audio.pause()
      SDL::Mixer.pause(-1)
      return self
   end
   
   
   ##
   #Permet de reprendre tous les sons mis en pause (Musique de fond + bruitages)
   #
   def Audio.resume()
      SDL::Mixer.resume(-1)
      return self
   end
   
   
   ##
   #Permet d'arreter tous les sons (Musique de fond + bruitages)
   #
   def Audio.stop()
      SDL::Mixer.halt(-1)
      return self
   end
   
end