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

 	o_F <=  i_0 when (i_sel =  "000") else
		i_1 when (i_sel =  "001") else
		i_2 when (i_sel =  "010") else	
		i_3 when (i_sel =  "011") else
		i_4 when (i_sel =  "100") else		
		'0';
  
end dataflow;
