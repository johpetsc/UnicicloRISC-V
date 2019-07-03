library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;


entity genImm32 is
    port (
        instr : in std_logic_vector(31 downto 0);
        imm32 : out std_logic_vector(31 downto 0));
end genImm32;

architecture behavioral of genImm32 is
	signal aux : std_logic_vector(31 downto 0);
begin
	process(instr)
		variable opcode : std_logic_vector(7 downto 0);
	begin
		opcode := '0' & instr(6 downto 0);
		case opcode is
			when X"33" => aux <= X"00000000";
			when X"03" => aux <= X"00000" & instr(31 downto 20);
			when X"13" => aux <= X"00000" & instr(31 downto 20);
			when X"67" => aux <= X"00000" & instr(31 downto 20);
			when X"23" => aux <= X"00000" & instr(31 downto 25) & instr(11 downto 7);
			when X"63" => aux <= X"0000" & "0" & "0" & "0" & instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & "0";
			when X"37" => aux <= X"00" & "0" & "0" & "0" & instr(31) & instr(19 downto 12) & instr(20) & instr(30 downto 21) & "0";
			when X"6F" => aux <= instr(31 downto 12) & X"000";
			when others => aux <= (others => '0');
		end case;
		imm32 <= aux;
	end process;
	 
end behavioral;