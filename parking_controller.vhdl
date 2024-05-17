library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity parking_controller is
	port(start, stop, override, entr, ext, sys_clk: IN STD_LOGIC;
		opn, full, closed: OUT STD_LOGIC);

end parking_controller;

architecture behavior of parking_controller is

	component clock_divider is 
		port(
		clk_in : IN std_logic;
		clk_out : OUT std_logic);
	end component;

	type stateType is (S_IDLE, S_EMPTY, S_OPN, S_FULL);	-- 4 parking states, IDLE, EMPTY, OPN, FULL
	signal STATE : stateType := S_IDLE;
	signal NXT_STATE : stateType := S_IDLE;
	signal count : INTEGER := 0;
	signal slow_clk :  std_logic := '0';
	
	begin
	
	clk_divider0: clock_divider port map(clk_in => sys_clk, clk_out => slow_clk);

	process(slow_clk) begin 	-- State transition logic
		if rising_edge(slow_clk) then
			case(STATE) is
				WHEN S_IDLE =>			-- Initial state, moves out of IDLE when start = 1
					if (start = '1') then
						if (count = 0) then		-- When count = 0, next state is EMPTY
							NXT_STATE <= S_EMPTY;
						elsif (count = 20) then		-- When count = 20, next state is FULL
							NXT_STATE <= S_FULL;
						else				-- When 0 < count < 20, next state is OPN
							NXT_STATE <= S_OPN;
						end if;
					else 
						NXT_STATE <= S_IDLE;
					end if;

				WHEN S_EMPTY =>					-- When system is in EMPTY state, count = 0
					if (stop = '1') then			-- When stop = 1, next state is IDLE
						NXT_STATE <= S_IDLE;
					elsif (entr = '1') then			-- When enter = 1, next state is OPN
						count <= count + 1;
						NXT_STATE <= S_OPN;
					elsif (override = '1') then		-- When override = 1, next state is EMPTY and count updates
						if (entr = '1') then
							count <= count + 1;
							NXT_STATE <= S_EMPTY;
						elsif (ext = '1') then
							count <= count - 1;
							NXT_STATE <= S_EMPTY;
						else 
							NXT_STATE <= S_EMPTY;
						end if;
					else
						NXT_STATE <= S_EMPTY;
					end if;
				WHEN S_OPN =>					-- When system is in OPN state, 0 < count < 20
					if (stop = '1') then			-- If stop = 1, next state is IDLE
						NXT_STATE <= S_IDLE;
					elsif (count = 1 and ext = '1') then	-- If count = 1 and exit = 1, next state is EMPTY
						count <= count - 1;
						NXT_STATE <= S_EMPTY;
					elsif (count = 19 and entr = '1') then	-- If count = 19 and entr = 1, next state is FULL
						count <= count + 1;
						NXT_STATE <= S_FULL;
					elsif (override = '1') then		-- If override = 1, next state is OPN and count updates
						if (entr = '1') then		
							count <= count + 1;
							NXT_STATE <= S_OPN;
						elsif (ext = '1') then
							count <= count - 1;
							NXT_STATE <= S_OPN;
						else
							NXT_STATE <= S_OPN;
						end if;
					elsif (entr = '1') then
						count <= count + 1;
						NXT_STATE <= S_OPN;
					elsif (ext = '1') then 
						count <= count - 1;
						NXT_STATE <= S_OPN;
					else
						NXT_STATE <= S_OPN;
					end if;

				WHEN S_FULL =>					-- When system is in FULL state, count = 20
					if (stop = '1') then			-- If stop = 1, next state is IDLE
						NXT_STATE <= S_IDLE;
					elsif (ext = '1') then			-- If ext = 1, next state is OPN
						count <= count - 1;
						NXT_STATE <= S_OPN;
					elsif (override = '1') then		-- If override = 1, next state is full and count updates
						if(entr = '1') then
							count <= count + 1;
							NXT_STATE <= S_FULL;
						elsif(ext = '1') then		
							count <= count - 1;
							NXT_STATE <= S_FULL;
						else
							NXT_STATE <= S_FULL;
						end if;
					else
						NXT_STATE <= S_FULL;
					end if;
			end case;
		end if;
	end process;
	
	process(STATE) begin					-- Output logic
		case(STATE) is 
			WHEN S_IDLE =>
				closed <= '1';
				if (count = 20) then
					full <= '1';
					opn <= '0';
				else
					full <= '0';
					opn <= '1';
				end if;
			WHEN S_EMPTY =>
				opn <= '1';
				full <= '0';
				closed <= '0';
			WHEN S_OPN =>
				opn <= '1';
				full <= '0';
				closed <= '0';
			WHEN S_FULL =>
				opn <= '0';
				full <= '1';
				closed <= '0';
		end case;

	end process;

	STATE <= NXT_STATE;			-- STATE flip flop
end behavior;


---use work.ALL;
---configuration parking_controller_cfg of parking_controller is
---	for behavior end for;
---end configuration;
		 
