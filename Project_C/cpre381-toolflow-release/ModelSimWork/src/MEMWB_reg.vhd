-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------

-- EXMEM_reg.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity MEMWB_reg is
  port(CLK             : in std_logic;     -- Clock input
       MEMWB_WriteEn   : in std_logic;     -- Write enable (1) 
	      
	   --Inputs (MEM)
	   MEM_flush       : in std_logic; 
	   MEM_RegWrite	   : in std_logic; 
	   MEM_MemtoReg    : in std_logic; 
	   --MEM_MemWrite    : in std_logic; 
	   MEM_OutRd       : in std_logic_vector(31 downto 0); 
	   MEM_WriteData   : in std_logic_vector(31 downto 0); 
	   MEM_WriteReg    : in std_logic_vector(4 downto 0); 
	   
	   --Outputs (WB)
	   WB_flush        : out std_logic;
	   WB_RegWrite     : out std_logic; 
	   WB_MemtoReg     : out std_logic;
	   WB_ReadData     : out std_logic_vector(31 downto 0); 
	   WB_ALUResult    : out std_logic_vector(31 downto 0);
	   WB_WriteReg     : out std_logic_vector(4 downto 0)); 

end MEMWB_reg;

architecture arch of MEMWB_reg is

component N_bit_reg
  generic(N : integer := 32);
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
end component;

component one_bit_reg
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       --i_flush      : in std_logic;     -- Flu
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

component five_bit_reg
  generic(N : integer := 5);
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
end component;

begin

   MEMWB_Flush_reg: one_bit_reg
   port map(i_CLK => CLK,
            i_RST => '0',
            i_WE => MEMWB_WriteEn,
            i_D => MEM_flush,
            o_Q => WB_flush);
			
	MEMWB_RegWrite_reg: one_bit_reg
	port map(i_CLK => CLK, 
                 i_RST => MEM_flush, 
		 i_WE => MEMWB_WriteEn,
		 i_D => MEM_RegWrite, 
		 o_Q => WB_RegWrite); 
			
	MEMWB_MemtoReg_reg: one_bit_reg
	port map(i_CLK => CLK, 
		 i_RST => MEM_flush, 
		 i_WE => MEMWB_WriteEn,
		 i_D => MEM_MemtoReg, 
		 o_Q => WB_MemtoReg);
			 
	MEMWB_MEMOutRD_reg: N_bit_reg
	port map(i_CLK => CLK, 
		 i_RST => MEM_flush,
	         i_WE => MEMWB_WriteEn,
	         i_D => MEM_OutRd,
		 o_Q => WB_ReadData); 

	MEMWB_WriteData_reg: N_bit_reg
	port map(i_CLK => CLK, 
		 i_RST => MEM_flush, 
		 i_WE => MEMWB_WriteEn, 
		 i_D => MEM_WriteData,
		 o_Q => WB_ALUResult);

	MEMWB_WriteReg_reg: five_bit_reg
	port map(i_CLK => CLK, 
	         i_RST => MEM_flush, 
		 i_WE => MEMWB_WriteEn,
		 i_D => MEM_WriteReg, 
		 o_Q => WB_WriteReg);			 
	
end arch;
