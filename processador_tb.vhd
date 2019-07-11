LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;
use work.riscv_pkg.all;                                

ENTITY processador_tb IS
END processador_tb;
ARCHITECTURE processador_arch OF processador_tb IS
-- constants                                                 
-- signals                                                   
SIGNAL clock : STD_LOGIC;
SIGNAL clock_mem : STD_LOGIC;
COMPONENT processador
	PORT (
	clock : IN STD_LOGIC;
	clock_mem : IN STD_LOGIC
	);
END COMPONENT;


BEGIN
	i1 : processador
	PORT MAP (
-- list connections between master ports and signals
	clock => clock,
	clock_mem => clock_mem
	);
init : PROCESS                                    
-- variable declarations                                     
BEGIN
        -- code that executes only once
wait;
END PROCESS init;
                                           
always : PROCESS

-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
	clock <= '1';
	clock_mem <= '0';
	wait for 1 ps;
	clock <= '0';
	clock_mem <= '1';
	wait for 1 ps;  
	
END PROCESS always;                                          
END processador_arch;