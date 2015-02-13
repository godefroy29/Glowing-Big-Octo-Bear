#COMOK
#!/usr/bin/env ruby

##
# Fichier : Inventaire.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de représenter un Inventaire.
#Un Inventaire est caractérisé par :
#* Un capital : somme d'argent dont dispose le propriétaire de l'inventaire
#* Un tableau d'Item
#* Une taille : nombre maximal d'Item stockables dans l'Inventaire
#* Une nombre d'Item : nombre d'Item que contient l'Inventaire à un instant t
#


class Inventaire


  #=== Variables d'instance ===
  @capital
  @items
  @taille
  @nbItem
  

   private_class_method :new #La construction se fera par la méhode de classe Inventaire.creer(taille)
  
   attr_reader :items, :taille, :nbItem
   attr_accessor :capital
  

   ##
   #Permet de créer un nouvel Inventaire à partir des informations passées en paramètre.
   #
   #===Paramètre :
   #* <b>taille :</b> la capacité de l'Inventaire (nombre maximal d'Item stockables dans l'Inventaire)
   #
   def initialize(taille)
     @capital=0
     @items=Array.new()
     @taille=taille
     @nbItem=0
   end

  
   ##
   #Crée un nouvel Inventaire à partir des informations passées en paramètre.
   #
   #===Paramètre :
   #* <b>taille :</b> la capacité de l'Inventaire (nombre maximal d'Item stockables dans l'Inventaire)
   #===Retourne :
   #* <b>nouvelInventaire</b> : le nouvel Inventaire créé
   #
   def Inventaire.creer(taille)
     new(taille)
   end
  
  
   ##
   #Permet de récupérer l'Item placé à l'indice "indice" de l'Inventaire courant.
   #
   #===Paramètre :
   #* <b>indice :</b> l'indice de l'Item de l'Inventaire à récupérer
   #===Retourne :
   #* <b>itemIndice</b> : l'Item de l'Inventaire situé à l'indice "indice"
   #
   def getItem(indice)
      return @items.fetch(indice)
   end

  
   ##
   #Ajoute l'Item passé en paramètre à l'Inventaire courant
   #
   #===Paramètre :
   #* <b>item :</b> l'Item à ajouter à l'Inventaire courant
   #
   def ajouter(item)
      if(!self.estPlein?())
         @items.push(item)
         @nbItem=@nbItem+1
         AffichageDebug.Afficher("Ajout de \n#{item} dans \n#{self}")
         return nil
      end
   end
  
  
   ##
   #Retire l'Item passé en paramètre de l'Inventaire courant
   #
   #===Paramètre :
   #* <b>item :</b> l'Item à retirer de l'Inventaire courant
   #
   def retirer(item)
      @items.delete(item)
      @nbItem=@nbItem-1
      AffichageDebug.Afficher("Retrait de \n#{item} de \n#{self}")
      return nil
   end
  

   ##
   #Retourne le prix de l'Item placé a l'indice "i" dans l'Inventaire courant
   #
   #===Paramètre :
   #* <b>i :</b> l'indice de l'Item dont on souhaite connaître le prix
   #
   def prix(i)
     return @items.fetch(i).caracteristique.prix
   end

  
   ##
   #Retire l'item de l'inventaire placé à l'indice "indice" passé en paramètre
   #
   #===Paramètre :
   #* <b>i :</b> l'indice de l'Item  à supprimer de l'Inventaire courant
   #===Retourne :
   #* <b>itemJette</b> : l'Item jetté ou nil en cas d'indice invalide 
   #
   def retirer_at(indice)
      itemJette = @items.delete_at(indice)
      if itemJette != nil
         @nbItem=@nbItem-1
      end
      return itemJette
   end
  
  
   ##
   #Permet de déterminer si l'Inventaire courant est plein
   #
   #===Retourne :
   #* <b>isFull</b> : un booléen à vrai (true) si l'Inventaire est pleine, à faux (false) le cas contraire
   #
   def estPlein?()
     return @nbItem >= @taille
   end
  
  
   ##
   #Retourne une chaîne de caractères représentant l'Inventaire courant
   #
   #===Retourne :
   #* <b>s</b> : une chaîne de caractères représentant l'Inventaire courant (la liste des Item que contient l'Inventaire entouré de [==Inventaire >>> | et <<< Inventaire==])
   #
   def to_s
     s= "[==Inventaire  >>> | "
     s+= "Taille: #{@taille} | "
     s+= "Capital: #{@capital} | "
     s+= "Items: "
     if(@nbItem==0)
       s+="aucun "
     end
     for i in @items
       s+= "#{i} ,"
     end
     s+="| "
     s+="<<< Inventaire==]"
     return s
   end

end

