-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------


-- tb_mips_component.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: 
--
--
-- NOTES:
-- 9/11/2019: Created by Nick
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_mips_component is
generic(gCLK_HPER   : time := 50 ns ; 
	N : integer := 32);
end tb_mips_component;

architecture behavior of tb_mips_component is
  

  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


component mips_component 
port(   i_imm		: in std_logic_vector(15 downto 0); 	--Immediate value to be adder/subtracted
	i_alu_ctl	: in std_logic;
	ALUctl		: in std_logic;  	
	memWE 		: in std_logic; 
	regWE		: in std_logic;
	load		: in std_logic;
	ext_ctl		: in std_logic; 
	memAddr		: in std_logic_vector(9 downto 0); 
	regAddr		: in std_logic_vector(4 downto 0); 
	i_read1		: in std_logic_vector(4 downto 0); 	--Read(1)
	i_read2		: in std_logic_vector(4 downto 0); 	--Read(2)
	i_rst		: in std_logic;				--Reset
	i_clk		: in std_logic);				--Clock  

end component;

--Controls
signal s_clk, s_rst, s_alu_ctl, s_ALUctl, s_memWE, s_regWE, s_load, s_ext_ctl : std_logic;

--Address 
signal s_regAddr : std_logic_vector(4 downto 0);
signal s_memAddr : std_logic_vector(9 downto 0); 
 
--reads
signal s_read1, s_read2 : std_logic_vector(4 downto 0);

-- immediate value 
signal s_imm : std_logic_vector(15 downto 0); 

