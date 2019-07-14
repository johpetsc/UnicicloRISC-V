library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;

entity memoria is
	port(
		DataAddress		:	in	std_logic_vector(31 downto 0);
		DataMux		:	in std_logic_vector(31 downto 0);
		WriteData	:	in std_logic_vector(31 downto 0);
		MemWrite		:	in std_logic;
		MemRead			:	in std_logic;
		MemtoReg	:	in std_logic;
		clock_mem		: 	in std_logic;
		
		dataout			:	out std_logic_vector(31 downto 0)
	);
end memoria;

architecture rtl of memoria is
	
	signal DataMem		:	std_logic_vector(31 downto 0);
	signal res				:	std_logic_vector(31 downto 0);
	signal address_aux:	std_logic_vector(7 downto 0);
	
begin

	address_aux	<=	DataAddress(9 downto 2);
	dataout <= res;

memoriaDados: entity work.memoriaDados port map(
	address	=> address_aux,
	clock		=> clock_mem,
	data		=>	WriteData,
	wren		=>	MemWrite,
	q			=>	DataMem
);

mux: entity work.mux port map(
	A			=> DataMux,
	B			=> DataMem,
	sel		=> MemtoReg,
	X			=> res
);
	
end rtl;