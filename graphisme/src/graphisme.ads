with Ada.Finalization; use Ada.Finalization;
with Gtk.Window;
with Gtk.Table;
with Tictactoe; use Tictactoe;
with Tictactoe.Plateau;
with gtk.Button;
with gtk.Handlers;
with gtk.Widget;
with Gtk.image;
with GNAT; use GNAT;
with GNAT.Directory_Operations;
with Tictactoe.IA;
with Gtk.Combo_Box_Text;
with Gtk.Label;
package Graphisme is
   type Fenetre is private;
   type Pointeur_Fenetre is access Fenetre;
   type Niveau_Jeu is (Facile, Moyen,Difficile);

   Dossier_Images : constant String := "../images" ;
   X_image : constant string := "../images/x.png";
   O_image : constant string := "../images/o.png";
   V_image : constant string := "../images/vide.png";

   Intelligences : constant array(Niveau_Jeu'Range) of access procedure(P_Plateau : Tictactoe.Plateau.Pointeur_Plateau ; P_Pion : Pion) :=
     (Facile => Tictactoe.IA.Facile'Access , Moyen => Tictactoe.IA.Moyen'Access, Difficile => Tictactoe.IA.Difficile'Access);


   function NouvelleFenetre return Pointeur_Fenetre;
   procedure show(P_Fenetre : Pointeur_Fenetre );
   function Cellule_En_Image(P_Fenetre : Pointeur_Fenetre; P_Ligne : Ligne; P_Colonne : Colonne)
                             return Gtk.Image.Gtk_Image;

private
   type Type_Buttons is array(Tictactoe.Ligne'Range, Colonne'Range) of Gtk.Button.Gtk_Button;
   type Type_Option is record
      Window : Gtk.Window.Gtk_Window;
      Combo_Box_Premier_Joueur : Gtk.Combo_Box_text.Gtk_Combo_Box_Text;
      Combo_Box_Second_Joueur : Gtk.Combo_Box_Text.Gtk_Combo_Box_Text;
      Nouvelle_Partie : Gtk.Button.Gtk_Button;
      Pion : Tictactoe.Pion := Tictactoe.X;
   end record;
   type Pointeur_Type_Option is access Type_Option;

   type Type_Menu is record
      Quitter : Gtk.Button.Gtk_Button;
      Recommencer : Gtk.Button.Gtk_Button;
      Option : Gtk.Button.Gtk_Button;
      Label : Gtk.Label.Gtk_Label;
      Commencer : boolean := false;
   end record;
   Type Pointeur_Type_Menu is access Type_Menu;

   type Type_Scene is record
      Window : Gtk.Window.Gtk_Window;
      Plateau : Tictactoe.Plateau.Pointeur_Plateau := Tictactoe.Plateau.NouveauPlateau;
      Buttons : Type_Buttons;
      Menu : Pointeur_Type_Menu := new Type_Menu;
   end record;
   type Pointeur_Scene is access Type_Scene;
   type Fenetre is new Controlled with record
      Scene : Pointeur_Scene := new Type_Scene;
      Terminer : Boolean := false;
      Option : Pointeur_Type_Option := new Type_Option;
   end record;
   package P_User_Callback is new Gtk.Handlers.User_Callback(Widget_Type => Gtk.Button.Gtk_Button_Record, User_Type => Pointeur_Fenetre);
end Graphisme;
