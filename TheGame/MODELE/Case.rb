#COMOK
#!/usr/bin/env ruby

##
# Fichier : Case.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de représenter une Case.
#Une Case se caractérise par :
#* Un nombre maximal d'ennemis
#* Une abscisse x
#* Une ordonnée y
#* Une liste d'éléments Elt
#* Une liste d'Ennemi
#* Une référence vers la Carte à laquelle elle appartient
#* Un type de terrain TypeTerrain
#* Un Joueur éventuel


require 'MODELE/Enum/EnumDirection.rb'


class Case
  
  
   #=== Variable de classe ===
   @@NombreMaxElementsEnnemis = 5
   #=== Variable d'instance ===
   @coordonneeX
   @coordonneeY
   @listeElements
   @listeEnnemis
   @carte
   @typeTerrain
   @joueur


   attr_reader :listeEnnemis, :listeElements, :coordonneeX, :coordonneeY
   attr_accessor :typeTerrain,:joueur
  
   private_class_method :new #La construction se fera par la méhode de classe Case.nouvelle(x,y,carte,typeDefaut)


   ##
   #Crée une nouvelle Carte à partir des informations passées en paramètres. Pour le moment le type est aléatoire.
   #
   # == Paramètres:
   #* <b>x</b> : l'abscisse de la Case
   #* <b>y</b> : l'ordonnée de la Case
   #* <b>Carte</b> : la Carte à laquelle sera rattaché la Case
   #* <b>id_terrainDef :</b> l'identifiant du typeTerrain par défaut
   #
   def initialize(x,y,carte,typeDefaut)
      @carte = carte
      @coordonneeX = x
      @coordonneeY = y
      @listeEnnemis = Array.new()
      @listeElements = Array.new()
      @typeTerrain = BibliothequeTypeTerrain.getTypeTerrain(typeDefaut)
      if @typeTerrain==nil 
	puts 'Grosse erreur'
      end
   end


   ##
   #Permet de créer une nouvelle Case à partir des informations passées en paramètres.
   #
   # == Paramètres :
   #* <b>x</b> : l'abscisse de la Case
   #* <b>y</b> : l'ordonnée de la Case
   #* <b>Carte</b> : la Carte à laquelle sera rattaché la Case
   #* <b>id_terrainDef :</b> l'identifiant du typeTerrain par défaut
   #
   #===Retourne :
   #* <b>nouvelleCase</b> : la nouvelle Case créée
   #
   def Case.nouvelle(x,y,carte,typeDefaut)
     return new(x,y,carte,typeDefaut)
   end

  
   ##
   #Permet de maintenir à jour la liste d'Ennemi de la Case : parcours la liste des Ennemi que contient la Case et supprime tous ceux qui ne sont plus vivant.
   #
   def verifEnnemis
      for e in listeEnnemis
         if(!e.vivant)
	    e.meurt
	    listeEnnemis.delete(e)
	 end
      end
   end
   
  ##
  #Renvoi le niveau de priorité du terrain
  #
  #===Retourne :
  #* <b>niveau</b> : le niveau du type de terrain
  #
  def getNumTerrain()
     return @typeTerrain.niveau
  end
  

   ##
   #Permet de tester si la Case est accessible ou non.
   #
   #===Retourne :
   #* <b>isAccessible</b> : un booléen à vrai (true) si la Case est accessible, à faux (false) le cas contraire
   #
   def estAccessible?()
     return @typeTerrain.isAccessible
   end


   ##
   #Permet de tester si la Case est pleine ou non.
   #
   #===Retourne :
   #* <b>isFull</b> : un booléen à vrai (true) si la Case est pleine, à faux (false) le cas contraire
   #
   def isFull?()
     return @@NombreMaxElementsEnnemis <= (@listeElements.length + @listeEnnemis.length)
   end
  

   ##
   #Permet de tester si la Case contient des ennemis ou non.
   #
   #===Retourne :
   #* <b>hasEnnemis</b> : un booléen à vrai (true) si la Case contient des ennemis, à faux (false) le cas contraire
   #
   def presenceEnnemis?()
     return @listeEnnemis.length != 0
   end
  

   ##
   #Permet de tester si la Case contient des personnages d'aide ou non.
   #
   #===Retourne :
   #* <b>hasPersosAide</b> : un booléen à vrai (true) si la Case contient des personnages d'aide, à faux (false) le cas contraire
   #
   def presenceAides?()
     return @listeElements.length != 0
   end
  
   def getIntitule()
     return @typeTerrain.intitule()
   end


   ##
   #Permet d'ajouter un Ennemi à la Case courante  si cette derrnière n'est pas pleine.
   #
   #==Paramètre :
   #* <b>ennemi</b> : l'ennemi à déposer sur la Case courante
   #
   def ajouterEnnemi(ennemi)
      if(!self.isFull?())
        @listeEnnemis.push(ennemi)
      end
      AffichageDebug.Afficher("#{ennemi} \najouté dans \n#{self}")
      return nil
   end
 
    
   ##
   #Permet de retirer un Ennemi de la Case courante.
   #
   #==Paramètre :
   #* <b>ennemi</b> : l'ennemi à retirer de la Case courante
   #
   def retirerEnnemi(ennemi)
      @listeEnnemis.delete(ennemi)
      AffichageDebug.Afficher("#{ennemi} \nsupprimé de \n#{self}")
      return nil
   end

  
   ##
   #Permet d'ajouter un élément Elt à la Case courante  si cette derrnière n'est pas pleine.
   #
   #==Paramètre :
   #* <b>element</b> : l'élément Elt à déposer sur la Case courante
   #
   def ajouterElement(element)
      if(!self.isFull?())
         @listeElements.push(element)
      end
     AffichageDebug.Afficher("#{element} \najouté à dans \n#{self}")
     return nil
   end

  
   ##
   #Permet de retirer un élément Elt à la Case courante
   #
   #==Paramètre :
   #* <b>element</b> : l'élément Elt à retirer de la Case courante
   #
   def retirerElement(element)
     @listeElements.delete(element)
     AffichageDebug.Afficher("#{element} \nsupprimé de \n#{self}")
     return nil
   end


   ##
   #Permet d'obtenir la Case voisine de la Case courante dans une des 4 directions au choix.
   #
   #==Paramètre :
   #* <b>direction</b> : la direction choisie (EnumDirection.NORD, EnumDirection.SUD, EnumDirection.EST ou EnumDirection.OUEST)
   #===Retourne :
   #* <b>case</b> : la Case voisine de la Case courante dans la direction passée en paramètre
   #
   def getDestination(direction)
      case direction
      when EnumDirection.NORD
         return @carte.getCaseAt(coordonneeX-1,coordonneeY)
      when EnumDirection.SUD
         return @carte.getCaseAt(coordonneeX+1,coordonneeY)
      when EnumDirection.EST
         return @carte.getCaseAt(coordonneeX,coordonneeY+1)
      when EnumDirection.OUEST
         return @carte.getCaseAt(coordonneeX,coordonneeY-1)
      else
         raise 'Erreur, direction incohérente'
      end
   end


   ##
   #Retourne la Case située au Nord de la Case courante
   #
   #===Retourne :
   #* <b>caseNord</b> : la Case voisine de la Case courante dans la direction Nord
   #
   def caseNord
      return @carte.getCaseAt(coordonneeX-1,coordonneeY)
   end

   ##
   #Retourne la Case située au Sud de la Case courante
   #===Retourne :
   #* <b>caseSud</b> : la Case voisine de la Case courante dans la direction Sud
   #
   def caseSud
      return @carte.getCaseAt(coordonneeX+1,coordonneeY)
   end

   ##
   #Retourne la Case située à l'Est de la Case courante
   #===Retourne :
   #* <b>caseEst</b> : la Case voisine de la Case courante dans la direction Est
   #
   def caseEst
      return @carte.getCaseAt(coordonneeX,coordonneeY+1)
   end

   ##
   #Retourne la Case située à l'ouest de la Case courante
   #===Retourne :
   #* <b>caseOuest</b> : la Case voisine de la Case courante dans la direction Ouest
   #
   def caseOuest
      return @carte.getCaseAt(coordonneeX,coordonneeY-1)
   end
 
   
   ##
   #Retourne une chaîne de caractères représentant la Case courante
   #
   #===Retourne :
   #* <b>s</b> : une chaîne de caractères représentant la Carte courante (coordonnées, éléments Elt présents, Ennemi présents, TypeTerrain, Joueur, nombre maximal d'ennemis)
   #
   def to_s
     s= "[==Case >>> | "
     s+= "X: #{@coordonneeX} | "
     s+= "Y: #{@coordonneeY} | "
     s+= "Elements: "
     if(@listeElements.empty?)
        s+="aucun "
     end
     for e in @listeElements
        s+= "#{e} ,"
     end
     s+="| "
     s+= "Ennemis: "
     if(@listeEnnemis.empty?)
        s+="aucun "
     end
     for e in @listeEnnemis
        s+= "#{e} ,"
     end
     s+="| "
     s+= "Terrain de type: #{@typeTerrain} | "
     if(@joueur==nil)
        s+= "Joueur: absent | "
     else
        s+= "Joueur: présent | "
     end
     s+= "Nombre max d'élements/ennemis: #{@@NombreMaxElementsEnnemis} | "
     s+= "<<< Case==]"
     return s
   end
 

end
