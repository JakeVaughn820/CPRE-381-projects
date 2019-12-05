-------------------------------------------------------------------------
-- Jacob Vaughn
-------------------------------------------------------------------------

-- 1_bit_reg.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity one_bit_reg is
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
      -- i_flush      : in std_logic;     -- Flu
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output

end one_bit_reg;

architecture arch of one_bit_reg is
  signal s_D    : std_logic;    -- Multiplexed input to the FF
  signal s_Q    : std_logic;    -- Output of the FF

begin

  o_Q <= s_Q;

  with i_WE select
    s_D <= i_D when '1',
              s_Q when others;

  process (i_CLK, i_RST)
  begin
    if (i_RST = '1') then
      s_Q <= '0';
    elsif (rising_edge(i_CLK)) then
      s_Q <= s_D;
    end if;

  end process;

end arch;