#COMOK
#!/usr/bin/env ruby

##
# Fichier : Item.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de représenter un Item.
#Un Item est caractérisé par :
#* Une Caracteristique
#

require 'MODELE/Elem.rb'

class Item < Elem


   #=== Variable d'instance ===
   @caracteristique
   #@selected #AFR : à supprimer
   
   attr_reader :caracteristique

   private_class_method :new #La construction se fera par la méhode de classe Item.creer(casePosition, caracteristique)
   

   ##
   #Crée un nouvel Item à partir des informations passées en paramètre.
   #
   #===Paramètre :
   #* <b>casePosition :</b> la case où se trouvera le nouvel Item
   #* <b>caracteristique :</b> la caracteristique du nouvel Item
   #
   def initialize(casePosition, caracteristique)
      super(casePosition)
      @caracteristique = caracteristique
   end
   

   ##
   #Permet de créer un nouvel Item à partir des informations passées en paramètre.
   #
   #===Paramètre :
   #* <b>casePosition :</b> la case où se trouvera le nouvel Item
   #* <b>caracteristique :</b> la caracteristique du nouvel Item
   #
   def Item.creer(casePosition, caracteristique)
      new(casePosition, caracteristique)
   end


   ##
   #Renvoie le nom commun de l'Item courant
   #
   #===Retourne :
   #* <b>intitule</b> : le nom commun de l'Item courant
   #
   def getIntitule()
      return @caracteristique.getIntitule()
   end



   ##
   #Fait en sorte que le Joueur utilise l'Item.
   #
   #===Paramètre :
   #* <b>joueur</b> : un objet Joueur corespondant au joueur qui utilise l'Encaissable
   #
   def utiliseToi(joueur)
      #L'utilisation de l'Item dépend de sa Caracteristique
      @caracteristique.utiliseToi(joueur)
      joueur.inventaire.retirer(self)
      return nil
   end


   ##
   #Permet de déterminer si l'Item peut être stocké ou non.
   #
   #===Retourne :
   #* <b>isStockable</b> : un booléen à vrai (true) si l'Item courant peut être stocké, à faux (false) le cas contraire
   #  
   def estStockable?()
       return @caracteristique.estStockable?()
   end
   

   ##
   #Permet de déterminer si l'Item peut équiper le Joueur ou non (exemple : une épée).
   #
   #===Retourne :
   #* <b>isEquipable</b> : un booléen à vrai (true) si l'Item peut équiper le Joueur, à faux (false) le cas contraire
   # 
   def estEquipable?()
         return @caracteristique.estEquipable?()
   end
    
   #AFR : supprimer ces deux méthodes
   #def selectionner()
   #    selected = true
   #end
   #def deselectionner()
   #     selected = true
   #end
   

   ##
   #Renvoie une chaîne de caractères représentant ce que peux faire l'Item courant (exemple : "Apporte X d'énergie")
   #
   #===Retourne :
   #* <b>descItem</b> : une chaîne de caractères représentant ce que peux faire l'Item courant
   #
   def description
     return "#{@caracteristique.to_s}"
   end



   ##
   #Permet à l'Item d'interargir avec le Joueur "joueur" passé en paramètre (se faire ramasser par le Joueur)
   #
   #===Paramètre :
   #* <b>joueur</b> : le joueur avec lequel l'Item doit interargir
   #
   def interaction(joueur)
     pleinTmp=joueur.inventaire.estPlein?()
     if(estStockable?())
       joueur.ramasserItem(self)
     else
       @caracteristique.utiliseToi(joueur)
       joueur.casePosition.retirerElement(self)
       joueur.modele.tourPasse()
     end
     @casePosition=nil
     if(pleinTmp==false)
         joueur.modele.debutTour()
      end
     joueur.modele.vue.actualiser
     return nil
   end

   
   ##
   #Retourne une chaîne de caractères représentant les différentes caractéristiques de l'Item courant
   #
   #===Retourne :
   #* <b>s</b> : une chaîne de caractères représentant l'Item courant (position sur la Carte et Caracteristique entourées par [==Item >>> | et par <<< Item==])
   #
   def to_s
      s= "[==Item >>> | "
      s+= super()
      s+= "Caracteristique: #{@caracteristique} | "
      s+= "<<< Item==]"
   end

end
