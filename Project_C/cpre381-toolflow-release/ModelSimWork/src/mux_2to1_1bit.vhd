-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------

-- mux_2to1_1bit.vhd
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

entity mux_2to1_1bit is

  port(i_0, i_1          : in std_logic;
       i_sel		     : in std_logic;  
       o_F     	         : out std_logic);

end mux_2to1_1bit;

architecture dataflow of mux_2to1_1bit is
begin

 	o_F <=  i_0 when (i_sel =  '0') else
		    i_1 when (i_sel =  '1') else	
		    '0';
   
end dataflow;
