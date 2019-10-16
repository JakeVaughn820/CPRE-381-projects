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
  port(i_CLK        : in std_logic;     -- Clock input

       i_rs         : in std_logic_vector(4 downto 0);     -- Read address 1
       i_rt         : in std_logic_vector(4 downto 0);     -- Read address 2
       i_rd         : in std_logic_vector(4 downto 0);     -- Write address

       i_ALUSrc     : in std_logic;  -- rt or Immediate
       i_ALUOp      : in std_logic_vector(5 downto 0); --Operation for the ALU
                                                       --000000 : AND
                                                       --000011 : xor
                                                       --011100 : slt
                                                       --110000 : NOR
                                                       --110001 : NAND
                                                       --011010 : Sub
                                                       --111100 : arithmetic shift right
                                                       --111101 : logical shift right
                                                       --111110 : Shift left

       i_regWrite   : in std_logic;  -- Write to reg?
       i_mem_we     : in std_logic;  -- Write to mem?
       i_MemtoReg   : in std_logic;  -- lw

       i_immediate  : in std_logic_vector(15 downto 0));     -- Data value input
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

signal       s_Add_Sub_S  : std_logic_vector(31 downto 0);

signal       s_rs_data    : std_logic_vector(31 downto 0);
signal       s_rt_data    : std_logic_vector(31 downto 0);
signal       s_mem_q      : std_logic_vector(31 downto 0);
signal       s_32Imm      : std_logic_vector(31 downto 0);

signal       s_ALUSrc_out     : std_logic_vector(31 downto 0);
signal       s_MemtoReg_out   : std_logic_vector(31 downto 0);

signal       s_Cout : std_logic;

signal       s_Overflow : std_logic;
signal       s_Zero       : std_logic;
signal       s_ALU_result : std_logic_vector(31 downto 0);  

--  

begin 

---------------------------------------------------------------------------
--RegFile
--------------------------------------------------------------------------
Reg : regFile
	port MAP(waddr		=> s_MemtoReg_out, 		
        	 w_enable 	=> i_regWrite,
		 rd		=> i_rd,
		 rt		=> i_rt,
		 rs		=> i_rs,
		 i_rst		=> '0',
		 i_clk		=> i_CLK, 
		 out1		=> s_rs_data,
       		 out2		=> s_rs_data); 

---------------------------------------------------------------------------
--Mux (between memory and regFile)
---------------------------------------------------------------------------
Mux1 : mux_2to1_32bit
  	port MAP(i_0	=> s_rt_data,
		 i_1 	=> s_32Imm,
		 sel 	=> i_ALUSrc,
       		 o_f 	=> s_ALUSrc_out);

---------------------------------------------------------------------------
--Memory
---------------------------------------------------------------------------
Memory : mem 
   port map( clk => i_CLK,
             addr => s_Add_Sub_S(9 downto 0),
             data => s_rt_data,
             we => i_mem_we,
             q => s_mem_q);

---------------------------------------------------------------------------
--ALU
---------------------------------------------------------------------------
ALU : adder_subtractor
	port MAP(in1		=> s_rs_data,
		 in2  		=> s_rt_data,
       		 i_ctl  	=> i_ALUOp,			
      		 o_Carryout 	=> s_Cout,
      		 o_result  	=> s_Zero); 

---------------------------------------------------------------------------
--Mux (between memory and regFile)
---------------------------------------------------------------------------
Mux0 : mux_2to1_32bit
  	port MAP(i_0	=> s_ALU_result,
		 i_1 	=> s_mem_q,
		 sel 	=> i_MemtoReg,
       		 o_f 	=> s_MemtoReg_out);

---------------------------------------------------------------------------
--Extender
---------------------------------------------------------------------------
Extender : extend_16bit
  	port Map(i_ext	=> i_immediate, 	
       		 ctl	=> '1',
       		 o_f 	=> s_32Imm); 
 	



end structure;
















