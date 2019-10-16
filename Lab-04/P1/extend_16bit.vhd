-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------


-- extend_16bit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a 16-bit extender
--
--
-- NOTES:
-- 9/11/2019 Created by Nick
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity extend_16bit is
  port(i_ext 	: in std_logic_vector(15 downto 0); 
       ctl	: in std_logic; 			--'0' = zero extend : '1' = sign extend
       o_f  	: out std_logic_vector(31 downto 0));
       
end extend_16bit;

architecture structure of extend_16bit is 

begin 
     process(i_ext, ctl)
	begin

	if(ctl = '0') then 	
		o_f <= std_logic_vector(resize(unsigned(i_ext), 32));
	else
		o_f <= std_logic_vector(resize(signed(i_ext), 32)); 
	end if; 
     end process;

end structure;
















