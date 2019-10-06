-------------------------------------------------------------------------
-- Jacob Vaughn
-- Nickolas Mitchell
-------------------------------------------------------------------------

-- right_shifter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 32-bit right 
-- right shifter.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity right_shifter is
--generic(N : integer:=32);
  port( i_rightshift	: in std_logic_vector(31 downto 0);
	ctl_rightshift 	: in std_logic_vector(4 downto 0);
	ctl_rs_aorl	: in std_logic;					--'0' <= arithmetic shift 	'1' <= logical shift
	o_rightshift	: out std_logic_vector(31 downto 0));

end right_shifter;

architecture behavioral of right_shifter is

component mux_2to1_1bit
  port(i_0, i_1          : in std_logic;
       i_sel		 : in std_logic;  
       o_F     	         : out std_logic);
end component;

begin

	process is 
	begin 

		--Arithmetic Shift
		if ctl_rs_aorl = '0' then 
			o_rightshift <= std_logic_vector(shift_right(signed(i_rightshift), to_integer(unsigned(ctl_rightshift))));
 

		--Logical shift
		elsif ctl_rs_aorl = '1' then
			o_rightshift <= std_logic_vector(shift_right(unsigned(i_rightshift), to_integer(unsigned(ctl_rightshift)))); 
		end if;

		wait for 100 ns;
  
	end process;  

end behavioral;
