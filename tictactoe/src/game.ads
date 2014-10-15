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
   Type Tableau_J is array(1..2) of Joueur;--Un tableau pour stocker les 2 joueurs de la partie

   --Affiche le plateau
   procedure  Affichage(P_Plateau: Tictactoe.Plateau.Pointeur_Plateau);

   --Permet de lancer une partie
   procedure Jouer;

   --Permet d'obtenir le pion associer à un joueur
   Function Get_Pion(J:Joueur) return Pion;

   --Permet à un joueur de jouer un coup
   procedure Jouer_Tour(P:Tictactoe.Plateau.Pointeur_Plateau;J:Joueur);

   --Procedure de stockage des joueurs dans le jeu
   Procedure Inscrire_Joueurs(J:in out Jeu);
private
   Type Jeu is record
      P: Tictactoe.Plateau.Pointeur_Plateau;-- Le plateau du jeu
      Tab_j:Tableau_J; --Le tableau des joueurs de la partie
   end record;
end Game;
