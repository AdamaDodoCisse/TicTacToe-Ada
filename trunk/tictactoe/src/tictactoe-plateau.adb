package body Tictactoe.Plateau is

   -- La procedure [tracer] permet d'inserer un pion dans un plateau dont les coordonnées sont passées en paramètre
   procedure Tracer(P_Plateau : Pointeur_Plateau; P_Ligne : Ligne ; P_Colonne : Colonne ; P_Pion : Pion ) is
   begin
      case P_Plateau.Coordonnees(P_Ligne,P_Colonne).Vide is
         -- si la case est vide on lui passe les coordonnées et le type de pion passés en paramètre
      when true =>
          Tracer(Cell => P_Plateau.Coordonnees(P_Ligne,P_Colonne),
                 Pi   => P_Pion);
         P_Plateau.Etat := P_Plateau.Etat + 1;
         -- si elle possède déjà un pion, on ne fait rien
         when false =>
            null;
      end case;
   end ;


   -- La procedure [liberer] permet de liberer une cellule dans le plateau dont les coordonnées sont passées en paramètre
   procedure Liberer(P_Plateau : Pointeur_Plateau ; P_Ligne : Ligne ; P_Colonne : Colonne) is
   begin
      -- si la case est deja vide on ne fait rien
      case P_Plateau.Coordonnees(P_Ligne,P_Colonne).Vide is
         when true => null;
            -- si la case n'est pas vide, on la libère
         when false =>
            Liberer(Cell => P_Plateau.Coordonnees(P_Ligne,P_Colonne));
            P_Plateau.Etat := P_Plateau.Etat - 1;
      end case;
   end Liberer;


    -- La fonction [NouveauPlateau] retourne un nouveau plateau avec toutes les cases à vides
   function NouveauPlateau return Pointeur_Plateau is
      --tableau à deux dimention contenant des lignes et des colonnes
      P : Tableau2D;
   begin
      --parcours du plateau
      for L in Ligne'Range loop
         for C in Colonne'Range loop
            --initialisation des cellules
            Cellule.Liberer(Cell => P(L,C));
         end loop;
      end loop;
      return new Plateau'(Coordonnees => P , Etat => 0 );
   end NouveauPlateau;


   -- La fonction [EstPlein] test si le plateau ne contient aucune case vide
   function EstPlein(P_Plateau : Pointeur_Plateau) return boolean is
   begin
      --Si état vaut 9, cela signifie que toutes les cases sont jouées.
      return P_Plateau.Etat >= 9;
   end EstPlein;


   -- La fonction [Gagnant] test si le pion passer en parametre a gagné
   function Gagnant(P_Plateau : Pointeur_Plateau; P_Pion : Pion) return boolean is
      V : Natural := 0; -- représente les verticals
      H : Natural := 0; -- représente les horizontals
      D1 : Natural := 0; -- représente les diagonales
      D2 : Natural := 0; -- idem
   begin
      -- parcour des lignes
     For L in Ligne'Range loop
         V := 0;
         H := 0;
         For C in Colonne'Range loop
            --si la case n'est pas libre
            if not EstLibre(Cell => P_Plateau.Coordonnees(L,C)) then
               --et si le pion correspond à celui passé en paramètre
               if Get_Pion(Cell => P_Plateau.Coordonnees(L,C)) = P_Pion then
                  H := H + 1;
                  if Ligne'Pos(L) - Ligne'Pos(Ligne'First)  = Colonne'Pos(C) - Colonne'Pos(Colonne'First)  then D1 := D1 + 1; end if;
                  if Ligne'Pos(L) - Ligne'Pos(Ligne'First) + Colonne'Pos(C) - Colonne'Pos(Colonne'First)  = 2 then D2 := D2 + 1; end if;
               end if;
            end if;
            declare
               I : integer := Ligne'Pos(L) - Ligne'Pos(Ligne'First) ;
               J : Integer := Colonne'Pos(C) - Colonne'Pos(Colonne'First);
               C1 : Colonne := Colonne'Val( I + Colonne'Pos(Colonne'First));
               L1 : Ligne := Ligne'Val( J + Ligne'Pos(Ligne'First));
            begin
               if not EstLibre(Cell => P_Plateau.Coordonnees(L1,C1)) then
                  if Get_Pion(Cell => P_Plateau.Coordonnees(L1,C1)) = P_Pion then
                     V := V + 1;
                  end if;
               end if;
            end;
         end loop;
         if V > 2 or H > 2 or D1 > 2 or D2 > 2  then return true; end if;
      end loop;
      return false;
   end Gagnant;

    -- La fonction [Get_Cellule] retourne un pointeur sur une cellule a une position donnée
   function Get_Cellule(P_Plateau : Pointeur_Plateau ; P_Ligne : Ligne ; P_Colonne: Colonne) return Pointeur_Cellule is
   begin
      return P_Plateau.Coordonnees(P_Ligne,P_Colonne);
   end;

end;
