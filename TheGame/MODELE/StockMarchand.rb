#COMOK
#!/usr/bin/env ruby

##
# Fichier : StockMarchand.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de gérer un StockMarchand
#Un StockMarchand est caractérisé par :
#* Un tableau des Items que contient le StockMarchand
#


require 'AffichageDebug.rb'
require 'MODELE/Item.rb'
require 'MODELE/Bibliotheque/BibliothequeTypeEquipable.rb'
require 'MODELE/Bibliotheque/BibliothequeTypeMangeable.rb'
require 'XMLReader/XmlEquipablesReader.rb'
require 'XMLReader/XmlMangeablesReader.rb'

class StockMarchand

  #=== Variable d'instance === 
  @itemsStock
  
  private_class_method :new #La construction se fera par la méhode de classe StockMarchand.creer()
  
  attr_reader :itemsStock 
   
   ##
   #Crée un nouveau StockMarchand
   #
   def initialize()
      @itemsStock=Array.new()
      caracteristiquesDuJeu=BibliothequeTypeEquipable.getTypes()
      for c in caracteristiquesDuJeu
         caract = Equipable.creer(c)
         @itemsStock.push(Item.creer(nil,caract))
      end
      caracteristiquesDuJeu=BibliothequeTypeMangeable.getTypes()
      for c in caracteristiquesDuJeu
         caract = Mangeable.creer(c)
         @itemsStock.push(Item.creer(nil,caract))
       end
   end

   ##
   #Crée un nouveau StockMarchand
   #
   #===Retourne :
   #* <b>nouveauStockMarchand</b> : le nouveau StockMarchand créé
   #  
   def StockMarchand.creer()
      return new()
   end
    
   ##
   #Crée un nouvel Item aillant la même Caracteristique que l'Item du StockMarchand d'indice i
   #
   #===Paramètre :
   #* <b>i</b> : l'indice de l'Item dans le StockMarchand
   #===Retourne :
   #* <b>nouvelItem</b> : le nouvel Item créé par la méthode
   #  
   def genererItem(i)
      return Item.creer(nil,@itemsStock[i].caracteristique)
   end
  

end

