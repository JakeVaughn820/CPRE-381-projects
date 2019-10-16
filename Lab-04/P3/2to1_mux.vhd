-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------


-- 2to1_mux.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a 2:1 mux
--
--
-- NOTES:
-- 9/8/19 Created by Nick
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux_2to1 is
  port(i_x0, i_x1  : in std_logic;
       i_s  : in std_logic;
       o_y  : out std_logic);

end mux_2to1;

architecture structure of mux_2to1 is

component invg
  port(i_A  : in std_logic;
       o_F  : out std_logic);
end component;

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

--Signal to store not value
signal sVALUE_not : std_logic;

--Signal to store and1 value
signal sVALUE_and1 : std_logic;

--Signal to store and2 value
signal sVALUE_and2 : std_logic;

begin

  ---------------------------------------------------------------------------
  -- Level 1: Not i_s
  ---------------------------------------------------------------------------
  g_Not: invg
	port MAP(i_A	=> i_s,
                 o_F	=> sVALUE_not);  

  ---------------------------------------------------------------------------
  -- Level 2: And1 (x0 and ~i_s) 
  ---------------------------------------------------------------------------
  g_And1: andg2
	port MAP(i_A	=> i_x0,
		 i_B	=> sVALUE_not, 
		 o_F	=> sVALUE_and1);

  ---------------------------------------------------------------------------
  -- Level 3: And2 (x1 and s) 
  ---------------------------------------------------------------------------
  g_And2: andg2 
	port MAP(i_A	=> i_x1,
		 i_B	=> i_s,
		 o_F	=> sVALUE_and2);

  ---------------------------------------------------------------------------
  -- Level 4: Or And1 & And2
  ---------------------------------------------------------------------------
  g_Or: org2
	port MAP(i_A	=> sVALUE_and1, 
		 i_B	=> sVALUE_and2, 
		 o_F	=>o_y); 


end structure;
















