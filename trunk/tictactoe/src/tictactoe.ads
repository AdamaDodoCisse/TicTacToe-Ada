package Tictactoe is
   type Pion is (X,O);
   subtype Ligne is Natural range 1 .. 3;
   subtype Colonne is Character range 'A' .. 'C';
   suivant : array(Pion'Range) of Pion := (X => O , O => X);
   Not_Pion_Exception : exception;
end Tictactoe;
