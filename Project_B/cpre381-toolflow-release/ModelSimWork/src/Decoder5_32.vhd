-------------------------------------------------------------------------
-- Jacob Vaughn
-------------------------------------------------------------------------

-- Decoder5_32.vhd
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Decoder5_32 is
  port(i_Sel          : in std_logic_vector(4 downto 0);     -- Data value input
       i_WE           : in std_logic; --Write enable
       o_Out          : out std_logic_vector(31 downto 0));   -- Data value output

end Decoder5_32;

architecture mixed of Decoder5_32 is

begin
   process(i_Sel, i_WE)
      begin
         o_Out <= x"00000000";

         if(i_WE = '1') then
            o_Out(to_integer(unsigned(i_Sel))) <= '1';
         end if;
   end process;

end mixed;