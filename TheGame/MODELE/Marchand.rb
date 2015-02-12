#COMOK
#!/usr/bin/env ruby

##
# Fichier : Marchand.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de gérer des PNJ (Personnages Non Joueurs) Marchand.
#Les PNJ (Personnages Non Joueurs) Marchand sont caractérisés par :
#* Un pourcentage de reprise effectué sur les articles qu'il achète
#


require 'MODELE/Ami.rb'
require 'MODELE/Interface/Commercant.rb'
require 'MODELE/Type/TypeEquipable.rb'
require 'MODELE/Equipable.rb'
require 'MODELE/Type/TypeMangeable.rb'
require 'MODELE/Mangeable.rb'
require 'MODELE/Item.rb'
require 'MODELE/Bibliotheque/BibliothequeTypeEquipable.rb'
require 'MODELE/Bibliotheque/BibliothequeTypeMangeable.rb'
require 'MODELE/StockMarchand.rb'


class Marchand < Ami
   include Commercant

   #=== Variable d'instance ===
   @pourcentageReprise


   private_class_method :new #La construction se fera par la méhode de classe Marchand.creer(casePosition)

   ##
   #Crée un nouveau Marchand à partir des informations passées en paramètre.
   #
   #===Paramètre :
   #* <b>casePosition :</b> la case où se trouvera le PNJ Marchand
   #* <b>stock :</b> les items dont disposera le Marchand (les produit qu'il pourra proposer)
   #
   def initialize(casePosition,stock)
      super(casePosition)
      @intitule = "Marchand"
      @listeItem=stock
      @pourcentageReprise=0.8
   end
  
   
   ##
   #Crée un nouveau Marchand à partir des informations passées en paramètre.
   #
   #===Paramètre :
   #* <b>casePosition :</b> la case où se trouvera le PNJ Marchand
   #* <b>stock :</b> les items dont disposera le Marchand
   #===Retourne :
   #* <b>nouveauMarchand</b> : le nouveau Marchand créé
   #
   def Marchand.creer(casePosition,stock)
      return new(casePosition,stock)
   end
  
   
   ##
   # Permet au marchand d'acheter un item à un vendeur.
   #
   #===Paramètre :
   #* <b>vendeur :</b> le vendeur à qui on achéte l'item
   #* <b>item :</b> l'item acheté
   #
   def acheter(vendeur, item)
      vendeur.retirerDuStock(item)
      vendeur.encaisser((item.caracteristique.type.prix*@pourcentageReprise).to_i)
      AffichageDebug.Afficher("#{item} \nacheté à \n#{vendeur}")
      return nil
   end

   
   ##
   # Permet au marchand de vendre un item à un acheteur.
   #
   #===Paramètre :
   #* <b>acheteur :</b> l'acheteur à qui on vend l'item
   #* <b>item :</b> l'item vendu
   #
   def vendre(acheteur, item)
      #acheteur.ajouterAuStock(item)
      #acheteur.debourser(item.caracteristique.type.prix)
      acheteur.acheter(item) #AFR
      AffichageDebug.Afficher("#{item} \nvendu à \n#{acheteur}")
      return nil
   end
 
    
   ##
   # Permet au marchand d'ajouter un item à son stock.
   #
   #===Paramètre :
   #* <b>item :</b> l'item à ajouter au stock
   #
   def ajouterAuStock(item)
      return nil
   end
   
   
   ##
   #Permet au marchand de retirer un item de son stock.
   #
   #===Paramètre :
   #* <b>item :</b> l'item à retirer du stock
   #
   def retirerDuStock(item)
      return nil
   end
   

   ##
   #Permet au Marchand d'encaisser une somme d'argent "revenu"
   #
   #===Paramètre :
   #* <b>revenu :</b> la somme d'argent à encaisser
   #
   def encaisser(revenu)
         return nil
   end
    
   ##
   ##
   #Permet au Marchand de décaisser une somme d'argent "somme"
   #
   #===Paramètre :
   #* <b>revenu :</b> la somme d'argent à décaisser
   #
   def debourser(somme)
       return nil
   end
   

   ##
   #Permet au Marchand d'interargir avec le Joueur "joueur" passé en paramètre (acheter/vendre des Item)
   #
   #===Paramètre :
   #* <b>joueur</b> : le joueur avec lequel le Guerisseur doit interargir
   #
   def interaction(joueur)
     joueur.modele.pnjAideEnInteraction=self  
     joueur.modele.changerStadePartie(EnumStadePartie.INTERACTION_MARCHAND)
   end
   

   ##
   #Renvoie une chaîne de caractères représentant ce que peux faire un Marchand (exemple : "Je peux faire de l'achat/revente")
   #
   #===Retourne :
   #* <b>descMarchand</b> : une chaîne de caractères représentant ce que peux faire un Marchand
   #
   def description
      s=XmlMultilingueReader.lireTexte("descMarchand")
   end


   ##
   #Retourne une chaîne de caractères représentant le Marchand courant
   #
   #===Retourne :
   #* <b>s</b> : une chaîne de caractères représentant le Marchand courant (intitulé, position sur la Carte et liste de ses Item encadré de [==Marchand >>> | et <<< Marchand==])
   #
   def to_s
      s= "[==Marchand >>> |"
      s+= super()
     s+= "Items: "
     if(@listeItem.itemsStock.empty?)
       s+= "aucun "
     end
     for i in @listeItem.itemsStock
       s+= "#{i}, "
     end
     s+="| "
      s+= "<<< Marchand==]"
   end
  
end
