library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;

entity ula is
	port (
		opcode : in std_logic_vector(3 downto 0);
		A, B : in std_logic_vector(31 downto 0);
		Z : out std_logic_vector(31 downto 0);
		zero : out std_logic);
end entity;

architecture behavioral of ula is
	signal MSB : natural;

begin
	
	process(opcode, A, B)
		variable auxZ : std_logic_vector(31 downto 0);
		variable aux_jalr : std_logic := '0';
	begin
		
		case opcode is
		
			-- ADD
			when "0000" => auxZ := std_logic_vector(signed(A) + signed(B));
			
			-- SUB
			when "0001" => auxZ := std_logic_vector(signed(A) - signed(B));
			
			-- AND
			when "0010" => auxZ := A AND B;
			
			-- OR
			when "0011" => auxZ := A OR B;
								
			-- XOR
			when "0100" => auxZ := A XOR B;
			
			-- SLL
			when "0101" => auxZ := std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B))));
			
			-- SRL
			when "0110" => auxZ := std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B))));
			
			-- SRA
			when "0111" => auxZ := std_logic_vector(shift_right(signed(A), to_integer(unsigned(B))));
			
			-- SLT
			when "1000" => if(signed(A) < signed(B)) then 
									auxZ := (0 => '1', others => '0');
								else
									auxZ := (others => '0');
								end if;
								
			-- SLTU
			when "1001" => if(unsigned(A) < unsigned(B)) then 
									auxZ := (0 => '1', others => '0');
								else
									auxZ := (others => '0');
								end if;
			

			-- SGE
			when "1010" => if(signed(A) >= signed(B)) then
									auxZ := (0 => '1', others => '0');
								else 
									auxZ := (others => '0');
								end if;
			-- SGEU
			when "1011" => if(unsigned(A) >= unsigned(B)) then
									auxZ := (0 => '1', others => '0');
								else 
									auxZ := (others => '0');
								end if;
			
			-- SEQ
			when "1100" => if(signed(A) = signed(B)) then
									auxZ := (0 => '1', others => '0');
								else 
									auxZ := (others => '0');
								end if;
								
			-- SNE
			when "1101" => if(signed(A) /= signed(B)) then
									auxZ := (0 => '1', others => '0');
								else 
									auxZ := (others => '0');
								end if;
			-- Lui
			when "1110" => auxZ := std_logic_vector(signed(B));
			
			when others => 
			aux_jalr := '1';
			auxZ := std_logic_vector(signed(A) + signed(B));
			
		end case;
		
		if(auxZ = X"00000000" or aux_jalr = '1') then
			zero <= '1';
			aux_jalr := '0';
		else
			zero <= '0';
		end if;
		
		Z <= auxZ;
		
	end process;

end behavioral;