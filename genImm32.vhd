library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity genImm32 is
	port (
		instr : in std_logic_vector(31 downto 0);
		imm32 : out signed(31 downto 0)
		);
end genImm32;

architecture arch_gen of genImm32 is

signal opcode : std_logic_vector(7 downto 0);
signal aux : signed(31 downto 0);

begin
	
	process(instr, opcode, aux)
	
	begin
	
		opcode <= '0' & instr(6 downto 0);
	
		case opcode is
			when X"33" => aux <= X"00000000";
			when X"23" => aux <= (resize(signed(instr(31 downto 25)&instr(11 downto 7)), 32));
			when X"63" => aux <= (resize(signed(instr(31)&instr(7)&instr(30 downto 25)&instr(11 downto 8)&'0'), 32));
			when X"37" => aux <= (signed(shift_left((resize(signed(instr(31 downto 12)), 32)), 12)) and X"FFFFF000");
			when X"17" => aux <= (signed(shift_left((resize(signed(instr(31 downto 12)), 32)), 12)) and X"FFFFF000");
			when X"6F" => aux <= (resize(signed(instr(31)&instr(19 downto 12)&instr(20)&instr(30 downto 21)&'0'), 32));
			when others => 
				case instr(14 downto 12) is
					when "101" => aux <= (resize(signed(instr(24 downto 20)), 32));
					when "001" => aux <= (resize(signed(instr(24 downto 20)), 32));
					when others => aux <= (resize(signed(instr(31 downto 20)), 32));
					end case;
		end case;
		imm32 <= aux;
	end process;
end arch_gen;
