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

component mem is
	generic 
	(
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10
	);
	port 
	(
		clk		: in std_logic;
		addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '1';
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);
end component;    

 --signals
signal       s_CLK        : std_logic;     -- Clock input

signal       s_rs         : std_logic_vector(4 downto 0);     -- Read address 1
signal       s_rt         : std_logic_vector(4 downto 0);     -- Read address 2
signal       s_rd         : std_logic_vector(4 downto 0);     -- Write address

signal       s_ALUSrc     : std_logic;
signal       s_nAdd_Sub   : std_logic;
signal       s_regWrite   : std_logic;
signal       s_mem_we     : std_logic;
signal       s_MemtoReg   : std_logic;
signal       s_immediate  : std_logic_vector(15 downto 0);     -- Data value input

begin



   TB_MIPS_processor_V2: MIPS_processor_V2
   port map(i_CLK => s_CLK,
            i_rs => s_rs,
            i_rt => s_rt,
            i_rd => s_rd,
            i_ALUSrc => s_ALUSrc,
            i_nAdd_Sub => s_nAdd_Sub,
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

    -- addi $25, $0, 0 # Load &A into $25
       s_rs <= "00000";

       s_rd <= "11001";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';

       s_immediate <= x"0000";
    wait for cCLK_PER;  

    -- addi $26, $0, 256 # Load &B into $26
       s_rs <= "00000";

       s_rd <= "11010";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';

       s_immediate <= x"0100";
    wait for cCLK_PER;  

    -- lw $1, 0($25) # Load A[0] into $1
       s_rs <= "11001";

       s_rd <= "00001";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '1';

       s_immediate <= x"0000";
    wait for cCLK_PER;  

    -- lw $2, 4($25) # Load A[1] into $2
       s_rs <= "11001";

       s_rd <= "00010";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '1';

       s_immediate <= x"0004";
    wait for cCLK_PER;  

    -- add $1, $1, $2 # $1 = $1 + $2
       s_rs <= "00001";
       s_rt <= "00010";
       s_rd <= "00001";
 
       s_ALUSrc <= '0';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
    wait for cCLK_PER;  

    -- sw $1, 0($26) # Store $1 into B[0]
       s_rs <= "11010";

       s_rd <= "00001";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '0';
       s_mem_we <= '1';

       s_immediate <= x"0000";
    wait for cCLK_PER;  

    -- lw $2, 8($25) # Load A[2] into $2
       s_rs <= "11001";

       s_rd <= "00010";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '1';

       s_immediate <= x"0008";
    wait for cCLK_PER;  

    -- add $1, $1, $2 # $1 = $1 + $2
       s_rs <= "00001";
       s_rt <= "00010";
       s_rd <= "00001";
 
       s_ALUSrc <= '0';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
    wait for cCLK_PER;  

    -- sw $1, 4($26) # Store $1 into B[1]
       s_rs <= "11010";

       s_rd <= "00001";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '0';
       s_mem_we <= '1';

       s_immediate <= x"0004";
    wait for cCLK_PER;  

    -- lw $2, 12($25) # Load A[3] into $2
       s_rs <= "11001";

       s_rd <= "00010";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '1';

       s_immediate <= x"000C";
    wait for cCLK_PER;  

    -- add $1, $1, $2 # $1 = $1 + $2
       s_rs <= "00001";
       s_rt <= "00010";
       s_rd <= "00001";
 
       s_ALUSrc <= '0';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
    wait for cCLK_PER;  

    -- sw $1, 8($26) # Store $1 into B[2]
       s_rs <= "11010";

       s_rd <= "00001";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '0';
       s_mem_we <= '1';

       s_immediate <= x"0008";
    wait for cCLK_PER;  

    -- lw $2, 16($25) # Load A[4] into $2
       s_rs <= "11001";

       s_rd <= "00010";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '1';

       s_immediate <= x"0010";
    wait for cCLK_PER;  

    -- add $1, $1, $2 # $1 = $1 + $2
       s_rs <= "00001";
       s_rt <= "00010";
       s_rd <= "00001";
 
       s_ALUSrc <= '0';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
    wait for cCLK_PER;  

    -- sw $1, 12($26) # Store $1 into B[3]
       s_rs <= "11010";

       s_rd <= "00001";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '0';
       s_mem_we <= '1';

       s_immediate <= x"000C";
    wait for cCLK_PER;  

    -- lw $2, 20($25) # Load A[5] into $2
       s_rs <= "11001";

       s_rd <= "00010";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '1';

       s_immediate <= x"0014";
    wait for cCLK_PER;  

    -- add $1, $1, $2 # $1 = $1 + $2
       s_rs <= "00001";
       s_rt <= "00010";
       s_rd <= "00001";
 
       s_ALUSrc <= '0';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
    wait for cCLK_PER;  

    -- sw $1, 16($26) # Store $1 into B[4]
       s_rs <= "11010";

       s_rd <= "00001";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '0';
       s_mem_we <= '1';

       s_immediate <= x"0010";
    wait for cCLK_PER;  

    -- lw $2, 24($25) # Load A[6] into $2
       s_rs <= "11001";

       s_rd <= "00010";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '1';

       s_immediate <= x"0018";
    wait for cCLK_PER;  

    -- add $1, $1, $2 # $1 = $1 + $2
       s_rs <= "00001";
       s_rt <= "00010";
       s_rd <= "00001";
 
       s_ALUSrc <= '0';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';
    wait for cCLK_PER;  

    -- addi $27, $0, 512 # Load &B[256] into $27
       s_rs <= "00000";

       s_rd <= "11011";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '1';
       s_mem_we <= '0';
       s_MemtoReg <= '0';

       s_immediate <= x"0200";
    wait for cCLK_PER;  

    -- sw $1, -4($27) # Store $1 into B[255]
       s_rs <= "11011";

       s_rd <= "00001";
 
       s_ALUSrc <= '1';
       s_nAdd_Sub <= '0';
       s_regWrite <= '0';
       s_mem_we <= '1';

       s_immediate <= x"FFFC";
    wait for cCLK_PER;  

    wait;
  end process;
  
end arch;