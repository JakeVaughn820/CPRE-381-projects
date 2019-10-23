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
       i_ALUOp      : in std_logic_vector(5 downto 0);
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
       s_ALUOp <= "000010";
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
       s_immediate <= x"0001";
    wait for cCLK_PER;

    -- addi $2, $0, 2
       s_rs <= "00000";
       s_rd <= "00010";
       s_ALUSrc <= '1';
       s_ALUOp <= "000010";
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
       s_immediate <= x"0002";
    wait for cCLK_PER;

    -- sw $1, 0($1)
       s_rs <= "00001";
       s_rt <= "00001";
       s_ALUSrc <= '1';
       s_ALUOp <= "000010";
       s_regWrite <= '0';
       s_mem_we <= '1';
       s_immediate <= x"0000";
    wait for cCLK_PER; 

    -- sw $2, 0($2)
       s_rs <= "00010";
       s_rt <= "00010";
       s_ALUSrc <= '1';
       s_ALUOp <= "000010";
       s_regWrite <= '0';
       s_mem_we <= '1';
       s_immediate <= x"0000";
    wait for cCLK_PER; 

    -- lw $3, 0($1)
       s_rs <= "00001";
       s_rd <= "00011"; 
       s_ALUSrc <= '1';
       s_ALUOp <= "000010";
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '1';
       s_immediate <= x"0000";
    wait for cCLK_PER; 

    -- lw $4, 0($2)
       s_rs <= "00010";
       s_rd <= "00100"; 
       s_ALUSrc <= '1';
       s_ALUOp <= "000010";
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '1';
       s_immediate <= x"0000";
    wait for cCLK_PER; 

   -- add $3 $3 $4
       s_rs <= "00011";
       s_rt <= "00100";
       s_rd <= "00011";
       s_ALUSrc <= '0';
       s_ALUOp <= "000010";
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
    wait for cCLK_PER; 

   -- add $4 $3 $1
       s_rs <= "00011";
       s_rt <= "00001";
       s_rd <= "00100";
       s_ALUSrc <= '0';
       s_ALUOp <= "000010";
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
    wait for cCLK_PER; 

   -- sub $5 $4 $3
       s_rs <= "00100";
       s_rt <= "00011";
       s_rd <= "00101";
       s_ALUSrc <= '0';
       s_ALUOp <= "011010";
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
    wait for cCLK_PER; 

   -- subi $5 $5 6
       s_rs <= "00101";
       s_rd <= "00101";
       s_ALUSrc <= '1';
       s_ALUOp <= "011010";
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
       s_immediate <= x"0006";
    wait for cCLK_PER; 

   -- and $6 $1 $3
       s_rs <= "00001";
       s_rt <= "00011";
       s_rd <= "00110";
       s_ALUSrc <= '0';
       s_ALUOp <= "000000";
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
    wait for cCLK_PER; 


   -- andi $7 $5 imm
       s_rs <= "00101";
       s_rd <= "00111";
       s_ALUSrc <= '1';
       s_ALUOp <= "000000";
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
       s_immediate <= x"F000";
    wait for cCLK_PER; 

   -- or $5 $1 $3
       s_rs <= "00001";
       s_rt <= "00011";
       s_rd <= "00101";
       s_ALUSrc <= '0';
       s_ALUOp <= "000001";
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
    wait for cCLK_PER; 

   -- ori $rd $rs imm
       s_rs <= "00000";
       s_rd <= "00111";
       s_ALUSrc <= '1';
       s_ALUOp <= "000001";
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
       s_immediate <= x"FFCF";
    wait for cCLK_PER; 


   -- slt $5 $3 $4
       s_rs <= "00011";
       s_rt <= "00100";
       s_rd <= "00101";
       s_ALUSrc <= '0';
       s_ALUOp <= "011100";
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
    wait for cCLK_PER; 

   -- slt $5 $4 $3
       s_rs <= "00100";
       s_rt <= "00011";
       s_rd <= "00101";
       s_ALUSrc <= '0';
       s_ALUOp <= "011100";
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
    wait for cCLK_PER; 


   -- slti $5 $3 4
       s_rs <= "00011";
       s_rd <= "00101";
       s_ALUSrc <= '1';
       s_ALUOp <= "011100";
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
       s_immediate <= x"0004";
    wait for cCLK_PER; 

   -- sll $rd $rt $sa
       s_rt <= "00111";
       s_rd <= "01000";
       s_ALUSrc <= '0';
       s_ALUOp <= "111110";
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
       s_immediate <= x"0004";  --imm(4 downto 0) = $sa
    wait for cCLK_PER; 


   -- srl $rd $rt $sa
       s_rt <= "00111";
       s_rd <= "01001";
       s_ALUSrc <= '0';
       s_ALUOp <= "111101";
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
       s_immediate <= x"0004";  --imm(4 downto 0) = $sa
    wait for cCLK_PER; 


   -- sra $rd $rt $sa
       s_rt <= "00111";
       s_rd <= "01010";
       s_ALUSrc <= '0';
       s_ALUOp <= "111100";
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
       s_immediate <= x"0004";  --imm(4 downto 0) = $sa
    wait for cCLK_PER; 
   wait;
end process;

end arch;