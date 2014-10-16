with Graphisme;
use Graphisme;
with Gtk.Main;
procedure executable
is
   F : Graphisme.Pointeur_Fenetre;
begin
   F := NouvelleFenetre;
   Graphisme.Afficher(P_Fenetre => F);

end executable;
