with Ada.Command_Line, Ada.Text_IO, Ada.Strings.Unbounded;
with codificador;
use codificador;


procedure codec is
	package SU renames Ada.Strings.Unbounded;
	package T_IO renames Ada.Text_IO;
	package CL renames Ada.Command_Line;
    
	opc: SU.Unbounded_String :=  SU.To_Unbounded_String(CL.Argument(1)); --opció (c/d)
	arxiu1: SU.Unbounded_String :=  SU.To_Unbounded_String(CL.Argument(2)); --entrada d'on llegir
	arxiu2: SU.Unbounded_String :=  SU.To_Unbounded_String(CL.Argument(3)); -- fitxer *.co o *.de
    arxiu3: SU.Unbounded_String :=  SU.To_Unbounded_String(CL.Argument(4)); --sortida tractada
    
    opcio: String:= SU.To_String(opc);
begin
	if opcio = "c" then 
		codificar(SU.To_String(arxiu1), SU.To_String(arxiu2), SU.To_String(arxiu3));
	elsif opcio = "d" then
		decodificar(SU.To_String(arxiu1), SU.To_String(arxiu2), SU.To_String(arxiu3));
	else
		T_IO.Put_line("Opció incorrecta");
	end if;
end codec;























