#COMOK
#!/usr/bin/env ruby

##
# Fichier : Caracteristique.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe abstraite permettant de définir les caractéristique des Item.
#Les Caracteristique des Item se définissent par :
#* Leur capacité à être stockée
#* Leur capacité à être mangée
#* Leur capacité à être utilisée
#


class Caracteristique
    
   private_class_method :new #Il n'est pas possible d'instancer une Caracteristique par le biais de la méhode new depuis l'extérieur
    
    
    ##
    # Appel de la méthode initialize.
    #
    def Caracteristique.creer()
       if(self.class==Caracteristique)
          raise "Subclass responsability"
       end
       return new()
    end
    
    
   ##
   #(Abstraite) Renvoie le nom commun de la Caracteristique courante.
   #
   #===Retourne :
   #* <b>intitule</b> : le nom commun de la Caracteristique courante
   #
   def getIntitule()
   end
    
    
   ##
   #(Abstraite) Fait en sorte que le Joueur utilise l'Item possédant cette Caracteristique.
   #
   #===Paramètre :
   #* <b>joueur</b> : un objet Joueur corespondant au joueur qui utilise l'item
   #
   def utiliseToi(joueur)
   end
    

   ##
   #Permet de déterminer si l'Item possédant cette Caracteristique peut être stockée ou non.
   #
   #===Retourne :
   #* <b>isStockable</b> : un booléen à vrai (true) si l'Item possédant cette Caracteristique peut être stockée, à faux (false) le cas contraire
   #
    def estStockable?()
        return true
    end
    

   ##
   #Permet de déterminer si l'Item possédant cette Caracteristique peut équiper le Joueur ou non (exemple : une épée).
   #
   #===Retourne :
   #* <b>isEquipable</b> : un booléen à vrai (true) si l'Item possédant cette Caracteristique peut équiper le Joueur, à faux (false) le cas contraire
   #
   def estEquipable?()
      return false
   end
    

   ##
   #(Abstraite) Retourne une chaîne de caractères représentant les différentes caractéristiques de la Caracteristique courante
   #
   #===Retourne :
   #* <b>s</b> : une chaîne de caractères représentant la Caracteristique courante
   #
   def to_s
   end

    
end
