with Tictactoe.Plateau;
use Tictactoe.Plateau;
with Tictactoe;
use Tictactoe;
with Tictactoe.IA;
use Tictactoe.IA;
with Ada; use Ada;
with Ada.Text_IO;
procedure main is
   P : Tictactoe.Plateau.Plateau := NouveauPlateau;
begin
   P.afficher;
   Tictactoe.IA.Difficile(P_Plateau => P,
                          P_Pion    => Tictactoe.O);
   Ada.Text_IO.Put(ASCII.ESC & "[2J");
   P.afficher;
end main;
