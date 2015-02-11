#COMOK
#!/usr/bin/env ruby

##
# Fichier : Pisteur.rb
# Auteur : L3SPI - Groupe de projet B
# Fait partie de : TheGame

#===Classe permettant de gérer des PNJ (Personnages Non Joueurs) Ennemi Pisteur.
#Un Pisteur est caractérisé par :
#* Un Joueur à pister
#* Une distance de pistage (= champ d'action du Pisteur)
#

require 'MODELE/Ennemi.rb'
require 'MODELE/Joueur.rb'

class Pisteur < Ennemi


   #=== Variable d'instance ===
   @joueur
   @distancePistage


   private_class_method :new #La construction se fera par la méhode de classe Pisteur.creer(casePosition, niveau, type,modele, joueur)


   ##
   #Crée un nouveau Pisteur à partir des informations passées en paramètre.
   #   
   #===Paramètres :
   #* <b>casePosition :</b> la case où se trouvera le PNJ Pisteur
   #* <b>niveau :</b> le niveau du PNJ Pisteur
   #* <b>type :</b> le type de PNJ Pisteur
   #* <b>modele :</b> le modèle qui gère le PNJ Pisteur
   #* <b>joueur :</b> le Joueur pisté
   #
   def initialize(casePosition, niveau, type,modele, joueur)
      super(casePosition, niveau, type,modele)
      @joueur = joueur
      @distancePistage = 5
   end

   
   ##
   #Permet de crée un nouveau Pisteur à partir des informations passées en paramètre.
   #   
   #===Paramètres :
   #* <b>casePosition :</b> la case où se trouvera le PNJ Pisteur
   #* <b>niveau :</b> le niveau du PNJ Pisteur
   #* <b>type :</b> le type de PNJ Pisteur
   #* <b>modele :</b> le modèle qui gère le PNJ Pisteur
   #* <b>joueur :</b> le Joueur pisté
   #===Retourne :
   #* <b>nouveauPisteur</b> : le Pisteur créé
   #
   def Pisteur.creer(casePosition, niveau, type,modele, joueur)
      return new(casePosition, niveau, type,modele, joueur)
   end

   
   ##
   #Permet de deplacer l'Ennemi sur une cible calculée suivant la position du joueur.
   #
   def deplacementIntelligent()
      cj = @joueur.casePosition # CaseJoueur
      list_case = Array.new()   # Liste de listes de cases
      indice = 0                # Indice
      find = false              # Boolean pour savoir si le joueur a été trouvé

      if(!(cj == self.casePosition))

         # Recherche de la case du joueur
         list_case[indice] = Array.new().push(@casePosition)

       if(cj.coordonneeX >=@casePosition.coordonneeX-@distancePistage && cj.coordonneeX <= @casePosition.coordonneeX+@distancePistage && cj.coordonneeY >= @casePosition.coordonneeY-@distancePistage && cj.coordonneeY <= @casePosition.coordonneeY+@distancePistage  )
           while(!find)
              list_case[indice+1] = Array.new()
              ajoutList = list_case[indice+1]
  
              for c in list_case[indice]
  
                 if(!existe?(c.caseNord, list_case, indice) && !c.caseNord.isFull?() && c.caseNord.typeTerrain.isAccessible)
                    ajoutList.push(c.caseNord)
                    if(estCible?(c.caseNord))
                       find = true
                       break
                    end
                 end
  
                 if(!existe?(c.caseSud, list_case, indice) && !c.caseSud.isFull?() && c.caseSud.typeTerrain.isAccessible)
                    ajoutList.push(c.caseSud)
                    if(estCible?(c.caseSud))
                       find = true
                       break
                    end
                 end
  
                 if(!existe?(c.caseEst, list_case, indice) && !c.caseEst.isFull?() && c.caseEst.typeTerrain.isAccessible)
                    ajoutList.push(c.caseEst)
                    if(estCible?(c.caseEst))
                       find = true
                       break
                    end
                 end
  
                 if(!existe?(c.caseOuest, list_case, indice) && !c.caseOuest.isFull?() && c.caseOuest.typeTerrain.isAccessible)
                    ajoutList.push(c.caseOuest)
                    if(estCible?(c.caseOuest))
                       find = true
                       break
                    end
                 end
  
              end # Fin for
  
              ajoutList.uniq()  # Enleve les cases en doublons du tableau
  
              indice += 1
              
              if(indice >= @distancePistage) # Hors du champs de l'ennemi
                 break
              end
  
           end # Fin while
        end
         # Fin Recherche de la case du joueur

         # Determination de la case de deplacement
         if(find)
          str=XmlMultilingueReader.lireTexte("pistage")
          str=str.gsub("PISTEUR",XmlMultilingueReader.lireDeterminant_Nom(self)).gsub("CX",@casePosition.coordonneeX.to_s()).gsub("CY",@casePosition.coordonneeY.to_s())
          @joueur.modele.notifier(str)
            # Remplacement de la liste de case du derniere indice par la case du joueur
            list_case[indice] = Array.new().push(cj)

            while(indice > 0)
               caseFind = list_case[indice][0] # Derniere case du chemin trouvé
               listFind = list_case[indice-1]  # Liste contenant la case suivante du chemin

               if(listFind.index(caseFind.caseNord) != nil)
                  listFind = Array.new().push(caseFind.caseNord)
               elsif(listFind.index(caseFind.caseSud) != nil)
                  listFind = Array.new().push(caseFind.caseSud)
               elsif(listFind.index(caseFind.caseEst) != nil)
                  listFind = Array.new().push(caseFind.caseEst)
               elsif(listFind.index(caseFind.caseOuest) != nil)
                  listFind = Array.new().push(caseFind.caseOuest)
               end

               list_case[indice-1] = listFind
               indice -= 1

            end # Fin while
            
            if(list_case[1][0] == @casePosition.caseNord)
               deplacement(EnumDirection.NORD)
            elsif(list_case[1][0] == @casePosition.caseSud)
               deplacement(EnumDirection.SUD)
            elsif(list_case[1][0] == @casePosition.caseEst)
               deplacement(EnumDirection.EST)
            else
               deplacement(EnumDirection.OUEST)
            end

            # Fin determination de la case de deplacement

            # Deplacement aleatoire du pisteur
         else
            super() # Appelle de la methode deplacementIntelligent de la classe Ennemi (aleatoire)
         end # Fin if(find)

      end # Fin if(!(cj == self.casePosition))
       return nil
   end # Fin methode

   
   ##
   #Permet de savoir si une case à déjà été marquée.
   #
   #===Paramètres :
   #* <b>uneCase :</b> la case à vérifier
   #* <b>list_case :</b> la liste qui contient les cases marquées
   #* <b>indice :</b> l'indice du dernier ajout
   #
   def existe?(uneCase, list_case, indice)
      for i in 0..indice
         if(list_case[i].index(uneCase) != nil)
            return true
         end
      end

      return false
  end


   ##
   #Fait mourrir le Pisteur
   #
   def meurt()
     @modele.nbPisteur=@modele.nbPisteur-1
     super()
   end 
  
  
   ##
   # Permet de savoir si une case est la cible (celle qui contient le Joueur pisté)
   #
   #===Paramètres :
   #* <b>uneCase :</b> la case à vérifier
   #
   def estCible?(uneCase)
      if(uneCase == @joueur.casePosition)
         return true
      end

      return false
   end

   
   ##
   #Retourne une chaîne de caractères représentant le Pisteur courant
   #
   #===Retourne :
   #* <b>s</b> : une chaîne de caractères représentant le Pisteur courant
   #
   def to_s
     s= "[==Pisteur >>> | "
     s+= super()
     s+= "Distance de pistage: #{@distancePistage} | "
     s+= "<<< Pisteur==]"
   end

end
