-------------------------------------------------------------------------
-- Jacob Vaughn
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- N_bit_ones_complimenter_D.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This code implements an N-bit one's complimenter susing structural VHDL.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity N_bit_ones_complimenter_D is
  generic(N : integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));

end N_bit_ones_complimenter_D;

architecture dataflow of N_bit_ones_complimenter_D is

begin
	
G1: for i in 0 to N-1 generate

    o_F(i) <= NOT i_A(i);

end generate;
  
end dataflow;