Package body Tictactoe.Cellule is
   procedure Liberer( Cell : in out Pointeur_Cellule) is
   begin
      Cell := new Cellule'(Vide => True);
   end Liberer;
   procedure Tracer( Cell : in out Pointeur_Cellule ; Pi : Pion) is
   begin
      case  Cell.Vide is
      	when true =>
         Cell := new Cellule'( Vide => false, Valeur => Pi);
      	when false => null;
      end case;

   end Tracer;
   function EstLibre(Cell : Pointeur_Cellule) return boolean is
   begin
      return Cell.Vide;
   end EstLibre;

   function Get_Pion(Cell : Pointeur_Cellule) return Pion is
   begin
      case Cell.Vide is
      when true =>
         raise Not_Pion_Exception;
      when false =>
         return Cell.valeur;
      end case;
   end Get_Pion;
end;
