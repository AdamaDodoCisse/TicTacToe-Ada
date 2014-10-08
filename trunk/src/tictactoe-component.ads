package Tictactoe.Component is

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
   -- La fonction [Get_Case] renvoie la case du plateau a la position P_Ligne, C_Colonne,
   function Get_Case(P_Plateau : Plateau ; P_Ligne : Ligne ; P_Colonne : Colonne) return Case_Plateau;
   -- La fonction [Get_Pion] renvoie le pion de la case passer en paramètre
   -- Attention : Elle leve une exception de type Not_Pion_Exception si la case est vide
   function Get_Pion(P_Case_Plateau : Case_Plateau) return Pion;
   -- Permet d'afficher le contenu d'un plateau
   procedure afficher(P_Plateau : Plateau);

end Tictactoe.Component;
