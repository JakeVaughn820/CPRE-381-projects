-------------------------------------------------------------------------
-- Nickolas Mitchell, Jake Vaughn
-------------------------------------------------------------------------

-- mux_3to1_32bit.vhd

library IEEE;
use IEEE.std_logic_1164.all;

entity mux_3to1_32bit is

  port(i_0, i_1, i_2, i_3  : in std_logic_vector(31 downto 0);
       i_sel				       : in std_logic_vector(1 downto 0);
       o_F          	     : out std_logic_vector(31 downto 0));

end mux_3to1_32bit;

architecture dataflow of mux_3to1_32bit is
begin
   process(i_sel, i_0, i_1, i_2)
   begin
   case i_sel is
    when "00" => o_F <= i_0;
    when "01" => o_F <= i_1;
    when "10" => o_F <= i_2;
    when "11" => o_F <= i_3;
    when others => o_F <= x"99999999";

    end case;

end process;
end dataflow;
