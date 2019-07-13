library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;

entity fetch is
	port(
		pc_mais_4		:	in std_logic_vector(31 downto 0) := X"00000000";
		clock				:	in std_logic;
		pc_rst 			:	in std_logic := '1';
		clock_mem		:	in std_logic;
		
		opcode		   :	out std_logic_vector(6 downto 0);
		rs1, rs2, rd	:  out std_logic_vector(4 downto 0);
		pc_out		   : 	out std_logic_vector(31 downto 0) := X"00000000";
		imm		      : 	out std_logic_vector(31 downto 0)
		
	);
end fetch;

architecture rtl of fetch is

	signal pc_to_mem	:	std_logic_vector(7 downto 0);
	signal pc_out_32	:	std_logic_vector(31 downto 0) := x"00000000";
	signal q_out		:	std_logic_vector(31 downto 0);
	
begin
	
	pc_to_mem		<=	pc_out_32(9 downto 2);
	rs1				<=	q_out(19 downto 15);
	rs2				<=	q_out(24 downto 20);
	imm		      <= q_out(31 downto 0);
	rd		         <= q_out(11 downto 7);
	opcode			<= q_out(6 downto 0);
	pc_out			<= pc_out_32;
	
pc: entity work.pc port map(
	pcin		=>	pc_mais_4,
	clock		=> clock,
	pcout		=> pc_out_32,
	pc_rst 	=> pc_rst
);

memoriaIns: entity work.memoriaIns port map(
	address	=>	pc_to_mem,
	clock		=> clock_mem,
	data 		=> X"00000000",
	wren 		=> '0',
	q			=>	q_out
);

end rtl;