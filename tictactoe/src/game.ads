With Ada.Text_IO;
use Ada.Text_IO;
With Ada.Strings.Unbounded;
Use Ada.Strings.Unbounded;
With Player;
Use Player;
With tictactoe;
Use tictactoe;

With Tictactoe.Plateau;
Use Tictactoe.Plateau;

With Tictactoe.IA;
Use Tictactoe.IA;

with Tictactoe.Cellule;
use Tictactoe.Cellule;


Package Game is
   Type Jeu is private;
   Type Tableau_J is array(1..2) of Joueur;
   procedure  Affichage(P_Plateau: Tictactoe.Plateau.Pointeur_Plateau);
   procedure Jouer;
   Function Get_Pion(J:Joueur) return Pion;
   procedure Jouer_Tour(P:Tictactoe.Plateau.Pointeur_Plateau;J:Joueur);
   Procedure Inscrire_Joueurs(J:in out Jeu);
private
   Type Jeu is record
      P: Tictactoe.Plateau.Pointeur_Plateau;
      Tab_j:Tableau_J;
   end record;
end Game;
