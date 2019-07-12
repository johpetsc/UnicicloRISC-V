library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;

entity mux_breg is

	port(
		sel	:	in std_logic;
		A		:	in std_logic_vector(4 downto 0);
		B		:	in std_logic_vector(4 downto 0);
		X		:	out std_logic_vector(4 downto 0)
	);
end mux_breg;

architecture behavioral of mux_breg is
	signal A_mux, B_mux, X_mux : std_logic_vector(4 downto 0);
	signal sel_mux : std_logic;
	
	begin
			A_mux <= A;
			B_mux <= B;
			X <= X_mux;
			
			sel_mux <= sel;
			
			X_mux <= A_mux when sel_mux = '0' 
			else B_mux ;
end behavioral;