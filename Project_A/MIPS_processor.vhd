-------------------------------------------------------------------------
-- Jacob Vaughn
-------------------------------------------------------------------------

-- MIPS_processor.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity MIPS_processor is
  port(i_CLK        : in std_logic;     -- Clock input

       i_rs         : in std_logic_vector(4 downto 0);     -- Read address 1
       i_rt         : in std_logic_vector(4 downto 0);     -- Read address 2
       i_rd         : in std_logic_vector(4 downto 0);     -- Write address

       i_ALUSrc     : in std_logic;     -- Reset registers
       i_nAdd_Sub   : in std_logic;     -- Reset registers
       i_regWrite      : in std_logic;     -- Reset registers

       i_immediate  : in std_logic_vector(31 downto 0));     -- Data value input
       
end MIPS_processor;

architecture arch of MIPS_processor is

--components
component RegFile
  port(i_CLK        : in std_logic;     -- Clock input
       i_read_write : in std_logic;     -- read/Write enable
       i_rs         : in std_logic_vector(4 downto 0);     -- Read address 1
       i_rt         : in std_logic_vector(4 downto 0);     -- Read address 2
       i_rd         : in std_logic_vector(4 downto 0);     -- Write address
       i_reset      : in std_logic;     -- Reset registers
       i_data       : in std_logic_vector(31 downto 0);     -- Data value input
       o_rs_data    : out std_logic_vector(31 downto 0);   -- Data value output
       o_rt_data    : out std_logic_vector(31 downto 0));   -- Data value output
end component;

component Add_Sub
  generic(N : integer := 32);
  port( i_A  : in std_logic_vector(N-1 downto 0);
	i_B  : in std_logic_vector(N-1 downto 0);
	i_nAdd_Sub  : in std_logic;
       	o_S  : out std_logic_vector(N-1 downto 0);
        o_Cout  : out std_logic);

end component;

component mux2_1_D is
  generic(N : integer := 32);
  port( i_A  : in std_logic_vector(N-1 downto 0);
	i_B  : in std_logic_vector(N-1 downto 0);
	i_X  : in std_logic;
        o_Y  : out std_logic_vector(N-1 downto 0));

end component;

 --signals
signal       s_Add_Sub_out    : std_logic_vector(31 downto 0);
signal       s_RegFile_out1    : std_logic_vector(31 downto 0);
signal       s_RegFile_out2    : std_logic_vector(31 downto 0);
signal       s_muxOut : std_logic_vector(31 downto 0);
signal       s_Cout : std_logic;

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