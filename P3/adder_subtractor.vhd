-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------


-- adder_subtracter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements an adder/subtracter
--
--
-- NOTES:
-- 9/8/19 Created by Nick
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity adder_subtractor is
  generic(N : integer := 32);
  port(in1, in2  	: in std_logic_vector(N-1 downto 0);
       i_ctl  		: in std_logic;				--i_Carryin
								--i_sel
       o_Carryout 	: out std_logic; 
       o_result  	: out std_logic_vector(N-1 downto 0));

end adder_subtractor;

architecture structure of adder_subtractor is

component ones_comp
generic(N : integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));

end component; 


component nbit_mux
generic(N : integer := 32);
  port(i_x0, i_x1  : in std_logic_vector(N-1 downto 0);
       i_s  	   : in std_logic;
       o_y  	   : out std_logic_vector(N-1 downto 0));

end component; 


component nbit_adder_structural
generic(N : integer := 32);
  port(i_A1, i_B1  : in std_logic_vector(N-1 downto 0);
       i_Cin  	   : in std_logic;
       o_carry 	   : out std_logic; 
       o_sum  	   : out std_logic_vector(N-1 downto 0));

end component;

--Signal to store inverted value for input 2
signal sVALUE_inv2 : std_logic_vector(N-1 downto 0);

--Signal to store value of multiplexer
signal sVALUE_multi : std_logic_vector(N-1 downto 0);

begin

  ---------------------------------------------------------------------------
  -- Level 1: Invert input 2
  ---------------------------------------------------------------------------  
  g_inv: ones_comp
	port MAP(i_A	=> in2, 
                 o_F	=> sVALUE_inv2);   

  ---------------------------------------------------------------------------
  -- Level 2: Multiplexer 
  --------------------------------------------------------------------------- 
  g_Multi: nbit_mux
	port MAP(i_x0 => in2, 
		 i_x1 => sVALUE_inv2,  
       		 i_s => i_ctl,
       		 o_y => sVALUE_multi); 

  ---------------------------------------------------------------------------
  -- Level 3: Adder 
  ---------------------------------------------------------------------------
  g_Adder: nbit_adder_structural
	port MAP(i_A1		=> sVALUE_multi, 
		 i_B1		=> in1, 
     		 i_Cin  	=> i_ctl,
       		 o_carry  	=> o_Carryout,
       		 o_sum  	=> o_result);  

end structure;
















