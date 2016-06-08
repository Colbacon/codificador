package body arbre_b is
	
	procedure buit (t: out arbre) is
		p: pnode renames t.arrel;
	begin
		p:= null;
	end buit;
		
	function es_buit (t: in arbre) return boolean is
		p: pnode renames t.arrel;
	begin
		return p=null;
	end es_buit;
	
	--Donat un arbre, retorna el tipus de node
	procedure arrel (t: in arbre; tnd: out tipusdenode) is 
		p: pnode renames t.arrel;
	begin
		tnd:= p.tn;
	exception
		when storage_error => raise space_overflow;
	end arrel;
	
	--Construeix arbre intermig
	procedure construeix (t: out arbre; lr, rt: in arbre; f: out float) is 
		pl: pnode renames lr.arrel;
		pr: pnode renames rt.arrel;
		p: pnode;
	begin
		t.f:= lr.f + rt.f; f:= t.f;
		p:= new node'(npas, pl, pr);
		t.arrel:= p;
	exception 
		when storage_error => raise space_overflow;
	end construeix;
		
	--Construeix arbre fulla
	procedure construeix (t: out arbre; x: in item; f: in float) is --!float asociado
		p:pnode;
	begin
		t.f:= f;
		p:= new node'(nitem, x);
		t.arrel:= p;
	exception
		when storage_error => raise space_overflow;
	end construeix;
	
	--Retorna fill esquerra
	procedure esquerra(t: in arbre; lt: out arbre) is
		p:  pnode renames t.arrel;
		pl: pnode renames lt.arrel;
	begin
		pl:= p.l;
	exception
		when constraint_error => raise bad_use;
	end esquerra;
	
	--Retorna fill dret
	procedure dreta	(t: in arbre; rt: out arbre) is
		p:  pnode renames t.arrel;
		pr: pnode renames rt.arrel;
	begin
		pr:= p.r;
	exception
		when constraint_error => raise bad_use;
	end dreta;
	
	procedure obtenir_item (t: in arbre; x: out item) is
		p: pnode renames t.arrel;
	begin
		x:= p.x;
	end obtenir_item;
	
	function "<" (x1, x2: in arbre) return boolean is
	begin
		return x1.f < x2.f;
	end "<";
	
	function ">" (x1, x2: in arbre) return boolean is
	begin
		return x1.f > x2.f;
	end ">";
end arbre_b;
