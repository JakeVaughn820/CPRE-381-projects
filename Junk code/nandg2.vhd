-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------

-- norg2.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2-input NAND 
-- gate.
--
--
-- NOTES:
-- Created on 10/2/2019 by Nick Mitchell
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity nandg2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end nandg2;

architecture dataflow of nandg2 is
begin

  o_F <= i_A nand i_B;
  
end dataflow;
