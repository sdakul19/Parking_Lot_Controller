Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity parking_controller_tb is
end parking_controller_tb;

architecture behavior of parking_controller_tb is

	component parking_controller is
		port(start, stop, override, entr, ext : IN std_logic;
			opn, full, closed : OUT std_logic);
	end component;

	signal start, stop, override, entr, ext : std_logic := '0';
	signal opn, full, closed : std_logic;

	begin
		UUT: parking_controller port map(
						start => start,
						stop => stop,
						override => override,
						entr => entr,
						ext => ext,
						opn => opn, full => full,
						closed => closed
			);
		process 
		begin
			--- Initialize
			start <= '0';
			stop <= '0';
			override <= '0';
			entr <= '0';
			ext <= '0';
			wait for 50 ns;
 
			--- Start controller
			start <= '1';
			wait for 10 ns;
			start <= '0';
			wait for 10 ns;

			--- One car enters
			entr <= '1';
			wait for 10 ns;
			entr <= '0';
   			wait for 10 ns;

			--- Second car enters
			entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;
			--- Third car enters
			entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;

			--- Fourth car enters
			entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;

			--- Fifth car enters
			entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;
			
			--- Stop controller
			stop <= '1';
			wait for 10 ns;
			stop <= '0';
			wait for 10 ns;

			--- Block 6th car
			entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;
	
			--- Start controller
			start <= '1';
			wait for 10 ns;
			start <= '0';
			wait for 10 ns;

			--- Car leaves
			ext <= '1';
			wait for 10 ns;
			ext <= '0';
			wait for 10 ns;

			--- Car leaves;
			ext <= '1';
			wait for 10 ns;
			ext <= '0';
			wait for 10 ns;

			 --- Fourth  car enters
                        entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;

                        --- Fifth car enters
                        entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;

                        --- Sixth car enters
                        entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;

                        --- Seventh car enters
                        entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;

                        --- Eighth car enters
                        entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;

			--- Ninth car enters
                        entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;

                        --- Tenth car enters
                        entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;

                        --- Eleventh car enters
                        entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;

                        --- Twelfth car enters
                        entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;

                        --- Thirteenth car enters
                        entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;

			--- Fourteenth car enters
                        entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;

                        --- Fifteenth car enters
                        entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;

                        --- Sixteenth car enters
                        entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;

                        --- Seventeenth car enters
                        entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;

                        --- Eighteenth car enters
                        entr <= '1';
                        wait for 10 ns;
                        entr <= '0';
			wait for 10 ns;
			
			--- Nineteenth car enters
			entr <= '1';
			wait for 10 ns;
			entr <= '0';
			wait for 10 ns;

			--- Twentieth car enters
			entr <= '1';
			wait for 10 ns;
			entr <= '0';
			wait for 10 ns;

		end process;
end behavior;

use work.ALL;
configuration parking_controller_tb_cfg of parking_controller_tb is
for behavior end for;
end configuration;
