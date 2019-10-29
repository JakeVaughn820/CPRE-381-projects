-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------

-- norg2.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2-input NOT 
-- gate.
--
--
-- NOTES:
-- Created on 10/2/2019 by Nick Mitchell
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity notg2 is

  port(i_A          : in std_logic;
       o_F          : out std_logic);

end notg2;

architecture dataflow of notg2 is
begin

  o_F <= not i_A;
  
end dataflow;
