-------------------------------------------------------------------------
-- Jacob Vaughn
-- Nickolas Mitchell
-------------------------------------------------------------------------

-- ALU_1_bit.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity ALU_1_bit is
  port(i_a       : in std_logic;
       i_b       : in std_logic;
       less      : in std_logic;
       ainvert   : in std_logic;
       binvert   : in std_logic;
       Carryin   : in std_logic;
       Operation : in std_logic;
       result    : in std_logic);
       
end ALU_1_bit;

architecture arch of ALU_1_bit is

--components
component mux_2to1_1bit

  port(i_0, i_1          : in std_logic;
       i_sel		 : in std_logic;  
       o_F     	         : out std_logic);

component mux_2to1_1bit;



 --signals
signal       s_Add_Sub_out    : std_logic_vector(31 downto 0);
signal       s_RegFile_out1   : std_logic_vector(31 downto 0);
signal       s_RegFile_out2   : std_logic_vector(31 downto 0);
signal       s_muxOut         : std_logic_vector(31 downto 0);
signal       s_Cout           : std_logic;

begin

   RegFile1: RegFile
   port map(i_CLK => i_CLK,
       i_read_write => i_regWrite,
       i_rs => i_rs,
       i_rt => i_rt,
       i_rd => i_rd,
       i_reset => '0',
       i_data => s_Add_Sub_out,
       o_rs_data => s_RegFile_out1,
       o_rt_data => s_RegFile_out2);

   AddSub1: Add_Sub
   port map( i_A  => s_RegFile_out1,
	i_B => s_muxOut,
	i_nAdd_Sub => i_nAdd_Sub,
       	o_S => s_Add_Sub_out,
        o_Cout => s_Cout);
  
   mux1: mux2_1_D
   port map(i_A => s_RegFile_out2,
	i_B => i_immediate,
	i_X => i_ALUSrc,
       	o_Y => s_muxOut);

  
end arch;