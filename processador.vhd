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

architecture rtl of processador is
	
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
	signal controle_alu_out		: std_logic_vector(1 downto 0);
	signal controle_alu_in 		: std_logic_vector(3 downto 0);
	signal controle_mem_write	: std_logic;
	signal controle_alu_src		: std_logic;
	signal controle_reg_write	: std_logic;
	signal controle_zero_ula	: std_logic;
	signal controle_aux_or		: std_logic;
	
	-- Memoria de dados
	signal mem_data_out			: std_logic_vector(31 downto 0);
	signal mem_to_reg				: std_logic_vector(31 downto 0);
	
	-- ULA
	signal ula_result				: std_logic_vector(31 downto 0);
	signal ula_from_mux			: std_logic_vector(31 downto 0);
	
	-- Memoria de instrucoes
	signal instrucao				: std_logic_vector(31 downto 0);
	
	-- Imediato
	signal imm						: std_logic_vector(31 downto 0);
	signal imm_shiftado_1		: std_logic_vector(31 downto 0);
	
begin

	controle_aux_or <= controle_branch or controle_zero_ula;
	imm_shiftado_1 <= imm(30 downto 0) & '0';
	
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
	imm 			=> imm
	
);

breg_ula: entity work.breg_ula port map(
		
	-- sinais do breg_ula => sinais do processador 
	din 				=> mem_to_reg,
	wren 				=> controle_reg_write,
	clk 				=> clock,
	rst 				=> '0',
	rs1 				=> rs1,
	rs2 				=> rs2,
	rd 				=> rd,
	ALUOp 			=> controle_alu_op,
	ALUSrc 			=> controle_alu_src,
	imm 				=> imm,
	zero 				=> controle_zero_ula,
	dout 				=> ula_result,
	mem_data_write => r_out_2
	
		
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
	DataMux 		=> mem_data_out,
	WriteData 	=> r_out_2,
	MemWrite 	=> controle_mem_write,
	MemRead 		=> controle_mem_read,
	MemtoReg 	=> controle_mem_to_reg,
	clock_mem 	=> clock_mem,
	dataout 		=> mem_to_reg
		
);

mux1: entity work.mux port map(
	
	-- sinais do mux => sinais do processador
	sel => controle_alu_src,
	A => r_out_2,
	B => imm,
	X => ula_from_mux
		
);

mux2: entity work.mux port map(
	
	-- sinais do mux => sinais do processador
	sel => controle_mem_to_reg,
	A => ula_result,
	B => mem_data_out,
	X => mem_to_reg
	
);

mux3: entity work.mux port map(
	
	-- sinais do mux => sinais do processador
	sel => controle_aux_or,
	A => pc_mais_4,
	B => pc_jump,
	X => pc_in
);

adder1: entity work.somador port map(
	
	-- sinais do somador => sinais do processador
	A => pc_out,
	B => x"00000004",
	Z => pc_mais_4
	
);

adder2: entity work.somador port map(
	
	-- sinais do somador => sinais do processador
	A => pc_out,
	B => imm_shiftado_1,
	Z => pc_jump
	
);


end rtl;
