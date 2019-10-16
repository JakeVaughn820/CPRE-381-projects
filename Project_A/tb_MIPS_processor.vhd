-------------------------------------------------------------------------
-- Jacob Vaughn
-------------------------------------------------------------------------

-- tb_MIPS_processor.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_MIPS_processor is
   generic(gCLK_HPER   : time := 50 ns);
end tb_MIPS_processor;

architecture arch of tb_MIPS_processor is

  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

--components
component MIPS_processor
  port(i_CLK        : in std_logic;     -- Clock input

       i_rs         : in std_logic_vector(4 downto 0);     -- Read address 1
       i_rt         : in std_logic_vector(4 downto 0);     -- Read address 2
       i_rd         : in std_logic_vector(4 downto 0);     -- Write address

       i_ALUSrc     : in std_logic;     -- Reset registers
       i_nAdd_Sub   : in std_logic;     -- Reset registers
       i_regWrite      : in std_logic;     -- Reset registers

       i_immediate  : in std_logic_vector(31 downto 0));     -- Data value input
end component;       

 --signals
signal       s_CLK        : std_logic;     -- Clock input

signal       s_rs         : std_logic_vector(4 downto 0);     -- Read address 1
signal       s_rt         : std_logic_vector(4 downto 0);     -- Read address 2
signal       s_rd         : std_logic_vector(4 downto 0);     -- Write address

signal       s_ALUSrc     : std_logic;     -- Reset registers
signal       s_nAdd_Sub   : std_logic;     -- Reset registers
signal       s_regWrite      : std_logic;     -- Reset registers

signal       s_immediate  : std_logic_vector(31 downto 0);     -- Data value input

begin

   MIPS_processor1: MIPS_processor
   port map(i_CLK => s_CLK,

       i_rs => s_rs,
       i_rt => s_rt,
       i_rd => s_rd,
 
       i_ALUSrc => s_ALUSrc,
       i_nAdd_Sub => s_nAdd_Sub,
       i_regWrite => s_regWrite,

       i_immediate => s_immediate);

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
  
  -- Testbench process  
  P_TB: process
  begin
    -- addi $1, $0, 1
       s_rs <= "00000";
       s_rd <= "00001";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';

       s_immediate <= x"00000001";
    wait for cCLK_PER;  

    -- addi $2; $0; 2

       s_rs <= "00000";
       s_rd <= "00010";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';

       s_immediate <= x"00000002";
    wait for cCLK_PER;  

     -- addi $3; $0; 3 

       s_rs <= "00000";
       s_rd <= "00011";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';

       s_immediate <= x"00000003";
    wait for cCLK_PER; 

     -- addi $; $0; 4 

       s_rs <= "00000";
       s_rd <= "00100";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';

       s_immediate <= x"00000004";
    wait for cCLK_PER; 

     -- addi $5; $0; 5 

       s_rs <= "00000";
       s_rd <= "00101";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';

       s_immediate <= x"00000005";
    wait for cCLK_PER; 

     -- addi $6; $0; 6 

       s_rs <= "00000";
       s_rd <= "00110";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';

       s_immediate <= x"00000006";
    wait for cCLK_PER; 

     -- addi $7; $0; 7 

       s_rs <= "00000";
       s_rd <= "00111";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';

       s_immediate <= x"00000007";
    wait for cCLK_PER; 

     -- addi $8; $0; 8 

       s_rs <= "00000";
       s_rd <= "01000";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';

       s_immediate <= x"00000008";
    wait for cCLK_PER; 

     -- addi $9; $0; 9 

       s_rs <= "00000";
       s_rd <= "01001";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';

       s_immediate <= x"00000009";
    wait for cCLK_PER; 

     -- addi $10; $0; 10 

       s_rs <= "00000";
       s_rd <= "01010";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';

       s_immediate <= x"0000000a";
    wait for cCLK_PER; 

     -- add $11; $1; $2 

       s_rs <= "00001";
       s_rt <= "00010";
       s_rd <= "01011";
 
       s_ALUSrc <= '0';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
    wait for cCLK_PER; 

     -- sub $12; $11; $3

       s_rs <= "01011";
       s_rt <= "00011";
       s_rd <= "01100";
 
       s_ALUSrc <= '0';
       s_nAdd_Sub <= '1';
       s_regWrite <= '1';
    wait for cCLK_PER; 

     -- add $13; $12; $4

       s_rs <= "01100";
       s_rt <= "00100";
       s_rd <= "01101";
 
       s_ALUSrc <= '0';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
    wait for cCLK_PER; 

     -- sub $14; $13; $5

       s_rs <= "01101";
       s_rt <= "00101";
       s_rd <= "01110";
 
       s_ALUSrc <= '0';
       s_nAdd_Sub <= '1';
       s_regWrite <= '1';
    wait for cCLK_PER; 

     -- add $15; $14; $6

       s_rs <= "01110";
       s_rt <= "00110";
       s_rd <= "01111";
 
       s_ALUSrc <= '0';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
    wait for cCLK_PER;

     -- sub $16; $15; $7

       s_rs <= "01111";
       s_rt <= "00111";
       s_rd <= "10000";
 
       s_ALUSrc <= '0';
       s_nAdd_Sub <= '1';
       s_regWrite <= '1';
    wait for cCLK_PER;

     -- add $17; $16; $8

       s_rs <= "10000";
       s_rt <= "01000";
       s_rd <= "10001";
 
       s_ALUSrc <= '0';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
    wait for cCLK_PER;

     -- sub $18; $17; $9

       s_rs <= "10001";
       s_rt <= "01001";
       s_rd <= "10010";
 
       s_ALUSrc <= '0';
       s_nAdd_Sub <= '1';
       s_regWrite <= '1';
    wait for cCLK_PER;

     -- add $19; $18; $10

       s_rs <= "10010";
       s_rt <= "01010";
       s_rd <= "10011";
 
       s_ALUSrc <= '0';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
    wait for cCLK_PER;

     -- addi $20; $0; 35

       s_rs <= "00000";

       s_rd <= "10100";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';

       s_immediate <= x"00000023";
    wait for cCLK_PER;

     -- add $21; $19; $20

       s_rs <= "10011";
       s_rt <= "10100";
       s_rd <= "10101";
 
       s_ALUSrc <= '0';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
    wait for cCLK_PER;

    wait;
  end process;
  
end arch;