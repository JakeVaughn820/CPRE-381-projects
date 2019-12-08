-------------------------------------------------------------------------
-- Jacob Vaughn
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- Equal.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This code implements an N-bit one's complimenter susing structural VHDL.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_misc.all;

entity Equal is
  generic(N : integer := 32);
  port( i_A  : in std_logic_vector(N-1 downto 0);
	    i_B  : in std_logic_vector(N-1 downto 0);
       	o_Equal  : out std_logic);

end Equal;

architecture structure of Equal is

signal s_xnor_vals : std_logic_vector(N-1 downto 0);

begin

G1: for i in 0 to N-1 generate
   s_xnor_vals(i) <= i_A(i) XNOR i_B(i);

end generate;

o_Equal <= and_reduce(s_xnor_vals);

end structure;