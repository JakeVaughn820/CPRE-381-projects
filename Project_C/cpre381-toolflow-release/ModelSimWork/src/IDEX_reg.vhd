-------------------------------------------------------------------------
-- Jacob Vaughn
-------------------------------------------------------------------------

-- IDEX_reg.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity IDEX_reg is
  port(CLK             : in std_logic;     -- Clock input
       IDEX_WriteEn    : in std_logic;     -- ID 1 writing is enabled
       IDEX_flush      : in std_logic;

       ID_PC4          : in std_logic_vector(31 downto 0);
       ID_RegDst       : in std_logic;
       ID_MemtoReg     : in std_logic;
       ID_ALUOp        : in std_logic_vector(5 downto 0);
       ID_MemWrite     : in std_logic;
       ID_ALUSrc       : in std_logic;
       ID_ReWrite      : in std_logic;
       ID_Shift        : in std_logic;
       ID_Jr           : in std_logic;
       ID_Rs_data      : in std_logic_vector(31 downto 0);
       ID_Rt_data      : in std_logic_vector(31 downto 0);
       ID_32Imm        : in std_logic_vector(31 downto 0);
       ID_rs           : in std_logic_vector(5 downto 0);
       ID_rt           : in std_logic_vector(5 downto 0);
       ID_rd           : in std_logic_vector(5 downto 0);
       ID_Funct        : in std_logic_vector(5 downto 0);
       ID_PC4          : in std_logic_vector(31 downto 0);
       ID_Shift_Amount : in std_logic_vector(4 downto 0);

       EX_PC4          : out std_logic_vector(31 downto 0);
       EX_RegDst       : out std_logic;
       EX_MemtoReg     : out std_logic;
       EX_ALUOp        : out std_logic_vector(5 downto 0);
       EX_MemWrite     : out std_logic;
       EX_ALUSrc       : out std_logic;
       EX_ReWrite      : out std_logic;
       EX_Shift        : out std_logic;
       EX_Jr           : out std_logic;
       EX_Rs_data      : out std_logic_vector(31 downto 0);
       EX_Rt_data      : out std_logic_vector(31 downto 0);
       EX_32Imm        : out std_logic_vector(31 downto 0);
       EX_rs           : out std_logic_vector(5 downto 0);
       EX_rt           : out std_logic_vector(5 downto 0);
       EX_rd           : out std_logic_vector(5 downto 0);
       EX_Funct        : out std_logic_vector(5 downto 0);
       EX_PC4          : out std_logic_vector(31 downto 0);
       EX_Shift_Amount : out std_logic_vector(4 downto 0));
end IDEX_reg;

architecture arch of IDEX_reg is

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
     --  i_flush      : in std_logic;     -- Flu
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

component four_bit_reg
  generic(N : integer := 4);
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
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

   IDEX_PC4_reg: N_bit_reg
   port map(i_CLK => CLK,
            i_RST => IDEX_flush,
            i_WE => IDEX_WriteEn,
            i_D => ID_PC4,
            o_Q => EX_PC4);

   IDEX_RegDst_reg: one_bit_reg
   port map(i_CLK => CLK,
            i_RST => IDEX_flush,
            i_WE => IDEX_WriteEn,
            i_D => ID_RegDst,
            o_Q => EX_RegDst);

   IDEX_MemtoReg_reg: one_bit_reg
   port map(i_CLK => CLK,
            i_RST => IDEX_flush,
            i_WE => IDEX_WriteEn,
            i_D => ID_MemtoReg,
            o_Q => EX_MemtoReg);

   IDEX_ALUOp_reg: five_bit_reg
   port map(i_CLK => CLK,
            i_RST => IDEX_flush,
            i_WE => IDEX_WriteEn,
            i_D => ID_ALUOp,
            o_Q => EX_ALUOp);

   IDEX_MemWrite_reg: one_bit_reg
   port map(i_CLK => CLK,
            i_RST => IDEX_flush,
            i_WE => IDEX_WriteEn,
            i_D => ID_MemWrite,
            o_Q => EX_MemWrite);

   IDEX_ALUSrc_reg: one_bit_reg
   port map(i_CLK => CLK,
            i_RST => IDEX_flush,
            i_WE => IDEX_WriteEn,
            i_D => ID_ALUSrc,
            o_Q => EX_ALUSrc);

   IDEX_ReWrite_reg: one_bit_reg
   port map(i_CLK => CLK,
            i_RST => IDEX_flush,
            i_WE => IDEX_WriteEn,
            i_D => ID_ReWrite,
            o_Q => EX_ReWrite);

   IDEX_Shift_reg: one_bit_reg
   port map(i_CLK => CLK,
            i_RST => IDEX_flush,
            i_WE => IDEX_WriteEn,
            i_D => ID_Shift,
            o_Q => EX_Shift);

   IDEX_Jr_reg: one_bit_reg
   port map(i_CLK => CLK,
            i_RST => IDEX_flush,
            i_WE => IDEX_WriteEn,
            i_D => ID_Jr,
            o_Q => EX_Jr);

   IDEX_Rs_data_reg: N_bit_reg
   port map(i_CLK => CLK,
            i_RST => IDEX_flush,
            i_WE => IDEX_WriteEn,
            i_D => ID_Rs_data,
            o_Q => EX_Rs_data);

   IDEX_Rt_data_reg: N_bit_reg
   port map(i_CLK => CLK,
            i_RST => IDEX_flush,
            i_WE => IDEX_WriteEn,
            i_D => ID_Rt_data,
            o_Q => EX_Rt_data);

   IDEX_32Imm_reg: N_bit_reg
   port map(i_CLK => CLK,
            i_RST => IDEX_flush,
            i_WE => IDEX_WriteEn,
            i_D => ID_32Imm,
            o_Q => EX_32Imm);

   IDEX_rs_reg: N_bit_reg
   port map(i_CLK => CLK,
            i_RST => IDEX_flush,
            i_WE => IDEX_WriteEn,
            i_D => ID_rs,
            o_Q => EX_rs);

   IDEX_rt_reg: N_bit_reg
   port map(i_CLK => CLK,
            i_RST => IDEX_flush,
            i_WE => IDEX_WriteEn,
            i_D => ID_rt,
            o_Q => EX_rt);

   IDEX_rd_reg: N_bit_reg
   port map(i_CLK => CLK,
            i_RST => IDEX_flush,
            i_WE => IDEX_WriteEn,
            i_D => ID_rd,
            o_Q => EX_rd);

   IDEX_Funct_reg: five_bit_reg
   port map(i_CLK => CLK,
            i_RST => IDEX_flush,
            i_WE => IDEX_WriteEn,
            i_D => ID_Funct,
            o_Q => EX_Funct);

   IDEX_PC4_reg: N_bit_reg
   port map(i_CLK => CLK,
            i_RST => IDEX_flush,
            i_WE => IDEX_WriteEn,
            i_D => ID_PC4,
            o_Q => EX_PC4);

   IDEX_Funct_reg: four_bit_reg
   port map(i_CLK => CLK,
            i_RST => IDEX_flush,
            i_WE => IDEX_WriteEn,
            i_D => ID_Shift_Amount,
            o_Q => EX_Shift_Amount);            
end arch;
