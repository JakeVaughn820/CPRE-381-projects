-------------------------------------------------------------------------
-- Jacob Vaughn
-------------------------------------------------------------------------

-- tb_MIPS_processor_V3.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_MIPS_processor_V3 is
	generic 
	(
		DATA_WIDTH : natural := 32;
                gCLK_HPER   : time := 50 ns;
		ADDR_WIDTH : natural := 10
	);
end tb_MIPS_processor_V3;

architecture arch of tb_MIPS_processor_V3 is

  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

--components
component MIPS_processor_V3
  port(i_CLK        : in std_logic;     -- Clock input

       i_rs         : in std_logic_vector(4 downto 0);     -- Read address 1
       i_rt         : in std_logic_vector(4 downto 0);     -- Read address 2
       i_rd         : in std_logic_vector(4 downto 0);     -- Write address

       i_ALUSrc     : in std_logic;  -- rt or Immediate
       i_ALUOp      : in std_logic_vector(5 downto 0); --Operation for the ALU
                                                       --000000 : AND
                                                       --000011 : xor
                                                       --011100 : slt
                                                       --110000 : NOR
                                                       --110001 : NAND
                                                       --011010 : Sub
                                                       --111100 : arithmetic shift right
                                                       --111101 : logical shift right
                                                       --111110 : Shift left
       i_regWrite   : in std_logic;  -- Write to reg?
       i_mem_we     : in std_logic;  -- Write to mem?
       i_MemtoReg   : in std_logic;  -- lw

       i_immediate  : in std_logic_vector(15 downto 0));     -- Data value input
end component;      

 --signals
signal       s_CLK        : std_logic;     -- Clock input

signal       s_rs         : std_logic_vector(4 downto 0);     -- Read address 1
signal       s_rt         : std_logic_vector(4 downto 0);     -- Read address 2
signal       s_rd         : std_logic_vector(4 downto 0);     -- Write address

signal       s_ALUSrc     : std_logic;
signal       s_ALUOp      : std_logic_vector(5 downto 0);
signal       s_regWrite   : std_logic;
signal       s_mem_we     : std_logic;
signal       s_MemtoReg   : std_logic;
signal       s_immediate  : std_logic_vector(15 downto 0);     -- Data value input

begin



   TB_MIPS_processor_V3: MIPS_processor_V3
   port map(i_CLK => s_CLK,
            i_rs => s_rs,
            i_rt => s_rt,
            i_rd => s_rd,
            i_ALUSrc => s_ALUSrc,
            i_ALUOp => s_ALUOp,
            i_regWrite => s_regWrite,
            i_mem_we => s_mem_we,
            i_MemtoReg => s_MemtoReg,
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
       s_ALUOp <= '000010';
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
       s_immediate <= x"0001";
    wait for cCLK_PER;

    -- addi $2, $0, 2
       s_rs <= "00000";
       s_rd <= "00010";
       s_ALUSrc <= '1';
       s_ALUOp <= '000010';
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
       s_immediate <= x"0002";
    wait for cCLK_PER;

    -- sw $rt, imm($rs)
       s_rs <= "00001";
       s_rt <= "00001";
       s_ALUSrc <= '1';
       s_ALUOp <= '000010';
       s_regWrite <= '0';
       s_mem_we <= '1';
       s_immediate <= x"0000";
    wait for cCLK_PER; 
   wait;
end process;

end arch;