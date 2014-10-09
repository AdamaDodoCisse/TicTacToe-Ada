Package body Game is

   function  Get_Pion(J:Joueur) return Pion is
   begin
      if Get_Id(J)=1 then
         return X;
      else
         return O;
      end if;
   end Get_Pion;

   procedure Affichage(P_Plateau: Tictactoe.Plateau.Plateau) is
   begin
      For i in ligne loop
         For j in Colonne loop
            Put("|");
            if P_Plateau.EstLibre(i,j) then
               Put("  ");
            else
                Put(Pion'Image(Get_Pion(P_Plateau.Get_Cellule(i,j))));
            end if;
         end loop;
         Put_Line("|");
      end loop;
   end Affichage;

   procedure Jouer_Tour(P:in out Tictactoe.Plateau.PLateau;J:Joueur) is
      begin
      case Get_Type(J) is
      When 1=>
         Reel(P,J,Get_Pion(J));
      when 2=>
         Put_Line("Facile");
         Facile(P,Get_Pion(J));
      when 3=>
         Put_Line("Moyen");
         Moyen(P,Get_Pion(J));
      when 4=>
         Put_Line("Difficile");
         Difficile(P,Get_Pion(J));
      end case;

   end Jouer_Tour;

      Procedure Inscrire_Joueurs(J:in out Jeu) is
         J1:Joueur;
         J2:Joueur;
      begin
         For i in 1..2 loop
            Put_Line("Joueur numéro " & Integer'Image(i) & " Saisissez votre nom");
            case i is
            when 1=>
               Set_Name(J1,To_Unbounded_String(Get_Line));
               Set_Id(J1,i);
               Set_Type(J1);
               J.Tab_j(i):=J1;
            when 2=>
               Set_Name(J2,To_Unbounded_String(Get_Line));
               Set_Id(J2,i);
               Set_Type(J2);
               J.Tab_j(i):=J2;
            end case;
         end loop;
         --Put_Line(ASCII.ESC & "[2J");
      end Inscrire_Joueurs;

      procedure Jouer is
         J:Jeu;
         cpt:Integer;
      begin
         cpt:=0;
         J.P:=NouveauPlateau;
         Inscrire_Joueurs(J);
         while EstPlein(J.P)=False and not Gagnant(J.P,Get_Pion(J.Tab_j(1))) and not Gagnant(J.P,Get_Pion(J.Tab_j(2))) loop
            Affichage(J.P);
               Jouer_Tour(J.P,J.Tab_j((cpt mod 2)+1));
               --Put(ASCII.ESC & "[2J");
            cpt:=cpt+1;
         end loop;
      end Jouer;

   end Game;
