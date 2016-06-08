with t_frequencies, d_heap, arbre_b;
use t_frequencies;


package codificador is 
	package mitree is new arbre_b (item => character);
	
	procedure codificar_f(tfreq: in abecedari; a: out mitree.arbre);
	procedure generar_f (a: in mitree.arbre; fname1: in String; fname2: in String);
	procedure codificar (arxiu1: in String; arxiu2: in String; arxiu3: in String);
	procedure decodificar (arxiu1: in String; arxiu2: in String; arxiu3: in String);
	
end codificador;

