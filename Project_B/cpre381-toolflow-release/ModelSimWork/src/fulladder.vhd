-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------


-- fulladder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a full adder
--
--
-- NOTES:
-- 9/8/19 Created by Nick
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity fulladder is
  port(i_A1, i_B1  : in std_logic;
       i_Cin  : in std_logic;
       o_carry : out std_logic; 
       o_sum  : out std_logic);

end fulladder;

architecture structure of fulladder is

component andg2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component; 

component org2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component; 

component xorg2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

--Signal to store XOR value
signal sVALUE_xor : std_logic;

--Signal to store AND1 value
signal sVALUE_and1 : std_logic;

--Signal to store AND2 value
signal sVALUE_and2 : std_logic;

begin

  ---------------------------------------------------------------------------
  -- Level 1: XOR A & B 
  ---------------------------------------------------------------------------
  g_XOR: xorg2
	port MAP(i_A	=> i_A1,
		 i_B	=> i_B1, 
                 o_F	=> sVALUE_xor);  

  ---------------------------------------------------------------------------
  -- Level 2: AND1 A & B 
  ---------------------------------------------------------------------------
  g_And1: andg2
	port MAP(i_A	=> i_A1,
		 i_B	=> i_B1, 
		 o_F	=> sVALUE_and1);

  ---------------------------------------------------------------------------
  -- Level 3: AND2 Cin & sVALUE_xor 
  ---------------------------------------------------------------------------
  g_And2: andg2 
	port MAP(i_A	=> i_Cin,
		 i_B	=> sVALUE_xor,
		 o_F	=> sVALUE_and2);

  ---------------------------------------------------------------------------
  -- Level 4: OR AND1 & AND2
  ---------------------------------------------------------------------------
  g_Or: org2
	port MAP(i_A	=> sVALUE_and1, 
		 i_B	=> sVALUE_and2, 
		 o_F	=> o_carry); 

  ---------------------------------------------------------------------------
  -- Level 5: XOR Cin & sVALUE_XOR
  ---------------------------------------------------------------------------
  g_XOR2: xorg2
	port MAP(i_A	=> sVALUE_xor,
		 i_B	=> i_Cin,
		 o_F	=> o_sum); 

end structure;
















