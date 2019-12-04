-------------------------------------------------------------------------
-- Jacob Vaughn
-------------------------------------------------------------------------

-- IFID_reg.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity IFID_reg is
  port(CLK             : in std_logic;     -- Clock input
       IFID_WriteEn    : in std_logic;     -- if 1 writing is enabled
       IF_PC4          : in std_logic_vector(31 downto 0);
       IF_Inst         : in std_logic_vector(31 downto 0);
       IF_flush        : in std_logic;     -- Reset registers
       ID_PC4          : out std_logic_vector(31 downto 0);
       ID_Inst         : out std_logic_vector(31 downto 0);
       ID_flush        : out std_logic);

end IFID_reg;

architecture arch of IFID_reg is

component N_bit_reg
  generic(N : integer := 32);
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
end component;

component one_bit_reg
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
     --  i_flush      : in std_logic;     -- Flu
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

begin

   IFID_PC4_reg: N_bit_reg
   port map(i_CLK => CLK,
            i_RST => IF_flush,
            i_WE => IFID_WriteEn,
            i_D => IF_PC4,
            o_Q => ID_PC4);

   IFID_Inst_reg: N_bit_reg
   port map(i_CLK => CLK,
            i_RST => IF_flush,
            i_WE => IFID_WriteEn,
            i_D => IF_Inst,
            o_Q => ID_Inst);

   IFID_flush_reg: one_bit_reg
   port map(i_CLK => CLK,
            i_RST => '0',
            i_WE => IFID_WriteEn,
            i_D => IF_flush,
            o_Q => ID_flush);

end arch;
