# encoding: UTF-8

##
# Auteur PHILIPPE ARMANGER
# Version 0.1 : Date : Wed Jan 21 13:54:13 CET 2015
#

class Langue
# Va contenir les différents contenus de textes selon le choix de la langue 

	attr_reader :menu,:jouer,:tutoriel,:options,:score,:credits,:quitter,:retour #bouton du menu
	attr_reader :texte #credits
	attr_reader :o_graphique, :o_lang, :o_profil, :o_score #bouton options
	attr_reader :nouveauProfil, :envoyer

	def new(lang)
		initialize(lang)
	end

	def initialize(lang)
		if lang == 'fr'
			@menu,@jouer,@tutoriel,@options,@score,@credits,@quitter,@retour,@nouveauProfil,@envoyer = "Menu","Jouer","Tutoriel","Options","Score","Credits","Quitter","Retour au menu","Creer un profil","Envoyer"
			@texte = "\t\t\tVersion = 0.01\nChef de projet : \n\tGodefroy\nDocumentaliste : \n\tCookies \nSdf(sans denomination fixe) : \n\tWookles, Etienne, Benoit, Sylvain\n"
			@o_graphique,@o_lang,@o_profil,@o_score = "Graphiques","Langage","Profil","Score"
		else
			@menu,@jouer,@tutoriel,@options,@score,@credits,@quitter,@retour,@nouveauProfil,@envoyer = "Menu","Play","How to play","Options","Score","Credits","Leave","Return to menu","New User","Send"
			@texte = "\t\t\tVersion = 0.01\nProject leader : Godefroy\nWritter : Cookies \nWhat(WitHout A Title) : Wookles, Etienne, Benoit, Sylvain\n"
			@o_graphique,@o_lang,@o_profil,@o_score = "Graphics","Language","Profil","Score"
		end
	end


end # Marqueur de fin de classe
