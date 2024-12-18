entity Accumulator is
    port (
        D    : in  Bit_Vector(7 downto 0);
        Clk  : in  Bit;
        Clr  : in  Bit;
        LD   : in  Bit;
        Q    : out Bit_Vector(7 downto 0)
    );
end Accumulator;

architecture Behave of Accumulator is
begin
    acc: process(Clk)
    begin
        if Clk'Event and Clk = '1' then
            if Clr = '1' then
                Q <= (others => '0');  -- Clear 
            elsif LD = '1' then
                Q <= D;  -- Load
            end if;
        end if;
    end process;
end Behave;
