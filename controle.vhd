library ieee;
use ieee.std_logic_1164.all;
use work.riscv_pkg.all;

entity controle is
	port(
		opcode			:	in std_logic_vector(6 downto 0);
		
		ALUOp			:	out std_logic_vector(1 downto 0);
		Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite	:	out std_logic
	);
end controle;

architecture behavioral of controle is

	begin

	proc_controle:	process	(opcode)
		begin
			case opcode is
				when	"000000" =>	-- Tipo R
					Branch 		<= '0';
					MemRead 		<= '0';
					MemtoReg 	<= '0';
					MemWrite		<= '0';
					ALUSrc		<= '0';
					RegWrite		<= '1';
					ALUOp			<= "10";
					
				when	"100011" =>	-- LW
					Branch 		<= '0';
					MemRead 		<= '1';
					MemtoReg 	<= '1';
					MemWrite		<= '0';
					ALUSrc		<= '1';
					RegWrite		<= '1';
					ALUOp			<= "00";
				
				when	"101011" =>	-- SW
					Branch 		<= '0';
					MemRead 		<= '0';
					MemtoReg 	<= '0';
					MemWrite		<= '1';
					ALUSrc		<= '1';
					RegWrite		<= '0';
					ALUOp			<= "00";
				
				when	"000100" => -- Beq
					Branch 		<= '1';
					MemRead 		<= '0';
					MemtoReg 	<= '0';
					MemWrite		<= '0';
					ALUSrc		<= '0';
					RegWrite		<= '0';
					ALUOp			<= "01";
					
				when others =>	
					Branch 		<= '0';
					MemRead 		<= '0';
					MemtoReg 	<= '0';
					MemWrite		<= '0';
					ALUSrc		<= '0';
					RegWrite		<= '0';
					ALUOp			<= "00";
				end case;
	end process;
end behavioral;