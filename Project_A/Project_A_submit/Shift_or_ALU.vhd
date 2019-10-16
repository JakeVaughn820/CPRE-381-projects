-------------------------------------------------------------------------
-- Jacob Vaughn
-------------------------------------------------------------------------

-- ALU_control.vhd


library IEEE;
use IEEE.std_logic_1164.all;

entity ALU_control is
  port(Shift_Amount : in std_logic_vector(4 downto 0);
       Op 	: in std_logic_vector(5 downto 0);
       ctl_bits_to_shift 	: out std_logic_vector(4 downto 0);
       ctl_which_shift		: out std_logic_vector(1 downto 0));
       
end ALU_control;

architecture arch of ALU_control is 

begin 
	ctl_which_shift <=  "00" when (Op =  "111100") else
		            "01" when (Op =  "111101") else
                            "10" when (Op =  "111110") else
		            "00";

	ctl_bits_to_shift <= Shift_Amount when (Op =  "111100") else
		             Shift_Amount when (Op =  "111101") else
                             Shift_Amount when (Op =  "111110") else
		             "0000";

end arch;
















