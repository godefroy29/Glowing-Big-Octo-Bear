#COMOK
#!/usr/bin/env ruby 

## 
# Fichier        : XmlClassements.rb 
# Auteur         : L3SPI - Groupe de projet B 
# Fait partie de : TheGame 
# 
# Cette classe permet de parcourir le fichier XML des statistiques de chaque Joueur 
# et de les ajouter à la liste des joueurs classés (classe Classements).
#

require'VUE/Classements.rb'
require 'XMLReader/XmlMultilingueReader.rb'
require 'rexml/document'

include REXML

class XmlClassements


   ##
   #Méthode statique permettant de récupérer les statistiques des différents joueurs dans le fichier XML (classements.xml)
   #et de les ajouter à la liste des joueurs classés (classe Classements).
   #
   #===Paramètre :
   #* <b>listeStatsJoueurs :</b> la liste des statistiques à laquelle ajouter les statistiques lues à partir du fichier XML
   #
   def XmlClassements.lireXml(listeStatsJoueurs)
      #Ouvre le fichier XML contenant les statistiques de chaque joueur
      begin
         file = File.new("XMLFile/classements.xml")
         doc = Document.new(file)
      rescue
         raise "Impossible d'ouvrir le fichier XML des classements des joueurs."
      end

      #Pour chaque joueur du fichier XML...
      doc.elements.each('classements_joueur/joueur') do |j|
         #... on ajoute les stats à la liste des stats de chaque joueur
         listeStatsJoueurs.addJoueur(j.elements['nom'].text, j.elements['nb_ennemis_tues'].text.to_i,
         										j.elements['distance'].text.to_i, j.elements['or'].text.to_i,
         										j.elements['temps'].text.to_i, j.elements['score'].text.to_i,
         										j.elements['difficulte'].text)
      end

   end
   
   
   ##
   #Méthode statique permettant d'écrire les statistiques du joueur dans le fichier XML (classements.xml)
   #
   #===Paramètre :
   #* <b>modele :</b> le modele à partir duquel on récupère les statistiques du Joueur
   #
   def XmlClassements.ecrireXml(modele)
   	   	
      if(File.exist?("XMLFile/classements.xml") == false)# Création du fichier s'il n'existe pas
      	begin
	         file = File.open("XMLFile/classements.xml", "w")
	         file.syswrite("<?xml version = \"1.0\" encoding=\"UTF-8\" standalone=\"yes\" ?>\n\n")
		      file.syswrite("<!DOCTYPE classements_joueur [\n" +
									"<!ELEMENT classements_joueur (joueur+)>\n" +
									"<!ELEMENT joueur (nom, nb_ennemis_tues, distance, or, temps, score, difficulte)>\n" +
									"<!ELEMENT nom (#PCDATA)>\n" +
									"<!ELEMENT nb_ennemis_tues (#PCDATA)>\n" +
									"<!ELEMENT distance (#PCDATA)>\n" +
									"<!ELEMENT or (#PCDATA)>\n" +
									"<!ELEMENT temps (#PCDATA)>\n" +
									"<!ELEMENT score (#PCDATA)>\n" +
									"<!ELEMENT difficulte (#PCDATA)>\n" +
									"]>\n\n")
				doc = Document.new()
				doc.add_element("classements_joueur")
		      file.write(doc)
		      file.close
		   rescue
		   	raise "Impossible d'ouvrir le fichier XMLFile/classements.xml"
		   end
      end
      
      doc = Document.new(File.open("XMLFile/classements.xml"))
      
      joueur = Element.new("joueur")
      
      nom = Element.new("nom") 
      nom.text = modele.joueur.pseudo
      joueur.add_element(nom)
      
      nbEnnemisTues = Element.new("nb_ennemis_tues")
      nbEnnemisTues.text = modele.joueur.nbEnnemiTues
      joueur.add_element(nbEnnemisTues)
      
      dist = Element.new("distance")
      dist.text = modele.joueur.distanceParcourue
      joueur.add_element(dist)
      
      argent = Element.new("or")
      argent.text = modele.joueur.inventaire.capital
      joueur.add_element(argent)
      
      tps = Element.new("temps")
      tps.text = modele.joueur.tempsTotal
      joueur.add_element(tps)
      
      score = Element.new("score")
      
      # L'intitule de la difficulté est toujours en francais dans le Modele
      if(modele.difficulte.intitule == "Novice")
      	facteurDiff = 3
      elsif(modele.difficulte.intitule == "Moyen")
      	facteurDiff = 2
      else
      	facteurDiff = 1
      end
      score.text = ((modele.joueur.distanceParcourue*100 + modele.joueur.nbEnnemiTues*10) / facteurDiff)+
      					modele.joueur.inventaire.capital
      joueur.add_element(score)
      
      diff = Element.new("difficulte")
      diff.text = modele.difficulte.intitule
      joueur.add_element(diff)
      
      doc.root.add_element(joueur)
      
      # MAJ du fichier xml du classement des joueurs
	  begin
	      # w : Write-only, truncates existing file to zero length or creates a new file for writing.
	      file = File.open("XMLFile/classements.xml", "w")
	      file.write(doc)
	  rescue
			raise "Impossible d'ouvrir le fichier XMLFile/classements.xml"
	  ensure
			file.close
	  end

	end
	
end

