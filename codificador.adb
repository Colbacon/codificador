with Ada.Text_IO, ADA.Integer_Text_IO; 
use Ada.Text_IO, ADA.Integer_Text_IO;
with Ada.Strings.Bounded, Ada.Sequential_IO; 

package body codificador is

package SB is new Ada.Strings.Bounded.Generic_Bounded_Length(indexabc'Range_Length-1);

--Declarió de les estructures a utilizar
type t_cod is array (indexabc) of SB.Bounded_String; --taula codificació

type transicio is
	record
		e_inicial: natural;
		simbol: natural;
		e_final: natural;
		simbolc: character;
	end record;
	
type matriu_estat is array ( natural range <>, natural range <>) of natural;
type matriu_simbol is array ( natural range <>) of character;
type automat(n: natural) is 
	record 
		m_e: matriu_estat (1..n, 0..1);
		m_s: matriu_simbol (1..n);
	end record;
	
--Fi de la declaració de les estructures

package FitxerCo is new Ada.Sequential_IO(t_cod);
package FitxerDe is new Ada.Sequential_IO(transicio);
use FitxerCo, FitxerDe;

procedure codificar_f(tfreq: in abecedari; a: out mitree.arbre) is
package miheap is new d_heap (size => indexabc'Range_Length, item => mitree.arbre, "<" => mitree."<", ">" => mitree.">");
use miheap;
	it: iterador;
    ti, t, rt, lt: mitree.arbre;
	h: miheap.heap;
	v: float;
	c: indexabc;
begin
		buit(h);
		mitree.buit(ti);
		primer(tfreq, it);
		while(esValid(it)) loop --Creació e introducció de l'arbre dins el heap.
			consulta(tfreq, it, c, v);  
			mitree.construeix(ti, c, v);
			posa(h, ti); 
			succesor(tfreq, it);
		end loop;
		
		mitree.buit(lt); mitree.buit(t); mitree.buit(rt);
		while not miheap.es_buit(h) loop
			lt:= miheap.darrer(h);
			miheap.elimina_darrer(h);
			if miheap.es_buit(h) then --si només hi havia un element, aquest serà l'arbre final
				a:= lt;
			else 
			rt:= miheap.darrer(h);
			miheap.elimina_darrer(h);
			mitree.construeix(t, lt, rt, v);		
			miheap.posa(h, t); 
			end if;
		end loop;
		
end codificar_f;

procedure generar_transicio (FDe: in out FitxerDe.File_Type; ei: in natural; simbol: in natural; ef: in natural; c: in character) is
	tr: transicio;
begin
	tr.e_inicial:= ei;
	tr.simbol:= simbol;
	tr.e_final:= ef;
	tr.simbolc:= c;
		
	FitxerDe.Write (FDe, tr);
end generar_transicio;

procedure profunditat (a: in mitree.arbre; estat: in out natural; codi: in out SB.Bounded_String; tcod: in out t_cod; FDe: in out FitxerDe.File_Type) is 
	use mitree;
	use SB;

	tdn: tipusdenode;
	lt, rt: mitree.arbre;
	c_s: SB.Bounded_String; --codi següent;
	e_a: natural:= estat; --estat actual;
	c: character;
	
begin
	mitree.arrel(a,tdn);	--Obtenim el tipus de node de l'arbre;
	if tdn = mitree.npas then  -- si node pare
		estat:= estat+1; c_s:= codi & "0"; --S'obté l'estat y codi de la següent profunditat
		generar_transicio(FDe, e_a, 0, estat, '&' ); 
		mitree.esquerra(a,lt); 
		profunditat(lt, estat, c_s, tcod, FDe); --Profunditat cap el fill esquerra
		
		estat:= estat+1; c_s:= codi & "1";
		generar_transicio(FDe, e_a, 1, estat, '&'); codi:= codi & "1";
		mitree.dreta(a,rt);
		profunditat(rt, estat, c_s, tcod, FDe); --Profunditat cap el fill dret
		
	else -- si node fill;
		mitree.obtenir_item(a, c);	--Es genera l'ultima transicio d'aquell ramatge
		generar_transicio(FDe, estat, 0, 0, c);
		generar_transicio(FDe, estat, 1, 0, c);
		tcod(c):= codi;		--S'obté la codifiació del caracter.
	end if;
end profunditat;

procedure generar_f (a: in mitree.arbre; fname1: in String; fname2: in String) is
	FCo: FitxerCo.File_Type;
	FDe: FitxerDe.File_Type;
	Fe:  Ada.Text_IO.File_Type;
	estat: integer:=1;
	tcod: t_cod;
	codi: SB.Bounded_String;
begin
	Create (FDe, Mode => OUT_File, Name => fname2);
	Create (Fe , Mode => OUT_File, Name => "estats.n");
	
	profunditat (a, estat, codi, tcod, FDe); --Inicia el recorregut recursiu de l'arbre

	Create (FCo, Mode => OUT_File, Name => fname1);	
	Write (FCo, tcod);
	ADA.Integer_Text_IO.Put(Fe, estat);
	
	Close(FCo);
	Close(FDe);
	Close(Fe);
end generar_f;


procedure codificar (arxiu1: in String; arxiu2: in String; arxiu3: in String) is 			
	f_entrada, f_sortida: Ada.Text_IO.File_Type;
	FCo: FitxerCo.File_Type;
	c: character;
	tcod: t_cod;	
begin
	Open (f_entrada, Mode => IN_File, Name => arxiu1);
	Open (FCo, Mode => IN_File, Name => arxiu2); 
	Create (f_sortida, Mode => OUT_File, Name => arxiu3);
	 
	Read(FCo,tcod);
	
	while not End_Of_File (f_entrada) loop
		get (f_entrada, c);
		if c in indexabc'range then
			Put(SB.To_String(tcod(c)));
			Put(f_sortida, SB.To_String(tcod(c)));
		end if;			
	end loop;
	Close (f_entrada);
	Close (FCo);
	Close (f_sortida);
end codificar;

procedure decodificar0 (arxiu1: in String; arxiu2: in String; arxiu3: in String; n_e: natural) is
	f_entrada, f_sortida: Ada.Text_IO.File_Type;
	FDe: FitxerDe.File_Type;
	a: automat(n_e);
	tr: transicio;
	e: natural:= 1; --estat actual
	e_s: natural;
	c: character;
	i: integer;	
begin
	Open (f_entrada, Mode => IN_File, Name => arxiu1); 
	Open (FDe, Mode => IN_File, Name => arxiu2);
	Create (f_sortida, Mode => OUT_File, Name => arxiu3);
	--carregar l'automat
	while not End_Of_File (FDe) loop
		Read(FDe, tr);	
		a.m_e(tr.e_inicial, tr.simbol):= tr.e_final;	
		a.m_s(tr.e_inicial):= tr.simbolc;
	end loop;
	
	--Decodificació de l'entrada
	while not End_Of_File (f_entrada) loop
		get (f_entrada, c);
		i:=  Character'pos(c) - 48;
		e_s:= a.m_e(e, i);
		if a.m_e(e_s, i) = 0  then --si l'estat següent és final
			Put(a.m_s(e_s));
			Put(f_sortida, a.m_s(e_s));
			e:= 1;
		else
			e:= e_s;
		end if;
	end loop;
	Close(f_entrada);
	Close(FDe);
	Close(f_sortida);
end decodificar0;
	
procedure decodificar (arxiu1: in String; arxiu2: in String; arxiu3: in String) is
		Fe:  Ada.Text_IO.File_Type;
		c: character;
		i: integer;
		n_e: natural:= 0;
begin
		Open (Fe,  Mode => IN_File, Name => "estats.n");
		--Obté el nombre de estats de les transicions
		while not End_Of_File (Fe) loop
			get(Fe,c);
			i:= Character'pos(c) - 48;
			if  i /= -16 then --bota els espais en blanc que hi ha debut al tamany del tipus
				n_e:= n_e*10;
				n_e:= n_e+i;
			end if;
		end loop;
		decodificar0(arxiu1, arxiu2, arxiu3, n_e);
		Close(Fe);
	end decodificar;
end codificador;



















