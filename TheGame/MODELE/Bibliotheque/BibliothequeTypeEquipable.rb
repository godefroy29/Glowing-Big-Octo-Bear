#COMOK
#!/usr/bin/env ruby

##
# Fichier : BibliothequeTypeEquipable.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame
#
#===Cette classe représente la bibliothèque des types équipables définie par:
#* Une table de hachage statique contenant les TypeEquipable (les clés sont des intitulés sous forme de chaine de caractères)
#



class BibliothequeTypeEquipable

   @@tableType = Hash.new()

   private_class_method :new
    
   
   ##
   #Ajouter un TypeEquipable dans la bibliothèque (écrase si déjà présente).
   #
   #===Paramètres:
   #* <b>cle :</b> la clé du TypeEquipable à ajouter
   #* <b>type :</b> le type du TypeEquipable à ajouter
   #
   def BibliothequeTypeEquipable.ajouter(cle,type)
     AffichageDebug.Afficher("Ajout dans BibliothequeTypeEquipable-> clé:#{cle}, type:#{type}")
     @@tableType[cle] = type
     return self
   end
   
   
   ##
   #Retirer un TypeEquipable de la bibliothèque.
   #
   #===Paramètres:
   #* <b>cle :</b> la clé du TypeEquipable à retirer
   #
   def BibliothequeTypeEquipable.retirer(cle)
     AffichageDebug.Afficher("Suppression dans BibliothequeTypeEquipable-> clé:#{cle}")
     @@tableType.delete(cle)
     return self
   end
   
   
   ##
   #Permet de recuperer un TypeEquipable de la bibliothèque.
   #
   #===Paramètres:
   #* <b>cle :</b> la clé du TypeEquipable souhaitée
   #
   #===Retourne:
   #* <b>TypeEquipable :</b> le TypeEquipable souhaité
   #
   def BibliothequeTypeEquipable.getTypeEquipable(cle)
      return @@tableType[cle]
   end
   
   def BibliothequeTypeEquipable.getTypes()
     return @@tableType.values()
   end
   
   
   ##
   #Permet de recuperer un TypeEquipable au hasard
   #
   #===Retourne:
   #* <b>TypeEquipable :</b> un TypeEquipable au hasard
   #
   def BibliothequeTypeEquipable.getTypeEquipableAuHasard()
      valeurs=@@tableType.values()
      return valeurs[rand(valeurs.length)]
   end
   
   
   ##
   #Permet de recuperer un TypeEquipable au hasard suivant sa rareté.
   #
   #===Paramètres:
   #* <b>rareteMin :</b> valeur minimum de rareté
   #* <b>rareteMax :</b> valeur maximum de rareté
   #
   #===Retourne:
   #* <b>TypeEquipable :</b> le TypeEquipable au hasard
   #
   def BibliothequeTypeEquipable.getTypeEquipableAuHasardRarete(rareteMin,rareteMax)
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

