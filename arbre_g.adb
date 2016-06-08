with t_frequencies, arbre_b, d_heap;  --hablarlo con alex!!!
package body codificador is

procedure codificar_f(tfreq: in abecedari; a: out arbre) is
	tfreq: vfreq renames tfreq.freq;
	it: iterador;
	tp, ti, t: arbre;
	p: pnode;
	lt, rt: pnode;
	x: item;
	f: float;
	h: heap;
	fi: boolean;
begin
		it:= new iterador;
		it.valid:= false;
		heap:= new heap; 
		d_heap.buit(h);
		t_frequencies.primer(tfreq, it);
		
		while(esValid(it)) loop --Creació e introducció de l'arbre dins el heap.
		f:= tfreq(it.i); x:= i; 
		arbre_b.construeix(ti, x, f);
		d_heap.posa(h, ti); 
		
		t_frequencies.succesor(tfreq, it);
		
		end loop;
		
		fi:= false;
		
		while d_heap.es_buit(h) and not fi loop
			lt:= d_heap.darrer(h);
			d_heap.eliminar_darrer(h);
			rt:= d_heap.darrer(h);
			d_heap.eliminar_darrer(h);
			
			if d_heap.es_buit(h) then fi:= true; end if;
			
			f:= lt.f + rt.f;
			arbre_b.construeix(tn, lt.arrel, rt.arrel, f);
			
			if not fi then d_heap.posa(h, tn); end if;
		end loop;
		
		a:= tn;
end codificar_f;

end arbre_g;
