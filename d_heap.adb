package body d_heap is

procedure buit (q: out heap) is
	begin
		q.n := 0;
	end buit;

function es_buit (q: in heap) return boolean is
   begin
      return q.n = 0;
   end es_buit;

procedure posa (q: in out heap; x: in item) is
	  a: mem_space renames q.a;
	  n: natural renames q.n;
      i: natural;	--indice superior
      pi: natural;	--indice padre nodo i

      begin
      if n = size then raise space_overflow; end if;
      n:= n + 1; i:= n; pi:= n/2;
      while pi > 0 and then a(pi) > x loop
         a(i) := a(pi); i:= pi; pi := i/2;
      end loop;
      a(i) := x;
   end posa;

procedure elimina_darrer (q: in out heap) is
      a: mem_space renames q.a;
      n: natural renames q.n;
      i: natural;
      ci: natural;
      x: item;
   begin
      if n = 0 then raise bad_use; end if;
      x := a(n); n := n - 1;
      i := 1; ci := i * 2;
      if ci < n and then a(ci+1)< a(ci) then
         ci:= ci+1;
      end if;
      while ci <= n and then a(ci)< x loop
         a(i):= a(ci);i:=ci;ci:= i*2;
         if ci<n and then a(ci+1) < a(ci) then ci:= ci+1; end if;
      end loop;
      a(i):= x;
   end elimina_darrer;

function darrer	(q: in heap) return item is
   begin
      return q.a(1);
   end darrer;

end d_heap;
