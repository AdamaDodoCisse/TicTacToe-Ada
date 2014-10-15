Package body Game is

   function  Get_Pion(J:Joueur) return Pion is
   begin
      if Get_Id(J)=1 then
         return X;
      else
         return O;
      end if;
   end Get_Pion;

   procedure Affichage(P_Plateau : Tictactoe.Plateau.Pointeur_Plateau) is
   begin
      For i in ligne loop-- Pour chaque ligne du plateau
         For j in Colonne loop-- Pour chaque colonne du plateau
            Put("|"); -- On affiche un | pour marquer la séparation entre les cases du plateau
            if Tictactoe.Cellule.EstLibre(Tictactoe.Plateau.Get_Cellule(P_Plateau,i,j)) then
               --Si la celule est vide
               Put(" ");-- On affiche " "
            else --Sinon
               Put(Pion'Image(Get_Pion(Tictactoe.Plateau.Get_Cellule(P_Plateau,i,j))));
               --On affiche le pion de cette Cellule en utilisant Get_Pion
            end if;
         end loop;
         Put_Line("|");-- On affiche un  | à chaque fois que l'on fini de parcourir une ligne.
      end loop;
   end Affichage;

   procedure Jouer_Tour(P : Tictactoe.Plateau.Pointeur_Plateau;J:Joueur) is
   begin
      case Get_Type(J) is-- En fonction du type du joueur
      When 1=>-- Si c'est un Humain
         Reel(P,J,Get_Pion(J));-- On laisse l'utilisateur jouer
      when 2=>--Si c'est un CPU de niveau Facile
         Facile(P,Get_Pion(J));--On appelle la fonction Facile pour jouer
      when 3=>--Si c'est un CPU de niveau Moyen
         Moyen(P,Get_Pion(J));--On appelle la fonction Moyen pour jouer
      when 4=>-- Si c'est un CPU de niveau Difficile
         Difficile(P,Get_Pion(J));--On appelle la fonction Difficile pour jouer
      end case;
   end Jouer_Tour;

   Procedure Inscrire_Joueurs(J:in out Jeu) is
      J1:Joueur;
      J2:Joueur;
   begin
      For i in 1..2 loop
         Put_Line(ASCII.ESC & "[2J");
         Put_Line("Joueur numéro " & Integer'Image(i) & " Saisissez votre nom");
         --On demande à l'utilisateur de saisir son nom
         case i is
            when 1=>
               Set_Name(J1,To_Unbounded_String(Get_Line));
               --On initialise le nom du joueur
               Set_Id(J1,i);
               --Son id est autmatiquement initialisé en fonction de i
               Set_Type(J1);
               --On appelle la procedure pour initialiser le type du joueur
               J.Tab_j(i):=J1;
               --On ajoute ce joueur au tableau
            when 2=>
               Set_Name(J2,To_Unbounded_String(Get_Line));
               Set_Id(J2,i);
               Set_Type(J2);
               J.Tab_j(i):=J2;
         end case;
      end loop;
      Put_Line(ASCII.ESC & "[2J");
   end Inscrire_Joueurs;

   procedure Jouer is
      J:Jeu;
      cpt:Integer;
      choice : integer;
   begin
      cpt:=0;--Compteur de tour jouer
      J.P:=NouveauPlateau;--Initialise le plateau du jeu
      Inscrire_Joueurs(J);--On inscrit les joueurs pour la partie
      while EstPlein(J.P)=False and not Gagnant(J.P,Get_Pion(J.Tab_j(1))) and not Gagnant(J.P,Get_Pion(J.Tab_j(2))) loop
         --Tant que le plateau n'est pas plein et que le joueur 1 n'est pas gagnant et que le joueur 2 n'est pas gagnant.
         Affichage(J.P);-- Affichage du plateau
         Jouer_Tour(J.P,J.Tab_j((cpt mod 2)+1));--On fait jouer le joueur courant.
         --(cpt mod 2) + 1 permet de savoir à qui est-ce le tour de jouer.
         Put(ASCII.ESC & "[2J");-- Efface le contenu de la console
         cpt:=cpt+1;--On incrémente le compteur de tour.
      end loop;
      Affichage(J.P);
      if Gagnant(J.P,Get_Pion(J.Tab_j(1))) or Gagnant(J.P,Get_Pion(J.Tab_j(2))) then
         --Si il y a un gagnant
         if Gagnant(J.P,Get_Pion(J.tab_j(1))) then
            --Si c'est le joueur 1
            put_line( to_string(get_name(j.tab_j(1))) & " a gagné");
            --On indique que c'est lui qui à gagné.
         else
            put_line(to_string(get_name(j.tab_j(2))) & " a gagné");
         end if ;
      else--Sinon on affiche "Match Nul"
         put_line("Match nul......");
      end if ;
      put_line("voulez-vous refaire une partie ? 1=> oui ; 0=> non  ");
      --On demande à l'utilisateur si il veut rejouer
      choice := integer'value(get_line);
      if choice = 1 then
         --Si il saisit 1 alors on rappelle la fonction jouer pour relancer.
         Jouer;
      end if ;
   end Jouer;

end Game;
