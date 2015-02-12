#COMOK
#!/usr/bin/env ruby 

## 
# Fichier        : BibliothequeSlot.rb 
# Auteur         : L3SPI - Groupe de projet B 
# Fait partie de : TheGame 
# 
#===Cette classe permet de creer un tableau de hashage contenant les infos des slots de sauvegarde. Elle contient donc :
#* Un tableau de hashage representant chaque sauvegarde avec en cle le nom du fichier du slot de sauvegarde et en valeur, le slot en lui meme.
#


class BibliothequeSlot

   @@tableSlots = Hash.new()

   private_class_method :new
   
   
   ##
   #Ajouter un slot dans la bibliothèque (écrase si déjà présente).
   #
   #===Paramètres:
   #* <b>cle :</b> la clé du slot
   #* <b>slot :</b> le slot
   #
   def BibliothequeSlot.ajouter(cle,slot)
      @@tableSlots[cle] = slot
      return self
   end
   
   
   ##
   #Retirer un slot de la bibliothèque.
   #
   #===Paramètres:
   #* <b>cle :</b> la clé du slot à retirer
   #
   def BibliothequeSlot.retirer(cle)
      @@tableSlots.delete(cle)
      return self
   end
   
   
   ##
   #Retourne la valeur de la cle (nom fichier slotX.yaml) fournie en parametre
   #
   #===Paramètres:
   #* <b>cle :</b> la clé du slot
   #
   #===Retourne:
   #* <b>valeur :</b> la valeur du slot
   #
   def BibliothequeSlot.getSlot(cle)
      return @@tableSlots[cle]
   end

end

