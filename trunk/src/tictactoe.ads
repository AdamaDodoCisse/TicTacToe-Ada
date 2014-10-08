package Tictactoe is

   type Pion is (X , O);
   subtype Ligne is Natural range 1 .. 3;
   subtype Colonne is Character range 'A' .. 'C';
   type Case_Plateau( Vide : boolean ) is tagged private;
   type Plateau is private;
   Not_Pion_Exception : exception;
   Suivant : array(Pion'Range) of Pion := (X => O , O => X);
private
   type Case_Plateau ( Vide : Boolean) is tagged record
      case Vide is
         when true =>
            null;
         when false => Valeur : Pion;
      end case;
   end record;
   type Pointeur_Case_Plateau is access Case_Plateau;

   type Plateau is array(Ligne'Range, Colonne'Range) of Pointeur_Case_Plateau;

end Tictactoe   ;
