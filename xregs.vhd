library	ieee;
use	ieee.std_logic_1164.all;
use	ieee.numeric_std.all;
use work.riscv_pkg.all;

entity xregs is

port(
		clk, wren, rst			: in std_logic;
		rs1, rs2, rd			: in std_logic_vector(4 downto 0);
		data						: in std_logic_vector(31 downto 0);
		ro1, ro2					: out std_logic_vector(31 downto 0)
);
end xregs;

architecture behavioral of xregs is
	type bregi is array (0 to 31) of std_logic_vector(31 downto 0);
	signal reg 		: bregi := ((others => (others => '0')));
	
	signal zero		:	std_logic_vector(31 downto 0);
	signal zeroadd	:	std_logic_vector(4 downto 0);
begin

	zero <= std_logic_vector(to_unsigned(0, 32));
	zeroadd <= std_logic_vector(to_unsigned(0, 5));

	process(clk)
		variable rstcounter : integer;
		
	begin	
		if rising_edge(clk) then
			if(wren = '1' and rd /= zeroadd) then
				reg(to_integer(unsigned(rd))) <= data;
			end if;
			
			if(rst = '1') then
				for rstcounter in 1 to 31 loop
					reg(rstcounter) <= zero;
				end loop;
			end if;
		end if;
		ro1 <= reg(to_integer(unsigned(rs1)));
		ro2 <= reg(to_integer(unsigned(rs2)));
	end process;	
end behavioral;