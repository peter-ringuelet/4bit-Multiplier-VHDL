entity Mul4 is
    port (
        A_4, B_4: in  Bit_Vector(3 downto 0);
        STB, CLK: in  Bit;
        Result: out Bit_Vector(7 downto 0);
        Done: out Bit
    );
end Mul4;

architecture mul of Mul4 is

    -- Componentes
    component ShiftN
        port (CLK, CLR, LD, SH, DIR: in Bit; D: in Bit_Vector; Q: out Bit_Vector);
    end component;
    
    component Adder8
        port (A, B: in Bit_Vector(7 downto 0); Cin: in Bit; Cout: out Bit; Sum: out Bit_Vector(7 downto 0));
    end component;
    
    component Controller
        port (STB, CLK, LSB, Stop: in Bit; Init, Shift, Add, Done: out Bit);
    end component;
    
    component Accumulator
        port (D: in Bit_Vector(7 downto 0); Clk, Clr, LD: in Bit; Q: out Bit_Vector(7 downto 0));
    end component;

    -- Señales internas
    signal QA, QB, Sum, Res, A_8, B_8: Bit_Vector(7 downto 0);
    signal Init, Shift, Add, Stop: Bit;

    -- Función auxiliar que replica la compuerta NOR
    function compuerta_NOR(input_vector: Bit_Vector) return Bit is
    begin
        if input_vector = "00000000" then
            return '1';
        else
            return '0';
        end if;
    end compuerta_NOR;

begin
    -- Extender los operandos A y B a 8 bits (rellenando con ceros a la izquierda)
    A_8 <= "0000" & A_4;
    B_8 <= "0000" & B_4;

    -- Instancia de Shift Register A (SRA)
    SR_A: ShiftN port map(CLK, '0', Init, Shift, '0', A_8, QA);

    -- Instancia de Shift Register B (SRB) 
    SR_B: ShiftN port map(CLK, '0', Init, Shift, '1', B_8, QB);

    -- Generación de la señal de Stop usando la función compuerta_NOR
    Stop <= compuerta_NOR(QA);

    -- Instancia del Adder8 
    Adder: Adder8 port map(Res, QB, '0', open, Sum);

    -- Instancia del Acumulador
    ACC: Accumulator port map(Sum, CLK, Init, Add, Res);

    -- Instancia de la FSM Controller
    FSM: Controller port map(STB, CLK, QA(0), Stop, Init, Shift, Add, Done);

    -- Asignación de la salida del resultado
    Result <= Res;

end mul;

