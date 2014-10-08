with ada.Text_IO;
use ada.Text_IO;
package body Tictactoe.Component is

   -- La procedure [tracer] permet d'inserer un pion dans un plateau
   procedure Tracer(P_Plateau : in out Plateau ; P_Ligne : Ligne ; P_Colonne : Colonne ; P_Pion : Pion ) is
   begin
      case P_Plateau(P_Ligne,P_Colonne).Vide is
         when False => null; return;
         when true =>
            P_Plateau(P_Ligne,P_Colonne) := new Case_Plateau'(Vide => false, Valeur => P_Pion );
      end case;

   end Tracer;
   -- La procedure [liberer] permet de liberer un emplacement dans un plateau
   procedure Liberer(P_Plateau : in out Plateau ; P_Ligne : Ligne ; P_Colonne : Colonne) is
   begin
      P_Plateau(P_Ligne,P_Colonne) := new Case_Plateau'(Vide => true);
   end Liberer;
    -- La fonction [NouveauPlateau] retourne un nouveau plateau avec toutes les cases à vides
   function NouveauPlateau return Plateau is
   begin
      return (others => (others => new Case_Plateau'(Vide => true)));
   end NouveauPlateau;
   -- La fonction [EstLibre] test si un emplacement dans le plateau est libre ou pas
   function EstLibre(P_Plateau : Plateau ; P_Ligne : Ligne ; P_Colonne : Colonne) return boolean is
   begin
      return P_Plateau(P_Ligne,P_Colonne).Vide;
   end EstLibre;
   -- La fonction [EstPlein] test si le plateau ne contient aucune case vide
   function EstPlein(P_Plateau : Plateau) return boolean is
   begin
      For L in Ligne'Range loop
         For C in Colonne'Range loop
            if EstLibre(P_Plateau, L, C) then
               return false;
            end if;
         end loop;
      end loop;
      return true;
   end EstPlein;

   -- La fonction [Gagnant] test si le pion passer en parametre a gagné
   function Gagnant(P_Plateau : Plateau; P_Pion : Pion) return boolean is
      V : Natural := 0;
      H : Natural := 0;
      D1 : Natural := 0;
      D2 : Natural := 0;
   begin
      For L in Ligne'Range loop
         V := 0;
         H := 0;
         For C in Colonne'Range loop
            if P_Plateau(L,C).Vide = False then
               if P_Plateau(L,C).Valeur = P_Pion then
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
               if P_Plateau(L1,C1).Vide = false then
                  if P_Plateau(L1,C1).Valeur = P_Pion then
                     V := V + 1;
                  end if;
               end if;
            end;
         end loop;
         if V > 2 or H > 2 or D1 > 2 or D2 > 2  then return true; end if;
      end loop;

      return false;
   end Gagnant;
   -- La fonction [Get_Case] renvoie le case du plateau a la position P_Ligne, C_Colonne,
   function Get_Case(P_Plateau : Plateau ; P_Ligne : Ligne ; P_Colonne : Colonne) return Case_Plateau is
   begin
      return P_Plateau(P_Ligne,P_Colonne).all;
   end Get_Case;
   -- La fonction [Get_Pion] renvoie le pion de la case passer en paramètre
   -- Attention : Elle leve une exception de type Not_Pion_Exception si la case est vide
   function Get_Pion(P_Case_Plateau : Case_Plateau) return Pion is
   begin
      case P_Case_Plateau.Vide is
         when true => raise Not_Pion_Exception;
         when false =>
            return P_Case_Plateau.Valeur;
      end case;
   end Get_Pion;
   -- Permet d'afficher le contenu d'un plateau
   procedure afficher(P_Plateau : Plateau) is
   begin
      new_line;
      for L in Ligne'range loop
         for C in Colonne'Range loop
            if EstLibre(P_Plateau,L,C) then
               Put("[    ]");
            else
               Put("[ ");
               Put(Pion'image(Get_Pion(Get_Case(P_Plateau, L,C))));
               Put(" ]");
            end if;
         end loop;
         new_line;
      end loop;
      new_line;

   end Afficher;

end Tictactoe.Component;
