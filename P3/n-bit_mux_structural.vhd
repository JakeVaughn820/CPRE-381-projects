-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------


-- 2to1_mux.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements an n-bit 2:1 mux (Structural) 
--
--
-- NOTES:
-- 9/8/19 Created by Nick
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity nbit_mux is
generic(N : integer:=32);
  port(i_x0, i_x1  	: in std_logic_vector(N-1 downto 0);
       i_s  		: in std_logic;
       o_y  		: out std_logic_vector(N-1 downto 0));

end nbit_mux;

architecture structure of nbit_mux is

component mux_2to1
  port(i_x0, i_x1  	: in std_logic;
       i_s  		: in std_logic;
       o_y 		: out std_logic);

end component;

begin

  ---------------------------------------------------------------------------
  -- Level 1: MUX 
  ---------------------------------------------------------------------------
  G1: for i in 0 to N-1 generate  
  g_MUX: mux_2to1
	port MAP(i_x0	=> i_x0(i),
		 i_x1	=> i_x1(i),
		 i_s	=> i_s, 
                 o_y	=> o_y(i));
  end generate;   

end structure;
















