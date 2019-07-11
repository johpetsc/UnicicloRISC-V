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
	signal pc_in					: std_logic_vector(31 downto 0) := X"00000000";
	signal pc_out					: std_logic_vector(31 downto 0) := X"00000000";
	signal pc_mais_4					: std_logic_vector(31 downto 0) := X"00000000";
	signal pc_out_aux					: std_logic_vector(31 downto 0) := X"00000000";
	signal pc_mais_4_aux				: std_logic_vector(31 downto 0) := X"00000000";
	signal pc_jump					: std_logic_vector(31 downto 0) := X"00000000";
	signal pc_rst					: std_logic := '1';
	
	-- Registradores
	signal rs1_aux						: std_logic_vector(4 downto 0) := "00000";
	signal rs2_aux				: std_logic_vector(4 downto 0) := "00000";
	signal rd_aux			   : std_logic_vector(4 downto 0) := "00000";
	signal r_out_2					: std_logic_vector(31 downto 0) := X"00000000";
	
	-- Controle
	signal opcode_aux 			: std_logic_vector(6 downto 0) := "0000000";
	signal controle_branch		: std_logic := '0';
	signal controle_mem_read	: std_logic := '0';
	signal controle_mem_to_reg	: std_logic := '0';
	signal controle_alu_op		: std_logic_vector(1 downto 0) := "00";
	signal controle_alu_out		: std_logic_vector(1 downto 0) := "00";
	signal controle_alu_in 		: std_logic_vector(3 downto 0) := "0000";
	signal controle_mem_write	: std_logic := '0';
	signal controle_alu_src		: std_logic := '0';
	signal controle_reg_write	: std_logic := '0';
	signal controle_zero_ula	: std_logic := '0';
	signal controle_aux_or		: std_logic := '0';
	
	-- Memoria de dados
	signal mem_to_reg				: std_logic_vector(31 downto 0) := X"00000000";
	
	-- ULA
	signal ula_result				: std_logic_vector(31 downto 0) := X"00000000";
	
	-- Imediato
	signal imm_out						: std_logic_vector(31 downto 0) := X"00000000";
	signal imm_shiftado_1		: std_logic_vector(31 downto 0) := X"00000000";
	signal imm_result				: signed(31 downto 0) := X"00000000";
	
begin

	controle_aux_or <= controle_branch or controle_zero_ula;
	imm_shiftado_1 <= std_logic_vector(imm_result(30 downto 0) & '0');
	
fetch: entity work.fetch port map(
		
	-- sinais do fetch => sinais do processador 
	pc_mais_4 	=> pc_in,
	clock 		=> clock,
	clock_mem 	=> clock_mem,
	opcode 		=> opcode_aux,
	rs1 			=> rs1_aux,
	rs2 			=> rs2_aux,
	rd 			=> rd_aux,
	pc_out 		=> pc_out_aux,
	imm 			=> imm_out,
	pc_rst		=> pc_rst
	
);

breg_ula: entity work.breg_ula port map(
		
	-- sinais do breg_ula => sinais do processador 
	din 				=> mem_to_reg,
	wren 				=> controle_reg_write,
	clk 				=> clock_mem,
	rst 				=> '0',
	rs1 				=> rs1_aux,
	rs2 				=> rs2_aux,
	rd 				=> rd_aux,
	ALUOp 			=> controle_alu_op,
	ALUSrc 			=> controle_alu_src,
	imm 				=> imm_out,
	zero 				=> controle_zero_ula,
	dout 				=> ula_result,
	immout			=> imm_result,
	mem_data_write => r_out_2
	
		
);

controle: entity work.controle port map(
		
	-- sinais do controle => sinais do processador
	opcode 	=> opcode_aux,
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
	DataMux 		=> ula_result,
	WriteData 	=> r_out_2,
	MemWrite 	=> controle_mem_write,
	MemRead 		=> controle_mem_read,
	MemtoReg 	=> controle_mem_to_reg,
	clock_mem 	=> clock_mem,
	dataout 		=> mem_to_reg
		
);

mux3: entity work.mux port map(
	
	-- sinais do mux => sinais do processador
	sel => controle_aux_or,
	A => pc_mais_4_aux,
	B => pc_jump,
	X => pc_in
);

adder1: entity work.somador port map(
	
	-- sinais do somador => sinais do processador
	A => pc_out_aux,
	B => x"00000004",
	Z => pc_mais_4_aux
	
);

adder2: entity work.somador port map(
	
	-- sinais do somador => sinais do processador
	A => pc_out_aux,
	B => imm_shiftado_1,
	Z => pc_jump
	
);


end rtl;
