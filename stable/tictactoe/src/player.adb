with Ada.Text_IO; use Ada.Text_IO;
with Tictactoe.Cellule;
use Tictactoe.Cellule;
Package body Player is

   Function Get_Name(J:Joueur) return Unbounded_String is
   begin
      Return J.Name;
   end Get_Name;


   Function Get_Id(J:Joueur) return Natural is
   begin
      Return J.Id;
   end Get_Id;

   Function Get_Type(J:Joueur) return Type_Joueur is
   begin
      return J.Type_J;
   end Get_Type;


   procedure Set_Name(J:in out Joueur;N:Unbounded_String) is
      begin
      J.Name:=N;
   end Set_Name;

   procedure Set_Id(J:in out Joueur;I:Natural) is
      begin
      J.Id:=I;
   end Set_Id;

   procedure Set_Type(J:in out Joueur) is
   begin
      Put_Line("Selectionner le type du joueur");
      Put_Line("1=> Joueur");
      Put_Line("2=> CPU Facile");
      Put_Line("3=> CPU Moyen");
      Put_Line("4=> CPU Difficile");
      J.Type_J:=Integer'Value(Get_Line);
   end Set_Type;

   procedure Reel(P:in out Tictactoe.Plateau.Plateau;J:Joueur;P_Pion :Pion) is
      X:ligne;
      Y:Colonne;
   begin
      Put_Line(To_String(Get_Name(J)) & " C'est à vous de jouer ");
      Put_Line("Entrer la ligne");
      X:=Natural'Value(Get_Line);
      Put_Line("colonne");
      Y:=Get_Line(1);
      if Tictactoe.Cellule.EstLibre(P.Get_Cellule(X,Y)) then
         Tracer(P,X,Y,P_Pion);
      else
         Reel(P,J,P_Pion);
      end if;
   exception
      when Constraint_Error =>
            Put_Line("Mauvaise Coordonnées");
         Reel(P,J,P_Pion);
   end Reel;

End Player;
