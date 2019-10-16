-------------------------------------------------------------------------
-- Jacob Vaughn
-- Nickolas Mitchell
-------------------------------------------------------------------------

-- tb_ALU_32_bit.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_ALU_32_bit is
   generic(gCLK_HPER   : time := 50 ns);
end tb_ALU_32_bit;

architecture arch of tb_ALU_32_bit is

  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

--components
component ALU_32_bit
  port(A         : in   std_logic_vector(31 downto 0);
       B         : in   std_logic_vector(31 downto 0);
       control   : in   std_logic_vector(5 downto 0);
       F         : out  std_logic_vector(31 downto 0);
       Carryout  : out  std_logic;
       Overflow  : out  std_logic;
       Zero      : out  std_logic); 
end component;

 --signals

signal       s_A      : std_logic_vector(31 downto 0);
signal       s_B      : std_logic_vector(31 downto 0);
signal       s_control   : std_logic_vector(5 downto 0);
signal       s_F   : std_logic_vector(31 downto 0);
signal       s_Carryout  : std_logic;
signal       s_Overflow : std_logic;
signal       s_Zero       : std_logic;
signal       s_CLK : std_logic;

begin

tb_ALU_32_bit: ALU_32_bit
  port map(A => s_A,
           B => s_B,
           control => s_control,
           F => s_F,
           Carryout => s_Carryout,
           Overflow => s_Overflow,
           Zero => s_Zero);

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;

  P_TB: process
  begin
     s_A <= x"00000004";
     s_B <= x"00000005";
     s_control <= "000010";
     wait for cCLK_PER; 

     s_A <= x"00000005";
     s_B <= x"00000005";
     s_control <= "011010";
     wait for cCLK_PER;  

     s_A <= x"00000001";
     s_B <= x"00000001";
     s_control <= "000000";
     wait for cCLK_PER; 

     s_A <= x"00000001";
     s_B <= x"00000000";
     s_control <= "000000";
     wait for cCLK_PER; 


     s_A <= x"01110001";
     s_B <= x"01000000";
     s_control <= "011100";
     wait for cCLK_PER; 


     s_A <= x"01110001";
     s_B <= x"01111111";
     s_control <= "011100";
     wait for cCLK_PER; 


     s_A <= x"01110001";
     s_B <= x"01000100";
     s_control <= "000001";
     wait for cCLK_PER; 

     s_A <= x"01110001";
     s_B <= x"01000000";
     s_control <= "000011";
     wait for cCLK_PER; 


     s_A <= x"01110001";
     s_B <= x"01000000";
     s_control <= "110000";
     wait for cCLK_PER; 
  wait;
  end process;
end arch;