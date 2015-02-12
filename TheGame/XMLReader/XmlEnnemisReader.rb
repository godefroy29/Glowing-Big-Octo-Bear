#COMOK
#!/usr/bin/env ruby 

## 
# Fichier        : XmlEnnemisReader.rb 
# Auteur         : L3SPI - Groupe de projet B 
# Fait partie de : TheGame 
# 
# Cette classe permet de parcourir le fichier XML des types d'ennemis et de les ajouter à la bibliothèque correspondante.
#

require 'MODELE/Bibliotheque/BibliothequeTypeEnnemi.rb'
require 'MODELE/Type/TypeEnnemi.rb'
require 'rexml/document'
include REXML

class XmlEnnemisReader
    
    

   ##
   #Méthode statique permettant de récupérer les caractéristiques des différents types d'Ennemi dans le fichier XML (types_ennemis.xml)
   #et de les ajouter à la bibliothèque de types d'Ennemi (classe BibliothequeTypeEnnemi).
   #
    def XmlEnnemisReader.lireXml()
        #Ouvre le fichier XML contenant les références 
        begin
            file = File.new("XMLFile/types_ennemis.xml")
            doc = Document.new(file)
            rescue
            puts "Impossible d'ouvrir le fichier XML des ennemis."
        end
        
        #Pour chaque référence du fichier XML...
        doc.elements.each('types_ennemis/type') do |s|
            #... on ajoute à la bibliothèque
            BibliothequeTypeEnnemi.ajouter(s.elements['intitule'].text,
                                           TypeEnnemi.creer(
                                                             s.elements['intitule'].text, 
                                                             s.elements['energieBase'].text.to_f
                                                             ))
        end
      return nil
    end
    
    
end
