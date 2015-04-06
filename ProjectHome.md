Le Tic-tac-toe se joue sur une grille carrée de 3x3 cases. Deux joueurs s'affrontent. Ils doivent remplir chacun à leur tour une case de la grille avec le symbole qui leur est attribué : O ou X. Le gagnant est celui qui arrive à aligner trois symboles identiques, horizontalement, verticalement ou en diagonale.
On vous demande d'en réaliser une variante dans laquelle :
chaque joueur saisit au clavier les coordonnées (A,B ou C pour la colonne, 1, 2 ou 3 pour la ligne) de la case où il entend jouer,
sa requête n'est prise en compte que si la case jouée est vide : sinon il doit rejouer,
la partie s'arrête lorsqu'un joueur a aligné trois symboles identiques, horizontalement, verticalement ou en diagonale : alors, le vainqueur est félicité à l'écran.
de plus la partie s'arrête, évidemment, si le plateau est plein : alors la partie est déclarée nulle.

En raison du nombre de combinaisons limité, l'analyse complète du jeu est facile à réaliser : si les deux joueurs jouent chacun de manière optimale, la partie doit toujours se terminer par un match nul :
fort de ce constat vous simulerez un joueur qui, par son comportement optimal, ne perdra jamais face à vous.
si vous êtes las de saisir des coordonnées, vous pourrez vous tourner vers la bibliothèque gtkada pour réaliser une interface graphique
en tout cas, vous apporterez un soin particulier au traitement des erreurs.