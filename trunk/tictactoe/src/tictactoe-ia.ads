with Tictactoe.Plateau;
use Tictactoe.Plateau;
package Tictactoe.IA is
   -- Procedure permettant de simuler un niveau de jeu facile
   -- (essai de perdre a tout prix)
   procedure Facile( P_Plateau : Tictactoe.Plateau.Pointeur_Plateau ; P_Pion : Pion);
   -- Procedure permettant de simuler un niveau de jeu moyen
   -- (prevoit deux fois a l'avance le coup de son adversaire)
   procedure Moyen( P_Plateau : Tictactoe.Plateau.Pointeur_Plateau ; P_Pion : Pion);
   -- Procedure permettant de simuler un niveau de jeu difficile(ne perd jamais)
   procedure Difficile( P_Plateau : Tictactoe.Plateau.Pointeur_Plateau ; P_Pion : Pion);
end Tictactoe.IA;
