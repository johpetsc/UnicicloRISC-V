library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.riscv_pkg.all;

entity processador is 
	
	port(
		-- Ports	
		clock_pc_md		: in std_logic;
		clock_general	: in std_logic
	);
	
end processador;

architecture rtl of processador is
	
	--Signals
	
	-- PC's
	signal pc_in					: std_logic_vector(31 downto 0) := X"00000000";
	signal pc_out					: std_logic_vector(31 downto 0) := X"00000000";
	signal pc_mais_4					: std_logic_vector(31 downto 0) := X"00000000";
	signal pc_jump					: std_logic_vector(31 downto 0) := X"00000000";
	signal pc_rst					: std_logic := '1';
	signal pc_definitivo			: std_logic_vector(31 downto 0) := X"00000000";
	
	-- Registradores
	signal rs1						: std_logic_vector(4 downto 0) := "00000";
	signal rs2				: std_logic_vector(4 downto 0) := "00000";
	signal rd			   : std_logic_vector(4 downto 0) := "00000";
	signal r_out_2					: std_logic_vector(31 downto 0) := X"00000000";
	signal rs2_or_rd				: std_logic_vector(4 downto 0) := "00000";
	signal data_jal				: std_logic_vector(31 downto 0) := X"00000000";
	signal jal_aux					: std_logic_vector(31 downto 0) := X"00000000";
	
	-- Controle
	signal opcode 			: std_logic_vector(6 downto 0) := "0000000";
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
	signal controle_aux_and		: std_logic := '0';
	signal controle_aux_and2		: std_logic := '0';
	signal controle_jalr			: std_logic := '0';
	
	-- Memoria de dados
	signal mem_to_reg				: std_logic_vector(31 downto 0) := X"00000000";
	
	-- ULA
	signal ula_result				: std_logic_vector(31 downto 0) := X"00000000";
	
	-- Imediato
	signal instruction			: std_logic_vector(31 downto 0) := X"00000000";
	signal imm_shiftado_1		: std_logic_vector(31 downto 0) := X"00000000";
	signal imm_result				: signed(31 downto 0) := X"00000000";
	
begin
	process(clock_general)
	begin	
		if rising_edge(clock_general) then
			jal_aux <= pc_mais_4;
		end if;
	end process;
	controle_aux_and2 <= controle_jalr and controle_zero_ula;
	pc_rst <= '0';
	controle_aux_and <= controle_branch and controle_zero_ula;
	imm_shiftado_1 <= std_logic_vector(imm_result(31 downto 0));
	
fetch: entity work.fetch port map(
		
	-- sinais do fetch => sinais do processador 
	pc_mais_4 	=> pc_definitivo,
	clock 		=> clock_pc_md,
	clock_mem 	=> clock_general,
	opcode 		=> opcode,
	rs1 			=> rs1,
	rs2 			=> rs2,
	rd 			=> rd,
	pc_out 		=> pc_out,
	imm 			=> instruction,
	pc_rst		=> pc_rst
	
);

breg_ula: entity work.breg_ula port map(
		
	-- sinais do breg_ula => sinais do processador 
	din 				=> data_jal,
	wren 				=> controle_reg_write,
	clk 				=> clock_general,
	rst 				=> '0',
	rs1 				=> rs1,
	rs2 				=> rs2,
	rd 				=> rd,
	ALUOp 			=> controle_alu_op,
	ALUSrc 			=> controle_alu_src,
	imm 				=> instruction,
	zero 				=> controle_zero_ula,
	dout 				=> ula_result,
	immout			=> imm_result,
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
	RegWrite => controle_reg_write,
	Jalrpc	=> controle_jalr
		
);		

memoria: entity work.memoria port map(
		
	-- sinais da memoria => sinais do processador
	DataAddress => ula_result,
	DataMux 		=> ula_result,
	WriteData 	=> r_out_2,
	MemWrite 	=> controle_mem_write,
	MemRead 		=> controle_mem_read,
	MemtoReg 	=> controle_mem_to_reg,
	clock_mem 	=> clock_pc_md,
	dataout 		=> mem_to_reg
		
);

mux3: entity work.mux port map(
	
	-- sinais do mux => sinais do processador
	sel => controle_aux_and,
	A => pc_mais_4,
	B => pc_jump,
	X => pc_in
);

mux4: entity work.mux port map(
	
	-- sinais do mux => sinais do processador
	sel => controle_branch,
	A => mem_to_reg,
	B => jal_aux,
	X => data_jal
);

mux5: entity work.mux port map(
	
	-- sinais do mux => sinais do processador
	sel => controle_aux_and2,
	A => pc_in,
	B => ula_result,
	X => pc_definitivo
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