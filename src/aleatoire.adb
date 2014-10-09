function Aleatoire(A:Integer ; B:integer) return Integer is
   subtype Intervalle is Integer range A .. B;
   package Aleatoire is new Ada.Numerics.Discrete_Random(Intervalle);
   use Aleatoire;

   Nombre     : Integer;
   Generateur : Generator;
begin
   Reset(Generateur);
   Nombre:=Random(Generateur);
   return Nombre;
end aleatoire;
