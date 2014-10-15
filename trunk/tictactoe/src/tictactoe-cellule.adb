package body Tictactoe.Cellule is

   -- La procedure [Liberer] permet de libérer une cellule ( en passant par un pointeur)
   procedure Liberer (Cell : in out Pointeur_Cellule) is
   begin
      Cell := new Cellule'(Vide => True);
   end Liberer;

   -- La procédure [Tracer] permet d'insérer un pion dans une cellule
   procedure Tracer (Cell : in out Pointeur_Cellule; Pi : Pion) is
   begin
      -- si la case est vide alors on insère le pion dans la cellule
      case Cell.Vide is
         when True =>
            Cell := new Cellule'(Vide => False, valeur => Pi);
         -- sinon on ne fait rien
         when False =>
            null;
      end case;
   end Tracer;

   -- la fontion [EstLibre] permet de tester si une cellule est vide
   function EstLibre (Cell : Pointeur_Cellule) return Boolean is
   begin
      return Cell.Vide;
   end EstLibre;

   -- La fonction [Get_Pion] retourne le pion d'une cellule
   function Get_Pion (Cell : Pointeur_Cellule) return Pion is
   begin
      case Cell.Vide is
         -- si la case est vide, alors une excpetion est levée
         when True =>
            raise Not_Pion_Exception;
         -- si la case est plein alors on renvoi la valeur du pion (X ou O)
         when False =>
            return Cell.valeur;
      end case;
   end Get_Pion;
end Tictactoe.Cellule;
