# encoding: UTF-8
#Classe qui contient tout les textes affichés dans le jeu
#permet au joueur de changer de langue
class Langue
# Va contenir les différents contenus de textes selon le choix de la langue 

	attr_reader :menu,:jouer,:tutoriel,:options,:score,:credits,:quitter,:retour #bouton du menu
	attr_reader :texte #credits
	attr_reader :j_aide,:j_test,:j_pause,:j_undo,:j_redo,:j_debHypo,:j_annHypo,:j_valHypo,:j_reset #boutons UI jeu
	attr_reader :t_regle,:t_test,:t_help1,:t_help2,:t_help31,:t_help32     #textes de jeu
	attr_reader :o_graphique, :o_lang, :o_profil, :o_score #bouton options
	attr_reader :nouveauProfil, :envoyer
	attr_reader :f_chrono1,:f_chrono2,:f_rapide1,:f_rapide2  #textes de fin de partie
	attr_reader :m_hiscor,:m_chrono  #modes de jeu
	attr_reader :og_1,:og_2,:og_3 #options graphiques
	attr_reader :pr_jouer,:pr_alea,:pr_diff,:pr_taille  #boutons partie rapide
	attr_reader :d_1,:d_2,:d_3,:d_4,:d_5  #textes du didacticiel
	attr_reader :pc_nom,:pc_mdp   #labels de creation de profil
	attr_reader :os_nil,:os_score,:os_grille,:os_mode,:os_chrono,:os_pause,:os_undo #textes des options score
	attr_reader :p_conn,:p_deco,:p_supProf,:p_lab1,:p_lab2,:p_lab3,:p_lab4,:p_supprConf,:p_enterPass,:p_user #divers textes profil
	attr_reader :p_mStat1,:p_mStat2,:p_mStat3,:p_mStat4,:p_mStat5,:p_mStat6,:p_mStat7,:p_mStat8,:p_mStat9,:p_mStat10 #plus de textes profils

	def new(lang)
		initialize(lang)
	end

	def initialize(lang)
		if lang == 'fr'
			@menu,@jouer,@tutoriel,@options,@score,@credits,@quitter,@retour,@nouveauProfil,@envoyer = "Menu","Jouer","Tutoriel","Options","Score","Credits","Quitter","Retour au menu","Creer un profil","Envoyer"
			@texte = "\t\t\tVersion = 0.01\nChef de projet : \n\tGodefroy\nDocumentaliste : \n\tCookies \nSdf(sans denomination fixe) : \n\tWookles, Etienne, Benoit, Sylvain\n"
			@j_aide,@j_test,@j_pause,@j_undo,@j_redo,@j_debHypo,@j_annHypo,@j_valHypo,@j_reset="Aide","Vérification","Pause","Annuler","Rétablir","Debuter hypothèse","Annuler hypothèse","Valider Hypothèse","Reset"
			@t_regle,@t_test,@t_help1,@t_help2,@t_help3 = "  Les 3 règles du Takuzu sont les suivantes :\n_Il est interdit d'aligner plus de deux cases de la même couleur\n_Deux lignes ou colonnes ne doivent pas être identiques\n_Chaque colonne et ligne doivent comporter autant de cases des deux couleurs ","Nombre d'erreurs : ","Regle 1 colonne :","Regle 2 :  ","Regle 3 : "," et "
			@o_graphique,@o_lang,@o_profil,@o_score = "Graphiques","Langage","Profil","Score"
			@f_chrono1,@f_chrono2,@f_rapide1,@f_rapide2="Vous avez fait une partie rapide\nVous avez mis "," secondes pour reussir la grille !\nVotre temps va etre enregistre","Vous avez fait une partie rapide\nVous avez mis "," secondes pour reussir la grille !\nVotre score est de "
			@m_hiscor,@m_chrono="Score","Chronometré"
			@og_1,@og_2,@og_3="<big>Couleur</big>\nCliquez sur une tuile pour changer sa couleur !","Couleur classique","Couleur d'hypothèse"
			@pr_jouer,@pr_alea,@pr_diff,@pr_taille="Jouer !","Grille Aléatoire","Difficulté","Taille"
			@d_1,@d_2,@d_3,@d_4,@d_5="Bienvenue dans le tutoriel du jeu de Takuzu\nLe but est de compléter la grille\nIl est interdit d'avoir trois tuiles de même couleur adjacentes ","Pour changer la couleur d'une tuile, cliquez une fois dessus pour la rendre rouge, et deux fois pour bleu ","La deuxième règle stipule que chaque ligne et colonne doivent contenir le même nombre de tuiles bleues et rouges\nCombinez cette règle et la première pour continuer à avancer","La dernière règle stipule que deux lignes ou colonnes ne doivent pas être identiques \nAvec ces trois règles, vous êtes maintenant en mesure de finir toute partie de Takuzu","Félicitations ! \nVous pouvez relire les règles à tout moment en mettant le jeu en pause."
			@pc_nom,@pc_mdp="Nom","Mot de passe"
			@os_nil,@os_score,@os_grille,@os_mode,@os_chrono,@os_pause,@os_undo="Vous n'avez pas fini de partie","Score: ",", Grille: ",", Mode: ","\nchrono: ",", nombre de pauses: ",", nombre d'annulations: "
			@p_conn,@p_deco,@p_supProf,@p_lab1,@p_lab2,@p_lab3,@p_lab4,@p_supprConf,@p_enterPass,@p_user="Connexion","Deconnexion","Supprimer profil","<big>Connectez-vous ou ...</big>","<big>... creez un nouveau profil !</big>","<big>Deconnectez-vous ou ...</big>","<big>... supprimez votre profil !</big>","Attention toute suppression est definitive !!","Entrez votre mot de passe","Utilisateur : "
			@p_mStat1,@p_mStat2,@p_mStat3,@p_mStat4,@p_mStat5,@p_mStat6,@p_mStat7,@p_mStat8,@p_mStat9,@p_mStat10="Vous avez fini "," parties",", pour un score total de ",", soit un score moyen de ","\nVous avez joue pendant "," secondes, soit un temps moyen de "," secondes.","\nVous avez effectue "," undos et "," pauses."
		else
			@menu,@jouer,@tutoriel,@options,@score,@credits,@quitter,@retour,@nouveauProfil,@envoyer = "Menu","Play","How to play","Settings","Score","Credits","Leave","Return to menu","New User","Send"
			@texte = "\t\t\tVersion = 0.01\nProject leader : Godefroy\nWritter : Cookies \nWhat(WitHout A Title) : Wookles, Etienne, Benoit, Sylvain\n"
			@j_aide,@j_test,@j_pause,@j_undo,@j_redo,@j_debHypo,@j_annHypo,@j_valHypo,@j_reset="Help","Test","Pause","Undo","Redo","Start hypothesis","Undo hypothesis","Validate Hypothesis","Reset"
			@t_regle,@t_test,@t_help1,@t_help2,@t_help3 = "  Here are the three rules of Takuzu :\n_Thou shalt not put 3 tiles of the same colour in a row\n_Thou shalt not create two columns or lines that looks alike\n_Thou shalt not create a column or line with more tiles of a colour than of the other","Number of errors : ","Rule 1 column x:","Rule 2 :  ","Rule 3 : "," and "
			@o_graphique,@o_lang,@o_profil,@o_score = "Graphics","Language","Account","Score"
			@f_chrono1,@f_chrono2,@f_rapide1,@f_rapide2="You have completed a quick (and dirty) game!\nIt took you "," seconds to fill this grid !\nthis time will now be saved","You have completed a quick (and dirty) game!\nIt took you  "," seconds to fill this grid !\nYour score is "
			@m_hiscor,@m_chrono="Score","Timed"
			@og_1,@og_2,@og_3="<big>Colours</big>\nClick a tile to change its colour !","Classic colour","Hypothesis colour"
			@pr_jouer,@pr_alea,@pr_diff,@pr_taille="Play !","Random grid","Difficulty","Size"
			@d_1,@d_2,@d_3,@d_4,@d_5="Welcome to Takuzu Deluxe.\nThe purpose of this game is for you to fill the grid while following three basic rules. \nFirst rule is : \nThou shalt not put 3 tiles of the same colour in a row.","To change the colour of a tile, click on it once to make it red and twice to make it blue.","Second rule is : \nThou shalt not create a column or line with more tiles of a colour than of the other\nCombine the first two rules to fill a bit more of the grid.","Third rule is : \n_Thou shalt not create two columns or lines that looks alike\nWith this last one, you should be capable of completing every grid we can give you. Good luck!","Congratulations! \nYou can reread the rules anytime by clicking the Pause button."
			@pc_nom,@pc_mdp="Name","Password"
			@os_nil,@os_score,@os_grille,@os_mode,@os_chrono,@os_pause,@os_undo="You haven't completed a grid yet","Score: ",", Grid: ",", Mode: ","\ntime: ",", Amount of pauses: ",", amount of undoes: "
			@p_conn,@p_deco,@p_supProf,@p_lab1,@p_lab2,@p_lab3,@p_lab4,@p_supprConf,@p_enterPass,@p_user="Connection","Disconnection","Delete account","<big>Connect or ...</big>","<big>... create a new account !</big>","<big>Disconnect or ...</big>","<big>... delete your account !</big>","Warning : Any deletion can not be undone","Enter your password","User : "
			@p_mStat1,@p_mStat2,@p_mStat3,@p_mStat4,@p_mStat5,@p_mStat6,@p_mStat7,@p_mStat8,@p_mStat9,@p_mStat10="You have completed "," games",", for a total score of ",", and an average score of ","\nYou have played for "," seconds, or an average time of "," seconds.","\nYou have used "," undoes et "," pauses."
		end
	end

end
