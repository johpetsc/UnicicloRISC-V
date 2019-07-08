library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.riscv_pkg.all;

entity processador is 
	
	port(
		-- Ports	
		clock			: in std_logic;
		clock_mem	: in std_logic
	);
	
end processador;

architecture rtl of processador is:
	
	--Signals
	
	-- PC's
	signal pc_in					: std_logic_vector(31 downto 0);
	signal pc_out					: std_logic_vector(31 downto 0);
	signal pc_mais_4				: std_logic_vector(31 downto 0);
	signal pc_jump					: std_logic_vector(31 downto 0);
	
	-- Registradores
	signal rs1						: std_logic_vector(4 downto 0);
	signal rs2						: std_logic_vector(4 downto 0);
	signal rd					   : std_logic_vector(4 downto 0);
	signal r_out_1					: std_logic_vector(31 downto 0);
	signal r_out_2					: std_logic_vector(31 downto 0);
	signal r_out_2_ou_imm		: std_logic_vector(31 downto 0);
	
	-- Controle
	signal opcode 					: std_logic_vector(6 downto 0);
	signal controle_branch		: std_logic;
	signal controle_mem_read	: std_logic;
	signal controle_mem_to_reg	: std_logic;
	signal controle_alu_op		: std_logic_vector(1 downto 0);
	signal controle_ alu_out	: std_logic_vector(1 downto 0);
	signal controle_ alu_in 	: std_logic_vector(3 downto 0);
	signal controle_mem_write	: std_logic;
	signal controle_alu_src		: std_logic;
	signal controle_reg_write	: std_logic;
	signal controle_zero_ula	: std_logic;
	
	-- Memoria
	signal mem_data_out			: std_logic_vector(31 downto 0);
	signal mem_to_reg				: std_logic_vector(31 downto 0);
	
	-- ULA
	signal ula_result				: std_logic_vector(31 downto 0);
	
begin
	
fetch: entity work.fetch port map(
		
	-- sinais do fetch => sinais do processador 
	pc_mais_4 	=> pc_mais_4,
	clock 		=> clock,
	clock_mem 	=> clock_mem,
	opcode 		=> opcode,
	rs1 			=> rs1,
	rs2 			=> rs2,
	rd 			=> rd,
	pc_out 		=> pc_out,
	imm 			=> 
	
);

breg_ula: entity work.breg_ula port map(
		
	-- sinais do breg_ula => sinais do processador 
	din 				=> ,
	wren 				=> controle_reg_write,
	clk 				=> clock,
	rst 				=> ,
	rs1 				=> rs1,
	rs2 				=> rs2,
	rd 				=> rd,
	ALUOp 			=> controle_alu_op,
	ALUSrc 			=> controle_alu_src,
	imm 				=> ,
	zero 				=> controle_zero_ula,
	dout 				=> ,
	mem_data_write => 
	
		
);

controle: entity work.controle port map(
		
	-- sinais do controle => sinais do processador
	opcode 	=> opcode,
	ALUOp 	=> controle_alu_op,
	Branch 	=> controle_branch,
	MemRead 	=> controle_mem_read,
	MemtoReg	=> controle_mem_to_reg,
	MemWrite => controle_mem_write,
	ALUSrc 	=> controle_alu_src,
	RegWrite => controle_reg_write
		
);		

memoria: entity work.memoria port map(
		
	-- sinais da memoria => sinais do processador
	DataAddress => ula_result,
	DataMux 		=> ,
	WriteData 	=> r_out_2,
	MemWrite 	=> controle_mem_write,
	MemRead 		=> controle_mem_read,
	MemtoReg 	=> controle_mem_to_reg,
	clock_mem 	=> clock_mem,
	dataout 		=> 
		
);

end rtl;
