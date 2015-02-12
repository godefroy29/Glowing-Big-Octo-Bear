#COMOK
#!/usr/bin/env ruby

##
# Fichier : BibliothequeTypeMangeable.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
#===Cette classe représente la bibliothèque des types mangeable définie par:
#* Une table de hachage statique contenant les TypeMangeable (les clés sont des intitulés sous forme de chaine de caractères)
#

class BibliothequeTypeMangeable

   @@tableType = Hash.new()

   private_class_method :new
    
   
   ##
   #Ajouter un TypeMangeable dans la bibliothèque (écrase si déjà présente).
   #
   #===Paramètres:
   #* <b>cle :</b> la clé du TypeMangeable à ajouter
   #* <b>type :</b> le type du TypeMangeable à ajouter
   #
   def BibliothequeTypeMangeable.ajouter(cle,type)
     AffichageDebug.Afficher("Ajout dans BibliothequeTypeMangeable-> clé:#{cle}, type:#{type}")
     @@tableType[cle] = type
     return self
   end
   
   
   ##
   #Retirer un TypeMangeable de la bibliothèque.
   #
   #===Paramètres:
   #* <b>cle :</b> la clé du TypeMangeable à retirer
   #
   def BibliothequeTypeMangeable.retirer(cle)
     AffichageDebug.Afficher("Suppression dans BibliothequeTypeMangeable-> clé:#{cle}")
     @@tableType.delete(cle)
     return self
   end
   
   
   ##
   #Permet de recuperer un TypeMangeable de la bibliothèque par rapport à sa clé
   #
   #===Paramètres:
   #* <b>cle :</b> la clé du TypeMangeable souhaité
   #
   #===Retourne:
   #* <b>TypeMangeable :</b> le TypeMangeable souhaité
   #
   def BibliothequeTypeMangeable.getTypeMangeable(cle)
      return @@tableType[cle]
   end
   
   
   ##
   #Permet de recuperer le TypeMangeable de la bibliothèque.
   #
   #===Retourne:
   #* <b>TypeMangeable :</b> le TypeMangeable de la bibliothèque
   #
   def BibliothequeTypeMangeable.getTypes()
     return @@tableType.values()
   end
   
   
   ##
   #Permet de recuperer un TypeMangeable de la bibliothèque au hasard. 
   #
   #===Retourne:
   #* <b>TypeMangeable :</b> un TypeMangeable au hasard
   #
   def BibliothequeTypeMangeable.getTypeMangeableAuHasard()
      valeurs=@@tableType.values()
      return valeurs[rand(valeurs.length)]
   end
   
   ##
   #Permet de recuperer un TypeMangeable au hasard suivant sa rareté.
   #
   #===Paramètres:
   #* <b>rareteMin :</b> valeur minimum de rareté
   #* <b>rareteMax :</b> valeur maximum de rareté
   #
   #===Retourne:
   #* <b>TypeMangeable :</b> le TypeMangeable au hasard
   #
   def BibliothequeTypeMangeable.getTypeMangeableAuHasardRarete(rareteMin,rareteMax)
      valeurs=@@tableType.values()
      valeursPossible=Array.new()
      for v in valeurs
        if(v.rarete<=rareteMax && v.rarete>=rareteMin)
          valeursPossible.push(v)
        end
      end
      return valeursPossible[rand(valeursPossible.length)]
   end

end


