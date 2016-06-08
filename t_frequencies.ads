package t_frequencies is
   type abecedari is private;
	
   	subtype indexabc is character range ' '..'z';
	bad_it : exception;

	procedure tbuida (tfreq: out abecedari);
    procedure omple (tfreq: out abecedari; fname: in String ; ok: out boolean ) ;
	procedure mostra (tfreq : in abecedari) ;
	
    type iterador is private;
	procedure primer (ce: in abecedari; it: out iterador);
	procedure succesor (ce: in abecedari; it: in out iterador);
	procedure consulta (ce: in abecedari; it: in iterador; c: out indexabc; v: out float);
	function esValid (it: in iterador) return boolean;
	
	pragma inline (primer , succesor , consulta , esValid ) ;
	
private	
	type abecedari is array (indexabc) of float;
	type iterador is
		record
		i: indexabc;
		valid: boolean;
		end record;	
end t_frequencies ;
