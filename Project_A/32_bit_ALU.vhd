-------------------------------------------------------------------------
-- Jacob Vaughn
-- Nickolas Mitchell
-------------------------------------------------------------------------

-- 32_bit_ALU.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity 32_bit_ALU is
  port(i_a       : in std_logic;
       i_b       : in std_logic;
       less      : in std_logic;
       ainvert   : in std_logic;
       binvert   : in std_logic;
       Carryin   : in std_logic;
       Operation : in std_logic_vector (2 downto 0);
       Carryout  : out std_logic;
       result    : out std_logic);
       
end 32_bit_ALU;

architecture arch of 32_bit_ALU is

--components
entity ALU_1_bit is
  port(i_a       : in std_logic;
       i_b       : in std_logic;
       less      : in std_logic;
       ainvert   : in std_logic;
       binvert   : in std_logic;
       Carryin   : in std_logic;
       Operation : in std_logic_vector (2 downto 0);
       Carryout  : out std_logic;
       result    : out std_logic);
       
end ALU_1_bit;

  port(i_0, i_1, i_2, i_3, i_4          : in std_logic;
       i_sel				: in std_logic_vector(2 downto 0); 
       o_F          			: out std_logic);

end component;

component fulladder
  port(i_A1, i_B1  : in std_logic;
       i_Cin  : in std_logic;
       o_carry : out std_logic; 
       o_sum  : out std_logic);

end component;

 --signals
signal      s_ainvert_out    : std_logic;
signal      s_binvert_out    : std_logic;
signal      s_a_and_b        : std_logic;
signal      s_a_or_b         : std_logic;
signal      s_a_nand_b       : std_logic;
signal      s_a_xor_b        : std_logic;
signal      s_sum            : std_logic;
signal      s_notA           : std_logic;
signal      s_notB           : std_logic;


begin

s_notA <= NOT(i_a);
s_notB <= NOT(i_b);

Mux_ainvert: mux_2to1_1bit
  port map(i_0 => i_a,
          i_1 => s_notA,
          i_sel => ainvert,
          o_F => s_ainvert_out);

Mux_binvert: mux_2to1_1bit
  port map(i_0 => i_b,
          i_1 => s_notB,
          i_sel => binvert,
          o_F => s_binvert_out);
  
fulladder1: fulladder
  port map(i_A1 => s_ainvert_out,
       i_B1 => s_binvert_out,
       i_Cin => Carryin,
       o_carry => Carryout,
       o_sum => s_sum);

 s_a_and_b <= s_ainvert_out AND s_binvert_out;

 s_a_or_b <= s_ainvert_out OR s_binvert_out;

 s_a_nand_b <= s_ainvert_out NAND s_binvert_out;

 s_a_xor_b <= s_a_nand_b AND s_a_or_b;

resultMux: mux_5to1_1bit
  port map(i_0 => s_a_and_b,
       i_1 => s_a_or_b,
       i_2 => s_sum,
       i_3 => s_a_xor_b,
       i_4 => less,
       i_sel => Operation,
       o_F => result);


end arch;