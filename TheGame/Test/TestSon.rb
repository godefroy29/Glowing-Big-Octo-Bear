#!/usr/bin/env ruby 

## 
# Fichier        : TestJeu.rb 
# Auteur         : L3SPI - Groupe de projet B 
# Fait partie de : TheGame 
# 
# Cette classe permet de tester le jeu.
#

require 'VUE/Audio.rb'

Audio.load()
Audio.playSoundLoop("mario")

while(true)
   sleep 1
end
