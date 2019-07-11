library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use	work.riscv_pkg.all;

entity breg_ula is
	
	port (
		din				:	in std_logic_vector(31 downto 0);
		wren, clk, rst			:	in std_logic;
		rs1, rs2, rd		:	in std_logic_vector(4 downto 0);
		ALUOp				:	in std_logic_vector(1 downto 0);
		ALUSrc			:	in std_logic;
		imm				:	in std_logic_vector(31 downto 0);
		
		zero				:	out std_logic;
		dout				:	out std_logic_vector(31 downto 0);
		immout			:  out signed(31 downto 0);
		mem_data_write	:	out std_logic_vector(31 downto 0)
	);
	
end breg_ula;

architecture rtl of breg_ula is

signal r1, r2			:	std_logic_vector(31 downto 0);
signal res_mux			:	std_logic_vector(31 downto 0);
signal imm32_aux			:	signed(31 downto 0);
signal op			:	std_logic_vector(3 downto 0);

begin
	mem_data_write	<= r2;
	immout <= imm32_aux;

ula: entity work.ula port map(
	opcode	=>	op,
	A			=> r1,
	B			=> res_mux,
	Z			=>	dout,
	zero		=> zero
);

xregs: entity work.xregs port map(
	clk		=> clk,
	wren			=> wren,
	rst 		=> rst,
	rs1			=> rs1,
	rs2			=> rs2,
	rd 		=> rd,
	data 		=> din,
	ro1 		=> r1,
	ro2		=> r2
);

controleULA: entity work.controleULA port map(
	opin		=> imm,
	ALUOp 	=> ALUOp,
	opout		=> op
);

genImm32: entity work.genImm32 port map(
	instr 	=> imm,
	imm32		=> imm32_aux
);

mux: entity work.mux port map(
	A			=> r2,
	B			=> std_logic_vector(imm32_aux),
	sel		=> ALUSrc,
	X			=> res_mux
);

end rtl;