generic
	type item is private;
package arbre_b is 
	type arbre is private;
	type tipusdenode is (npas, nitem);
	
	bad_use: exception;
	space_overflow: exception;
	
	procedure buit			(t: out arbre);
	function es_buit		(t: in arbre) return boolean;
	procedure arrel			(t: in arbre; tnd: out tipusdenode);
	procedure construeix 	(t: out arbre; lr, rt: in arbre; f: out float);
	procedure construeix	(t: out arbre; x: in item; f: in float);
	procedure esquerra		(t: in arbre; lt: out arbre);
	procedure dreta			(t: in arbre; rt: out arbre);
	procedure obtenir_item	(t: in arbre; x: out item);
	function "<" (x1, x2: in arbre) return boolean;
	function ">" (x1, x2: in arbre) return boolean;

private 
	type node;
	type pnode is access node;
	type node (tn: tipusdenode) is
		record
			case tn is
				when npas =>
					l, r: pnode;
				when nitem =>
					x: item;
			end case;
		end record;
		
	type arbre is
		record
			f: float; --freqüencia de l'arbre
			arrel: pnode;
		end record;
end arbre_b; 