begin

  mips_test : mips_component
       port MAP(i_imm		=> s_imm,	
		i_alu_ctl	=> s_alu_ctl,
		ALUctl		=> s_ALUctl,  	
		memWE 		=> s_memWE, 
		regWE		=> s_regWe,	
		load		=> s_load,
		ext_ctl		=> s_ext_ctl, 
		memAddr		=> s_memAddr,
		regAddr		=> s_regAddr,  
		i_read1		=> s_read1, 	
		i_read2		=> s_read2,
		i_rst		=> s_rst,
		i_clk		=> s_clk); 

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
  begin
    s_clk <= '0';
    wait for gCLK_HPER;
    s_clk <= '1';
    wait for gCLK_HPER;
  end process;
  
  -- Testbench process  
  P_TB: process
  begin
	
	--addi	Load A into 25
	s_memAddr 	<= "0000000000"; 
	s_memWE 	<= '0'; 
	wait for cCLK_PER; 
	s_memWE		<= '1';
	s_memAddr	<= "0000011001";
	wait for cCLK_PER;

	--addi Load B into 26 
	s_memAddr 	<= "0000000001"; 
	s_memWE 	<= '0'; 
	wait for cCLK_PER; 
	s_memWE		<= '1';
	s_memAddr	<= "0000011010";
	wait for cCLK_PER;

	--lw Load A[0] into 1
	s_load		<= '1';
	s_regWE		<= '1';
	s_memWE		<= '0';
	s_memAddr	<= "0000000000";
	s_regAddr	<= "00001";
	wait for cCLK_PER;

	--lw Load A[1] into 2
	s_load		<= '1';
	s_regWE		<= '1';
	s_memWE		<= '0';
	s_memAddr	<= "0000000001";
	s_regAddr	<= "00010";
	wait for cCLK_PER;

	--add 1 = 1 + 2
	s_read1		<= "00001";
	s_read2		<= "00010";
	s_ALUctl 	<= '0';
	s_alu_ctl	<= '0';
	s_load 		<= '0';
	s_regWE		<= '1';
	s_regAddr	<= "00001";
	wait for cCLK_PER; 

	--sw store 1 into B[0]
	s_read1		<= "00001";
	s_ALUctl 	<= '0';
	s_alu_ctl	<= '0';
	s_memWE		<= '1'; 
	s_memAddr	<= "0000010000";
	s_load 		<= '1';
	s_regWE		<= '1';
	s_regAddr	<= "00001";
	wait for cCLK_PER; 

	--lw Load A[2] into 2
	s_load		<= '1';
	s_regWE		<= '1';
	s_memWE		<= '0';
	s_memAddr	<= "0000000010";
	s_regAddr	<= "00010";
	wait for cCLK_PER;

	--add 1 = 1 + 2
	s_read1		<= "00001";
	s_read2		<= "00010";
	s_ALUctl 	<= '0';
	s_alu_ctl	<= '0';
	s_load 		<= '0';
	s_regWE		<= '1';
	s_regAddr	<= "00001";
	wait for cCLK_PER; 

	--sw Store 1 into B[1]
	s_read1		<= "00001";
	s_ALUctl 	<= '0';
	s_alu_ctl	<= '0';
	s_memWE		<= '1'; 
	s_memAddr	<= "0000010001";
	s_load 		<= '1';
	s_regWE		<= '1';
	s_regAddr	<= "00001";
	wait for cCLK_PER; 

	--lw Load A[3] into 2
	s_load		<= '1';
	s_regWE		<= '1';
	s_memWE		<= '0';
	s_memAddr	<= "0000000011";
	s_regAddr	<= "00010";
	wait for cCLK_PER;

	--add 1 = 1 + 2
	s_read1		<= "00001";
	s_read2		<= "00010";
	s_ALUctl 	<= '0';
	s_alu_ctl	<= '0';
	s_load 		<= '0';
	s_regWE		<= '1';
	s_regAddr	<= "00001";
	wait for cCLK_PER; 

	--sw Store 1 into B[2]
	s_read1		<= "00001";
	s_ALUctl 	<= '0';
	s_alu_ctl	<= '0';
	s_memWE		<= '1'; 
	s_memAddr	<= "0000010010";
	s_load 		<= '1';
	s_regWE		<= '1';
	s_regAddr	<= "00001";
	wait for cCLK_PER; 

	--lw Load A[4] into 2
	s_load		<= '1';
	s_regWE		<= '1';
	s_memWE		<= '0';
	s_memAddr	<= "0000000100";
	s_regAddr	<= "00010";
	wait for cCLK_PER;

	--add 1 = 1 + 2
	s_read1		<= "00001";
	s_read2		<= "00010";
	s_ALUctl 	<= '0';
	s_alu_ctl	<= '0';
	s_load 		<= '0';
	s_regWE		<= '1';
	s_regAddr	<= "00001";
	wait for cCLK_PER; 

	--sw Store 1 into B[3]
	s_read1		<= "00001";
	s_ALUctl 	<= '0';
	s_alu_ctl	<= '0';
	s_memWE		<= '1'; 
	s_memAddr	<= "0000010011";
	s_load 		<= '1';
	s_regWE		<= '1';
	s_regAddr	<= "00001";
	wait for cCLK_PER; 

	--lw Load A[5] into 2
	s_load		<= '1';
	s_regWE		<= '1';
	s_memWE		<= '0';
	s_memAddr	<= "0000000101";
	s_regAddr	<= "00010";
	wait for cCLK_PER;

	--add 1 = 1 + 2
	s_read1		<= "00001";
	s_read2		<= "00010";
	s_ALUctl 	<= '0';
	s_alu_ctl	<= '0';
	s_load 		<= '0';
	s_regWE		<= '1';
	s_regAddr	<= "00001";
	wait for cCLK_PER; 

	--sw Store 1 into B[4]
	s_read1		<= "00001";
	s_ALUctl 	<= '0';
	s_alu_ctl	<= '0';
	s_memWE		<= '1'; 
	s_memAddr	<= "0000010100";
	s_load 		<= '1';
	s_regWE		<= '1';
	s_regAddr	<= "00001";

	--lw Load A[6] into 2
	s_load		<= '1';
	s_regWE		<= '1';
	s_memWE		<= '0';
	s_memAddr	<= "0000000110";
	s_regAddr	<= "00010";
	wait for cCLK_PER;

	--add 1 = 1 + 2
	s_read1		<= "00001";
	s_read2		<= "00010";
	s_ALUctl 	<= '0';
	s_alu_ctl	<= '0';
	s_load 		<= '0';
	s_regWE		<= '1';
	s_regAddr	<= "00001";
	wait for cCLK_PER; 

	--addi Load B[256] into 27
	s_memAddr 	<= "0000011011"; 
	s_memWE 	<= '0'; 
	wait for cCLK_PER; 
	s_memWE		<= '1';
	s_memAddr	<= "0100000000";
	wait for cCLK_PER; 

	--sw Store 1 into B[255]
	s_read1		<= "00001";
	s_ALUctl 	<= '0';
	s_alu_ctl	<= '0';
	s_memWE		<= '1'; 
	s_memAddr	<= "0100000000";
	s_load 		<= '1';
	s_regWE		<= '1';
	s_regAddr	<= "00001";





  	end process;
  
end behavior;
