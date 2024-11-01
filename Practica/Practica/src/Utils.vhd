---- Compilar el package y simular el testbench. 
---  a) Describir el funcionamiento de los atributos de tipos ('Val) y de arreglos ('Left y 'Right) predefinidos
----- usados en el package body
---  b) En el testbench hay 3 declaraciones USE exactamente id�nticas. Analizar y determinar cu�l o cu�les ------- de esas sentencias pueden sacarse sin que se afecte el uso y funcionamiento de los subprogramas del 
----- package.
--- c) �C�mo el compilador VHDL se d� cuenta a cual funci�n "Convert" debe llamar en el testbench? 

package Utils is
	procedure Clock(signal C: out Bit; HT,LT: Time);
	
	function Convert(N,L:Natural) return Bit_Vector;
	function Convert(B:Bit_Vector) return Natural;

end Utils;

package body Utils is
      procedure Clock(signal C: out Bit; HT,LT: Time) is
      begin
	loop
		C <='1' after LT, '0' after LT + HT;
		wait for LT + HT;
	end loop;	 		
      end;
	
      function Convert(N,L:Natural) return Bit_Vector is
	variable Temp: Bit_Vector(L - 1 downto 0);				
	variable Value:Natural:= N;						
      begin
	for i in Temp'Right to Temp'Left loop
		Temp(i):=Bit'Val(Value mod 2);
		Value:=Value / 2;
	end loop;
	return Temp;
      end;

      function Convert(B:Bit_Vector) return Natural is
	variable Temp: Bit_Vector(B'Length-1 downto 0):=B;				
	variable Value:Natural:= 0;						
      begin
	for i in Temp'Right to Temp'Left loop
		if Temp(i) = '1' then
			Value:=Value + (2**i);
		 end if;			
	end loop;
	return Value;
      end;

end Utils;
--------------------------Testbench-------------------------

entity Test_Utils is end;

use work.Utils.all;

architecture Driver of Test_Utils is
  signal N: Natural;
  signal B: Bit_Vector(5 downto 0);
  signal C: Bit;

  use work.Utils.all;

begin

  CLK: Clock(C, 10 ns, 10 ns);
  
  process
    use work.Utils.all;
  begin  
    for i in 0 to 31 loop
            B <= Convert (i, B'Length) after 10 ns;
            wait for 10 ns;
        end loop;
        wait;
  end process;

  N <= Convert (B) after 1 ns;

end;

