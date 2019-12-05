-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------

-- EXMEM_reg.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity MEMWB_reg is
  port(CLK             : in std_logic;     -- Clock input
       MEMWB_WriteEn   : in std_logic;     -- Write enable (1)
       MEMWB_flush       : in std_logic;

      --Inputs (MEM)
      MEM_RegWrite    : in std_logic;
      MEM_MemtoReg    : in std_logic;
      MEM_jal         : in std_logic;
      MEM_DMemOut     : in std_logic_vector(31 downto 0);
      MEM_ALUResult   : in std_logic_vector(31 downto 0);
      MEM_WriteReg    : in std_logic_vector(4 downto 0);
      MEM_PC4         : in std_logic_vector(31 downto 0);
	  MEM_Halt        : in std_logic; 

      --Outputs (WB)
      WB_RegWrite     : out std_logic;
      WB_MemtoReg     : out std_logic;
      WB_jal          : out std_logic;
      WB_DMemOut      : out std_logic_vector(31 downto 0);
      WB_ALUResult    : out std_logic_vector(31 downto 0);
      WB_WriteReg     : out std_logic_vector(4 downto 0);
      WB_PC4          : out std_logic_vector(31 downto 0);
	  WB_Halt         : out std_logic); 

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

   MEMWB_RegWrite_reg: one_bit_reg
   port map(i_CLK => CLK,
           i_RST => MEMWB_flush,
           i_WE => MEMWB_WriteEn,
           i_D => MEM_RegWrite,
           o_Q => WB_RegWrite);

   MEMWB_MemtoReg_reg: one_bit_reg
   port map(i_CLK => CLK,
           i_RST => MEMWB_flush,
           i_WE => MEMWB_WriteEn,
           i_D => MEM_MemtoReg,
           o_Q => WB_MemtoReg);

   MEMWB_jal_reg: one_bit_reg
   port map(i_CLK => CLK,
           i_RST => MEMWB_flush,
           i_WE => MEMWB_WriteEn,
           i_D => MEM_jal,
           o_Q => WB_jal);

   MEMWB_DMemOut_reg: N_bit_reg
   port map(i_CLK => CLK,
            i_RST => MEMWB_flush,
            i_WE => MEMWB_WriteEn,
            i_D => MEM_DMemOut,
            o_Q => WB_DMemOut);

   MEMWB_ALUResult_reg: N_bit_reg
   port map(i_CLK => CLK,
           i_RST => MEMWB_flush,
           i_WE => MEMWB_WriteEn,
           i_D => MEM_ALUResult,
           o_Q => WB_ALUResult);

   MEMWB_WriteReg_reg: five_bit_reg
   port map(i_CLK => CLK,
            i_RST => MEMWB_flush,
            i_WE => MEMWB_WriteEn,
            i_D => MEM_WriteReg,
            o_Q => WB_WriteReg);

   MEMWB_PC4_reg: N_bit_reg
   port map(i_CLK => CLK,
            i_RST => MEMWB_flush,
            i_WE => MEMWB_WriteEn,
            i_D => MEM_PC4,
            o_Q => WB_PC4);
			
MEMWB_Halt_reg: one_bit_reg
   port map(i_CLK => CLK,
           i_RST => MEMWB_flush,
           i_WE => MEMWB_WriteEn,
           i_D => MEM_Halt,
           o_Q => WB_Halt);
end arch;
