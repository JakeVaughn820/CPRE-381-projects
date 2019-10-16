-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------


-- 32to1_mux.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a 32:1 32-bit mux
--
--
-- NOTES:
-- 9/11/2019 Created by Nick
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux_32to1 is
  port(i_0, i_1, i_2, i_3, i_4, i_5, i_6, i_7, i_8, i_9 		: in std_logic_vector(31 downto 0);
       i_10, i_11, i_12, i_13, i_14, i_15, i_16, i_17, i_18, i_19 	: in std_logic_vector(31 downto 0); 
       i_20, i_21, i_22, i_23, i_24, i_25, i_26, i_27, i_28, i_29 	: in std_logic_vector(31 downto 0); 
       i_30, i_31 							: in std_logic_vector(31 downto 0); 
       sel 	: in std_logic_vector(4 downto 0);
       o_f 	: out std_logic_vector(31 downto 0));
       
end mux_32to1;

architecture my_mux of mux_32to1 is 

begin 
	o_f <=  i_0 when (sel =  "00000") else
		i_1 when (sel =  "00001") else 
		i_2 when (sel =  "00010") else 
		i_3 when (sel =  "00011") else 
		i_4 when (sel =  "00100") else 
		i_5 when (sel =  "00101") else 
		i_6 when (sel =  "00110") else 
		i_7 when (sel =  "00111") else 
		i_8 when (sel =  "01000") else 
		i_9 when (sel =  "01001") else
		i_10 when (sel = "01010") else 
		i_11 when (sel = "01011") else 
		i_12 when (sel = "01100") else
		i_13 when (sel = "01101") else 
		i_14 when (sel = "01110") else
		i_15 when (sel = "01111") else 
		i_16 when (sel = "10000") else
		i_17 when (sel = "10001") else 
		i_18 when (sel = "10010") else 
		i_19 when (sel = "10011") else
		i_20 when (sel = "10100") else 
		i_21 when (sel = "10101") else
		i_22 when (sel = "10110") else 
		i_23 when (sel = "10111") else
		i_24 when (sel = "11000") else 
		i_25 when (sel = "11001") else 
		i_26 when (sel = "11010") else 
		i_27 when (sel = "11011") else
		i_28 when (sel = "11100") else 
		i_29 when (sel = "11101") else 
		i_30 when (sel = "11110") else 
		i_31 when (sel = "11111") else 
		"00000000000000000000000000000000";

end my_mux;
















