-------------------------------------------------------------------------
-- Jacob Vaughn
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- Add_Sub.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This code implements an N-bit one's complimenter susing structural VHDL.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Add_Sub is
  generic(N : integer := 32);
  port( i_A  : in std_logic_vector(N-1 downto 0);
	i_B  : in std_logic_vector(N-1 downto 0);
	i_nAdd_Sub  : in std_logic;
       	o_S  : out std_logic_vector(N-1 downto 0);
        o_Cout  : out std_logic);

end Add_Sub;

architecture structure of Add_Sub is


component Full_Adder_D is
  generic(N : integer := 32);
  port( i_A  : in std_logic_vector(N-1 downto 0);
	i_B  : in std_logic_vector(N-1 downto 0);
	i_Cin  : in std_logic;
       	o_S  : out std_logic_vector(N-1 downto 0);
        o_Cout  : out std_logic);

end component;

component mux2_1_D is
  generic(N : integer := 32);
  port( i_A  : in std_logic_vector(N-1 downto 0);
	i_B  : in std_logic_vector(N-1 downto 0);
	i_X  : in std_logic;
       	o_Y  : out std_logic_vector(N-1 downto 0));

end component;

component N_bit_ones_complimenter_D is
  generic(N : integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));

end component;

signal s_ones_complement : std_logic_vector(N-1 downto 0);
signal s_Mux: std_logic_vector(N-1 downto 0);

begin

  ones1: N_bit_ones_complimenter_D
    port map(i_A => i_B,
             o_F => s_ones_complement); 

  mux1: mux2_1_D
    port map(i_A => i_B,
             i_B => s_ones_complement,
             i_X => i_nAdd_Sub,
             o_Y => s_Mux); 

  add1: Full_Adder_D
    port map(i_A => i_A,
             i_B => s_Mux,
             i_Cin => i_nAdd_Sub,
             o_S => o_S, 
             o_Cout => o_Cout);

end structure;