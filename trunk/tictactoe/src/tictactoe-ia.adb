with Tictactoe.Plateau;
use Tictactoe.Plateau;
with Aleatoire;
with Tictactoe.Cellule; use Tictactoe.Cellule;
package body Tictactoe.IA is
   -- La fonction min permet de simuler le pion adverse du pion passer en parametre et renvoie une evaluation de la case jouer
   -- Evaluation correspond à la valeur à retoourner lorsqu'on gagne
   function Min(P_Plateau : Tictactoe.Plateau.Pointeur_Plateau ; P_Pion : Pion; Evaluation : integer; Profondeur:integer ) return integer;
    -- La fonction max permet de simuler le pion en parametre et renvoie une evaluation de la case jouer
   function Max(P_Plateau : Tictactoe.Plateau.Pointeur_Plateau ; P_Pion : Pion; Evaluation : integer;Profondeur:integer) return integer;
   -- La procedure Generique_Min_Max permet de faire jouer un joueur en fonction des parametres passés

   procedure Generique_Min_Max(P_Plateau : Tictactoe.Plateau.Pointeur_Plateau ; P_Pion : Pion; Evaluation: integer := 1 ; Profondeur : integer := 9 ) is
      variante : Integer := Integer'First;
      eval : integer := 0;
      type Couple is record
         Ligne : Tictactoe.Ligne;
         Colonne : Tictactoe.Colonne;
      end record;
      Liste : array(1 .. 9) of Couple;
      dernier : Integer := 0;
   begin
      -- Si le jeu est fini on ne fais rien
      if EstPlein(P_Plateau) then
         return;
      end if;
      For L in Ligne'Range loop
         For C in Colonne'Range Loop
            if Tictactoe.Cellule.EstLibre(Get_Cellule(P_Plateau, L, C)) then
               Tracer(P_Plateau, L,C, P_Pion);
               eval := Min(P_Plateau , P_Pion, Evaluation,Profondeur );
               Liberer(P_Plateau,L,C);
               if eval = variante then
                  dernier := dernier + 1;
                  Liste(dernier).Ligne := L;
                  Liste(dernier).Colonne := C;
               end if;
               if eval > variante then
                  variante := eval;
                  dernier := 1;
                  Liste(dernier).Ligne := L;
                  Liste(dernier).Colonne := C;
               end if;
            end if;
         end loop;
      end loop;
      declare
         rand : integer := Aleatoire(1,dernier);
         L1 : Ligne := Liste(rand).Ligne;
         C1 : Colonne := Liste(rand).Colonne;
      begin
         Tracer(P_Plateau , L1 , C1, P_Pion);
      end;
   end Generique_Min_Max;

   procedure Facile( P_Plateau : Tictactoe.Plateau.Pointeur_Plateau ; P_Pion : Pion) is
   begin
       Generique_Min_Max(P_Plateau => P_Plateau,
                        P_Pion    => P_Pion,Evaluation => -1);
   end Facile;
   procedure Moyen( P_Plateau : Tictactoe.Plateau.Pointeur_Plateau ; P_Pion : Pion) is
   begin
      Generique_Min_Max(P_Plateau => P_Plateau,
                        P_Pion    => P_Pion,Evaluation => 1,
                        Profondeur => 2
                       );
   end Moyen;
   procedure Difficile( P_Plateau : Tictactoe.Plateau.Pointeur_Plateau ; P_Pion : Pion) is
   begin
       Generique_Min_Max(P_Plateau => P_Plateau,
                           P_Pion    => P_Pion,Evaluation => 1);
   end Difficile;

   -- -------------------------------------------------------
   -- Fonction Min --
   -- -------------------------------------------------------

   function Min(P_Plateau : Tictactoe.Plateau.Pointeur_Plateau ; P_Pion : Pion ; Evaluation : integer ; profondeur : integer  ) return integer is
      variante : Integer := Integer'Last;
      eval : integer := 0;
      P_Plateau_aux : Tictactoe.Plateau.Pointeur_Plateau := P_Plateau;
   begin
      if Gagnant(P_Plateau_aux, P_Pion) then
         return Evaluation;
      elsif EstPlein(P_Plateau_aux) or profondeur <= 0 then
         return 0;
      end if;

      For L in Ligne'Range loop
         For C in Colonne'Range Loop
            if Tictactoe.Cellule.EstLibre(Get_Cellule(P_Plateau_aux, L, C)) then
               Tracer(P_Plateau_aux, L,C, Suivant(P_Pion));
               eval := Max(P_Plateau_aux , P_Pion, -Evaluation, profondeur - 1);
               Liberer(P_Plateau_aux,L,C);
               if eval < variante then
                  variante := eval;
               end if;
            end if;
         end loop;
      end loop;
      return variante;
   end Min;

    -- -------------------------------------------------------
   -- Fonction Max --
   -- -------------------------------------------------------

   function Max(P_Plateau : Tictactoe.Plateau.Pointeur_Plateau ; P_Pion : Pion; Evaluation : integer ; profondeur : integer) return integer is
      variante : Integer := Integer'First;
      eval : integer := 0;
      P_Plateau_aux : Tictactoe.Plateau.Pointeur_Plateau:= P_Plateau;
   begin
      if Gagnant(P_Plateau_aux, Suivant(P_Pion)) then
         return Evaluation;
      elsif EstPlein(P_Plateau_aux) or profondeur <= 0 then
         return 0;
      end if;

      For L in Ligne'Range loop
         For C in Colonne'Range Loop
            if Tictactoe.Cellule.EstLibre(Get_Cellule(P_Plateau_aux, L, C)) then
               Tracer(P_Plateau_aux, L,C, P_Pion);
               eval := Min(P_Plateau_aux , P_Pion, -Evaluation, profondeur - 1);
               Liberer(P_Plateau_aux,L,C);
               if eval > variante then
                  variante := eval;
               end if;
            end if;
         end loop;
      end loop;
      return variante;
   end Max;

end Tictactoe.IA;
