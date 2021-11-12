library	ieee;
use	ieee.std_logic_1164.all;
use	ieee.numeric_std.all;

package	riscv_pkg	is

	component	ula	is
		port	(	
			opcode : in std_logic_vector(3 downto 0);
			A, B : in std_logic_vector(31 downto 0);
			Z : out std_logic_vector(31 downto 0);
			zero : out std_logic
		);
	end	component;
	
	component genImm32 is
		port (
        instr : in std_logic_vector(31 downto 0);
        imm32 : out std_logic_vector(31 downto 0)
		  );
	end	component;
	
	component controleULA	is
		port	(
			opin		:	in std_logic_vector(31 downto 0);
			ALUOp		:	in std_logic_vector(1 downto 0);
			
			opout	:	out std_logic_vector(3 downto 0)
		);
	end	component;
	
	component	xregs	is
		port	(
			clk, wren, rst			: in std_logic;
			rs1, rs2, rd			: in std_logic_vector(4 downto 0);
			data						: in std_logic_vector(31 downto 0);
			ro1, ro2					: out std_logic_vector(31 downto 0)
		);
	end component;
	
	component	mux is
		port(
			sel	:	in std_logic;
			A		:	in std_logic_vector(31 downto 0);
			B		:	in std_logic_vector(31 downto 0);
			X		:	out std_logic_vector(31 downto 0)
		);
	end	component;
	
	component 	pc is
		port(
			pcin	:	in std_logic_vector(31 downto 0);
			clock, pc_rst	:	in std_logic;
			
			pcout	:	out std_logic_vector(31 downto 0)
		);
	end component;
	
	component 	memoriaIns	is
		port(
			address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			wren		: IN STD_LOGIC ;
			q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
	
	component memoriaDados is
		PORT
		(
			address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			wren		: IN STD_LOGIC ;
			q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
	
	component somador is
		port(
			A	   : in std_logic_vector  (31 downto 0);
			B	   : in std_logic_vector  (31 downto 0);
			Z     : out std_logic_vector(31 downto 0)
		);
	end component;
	
	component fetch is
		port(
			pc_mais_4	:	in std_logic_vector(31 downto 0);
			clock, pc_rst			:	in std_logic;
			clock_mem	:	in std_logic;
			
			opcode		   :	out std_logic_vector(6 downto 0);
			rs1, rs2, rd	:  out std_logic_vector(4 downto 0);
			pc_out		   : 	out std_logic_vector(31 downto 0);
			imm		      : 	out std_logic_vector(31 downto 0)
		);
	end component;
	
	component breg_ula is
		port (
			din				:	in std_logic_vector(31 downto 0);
			wren, clk, rst			:	in std_logic;
			rs1, rs2, rd		:	in std_logic_vector(4 downto 0);
			ALUOp				:	in std_logic_vector(1 downto 0);
			ALUSrc			:	in std_logic;
			imm				:	in std_logic_vector(31 downto 0);
			
			zero				:	out std_logic;
			dout				:	out std_logic_vector(31 downto 0);
			immout			:  out signed(31 downto 0);
			mem_data_write	:	out std_logic_vector(31 downto 0)
		);
	
	end component;
	
	component memoria is
		port(
			DataAddress		:	in	std_logic_vector(31 downto 0);
			DataMux		:	in std_logic_vector(31 downto 0);
			WriteData	:	in std_logic_vector(31 downto 0);
			MemWrite		:	in std_logic;
			MemRead			:	in std_logic;
			MemtoReg	:	in std_logic;
			clock_mem		: 	in std_logic;
			
			dataout			:	out std_logic_vector(31 downto 0)
		);
	end component;
	
	component controle is
		port(
			opcode			:	in std_logic_vector(6 downto 0);
		
			ALUOp			:	out std_logic_vector(1 downto 0);
			Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Jalrpc	:	out std_logic
		);
	end component;


end	riscv_pkg;