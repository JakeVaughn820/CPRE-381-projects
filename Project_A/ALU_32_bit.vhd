-------------------------------------------------------------------------
-- Jacob Vaughn
-- Nickolas Mitchell
-------------------------------------------------------------------------

-- ALU_32_bit.vhd
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_misc.all;

entity ALU_32_bit is
  port(A         : in   std_logic_vector(31 downto 0);
       B         : in   std_logic_vector(31 downto 0);
       control   : in   std_logic_vector(5 downto 0);
       F         : out  std_logic_vector(31 downto 0);
       Carryout  : out  std_logic;
       Overflow  : out  std_logic;
       Zero      : out  std_logic); 
end ALU_32_bit;

architecture arch of ALU_32_bit is

--components
component ALU_1_bit
  port(i_a       : in std_logic;
       i_b       : in std_logic;
       less      : in std_logic;
       ainvert   : in std_logic;
       binvert   : in std_logic;
       Carryin   : in std_logic;
       Operation : in std_logic_vector (2 downto 0);
       Carryout  : out std_logic;
       result    : out std_logic);       
end component;

component ALU_1_bit_MostSig
  port(i_a       : in std_logic;
       i_b       : in std_logic;
       less      : in std_logic;
       ainvert   : in std_logic;
       binvert   : in std_logic;
       Carryin   : in std_logic;
       Operation : in std_logic_vector (2 downto 0);
       Carryout  : out std_logic;
       result    : out std_logic;
       Set       : out std_logic;
       Overflow  : out std_logic);      
end component;

 --signals
signal       s_less      : std_logic;
signal       s_ainvert   : std_logic;
signal       s_binvert   : std_logic;
signal       s_Carryin   : std_logic_vector (31 downto 0);
signal       s_Operation : std_logic_vector (2 downto 0);
signal       s_Set       : std_logic;
signal       s_F         : std_logic_vector (31 downto 0);

begin

       s_ainvert <= control(5);
       s_binvert <= control(4);
       s_Carryin(0) <= control(3);
       s_Operation <= control(2 downto 0);


ALU_1_bit0: ALU_1_bit
  port map(i_a => A(0),
           i_b => B(0),
           less => s_Set,
           ainvert => s_ainvert,
           binvert => s_binvert,
           Carryin => s_Carryin(0),
           Operation => s_Operation,
           Carryout => s_Carryin(1),
           result => s_F(0)); 

G1: for i in 1 to 30 generate

ALU_1_bitX: ALU_1_bit
  port map(i_a => A(i),
           i_b => B(i),
           less => '0',
           ainvert => s_ainvert,
           binvert => s_binvert,
           Carryin => s_Carryin(i),
           Operation => s_Operation,
           Carryout => s_Carryin(i+1),
           result => s_F(i));  

end generate;

My_ALU_1_bit_MostSig: ALU_1_bit_MostSig
  port map(i_a => A(31),
           i_b => B(31),
           less => '0',
           ainvert => s_ainvert,
           binvert => s_binvert,
           Carryin => s_Carryin(31),
           Operation => s_Operation,
           Carryout => Carryout,
           result => s_F(31),
           Set => s_Set,
           Overflow => Overflow);

   F <= s_F;
   Zero <= NOT(or_reduce(s_F));
end arch;