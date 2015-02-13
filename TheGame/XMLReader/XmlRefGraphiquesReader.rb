#COMOK
#!/usr/bin/env ruby 

## 
# Fichier        : XmlRefGraphiquesReader.rb 
# Auteur         : L3SPI - Groupe de projet B 
# Fait partie de : TheGame 
# 
# Cette classe permet de parcourir le fichier XML des références graphiques et le les ajouter à la "bibliothèque" RefGraphiques (classe RefGraphiques).
#

require 'VUE/ReferencesGraphiques.rb'
require 'rexml/document'
include REXML


class XmlRefGraphiquesReader


   ##
   # Méthode statique permettant de récupérer les références graphiques des différentes éléments d'affichages du jeu
   # et de les ajouter à la bibliothèque d'images du jeu (bibliothèque RefGraphiques).
   #
	#=== Paramètres:
	#* <b>biblioRefGgraphiques</b> : la classe ReferencesGraphiques
	#
   def XmlRefGraphiquesReader.lireXml(biblioRefGgraphiques)
      #Ouvre le fichier XML contenant les références graphiques des différents éléments
      begin
         file = File.new("XMLFile/references_graphiques.xml")
         doc = Document.new(file)
      rescue
         raise "Impossible d'ouvrire le fichier XML des références graphiques."
      end

      #Pour chaque référence du fichier XML...
      doc.elements.each('ref_graphiques/reference') do |s|
         #... on ajout la référence à la bibliothèque
         biblioRefGgraphiques.addRefGraphique(s.elements['intitule_objet'].text,s.elements['img_ihm'].text)
      end
		return nil
   end

end
