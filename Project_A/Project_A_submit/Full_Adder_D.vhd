-------------------------------------------------------------------------
-- Jacob Vaughn
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- Full_Adder_D.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This code implements an N-bit one's complimenter susing structural VHDL.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Full_Adder_D is
  generic(N : integer := 32);
  port( i_A  : in std_logic_vector(N-1 downto 0);
	i_B  : in std_logic_vector(N-1 downto 0);
	i_Cin  : in std_logic;
       	o_S  : out std_logic_vector(N-1 downto 0);
        o_Cout  : out std_logic);

end Full_Adder_D;

architecture structure of Full_Adder_D is

signal s_AxorB : std_logic_vector(N-1 downto 0);
signal s_AandB: std_logic_vector(N-1 downto 0);
signal s_CinandAB: std_logic_vector(N-1 downto 0);
signal s_Cout: std_logic_vector(N downto 0);

begin
s_Cout(0) <= i_Cin;

G1: for i in 0 to N-1 generate

  s_AxorB(i) <= i_A(i) xor i_B(i);

  o_S(i) <= s_AxorB(i) xor s_Cout(i);

  s_CinandAB(i) <= s_AxorB(i) and  s_Cout(i);

  s_AandB(i) <= i_A(i) and i_B(i);

  s_Cout(i+1) <= s_CinandAB(i) or s_AandB(i);

end generate;

  o_Cout <= s_Cout(N);
  
end structure;