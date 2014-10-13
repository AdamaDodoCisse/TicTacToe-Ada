with Graphisme;
use Graphisme;
with Gtk.Main;
procedure executable
is
   F : Graphisme.Pointeur_Fenetre;
begin
   F := NouvelleFenetre;
   Graphisme.show(P_Fenetre => F);

end executable;
