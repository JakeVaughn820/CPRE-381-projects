-------------------------------------------------------------------------
-- Jacob Vaughn
-- Nickolas Mitchell
-------------------------------------------------------------------------

-- right__left_shifter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 32-bit right 
-- right shifter.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity right_left_shifter is
--generic(N : integer:=32);
  port( i_shift			: in std_logic_vector(31 downto 0);
	ctl_bits_to_shift 	: in std_logic_vector(4 downto 0);
	ctl_which_shift		: in std_logic_vector(1 downto 0);	--'00' <= arithmetic shift right     '01' <= logical shift right     '10' <= Shift left 	
	o_shift		: out std_logic_vector(31 downto 0));

end right_left_shifter;

architecture behavioral of right_left_shifter is

begin

	process is 
	begin 

		--Arithmetic Right Shift
		if ctl_which_shift = "00" then 
			o_shift <= std_logic_vector(shift_right(signed(i_shift), to_integer(unsigned(ctl_bits_to_shift))));
 

		--Logical Left Shift
		elsif ctl_which_shift = "01" then
			o_shift <= std_logic_vector(shift_right(unsigned(i_shift), to_integer(unsigned(ctl_bits_to_shift))));
 
		--Right Shift
		elsif ctl_which_shift = "10" then
			o_shift <= std_logic_vector(shift_left(unsigned(i_shift), to_integer(unsigned(ctl_bits_to_shift)))); 
		end if;

		wait for 100 ns;
  
	end process;  

end behavioral;
