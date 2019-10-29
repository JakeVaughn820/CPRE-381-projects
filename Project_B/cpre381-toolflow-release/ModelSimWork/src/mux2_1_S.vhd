-------------------------------------------------------------------------
-- Jacob Vaughn
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- N_bit_ones_complimenter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This code implements an N-bit one's complimenter susing structural VHDL.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2_1_S is
  generic(N : integer := 32);
  port( i_A  : in std_logic_vector(N-1 downto 0);
	i_B  : in std_logic_vector(N-1 downto 0);
	i_X  : in std_logic;
       	o_Y  : out std_logic_vector(N-1 downto 0));

end mux2_1_S;

architecture structure of mux2_1_S is

component invg
  port(i_A  : in std_logic;
       o_F  : out std_logic);
end component;

component andg2

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component org2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

signal not_X : std_logic;
signal A_and_notX: std_logic_vector(N-1 downto 0);
signal B_and_X: std_logic_vector(N-1 downto 0);

begin

not1: invg port map(i_A => i_X, o_F => not_X);

G1: for i in 0 to N-1 generate
  and1: andg2 
    port map(i_A => i_A(i),
             i_B => not_X,
             o_F => A_and_notX(i)); 

  and2: andg2
    port map(i_A => i_B(i),
             i_B => i_X,
             o_F => B_and_X(i)); 
  or1: org2
     port map(i_A => A_and_notX(i),
              i_B => B_and_X(i),
              o_F =>o_Y(i));

end generate;
  
end structure;