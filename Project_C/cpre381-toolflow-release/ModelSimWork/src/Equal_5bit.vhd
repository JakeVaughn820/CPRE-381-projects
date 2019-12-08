-------------------------------------------------------------------------
-- Jacob Vaughn
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- Equal_5bit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This code implements an N-bit one's complimenter susing structural VHDL.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_misc.all;

entity Equal_5bit is
  generic(N : integer := 5);
  port( i_A  : in std_logic_vector(N-1 downto 0);
	    i_B  : in std_logic_vector(N-1 downto 0);
       	o_Equal_5bit  : out std_logic);

end Equal_5bit;

architecture structure of Equal_5bit is

signal s_xnor_vals : std_logic_vector(N-1 downto 0);

begin

G1: for i in 0 to N-1 generate
   s_xnor_vals(i) <= i_A(i) XNOR i_B(i);

end generate;

o_Equal_5bit <= and_reduce(s_xnor_vals);

end structure;