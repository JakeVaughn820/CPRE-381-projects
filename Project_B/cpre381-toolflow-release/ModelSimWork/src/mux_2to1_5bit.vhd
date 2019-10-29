-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------


-- mux_2to1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a 2:1 5-bit mux
--
--
-- NOTES:
-- 9/11/2019 Created by Nick
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux_2to1_5bit is
  port(i_0, i_1 : in std_logic_vector(4 downto 0);
       sel 	: in std_logic;
       o_f 	: out std_logic_vector(4 downto 0));
       
end mux_2to1_5bit;

architecture my_mux of mux_2to1_5bit is 

begin 
	o_f <=  i_0 when (sel =  '0') else
		i_1 when (sel =  '1') else
		"00000";
end my_mux;
















