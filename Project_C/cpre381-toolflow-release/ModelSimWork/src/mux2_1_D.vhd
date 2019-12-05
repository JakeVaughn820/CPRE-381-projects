-------------------------------------------------------------------------
-- Jacob Vaughn
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2_1_D is
  generic(N : integer := 32);
  port( i_A  : in std_logic_vector(N-1 downto 0);
	i_B  : in std_logic_vector(N-1 downto 0);
	i_X  : in std_logic;
       	o_Y  : out std_logic_vector(N-1 downto 0));

end mux2_1_D;

architecture structure of mux2_1_D is


signal not_X : std_logic;
signal A_and_notX: std_logic_vector(N-1 downto 0);
signal B_and_X: std_logic_vector(N-1 downto 0);

begin

not_X <= not i_X;

G1: for i in 0 to N-1 generate
  A_and_notX(i) <= (i_A(i) and not_X);

  B_and_X(i) <= (i_B(i) and i_X);

  o_Y(i) <= A_and_notX(i) or B_and_X(i);

end generate;
  
end structure;