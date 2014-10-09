with Tictactoe.Cellule; use Tictactoe.Cellule;
with Ada.Text_IO;use Ada.Text_IO;
package Tictactoe.Plateau is
   type Plateau is tagged private;
   -- La procedure [tracer] permet d'inserer un pion dans un plateau
   procedure Tracer(P_Plateau : in out Plateau ; P_Ligne : Ligne ; P_Colonne : Colonne ; P_Pion : Pion );
   -- La procedure [liberer] permet de liberer un emplacement dans un plateau
   procedure Liberer(P_Plateau : in out Plateau ; P_Ligne : Ligne ; P_Colonne : Colonne);
    -- La fonction [NouveauPlateau] retourne un nouveau plateau avec toutes les cases à vides
   function NouveauPlateau return Plateau;
   -- La fonction [EstLibre] test si un emplacement dans le plateau est libre ou pas
   function EstLibre(P_Plateau : Plateau ; P_Ligne : Ligne ; P_Colonne : Colonne) return boolean;
   -- La fonction [EstPlein] test si le plateau ne contient aucune case vide
   function EstPlein(P_Plateau : Plateau) return boolean;
   -- La fonction [Gagnant] test si le pion passer en parametre a gagné
   function Gagnant(P_Plateau : Plateau; P_Pion : Pion) return boolean;
   -- La fonction Afficher permet d'afficher le contenu d'un plateau
   procedure Afficher(P_Plateau : Plateau);
   -- La fonction [Get_Cellule] retourne un pointeur sur une cellule a une position donnée
   function Get_Cellule(P_Plateau : Plateau ; P_Ligne : Ligne ; P_Colonne : Colonne) return Pointeur_Cellule;

private
   type Tableau2D is array( Ligne'Range, Colonne'Range) of Pointeur_Cellule;
   type Plateau is tagged record
      Coordonnees : Tableau2D;
      Etat : Natural := 0;
   end record;
end;
