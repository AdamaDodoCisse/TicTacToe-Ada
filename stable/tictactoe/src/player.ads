with ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with Tictactoe;
use Tictactoe;
with Tictactoe.Plateau;
use Tictactoe.Plateau;

Package Player is
   type Joueur is private;
   subtype Type_Joueur is Natural Range 1..4;
    --Return le nom du joueur
   Function Get_Name(J:Joueur) return Unbounded_String;

   --Return le Pion du joueur
   Function Get_Id(J:Joueur) return Natural;

   --Retourne Le type du joueur
   Function Get_Type(J:Joueur) return Type_Joueur;

   --Nomme le joueur
   procedure Set_Name(J:in out Joueur;N:Unbounded_String);

   procedure Set_Id(J:in out Joueur;I:Natural);

   procedure Set_Type(J:in out Joueur);
   --Permet au joueur Réel de jouer
   procedure Reel(P:in out Tictactoe.Plateau.Plateau;J:Joueur;P_Pion:Pion);

private
   type Joueur is record
      Name: Unbounded_String;
      Id:Natural range 1..2;
      Type_J:Type_Joueur;
   end record;
end Player;
