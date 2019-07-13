LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;
use work.riscv_pkg.all;                                

ENTITY processador_tb IS
END processador_tb;
ARCHITECTURE processador_arch OF processador_tb IS
-- constants                                                 
-- signals                                                   
SIGNAL clock_pc_md : STD_LOGIC;
SIGNAL clock_general : STD_LOGIC;
COMPONENT processador
	PORT (
	clock_pc_md : IN STD_LOGIC;
	clock_general : IN STD_LOGIC
	);
END COMPONENT;


BEGIN
	i1 : processador
	PORT MAP (
-- list connections between master ports and signals
	clock_pc_md => clock_pc_md,
	clock_general => clock_general
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
	clock_pc_md <= '1';
	wait for 0.5 ps;
	clock_general <= '0';
	wait for 0.5 ps;
	clock_general <= '1';
	wait for 0.5 ps;
	clock_general <= '0';
	wait for 0.5 ps;
	clock_pc_md <= '0';
	wait for 0.5 ps;
	
END PROCESS always;                                          
END processador_arch;