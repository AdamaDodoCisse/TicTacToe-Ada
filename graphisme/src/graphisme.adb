with Glib; use Glib;
with Ada.Text_IO; use Ada.Text_IO;
with gtk.main;
with Tictactoe.Cellule;
with Gtk.Enums;
use Gtk.Enums;
with Gtk.Box;
with Gtk.Widget; use Gtk.Widget;
with Gdk.Color; use Gdk.Color;

package body Graphisme is

   -------------------------------------------
   --- Procedure qui permet de colorer un Composant
   -------------------------------------------

   Procedure Couleur(Gw : access Gtk_Widget_Record'class ; C : String) is
   Begin
      Gw.Modify_Bg(State_Normal, Parse(C));
   End Couleur;
   ----------------------------------------------
   -- Gestion des evenements --
   ----------------------------------------------

   procedure redesinner(P_Fenetre :Pointeur_Fenetre) is
   begin
      for L in Tictactoe.Ligne'Range loop
         for C in  Tictactoe.Colonne'Range loop
            P_Fenetre.Scene.Buttons(L,C).Set_Image(Cellule_En_Image(P_Fenetre,L,C));
         end loop;
      end loop;
   end;

   procedure Get_Coordonnees
     (P_Gtk_Button : access Gtk.Button.Gtk_Button_Record'Class ;
      P_Ligne : in out Tictactoe.Ligne;
      P_Colonne :in out  Tictactoe.Colonne) is
   begin
      P_Ligne :=Tictactoe.Ligne'Value( P_Gtk_Button.Get_Name(P_Gtk_Button.Get_Name'First..P_Gtk_Button.Get_Name'First+1));
      P_Colonne := Tictactoe.Colonne'Value( P_Gtk_Button.Get_Name(P_Gtk_Button.Get_Name'First + 2..P_Gtk_Button.Get_Name'Last));
   end Get_Coordonnees;

   function estTourDe(P_Fenetre : Pointeur_Fenetre ; Valeur : String) return boolean
   is begin
      return (P_Fenetre.Option.Combo_Box_Premier_Joueur.Get_Active_Text = Valeur and
                P_Fenetre.Option.Pion = Tictactoe.X ) or (
                                                          P_Fenetre.Option.Combo_Box_Second_Joueur.Get_Active_Text = Valeur and
                                                            P_Fenetre.Option.Pion = Tictactoe.O and not P_Fenetre.Terminer) ;
   end estTourDe;

   function TourHumain( P_Fenetre :  Pointeur_Fenetre) return boolean
   is begin
      return estTourDe(P_Fenetre => P_Fenetre, valeur => "Humain");
   end TourHumain;

   function TourCPU(P_Fenetre : Pointeur_Fenetre) return boolean
   is
   begin
      return not estTourDe(P_Fenetre,  "") and not estTourDe(P_Fenetre, "Humain") ;
   end TourCPU;

   procedure Jouer_CPU( P_Fenetre : Pointeur_Fenetre) is
   begin
      if TourCPU(P_Fenetre) then
         if P_Fenetre.Option.Pion = Tictactoe.X then
            Intelligences(Niveau_Jeu'Value(P_Fenetre.Option.Combo_Box_Premier_Joueur.Get_Active_Text)).all(P_Fenetre.Scene.Plateau , Tictactoe.X);
         else
            Intelligences(Niveau_Jeu'Value(P_Fenetre.Option.Combo_Box_Second_Joueur.Get_Active_Text)).all(P_Fenetre.Scene.Plateau , Tictactoe.O);
         end if;
         if Tictactoe.Plateau.Gagnant(P_Fenetre.Scene.Plateau , P_Fenetre.Option.Pion) then
            P_Fenetre.Terminer := true;
         end if;
         if Tictactoe.Plateau.EstPlein(P_Fenetre.Scene.Plateau) then
            P_Fenetre.Terminer := true;
         end if;
         redesinner(P_Fenetre);
         P_Fenetre.Option.Pion := Tictactoe.suivant(P_Fenetre.Option.Pion);
      end if;


   end Jouer_CPU;

   procedure Buttons_Click_Evenement(Button : access Gtk.Button.Gtk_Button_Record'Class; P_Fenetre : Pointeur_Fenetre ) is
      P_Ligne : Tictactoe.Ligne := Tictactoe.Ligne'First;
      P_Colonne :Tictactoe.Colonne := Tictactoe.Colonne'First;
   begin
      Get_Coordonnees(Button,P_Ligne,P_Colonne);
      if Tictactoe.Cellule.EstLibre(Tictactoe.Plateau.Get_Cellule(P_Fenetre.Scene.Plateau,P_Ligne , P_Colonne)) then
         if TourHumain(P_Fenetre) then
            Tictactoe.Plateau.Tracer(P_Fenetre.Scene.Plateau, P_Ligne  , P_Colonne, P_Fenetre.Option.Pion);
            P_Fenetre.Option.Pion := Tictactoe.suivant(P_Fenetre.Option.Pion);
            redesinner(P_Fenetre);
            if Tictactoe.Plateau.Gagnant(P_Fenetre.Scene.Plateau , P_Fenetre.Option.Pion) then
               P_Fenetre.Terminer := true;
            end if;
            if Tictactoe.Plateau.EstPlein(P_Fenetre.Scene.Plateau) then
               P_Fenetre.Terminer := true;
            end if;
         end if;
      end if;

   end Buttons_Click_Evenement;



   procedure Button_Commencer_Evenement(Button : access Gtk.Button.Gtk_Button_Record'Class; P_Fenetre : Pointeur_Fenetre ) is
   begin

      if Button.Get_Label = "Rejouer" then
         P_Fenetre.Scene.Plateau := Tictactoe.Plateau.NouveauPlateau;
         P_Fenetre.Terminer := false;
         P_Fenetre.Option.Pion := Tictactoe.X;
         Button.Set_Label(Label => "Suivant");
         redesinner(P_Fenetre);
      end if;

      if TourCPU(P_Fenetre) then
         Jouer_CPU( P_Fenetre);
      end if;

      if P_Fenetre.Terminer then
         Button.Set_Label(Label => "Rejouer");
      end if;
   end Button_Commencer_Evenement;


   function Ligne_En_Guint(P_Ligne : Tictactoe.Ligne) return Guint is
      L1 : Guint := Guint'Val(Ligne'Pos(P_Ligne) - Ligne'Pos(Ligne'First));
   begin
      return L1;
   end;
   function Colonne_En_Guint(P_Colonne : Tictactoe.Colonne) return Guint is
      C1 : Guint := Guint'Val(Colonne'Pos(P_Colonne) - Colonne'Pos(Colonne'First));
   begin
      return C1;
   end;

   procedure Ajout_Button_Scene
     ( P_Fenetre : Pointeur_Fenetre;
       P_Gtk_Table : in out Gtk.Table.Gtk_Table;
       P_Ligne : Tictactoe.ligne;
       P_Colonne : Tictactoe.Colonne) is
   begin
      Gtk.Button.Gtk_New(Button => P_Fenetre.Scene.Buttons(P_Ligne,P_Colonne));
      P_Fenetre.Scene.Buttons(P_Ligne,P_Colonne).Set_Relief(Relief_None);
      P_Fenetre.Scene.Buttons(P_Ligne,P_Colonne).Set_Name(Name => Ligne'Image(P_Ligne) & Colonne'Image(P_Colonne));
      P_Gtk_Table.Attach(P_Fenetre.Scene.Buttons(P_Ligne,P_Colonne),Ligne_En_Guint(p_Ligne) , Ligne_En_Guint(P_Ligne)  + 1 , Colonne_En_Guint(P_Colonne) , Colonne_En_Guint(P_Colonne) + 1);
      P_Fenetre.Scene.Buttons(P_Ligne,P_Colonne).Set_Image(Image => Cellule_En_Image(P_Fenetre , P_Ligne, P_Colonne));
      P_User_Callback.Connect(P_Fenetre.Scene.Buttons(P_Ligne,P_Colonne), "clicked", Buttons_Click_Evenement'ACCESS, P_Fenetre );
   end Ajout_Button_Scene;

   procedure Initialize_Scene
     (P_Fenetre : Pointeur_Fenetre;
      P_Gtk_Horizontal : in out Gtk.Box.Gtk_Hbox;
      P_Gtk_Table : in out Gtk.Table.Gtk_Table;
      P_Gtk_Vertical : in out Gtk.Box.Gtk_Vbox) is
      Img_Header : Gtk.Image.Gtk_Image;
   begin
      Gtk.Image.Gtk_New(Img_Header, Filename => "../images/header.png");
      Gtk.Table.Gtk_New(P_Gtk_Table, Tictactoe.Ligne'Range_Length , Tictactoe.Colonne'Range_Length, true);
      Gtk.Box.Gtk_New_Vbox(P_Gtk_Vertical, false,0);
      for L in Tictactoe.Ligne'Range loop
         for C in Tictactoe.Colonne'Range loop
            Ajout_Button_Scene(P_Fenetre, P_Gtk_Table, L,C);
         end loop;
      end loop;
      P_Gtk_Table.Set_Size_Request(200,200);
      P_Gtk_Horizontal.Add(P_Gtk_Table);
      P_Gtk_Vertical.Add(Img_Header);
      P_Gtk_Vertical.Add(P_Gtk_Horizontal);
      P_Fenetre.Scene.Window.Add(P_Gtk_Vertical);
   end Initialize_Scene;


   procedure Ajouter_Items_Option(P_Fenentre : Pointeur_Fenetre) is
   begin
      P_Fenentre.Option.Combo_Box_Premier_Joueur.Append_Text("Humain");
      P_Fenentre.Option.Combo_Box_Second_Joueur.Append_Text("Humain");
      for Element in Niveau_Jeu'Range loop
         P_Fenentre.Option.Combo_Box_Premier_Joueur.Append_Text(Niveau_Jeu'Image(Element));
         P_Fenentre.Option.Combo_Box_Second_Joueur.Append_Text(Niveau_Jeu'Image(Element));
      end Loop;
   end Ajouter_Items_Option;

   procedure Initialize_Option
     (P_Fenetre : Pointeur_Fenetre;
      Box : Gtk.Box.Gtk_Hbox) is
      Box_H1 :Gtk.Box.Gtk_Hbox;
      Box_H2 : Gtk.Box.Gtk_Hbox;
      Lbl : Gtk.Label.Gtk_Label;
      LbL2 : Gtk.Label.Gtk_Label;
      Box_V : Gtk.Box.Gtk_Vbox;
      Btn : Gtk.Button.Gtk_Button;
   begin
      Gtk.Window.Gtk_New(P_Fenetre.Option.Window, Gtk.Enums.Window_Popup);
      Gtk.Box.Gtk_New_Vbox(Box_V,false,0);
      Gtk.Combo_Box_Text.Gtk_New(P_Fenetre.Option.Combo_Box_Premier_Joueur);
      Gtk.Combo_Box_Text.Gtk_New(P_Fenetre.Option.Combo_Box_Second_Joueur);
      Gtk.Button.Gtk_New(Btn, "Suivant");
      Gtk.Box.Gtk_New_Hbox(Box_H1, false,0);
      Gtk.Label.Gtk_New(LbL, "Joueur X ");
      Box_H1.add(lbl);
      Box_H1.add(P_Fenetre.Option.Combo_Box_Premier_Joueur);
      Gtk.Box.Gtk_New_Hbox(Box_H2, false,0);
      Gtk.Label.Gtk_New(LbL2, "Joueur O");
      Box_H2.add(lbl2);
      Box_H2.add(P_Fenetre.Option.Combo_Box_Second_Joueur);
      Box_V.Add(Box_H1);
      Box_V.Add(Box_H2);
      Box_V.Add(Btn);
      Ajouter_Items_Option(P_Fenetre);
      Box.add(Box_V);
      P_User_Callback.Connect(btn, "clicked", Button_Commencer_Evenement'ACCESS, P_Fenetre );
   end ;


   function NouvelleFenetre return Pointeur_Fenetre is
      P_Fenetre : Pointeur_Fenetre := new Fenetre;
      Table : Gtk.Table.Gtk_Table;
      Box : Gtk.Box.Gtk_Hbox;
      Box_V : Gtk.Box.Gtk_Vbox;

   begin
      Gtk.Box.Gtk_New_Hbox(Box, false,0);
      Box.Set_Size_Request(50,100);
      Gtk.Window.Gtk_New(P_Fenetre.Scene.Window, Gtk.Enums.Window_Toplevel);
      Couleur(P_Fenetre.Scene.Window, "#fff");
      P_Fenetre.Scene.Window.Set_Resizable(false);
      Gtk.Label.Gtk_New(P_Fenetre.Scene.Menu.Label, "");
      Initialize_Scene(P_Fenetre,Box,Table,Box_V);
      Initialize_Option(P_Fenetre, Box);
      Box_V.Add(P_Fenetre.Scene.Menu.Label);
      return P_Fenetre;
   end NouvelleFenetre;


   procedure show (P_Fenetre : Pointeur_Fenetre ) is
   begin
      P_Fenetre.Scene.window.Show_All;
      --  P_Fenetre.Option.Window.Show_All;
      Gtk.Main.main;
   end Show;

   function Cellule_En_Image
     (P_Fenetre : Pointeur_Fenetre;
      P_Ligne : Ligne;
      P_Colonne : Colonne)  return Gtk.Image.Gtk_Image is
      Img : Gtk.Image.Gtk_Image;
   begin
      if Tictactoe.Cellule.EstLibre(Cell => Tictactoe.Plateau.Get_Cellule(P_Fenetre.Scene.Plateau,P_Ligne,P_Colonne)) then
         Gtk.Image.Gtk_New(Image    => img,
                           Filename => V_image);
      else
         if  Tictactoe.Cellule.Get_Pion(Cell => Tictactoe.Plateau.Get_Cellule(P_Fenetre.Scene.Plateau,P_Ligne,P_Colonne)) = Tictactoe.X then
            Gtk.Image.Gtk_New(Image    => img,
                              Filename => X_image);
         else
            Gtk.Image.Gtk_New(Image    => img,
                              Filename => O_image);
         end if;
      end if;
      return Img;
   end Cellule_En_Image;


begin
   gtk.main.Init;
end Graphisme;
