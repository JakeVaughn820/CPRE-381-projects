-------------------------------------------------------------------------
-- Jacob Vaughn
-- Nickolas Mitchell
-------------------------------------------------------------------------

-- ALU_and_Shifter.vhd
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_misc.all;

entity ALU_and_Shifter is
  port(A         : in   std_logic_vector(31 downto 0);
       B         : in   std_logic_vector(31 downto 0);
       ALUOp     : in   std_logic_vector(5 downto 0); --Operation for the ALU
                                                       --000000 : AND
                                                       --000001 : or
                                                       --000010 : add
                                                       --000011 : xor
                                                       --011100 : slt
                                                       --110000 : NOR
                                                       --110001 : NAND
                                                       --011010 : Sub
                                                       --111100 : arithmetic shift right
                                                       --111101 : logical shift right
                                                       --111110 : Shift left
       Shift_Amount : in   std_logic_vector(4 downto 0);
       F         : out  std_logic_vector(31 downto 0);
       Carryout  : out  std_logic;
       Overflow  : out  std_logic;
       Zero      : out  std_logic); 
end ALU_and_Shifter;

architecture arch of ALU_and_Shifter is

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

component right_left_shifter
--generic(N : integer:=32);
  port( i_shift			: in std_logic_vector(31 downto 0);
	ctl_bits_to_shift 	: in std_logic_vector(4 downto 0);
	ctl_which_shift		: in std_logic_vector(1 downto 0);	--'00' <= arithmetic shift right     '01' <= logical shift right     '10' <= Shift left 	
	o_shift			: out std_logic_vector(31 downto 0));

end component;

component ALU_control
  port(Shift_Amount             : in std_logic_vector(4 downto 0);
       Op 	                : in std_logic_vector(5 downto 0);
       ctl_bits_to_shift 	: out std_logic_vector(4 downto 0);
       ctl_which_shift		: out std_logic_vector(1 downto 0));
       
end component;

 --signals

signal       s_Carryout   : std_logic;
signal       s_Overflow   : std_logic;
signal       s_Zero       : std_logic;
signal       s_F_ALU         : std_logic_vector (31 downto 0);
signal       s_F_Shift         : std_logic_vector (31 downto 0);
signal       s_ctl_bits_to_shift 	: std_logic_vector(4 downto 0);
signal       s_ctl_which_shift		: std_logic_vector(1 downto 0);

begin

  ALU: ALU_32_bit 
  port map(A => A,
           B => B,
          control => ALUOp,
           F => s_F_ALU,
           Carryout => Carryout,
           Overflow => Overflow,
           Zero => Zero );
   
   
   Shifter: right_left_shifter         
   port map(i_shift => B,
	    ctl_bits_to_shift => s_ctl_bits_to_shift,
	    ctl_which_shift => s_ctl_which_shift,
	    o_shift => s_F_Shift);

  ALU_cont: ALU_control
   port map(Shift_Amount => Shift_Amount,
            Op => ALUOp,
            ctl_bits_to_shift => s_ctl_bits_to_shift,
            ctl_which_shift => s_ctl_which_shift);

	F <=  s_F_Shift when (ALUOp =  "111100") else
              s_F_Shift when (ALUOp =  "111101") else
              s_F_Shift when (ALUOp =  "111110") else
              s_F_ALU;
end arch;