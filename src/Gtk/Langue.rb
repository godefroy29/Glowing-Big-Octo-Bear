# encoding: UTF-8

##
# Auteur PHILIPPE ARMANGER
# Version 0.1 : Date : Wed Jan 21 13:54:13 CET 2015
#

class Langue
# Va contenir les différents contenus de textes selon le choix de la langue 

	attr_reader:menu,:jouer,:tutoriel,:options,:score,:credits,:quitter,:retour,:texte

	def initialize()
		@menu,@jouer,@tutoriel,@options,@score,@credits,@quitter,@retour,@texte = "menu","jouer","tutoriel","options","score","credits","quitter","retour au menu","\t\t\tVersion = 0.01\nchef de projet : Godefroy\ndocumentaliste : Cookies \nSdf(sans denomination fixe) : Wookles, Etienne, Benoit, Sylvain\n"
	end


end # Marqueur de fin de classe
