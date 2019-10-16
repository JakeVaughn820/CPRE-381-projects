-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------


-- 5to32_decoder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a 5:32 decoder
--
--
-- NOTES:
-- 9/11/2019 Created by Nick
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity decoder is
  port(i_x 	: in std_logic_vector(4 downto 0);
       enable : in std_logic; 
       o_f  	: out std_logic_vector(31 downto 0));
       
end decoder;

architecture my_decode of decoder is 

begin 
	     o_f <= 	"00000000000000000000000000000000" when enable = '0' else 
			"00000000000000000000000000000001" when enable = '1' and i_x = "00000" else
			"00000000000000000000000000000010" when enable = '1' and i_x = "00001" else 
			"00000000000000000000000000000100" when enable = '1' and i_x = "00010" else 
			"00000000000000000000000000001000" when enable = '1' and i_x = "00011" else
			"00000000000000000000000000010000" when enable = '1' and i_x = "00100" else
			"00000000000000000000000000100000" when enable = '1' and i_x = "00101" else
			"00000000000000000000000001000000" when enable = '1' and i_x = "00110" else
			"00000000000000000000000010000000" when enable = '1' and i_x = "00111" else
			"00000000000000000000000100000000" when enable = '1' and i_x = "01000" else 
			"00000000000000000000001000000000" when enable = '1' and i_x = "01001" else 
			"00000000000000000000010000000000" when enable = '1' and i_x = "01010" else 
			"00000000000000000000100000000000" when enable = '1' and i_x = "01011" else
			"00000000000000000001000000000000" when enable = '1' and i_x = "01100" else
			"00000000000000000010000000000000" when enable = '1' and i_x = "01101" else 
			"00000000000000000100000000000000" when enable = '1' and i_x = "01110" else
			"00000000000000001000000000000000" when enable = '1' and i_x = "01111" else
			"00000000000000010000000000000000" when enable = '1' and i_x = "10000" else 
			"00000000000000100000000000000000" when enable = '1' and i_x = "10001" else
			"00000000000001000000000000000000" when enable = '1' and i_x = "10010" else 
			"00000000000010000000000000000000" when enable = '1' and i_x = "10011" else
			"00000000000100000000000000000000" when enable = '1' and i_x = "10100" else
			"00000000001000000000000000000000" when enable = '1' and i_x = "10101" else
			"00000000010000000000000000000000" when enable = '1' and i_x = "10110" else 
			"00000000100000000000000000000000" when enable = '1' and i_x = "10111" else  
			"00000001000000000000000000000000" when enable = '1' and i_x = "11000" else 
			"00000010000000000000000000000000" when enable = '1' and i_x = "11001" else
			"00000100000000000000000000000000" when enable = '1' and i_x = "11010" else 
			"00001000000000000000000000000000" when enable = '1' and i_x = "11011" else
			"00010000000000000000000000000000" when enable = '1' and i_x = "11100" else
			"00100000000000000000000000000000" when enable = '1' and i_x = "11101" else
			"01000000000000000000000000000000" when enable = '1' and i_x = "11110" else
			"10000000000000000000000000000000" when enable = '1' and i_x = "11111" else  
			"00000000000000000000000000000000";  
end my_decode;
















