-------------------------------------------------------------------------
-- Jacob Vaughn
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- zeroExt_16_32bit.vhd

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.ALL;

entity zero_sign_ext_16_32bit is
  port( i_16in  : in std_logic_vector(15 downto 0);
        i_sel   : in std_logic;
        o_32out : out std_logic_vector(31 downto 0));

end zero_sign_ext_16_32bit;

architecture structure of zero_sign_ext_16_32bit is

begin
   process(i_16in, i_sel)
      begin
      if(i_sel = '0') then
         o_32out <= conv_std_logic_vector(unsigned(i_16in),32);
      else
         o_32out <= conv_std_logic_vector(signed(i_16in),32);
      end if;
   end process;

end structure;