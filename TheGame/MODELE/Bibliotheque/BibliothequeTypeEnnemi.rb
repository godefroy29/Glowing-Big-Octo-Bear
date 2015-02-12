#COMOK
#!/usr/bin/env ruby

##
# Fichier : BibliothequeTypeEnnemi.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
#===Cette classe représente la bibliothèque des types d'ennemi définie par:
#* Une table de hachage statique contenant les types d'ennemi (les clés sont des intitulés sous forme de chaine de caractères)
#

class BibliothequeTypeEnnemi

   @@tableType = Hash.new()

   private_class_method :new
   
   
   ##
   #Ajouter un TypeEnnemi dans la bibliothèque (écrase si déjà présente).
   #
   #===Paramètres:
   #* <b>cle :</b> la clé de l'Ennemi à ajouter
   #* <b>type :</b> le type du TypeEnnemi à ajouter
   #
   def BibliothequeTypeEnnemi.ajouter(cle,type)
      AffichageDebug.Afficher("Ajout dans BibliothequeTypeEnnemi-> clé:#{cle}, type:#{type}")
      @@tableType[cle] = type
      return self
   end

   
   ##
   #Retirer un TypeEnnemi de la bibliothèque.
   #
   #===Paramètres:
   #* <b>cle :</b> la clé de l'Ennemi à retirer
   #
   def BibliothequeTypeEnnemi.retirer(cle)
      AffichageDebug.Afficher("Suppression dans BibliothequeTypeEnnemi-> clé:#{cle}")
      @@tableType.delete(cle)
      return self
   end

   
   ##
   #Permet de recuperer un TypeEnnemi de la bibliothèque.
   #
   #===Paramètres:
   #* <b>cle :</b> la clé du TypeEnnemi souhaité
   #
   #===Retourne:
   #* <b>TypeEnnemi :</b> le TypeEnnemi souhaité
   #
   def BibliothequeTypeEnnemi.getTypeEnnemi(cle)
      return @@tableType[cle]
   end

   
   ##
   #Permet de recuperer un TypeEnnemi de la bibliothèque au hasard
   #
   #===Retourne:
   #* <b>TypeEnnemi :</b> un TypeEnnemi au hasard
   #
   def BibliothequeTypeEnnemi.getTypeEnnemiAuHasard()
      valeurs=@@tableType.values()
      return valeurs[rand(valeurs.length)]
   end

end
