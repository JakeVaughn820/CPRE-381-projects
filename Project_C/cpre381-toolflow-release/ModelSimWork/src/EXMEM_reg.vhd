-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------

-- EXMEM_reg.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity EXMEM_reg is
  port(CLK             : in std_logic;     -- Clock input
       EXMEM_WriteEn   : in std_logic;     -- Write enable (1)
       EXMEM_flush     : in std_logic;

      --Inputs (EX)
      EX_RegWrite      : in std_logic;
      EX_MemtoReg      : in std_logic;
      EX_MemWrite      : in std_logic;
      EX_ALUResult     : in std_logic_vector(31 downto 0);
      EX_WriteData     : in std_logic_vector(31 downto 0);
      EX_WriteReg      : in std_logic_vector(4 downto 0);

      --Outputs (MEM)
      MEM_RegWrite      : out std_logic;
      MEM_MemtoReg      : out std_logic;
      MEM_MemWrite    : out std_logic;
      MEM_ALUResult   : out std_logic_vector(31 downto 0);
      MEM_WriteData   : out std_logic_vector(31 downto 0);
      MEM_WriteReg      : out std_logic_vector(4 downto 0));
end EXMEM_reg;

architecture arch of EXMEM_reg is

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
      -- i_flush      : in std_logic;     -- Flu
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

   EXMEM_RegWrite_reg: one_bit_reg
   port map(i_CLK => CLK,
          i_RST => EXMEM_flush,
          i_WE => EXMEM_WriteEn,
          i_D => EX_RegWrite,
          o_Q => MEM_RegWrite);

   EXMEM_MemtoReg_reg: one_bit_reg
   port map(i_CLK => CLK,
          i_RST => EXMEM_flush,
          i_WE => EXMEM_WriteEn,
          i_D => EX_MemtoReg,
          o_Q => MEM_MemtoReg);

   EXMEM_MemWrite_reg: one_bit_reg
   port map(i_CLK => CLK,
          i_RST => EXMEM_flush,
          i_WE => EXMEM_WriteEn,
          i_D => EX_MemWrite,
          o_Q => MEM_MemWrite);

   EXMEM_ALUResult_reg: N_bit_reg
   port map(i_CLK => CLK,
          i_RST => EXMEM_flush,
          i_WE => EXMEM_WriteEn,
          i_D => EX_ALUResult,
          o_Q => MEM_ALUResult);

   EXMEM_WriteData_reg: N_bit_reg
   port map(i_CLK => CLK,
          i_RST => EXMEM_flush,
          i_WE => EXMEM_WriteEn,
          i_D => EX_WriteData,
          o_Q => MEM_WriteData);

   EXMEM_WriteReg_reg: five_bit_reg
   port map(i_CLK => CLK,
          i_RST => EXMEM_flush,
          i_WE => EXMEM_WriteEn,
          i_D => EX_WriteReg,
          o_Q => MEM_WriteReg);

end arch;
