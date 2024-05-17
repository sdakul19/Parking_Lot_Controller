library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock_divider is
    Port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end clock_divider;

architecture Behavioral of clock_divider is
    signal counter: STD_LOGIC_VECTOR(24 downto 0) := (others => '0');
    signal tmp_clk_out: STD_LOGIC := '0';
begin
    process(clk_in)
    begin
        
        if rising_edge(clk_in) then
            if(counter = "101111101011110000100000") then  
                counter <= (others => '0');
                tmp_clk_out <= NOT tmp_clk_out; 
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    clk_out <= tmp_clk_out;

end Behavioral;

--use work.ALL;
--configuration clock_divider_cfg of clock_divider is
--	for Behavioral end for;
--end configuration;
