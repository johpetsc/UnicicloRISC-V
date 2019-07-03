library ieee;
use ieee.std_logic_1164.all;
use work.riscv_pkg.all;

entity mux is

	port(
		sel	:	in std_logic;
		A		:	in std_logic_vector(31 downto 0);
		B		:	in std_logic_vector(31 downto 0);
		X		:	out std_logic_vector(31 downto 0)
	);
end mux;

architecture behavioral of mux is

	begin
	
	proc_mux: process (sel)
	begin
		if	(sel = '0') then
			X	<=	A;
		elsif (sel = '1') then
			X	<= B;
		else
			X 	<= X"00000000";
		end if;
	end process;
end behavioral;