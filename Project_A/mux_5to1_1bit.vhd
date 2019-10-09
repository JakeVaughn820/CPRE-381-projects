-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------

-- mux_5to1_1bit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2-input NOT 
-- gate.
--
--
-- NOTES:
-- Created on 10/2/2019 by Nick Mitchell
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux_5to1_1bit is

  port(i_0, i_1, i_2, i_3, i_4          : in std_logic;
       i_sel				: in std_logic_vector(2 downto 0); 
       o_F          			: out std_logic);

end mux_5to1_1bit;

architecture dataflow of mux_5to1_1bit is
begin
   process(i_sel, i_0, i_1, i_2, i_3, i_4)
   begin
 	 case i_sel is
    when "000" => o_F <= i_0;
    when "001" => o_F <= i_1;
    when "010" => o_F <= i_2;
    when "011" => o_F <= i_3;
    when "100" => o_F <= i_4;
    when others => o_F <= '0';

    end case;

end process;
end dataflow;
