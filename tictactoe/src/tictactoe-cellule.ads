Package Tictactoe.Cellule is
   -- Definition du typage d'une cellule
   Type Cellule(Vide : boolean:= true ) is private;
    -- Un pointeur sur les cellules
   Type Pointeur_Cellule is access Cellule;
   -- Une case vide
    Cellule_Vide : constant Cellule;
   -- Procedure permettant de liberer une cellule
   procedure Liberer( Cell : in out Pointeur_Cellule);
   -- Procedure permettant d'inserer un pion dans une cellule
   procedure Tracer( Cell : in out Pointeur_Cellule; Pi : Pion);
   -- Fonction permettant de tester si une cellule est libre
   function EstLibre(Cell : Pointeur_Cellule) return boolean;
   -- Fonction qui retourne le pion d'une cellulle
   -- Elle leve une exception lorsque c'est une cellule vide
   function Get_Pion(Cell : Pointeur_Cellule) return Pion;

private

   type Cellule(Vide : boolean := true) is  record
      case Vide is
         when true =>
            null;
         when false =>
            valeur : Pion;
      end case;
   end record;
    Cellule_Vide : constant Cellule := (Vide => true);
end;
