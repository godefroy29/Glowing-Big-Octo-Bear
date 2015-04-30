class GenerateScore

	def GenerateScore.generate

		$database.execute("create table IF NOT EXISTS Score (
			id_score INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
			id_joueur INTEGER REFERENCES Joueur(id_joueur),
			id_grille INTEGER REFERENCES Grille(id_grille),
			mode INTEGER,
			chrono INTEGER,
			nb_undo INTEGER,
			nb_pause INTEGER,
			nb_test INTEGER,
			nb_aide INTEGER,
			base VARCHAR(255));")

	end

end