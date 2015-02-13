#COMOK
#!/usr/bin/env ruby

##
# Fichier : Encaissable.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de représenter la Caractéristique Encaissable définie par
#* Un montant
#* Un intitule


require 'MODELE/Caracteristique.rb'
require 'MODELE/Joueur.rb'


class Encaissable < Caracteristique


   #=== Variable d'instance ===
   @montant
   @intitule

   attr_reader :montant
      
   private_class_method :new #La construction se fera par la méhode de classe Encaissable.creer(montant)


   ##
   #Crée un nouvel Encaissable comportant pour montant le montant passé au paramètre
   #
   #=== Paramètres:
   #* <b>montant</b> : le montant qui sera reversé lorsque l'Encaissable sera encaissé
   #
   def initialize(montant)
      super()
      @montant=montant
      @intitule="Bourse"
   end

   
   ##
   #Permer de créer un nouvel Encaissable comportant pour montant le montant passé au paramètre
   #
   #=== Paramètres:
   #* <b>montant</b> : le montant qui sera reversé lorsque l'Encaissable sera encaissé
   #===Retourne :
   #* <b>nouvelEncaissable</b> : le nouvel Encaissable créé
   #
   def Encaissable.creer(montant)
      new(montant)
   end


   ##
   #Renvoie le nom commun de l'Encaissable courant (permet d'accéder à l'image lui correspondant dans la table de RefGraphiques)
   #
   #===Retourne :
   #* <b>intitule</b> : le nom commun de l'Encaissable courant
   #   
   def getIntitule()
      return @intitule
   end


   ##
   #Permet de déterminer si l'Encaissable peut être stocké ou non.
   #
   #===Retourne :
   #* <b>isStockable</b> : un booléen à faux (false) (nous ne stockerons pas les encaissables)
   #
   def estStockable?()
      return false
   end
   

   ##
   #Fait en sorte que le Joueur utilise l'Encaissable (encaisse son montant).
   #
   #===Paramètre :
   #* <b>joueur</b> : un objet Joueur corespondant au joueur qui utilise l'Encaissable
   #
   def utiliseToi(joueur)
      joueur.inventaire.capital=joueur.inventaire.capital+@montant
      str=XmlMultilingueReader.lireTexte("encaissement")
      str=str.gsub("MONTANT",@montant.to_s())
      joueur.modele.notifier(str)
      return nil
   end

   
   ##
   #Retourne une chaîne de caractères représentant l'Encaissable courant
   #
   #===Retourne :
   #* <b>s</b> : une chaîne de caractères représentant l'Encaissable courant (intitulé et montant)
   #
   def to_s
      s=XmlMultilingueReader.lireTexte("to_sEncaissable")
      s=s.gsub("INTITULE",@intitule).gsub("OR",@montant.to_s)
      return s
   end


end
