with t_frequencies, Ada.Text_IO.Float_IO;
package body t_frequencies is
	
	procedure tbuida (tfreq: out abecedari) is
		freq: vfreq renames tfreq.freq;
	begin
		freq:= (others => 0.0);
	end tbuida;
		
	procedure mostra (tfreq: in abecedari) is 
		freq: vfreq renames tfreq.freq;
	begin
		for c in indexabc loop
			put(freq(c)); put("");
		end loop;
	end mostra;
	
	procedure omple (tfreq: out abecedari; fname: in String; ok: out boolean) is
		freq: vfreq renames tfreq.freq;
		
		F_Entrada: File_Type;
		c: character;
		n: float;
	begin
		Open (F_Entrada, Mode => In_File, Name => fname); 
		ok:= is_open (F_Entrada);
		
		while not End_Of_File (F_Entrada) loop
			n:= n+1.0;
			get (F_Entrada, c);
			if c in indexabc then
			freq(c):= freq(c)+1.0;
			end if;
		end loop;
		
		for c in indexabc loop
			freq(c):= (freq(c)/n);
		end loop;
	end omple;
	
	--iterador
	procedure primer (ce: in abecedari; it: out iterador) is
		freq: vfreq renames ce.freq;
		i: indexabc renames it.i;
		valid: boolean renames it.valid;		
	begin
		i:= indexabc'first;
		while freq(i)=0.0 and i < indexabc'Last loop
			i:= indexabc'succ(i);
		end loop;
		if freq(i)=0.0 then
			valid:= false;
		else
			valid:= true;
		end if;
	end primer;
	
	procedure succesor (ce: in abecedari; it: in out iterador)is
		freq: vfreq renames ce.freq;
		i: indexabc renames it.i;
		valid: boolean renames it.valid;
	begin
		if not valid then raise bad_it; end if;
		if i<indexabc'last then
			i:= rang'succ(i);
			while freq(i)=0.0 and i<indexabc'last loop
				i:= indexabc'succ(i);
			end loop;
			if  freq(i)=0.0 then 
				valid:= false;
			else
				valid:= true;
			end if;
		else
			valid:= false;
		end if;
	end succesor;
	
	procedure consulta (ce: in abecedari; it: in iterador; c: out indexabc; v: out float) is
		freq: vfreq renames ce.freq;
		i: indexabc renames it.i;
		valid: boolean renames it.valid;
	begin 
		if not valid then raise bad_it; end if;
		c:= i;
		v:= freq(i);
	end consulta; 
	
	function esValid (it: in iterador) return boolean is
	begin
		return it.valid;
	end esValid;
	
	

end t_frequencies;
	
