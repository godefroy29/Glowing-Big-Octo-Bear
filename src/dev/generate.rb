require 'sqlite3'

db = SQLite3::Database.new( "firstTest.db" )


db.execute("create table IF NOT EXISTS Grille (id_grille INTEGER PRIMARY KEY,difficulte INT,taille INT,base VARCHAR(255),solution VARCHAR(255));")

fic =File.open("../../ressources/BaseBineroParNiveau.txt",'r')
fic.each_line{|ligne|        #lecture ligne à ligne
        words = ligne.split(";")      #lecture de chaque mot d'une ligne
        db.execute "INSERT INTO Grille(difficulte,taille,solution,base) VALUES ('#{words[0]}',#{Math.sqrt(words[1].size)},'#{words[2]}','#{words[1]}')"
        #Grille = Grille.create(:difficulte=words[0],:taille=Math.sqrt(words[1].size,:base=words[1],:solution=words[2]))
        }
