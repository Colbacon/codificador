With Ada.Strings.Unbounded, Ada.Command_Line;
with codificador, t_frequencies;
use codificador, t_frequencies;

procedure g_fichero is

	package SU renames Ada.Strings.Unbounded;
	package CL renames Ada.Command_Line;
	
	entrada: SU.Unbounded_String :=  SU.To_Unbounded_String(CL.Argument(1)); --Text d'entrada
	fname1: SU.Unbounded_String :=  SU.To_Unbounded_String(CL.Argument(2)); --Nom del fitxer *.co
	fname2: SU.Unbounded_String :=  SU.To_Unbounded_String(CL.Argument(3)); --Nom del fitxer *.de
	
	tfreq: abecedari;
	a: mitree.arbre;
	ok: boolean;
begin
	tbuida (tfreq);
    omple (tfreq, SU.To_String(entrada), ok);
	
	codificar_f(tfreq, a);
	generar_f(a, SU.To_String(fname1), SU.To_String(fname2)); 
end g_fichero;
