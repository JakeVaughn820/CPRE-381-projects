-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------


-- addsub_component.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a 32-bit register file from this lab
-- in combination with the adder_sub from lab 2 
--
--
-- NOTES:
-- 9/11/2019 Created by Nick
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity addsub_component is
   port(i_imm		: in std_logic_vector(31 downto 0); 	--Immediate value to be adder/subtracted
	i_mux_ctl	: in std_logic; 			--2:1 mux select (0 add) (1 addi)
	i_alu_ctl	: in std_logic; 			--addsub control (0 to add) (1 to sub)
	w_addr 		: in std_logic_vector(4 downto 0);	--Write Address
        w_enable 	: in std_logic; 			--Write enable
	i_read1		: in std_logic_vector(4 downto 0); 	--Read(1)
	i_read2		: in std_logic_vector(4 downto 0); 	--Read(2)
	i_rst		: in std_logic;				--Reset
	i_clk		: in std_logic);				--Clock  
	
       
end addsub_component;

architecture structure of addsub_component is 

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

--Output value of ALU
signal alu_result : std_logic_vector(31 downto 0);

--Register file outputs 
signal reg_out1, reg_out2 : std_logic_vector(31 downto 0); 

--Mux output
signal mux_out : std_logic_vector(31 downto 0);

--Carryout from ALU (Currently this shouldn't do anything)
signal carry_out_s : std_logic; 

begin 

---------------------------------------------------------------------------
--RegFile
--------------------------------------------------------------------------
Reg : regFile
	port MAP(waddr		=> w_addr, 		
        	 w_enable 	=> w_enable,
		 rd		=> alu_result,
		 rt		=> i_read1,
		 rs		=> i_read2,
		 i_rst		=> i_rst,
		 i_clk		=> i_clk, 
		 out1		=> reg_out1,
       		 out2		=> reg_out2); 

---------------------------------------------------------------------------
--Mux
---------------------------------------------------------------------------
Mux : mux_2to1_32bit
  	port MAP(i_0	=> reg_out2,
		 i_1 	=> i_imm,
		 sel 	=> i_mux_ctl,
       		 o_f 	=> mux_out);

---------------------------------------------------------------------------
--ALU
---------------------------------------------------------------------------
ALU : adder_subtractor
	port MAP(in1		=> reg_out1,
		 in2  		=> mux_out,
       		 i_ctl  	=> i_alu_ctl,			
      		 o_Carryout 	=> carry_out_s,
      		 o_result  	=> alu_result); 

end structure;
















