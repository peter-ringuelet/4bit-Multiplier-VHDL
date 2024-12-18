use work.Utils.all;  -- Importa el paquete Utils con Clock y Convert

entity Test_Mul4 is
end Test_Mul4;

architecture Test of Test_Mul4 is
    -- Declaraci�n del componente a testear
    component Mul4
        port (
            A_4, B_4: in  Bit_Vector(3 downto 0);
            STB, CLK: in  Bit;
            Result: out Bit_Vector(7 downto 0);
            Done: out Bit
        );
    end component;

    -- Se�ales de prueba
    signal A_4, B_4 : Bit_Vector(3 downto 0);
    signal STB, CLK : Bit;
    signal Result   : Bit_Vector(7 downto 0);
    signal Done     : Bit;

begin
	-- Generaci�n del reloj
    Clock(CLK, 6 ns, 6 ns);  -- Procedimiento que genera la se�al de reloj
	
    -- Instancia del multiplicador usando mapeo posicional
    mul: Mul4 port map(A_4, B_4, STB, CLK, Result, Done);

    -- Inicializaci�n
    A_4 <= Convert(2,4);  -- Convierte el n�mero 9 en un vector de 4 bits
    B_4 <= Convert(9,4);      -- Convierte el n�mero 2 en un vector de 4 bits

    -- Inicio de la multiplicaci�n
    STB <= '0', '1' after 20 ns, '0' after 40 ns; 
	
	assert (Done = '0') report "Simulacion finalizada con exito. " severity Note;	
	
end Test;



