-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------


-- nbit_adder_structural.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements an n-bit full adder (Structural)
--
--
-- NOTES:
-- 9/8/19 Created by Nick
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity nbit_adder_structural is
generic(N : integer:=32);
  port(i_A1, i_B1  	: in std_logic_vector(N-1 downto 0);
       i_Cin  		: in std_logic;
       o_carry 		: out std_logic; 
       o_sum  		: out std_logic_vector(N-1 downto 0));

end nbit_adder_structural;

architecture structure of nbit_adder_structural is

component fulladder
  port(i_A1, i_B1  	: in std_logic;
       i_Cin  		: in std_logic;
       o_carry 		: out std_logic; 
       o_sum  		: out std_logic);
end component; 

signal carry : std_logic_vector(N downto 0); 

begin

  ---------------------------------------------------------------------------
  -- Level 1: Add A + B 
  ---------------------------------------------------------------------------	
  carry(0) <= i_Cin;
  G1: for i in 0 to N-1 generate  
  g_ADD: fulladder
	port MAP(i_A1		=> i_A1(i),
		 i_B1		=> i_B1(i),
		 i_Cin		=> carry(i),
		 o_carry	=> carry(i+1),  
                 o_sum		=> o_sum(i)); 
  end generate; 
  o_carry <= carry(n); 

end structure;
















