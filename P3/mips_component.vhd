-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------


-- mips_component.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: 
--
--
-- NOTES:
-- 9/28/2019 Created by Nick
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mips_component is
   port(i_imm		: in std_logic_vector(15 downto 0); 	--Immediate value to be adder/subtracted
	i_alu_ctl	: in std_logic;
	ALUctl		: in std_logic;  	
	memWE 		: in std_logic; 
	regWE		: in std_logic;
	load		: in std_logic;
	ext_ctl		: in std_logic; 
	memAddr		: in std_logic_vector(9 downto 0); 
	regAddr		: in std_logic_vector(4 downto 0); 
	i_read1		: in std_logic_vector(4 downto 0); 	--Read(1)
	i_read2		: in std_logic_vector(4 downto 0); 	--Read(2)
	i_rst		: in std_logic;				--Reset
	i_clk		: in std_logic);				--Clock  
end mips_component;

architecture structure of mips_component is 

component mux_2to1_32bit 
  port(i_0, i_1 : in std_logic_vector(31 downto 0);
       sel 	: in std_logic;
       o_f 	: out std_logic_vector(31 downto 0));
end component;

component adder_subtractor
  generic(N : integer := 32);
  port(in1, in2  	: in std_logic_vector(N-1 downto 0);
       i_ctl  		: in std_logic;				
       o_Carryout 	: out std_logic; 
       o_result  	: out std_logic_vector(N-1 downto 0));
end component;

component regFile
   port(waddr 		: in std_logic_vector(4 downto 0);	--Write Address
        w_enable 	: in std_logic; 			--Write enable
	rd		: in std_logic_vector(31 downto 0);	--Write
	rt		: in std_logic_vector(4 downto 0); 	--Read(1)
	rs		: in std_logic_vector(4 downto 0); 	--Read(2)
	i_rst		: in std_logic;				--Reset
	i_clk		: in std_logic;				--Clock
	out1		: out std_logic_vector(31 downto 0); 	--Output(1)
        out2		: out std_logic_vector(31 downto 0)); 	--Output(2)
end component;

component extend_16bit
  port(i_ext 	: in std_logic_vector(15 downto 0); 
       ctl	: in std_logic; 			--'0' = zero extend : '1' = sign extend
       o_f  	: out std_logic_vector(31 downto 0));
end component; 

component mem
generic 
	(
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10
	);

	port 
	(
		clk		: in std_logic;
		addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '1';
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);
end component; 

--Register file outputs 
signal s_reg0, s_reg1 : std_logic_vector(31 downto 0);

--Memory data input
signal s_mem_in : std_logic_vector(31 downto 0);

--Mux (between memory and regFile) output
signal s_mux0 : std_logic_vector(31 downto 0); 

--Mux (between extender and ALU) output
signal s_mux1 : std_logic_vector(31 downto 0); 

--Extender output
signal s_ext : std_logic_vector(31 downto 0);

--ALU output
signal s_alu : std_logic_vector(31 downto 0); 

--Memory output
signal s_mem_out : std_logic_vector(31 downto 0);

--ALU carryout out 
signal s_cout : std_logic;   

--  

begin 

---------------------------------------------------------------------------
--RegFile
--------------------------------------------------------------------------
Reg : regFile
	port MAP(waddr		=> regAddr, 		
        	 w_enable 	=> regWE,
		 rd		=> s_mux1,
		 rt		=> i_read1,
		 rs		=> i_read2,
		 i_rst		=> i_rst,
		 i_clk		=> i_clk, 
		 out1		=> s_reg0,
       		 out2		=> s_reg1); 

---------------------------------------------------------------------------
--Mux (between memory and regFile)
---------------------------------------------------------------------------
Mux1 : mux_2to1_32bit
  	port MAP(i_0	=> s_alu,
		 i_1 	=> s_mem_out,
		 sel 	=> load,
       		 o_f 	=> s_mux1);

---------------------------------------------------------------------------
--Memory
---------------------------------------------------------------------------
Memory : mem 
	port MAP(clk	=> i_clk,		
		 addr	=> memAddr,	        
		 data	=> s_mem_in,        
		 we	=> memWe,	
		 q	=> s_mem_out); 	

---------------------------------------------------------------------------
--ALU
---------------------------------------------------------------------------
ALU : adder_subtractor
	port MAP(in1		=> s_mux0,
		 in2  		=> s_reg0,
       		 i_ctl  	=> i_alu_ctl,			
      		 o_Carryout 	=> s_cout,
      		 o_result  	=> s_alu); 

---------------------------------------------------------------------------
--Mux (between memory and regFile)
---------------------------------------------------------------------------
Mux0 : mux_2to1_32bit
  	port MAP(i_0	=> s_reg1,
		 i_1 	=> s_ext,
		 sel 	=> ALUctl,
       		 o_f 	=> s_mux0);

---------------------------------------------------------------------------
--Extender
---------------------------------------------------------------------------
Extender : extend_16bit
  	port Map(i_ext	=> i_imm, 	
       		 ctl	=> ext_ctl,
       		 o_f 	=> s_ext); 
 	



end structure;
















