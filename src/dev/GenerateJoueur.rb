class GenerateJoueur

	def GenerateJoueur.generate

	$database.execute("create table IF NOT EXISTS Joueur (
		id_joueur INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
		pseudo VARCHAR(255) UNIQUE,
		password VARCHAR(255),
		avatar VARCHAR(255));")

	$database.execute("INSERT INTO Joueur(id_joueur,pseudo,password,avatar) VALUES (0,'anon','','#{$default_avatar}') ")

	end

end


