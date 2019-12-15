-------------------------------------------------------------------------
-- Jacob Vaughn
-------------------------------------------------------------------------

-- tb_Pipeline_Reg.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_Pipeline_Reg is
   generic(gCLK_HPER   : time := 50 ns);
end tb_Pipeline_Reg;

architecture arch of tb_Pipeline_Reg is

  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

--components
component IFID_reg is
  port(CLK             : in std_logic;     -- Clock input
       i_RST           : in std_logic;
       IFID_WriteEn    : in std_logic;     -- if 1 writing is enabled
       IF_PC4          : in std_logic_vector(31 downto 0);
       IF_Inst         : in std_logic_vector(31 downto 0);
       IF_flush        : in std_logic;     -- Reset registers
       ID_PC4          : out std_logic_vector(31 downto 0);
       ID_Inst         : out std_logic_vector(31 downto 0);
       ID_flush        : out std_logic);

end component; 

component IDEX_reg is
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
	   ID_UpperImm     : in std_logic;
       ID_Jr           : in std_logic;
	   ID_jal          : in std_logic;
       ID_Rs_data      : in std_logic_vector(31 downto 0);
       ID_Rt_data      : in std_logic_vector(31 downto 0);
       ID_32Imm        : in std_logic_vector(31 downto 0);
       ID_rs           : in std_logic_vector(4 downto 0);
       ID_rt           : in std_logic_vector(4 downto 0);
       ID_rd           : in std_logic_vector(4 downto 0);
       ID_Funct        : in std_logic_vector(5 downto 0);
       ID_Shift_Amount : in std_logic_vector(4 downto 0);
	   ID_Halt         : in std_logic; 

       EX_PC4          : out std_logic_vector(31 downto 0);
       EX_RegDst       : out std_logic;
       EX_MemtoReg     : out std_logic;
       EX_ALUOp        : out std_logic_vector(5 downto 0);
       EX_MemWrite     : out std_logic;
       EX_ALUSrc       : out std_logic;
       EX_ReWrite      : out std_logic;
       EX_Shift        : out std_logic;
	   EX_UpperImm     : out std_logic;
       EX_Jr           : out std_logic;
	   EX_jal          : out std_logic;
       EX_Rs_data      : out std_logic_vector(31 downto 0);
       EX_Rt_data      : out std_logic_vector(31 downto 0);
       EX_32Imm        : out std_logic_vector(31 downto 0);
       EX_rs           : out std_logic_vector(4 downto 0);
       EX_rt           : out std_logic_vector(4 downto 0);
       EX_rd           : out std_logic_vector(4 downto 0);
       EX_Funct        : out std_logic_vector(5 downto 0);
       EX_Shift_Amount : out std_logic_vector(4 downto 0);
	   EX_Halt		   : out std_logic); 
end component;

component EXMEM_reg is
  port(CLK             : in std_logic;     -- Clock input
       EXMEM_WriteEn   : in std_logic;     -- Write enable (1)
       EXMEM_flush     : in std_logic;

      --Inputs (EX)
      EX_RegWrite      : in std_logic;
      EX_MemtoReg      : in std_logic;
      EX_MemWrite      : in std_logic;
      EX_jal           : in std_logic;
      EX_ALUResult     : in std_logic_vector(31 downto 0);
      EX_WriteData     : in std_logic_vector(31 downto 0);
      EX_WriteReg      : in std_logic_vector(4 downto 0);
      EX_PC4           : in std_logic_vector(31 downto 0);
	  EX_Halt		   : in std_logic; 

      --Outputs (MEM)
      MEM_RegWrite     : out std_logic;
      MEM_MemtoReg     : out std_logic;
      MEM_MemWrite     : out std_logic;
      MEM_jal          : out std_logic;
      MEM_ALUResult    : out std_logic_vector(31 downto 0);
      MEM_WriteData    : out std_logic_vector(31 downto 0);
      MEM_WriteReg     : out std_logic_vector(4 downto 0);
      MEM_PC4          : out std_logic_vector(31 downto 0);
	  MEM_Halt         : out std_logic); 
end component;

component MEMWB_reg is
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

end component;

 --signals
  signal   s_CLK : std_logic;
  --IF register signals
  signal       s_BranchSel_OR_ID_Jump : std_logic;
  signal       IFID_reset : std_logic;
  signal       IF_flush     : std_logic;
  signal       IF_PC4 : std_logic_vector(31 downto 0);
    signal       IF_Inst : std_logic_vector(31 downto 0);
  signal ID_Funct: std_logic_vector(5 downto 0);

  --ID register signals
  signal ID_32Imm : std_logic_vector(31 downto 0);
  signal ID_RegDst : std_logic;
  signal s_MemtoReg : std_logic;
  signal ID_MemtoReg : std_logic;
  signal ID_ALUOp : std_logic_vector(5 downto 0);
  signal ID_ALUSrc : std_logic;
  signal ID_Shift : std_logic;
  signal ID_Jr : std_logic;
  signal ID_SignExtend : std_logic;
  signal ID_UpperImm : std_logic;
  signal ID_Jal : std_logic;
  signal ID_Jump : std_logic;
  signal ID_Beq : std_logic;
  signal ID_Bne : std_logic;
  signal ID_JumpAddress      : std_logic_vector(31 downto 0);

  signal       ID_Beq_and_Zero : std_logic;
  signal       ID_Bne_and_notEqual : std_logic;
  signal       s_BranchSel : std_logic;
  signal       ID_PC4          : std_logic_vector(31 downto 0);
  signal       ID_Inst         : std_logic_vector(31 downto 0);
  signal       ID_opCode       : std_logic_vector(5 downto 0);
  signal       ID_fnCode       : std_logic_vector(5 downto 0);
  signal       ID_flush        : std_logic;
  signal       ID_MemWrite     : std_logic;
  signal       s_MemWrite      : std_logic;
  signal       ID_Halt         : std_logic;
  signal       s_ReWrite       : std_logic;
  signal       ID_ReWrite      : std_logic;
  signal       ID_rs           : std_logic_vector(4 downto 0);
  signal       ID_rt           : std_logic_vector(4 downto 0);
  signal       ID_rd           : std_logic_vector(4 downto 0);
  signal       ID_Shift_amount : std_logic_vector(4 downto 0);
  signal       s_rs_data       : std_logic_vector(31 downto 0);
  signal       s_rt_data       : std_logic_vector(31 downto 0);
  signal       ID_rs_data      : std_logic_vector(31 downto 0);
  signal       ID_rt_data      : std_logic_vector(31 downto 0);
  signal       ID_equal        : std_logic;
  signal       s_reg2          : std_logic_vector(31 downto 0);
  signal       s_32Imm         : std_logic_vector(31 downto 0);
  signal       s_32Imm_Shiftleft2 : std_logic_vector(31 downto 0);
  signal       s_PC_PlusImm    : std_logic_vector(31 downto 0);

  signal       Mux_Stall       : std_logic;
  --IDEX register signals
  signal       IFID_WriteEn    :   std_logic;
  signal       IDEX_flush      :   std_logic;

  --EX register signals
  signal       EX_PC4          :   std_logic_vector(31 downto 0);
  signal       EX_RegDst       :   std_logic;
  signal       EX_MemtoReg     :   std_logic;
  signal       EX_ALUOp        :   std_logic_vector(5 downto 0);
  signal       EX_MemWrite     :   std_logic;
  signal       EX_ALUSrc       :   std_logic;
  signal       EX_ReWrite      :   std_logic;
  signal       EX_Shift        :   std_logic;
  signal       EX_UpperImm     :   std_logic;
  signal       EX_Jr           :   std_logic;
  signal       EX_jal          :   std_logic;
  signal       EX_Rs_data      :   std_logic_vector(31 downto 0);
  signal       EX_Rt_data      :   std_logic_vector(31 downto 0);
  signal       EX_32Imm        :   std_logic_vector(31 downto 0);
  signal       EX_rs           :   std_logic_vector(4 downto 0);
  signal       EX_rt           :   std_logic_vector(4 downto 0);
  signal       EX_rd           :   std_logic_vector(4 downto 0);
  signal       EX_Funct        :   std_logic_vector(5 downto 0);
  signal       EX_Shift_Amount :   std_logic_vector(4 downto 0);
  signal       s_Shift_amount  :   std_logic_vector(4 downto 0);
  signal       EX_WriteReg     :   std_logic_vector(4 downto 0);
  signal       EX_Halt         :   std_logic;
  signal       ForwardA_mux_out:   std_logic_vector(31 downto 0);
  signal       ForwardB_mux_out:   std_logic_vector(31 downto 0);
  signal       EX_Shift_out    : std_logic_vector(4 downto 0);
  signal       EX_ALUSrc_out   : std_logic_vector(31 downto 0);
  signal       EX_ALU_result   : std_logic_vector(31 downto 0);
  signal       s_ALU_operation : std_logic_vector(5 downto 0);
  --MEM register signals
  signal      MEM_RegWrite     :   std_logic;
  signal      MEM_MemtoReg     :   std_logic;
  signal      MEM_MemWrite     :   std_logic;
  signal      MEM_jal          :   std_logic;
  signal      MEM_ALUResult    :   std_logic_vector(31 downto 0);
  signal      MEM_WriteData    :   std_logic_vector(31 downto 0);
  signal      MEM_WriteReg     :   std_logic_vector(4 downto 0);
  signal      MEM_PC4          :   std_logic_vector(31 downto 0);
  signal      MEM_DMemOut      :   std_logic_vector(31 downto 0);
  signal      MEM_Halt         :   std_logic;

  --WB register signals
  signal      WB_RegWr        :   std_logic;
  signal      WB_RegWrData    :   std_logic_vector(31 downto 0);
  signal      WB_RegWrAddr    :   std_logic_vector(4 downto 0);
  signal      WB_MemtoReg     :   std_logic;
  signal      WB_jal          :   std_logic;
  signal      WB_DMemOut      :   std_logic_vector(31 downto 0);
  signal      WB_ALUResult    :   std_logic_vector(31 downto 0);
  signal      WB_WriteReg     :   std_logic_vector(4 downto 0);
  signal      WB_PC4          :   std_logic_vector(31 downto 0);
  signal      WB_MemtoReg_out :   std_logic_vector(31 downto 0);
  signal      WB_Halt         :   std_logic;


  signal      s_pc_plus4      :   std_logic_vector(31 downto 0);
  signal      ForwardA        :   std_logic_vector(1 downto 0);
  signal      ForwardB        :   std_logic_vector(1 downto 0);
  signal      s_Inst        :   std_logic_vector(31 downto 0); 
  signal      iRST : std_logic;
  signal      s_DMemOut : std_logic_vector(31 downto 0);

begin

   IFID_Register: IFID_reg
      port map(CLK => s_CLK,
               i_RST => IFID_reset,
               IFID_WriteEn => IFID_WriteEn,
               IF_PC4 => s_pc_plus4,
               IF_Inst => s_Inst, 
               IF_flush => IF_flush,
               ID_PC4 => ID_PC4,
               ID_Inst => ID_Inst,
               ID_flush => ID_flush);
			   

 IDEX_Register: IDEX_reg
   port map(CLK => s_CLK,
     IDEX_WriteEn => '1',  --TODO: add stall
     IDEX_flush => IDEX_flush,

     ID_PC4 => ID_PC4,
     ID_RegDst => ID_RegDst,
     ID_MemtoReg => ID_MemtoReg,
     ID_ALUOp => ID_ALUOp,
     ID_MemWrite => ID_MemWrite,
     ID_ALUSrc => ID_ALUSrc,
     ID_ReWrite => ID_ReWrite,
     ID_Shift => ID_Shift,
     ID_UpperImm => ID_UpperImm,
     ID_Jr => ID_Jr,
     ID_jal => ID_Jal,
     ID_Rs_data => ID_rs_data,
     ID_Rt_data => ID_rt_data,
     ID_32Imm => s_32Imm,
     ID_rs => ID_rs,
     ID_rt => ID_rt,
     ID_rd => ID_rd,
     ID_Funct => ID_fnCode,
     ID_Shift_Amount => ID_Shift_amount,
     ID_Halt => ID_Halt,

     EX_PC4 => EX_PC4,
     EX_RegDst => EX_RegDst,
     EX_MemtoReg => EX_MemtoReg,
     EX_ALUOp => EX_ALUOp,
     EX_MemWrite => EX_MemWrite,
     EX_ALUSrc => EX_ALUSrc,
     EX_ReWrite => EX_ReWrite,
     EX_Shift => EX_Shift,
     EX_UpperImm => EX_UpperImm,
     EX_Jr => EX_Jr,
     EX_jal => EX_jal,
     EX_Rs_data => EX_Rs_data,
     EX_Rt_data => EX_Rt_data,
     EX_32Imm => EX_32Imm,
     EX_rs => EX_rs,
     EX_rt => EX_rt,
     EX_rd => EX_rd,
     EX_Funct => EX_Funct,
     EX_Shift_Amount => EX_Shift_Amount,
     EX_Halt => EX_Halt);

 EXMEM_Register: EXMEM_reg
   port map(CLK => s_CLK,
     EXMEM_WriteEn => '1',  --TODO: add stall
     EXMEM_flush => iRST,   --TODO: add flush

    --Inputs (EX)
    EX_RegWrite => EX_ReWrite,
    EX_MemtoReg => EX_MemtoReg,
    EX_MemWrite => EX_MemWrite,
    EX_jal => EX_jal,
    EX_ALUResult => EX_ALU_result,
    EX_WriteData => EX_Rt_data,
    EX_WriteReg => EX_WriteReg,
    EX_PC4 => EX_PC4,
    EX_Halt => EX_Halt,

    --Outputs (MEM)
    MEM_RegWrite => MEM_RegWrite,
    MEM_MemtoReg => MEM_MemtoReg,
    MEM_MemWrite => MEM_MemWrite,
    MEM_jal => MEM_jal,
    MEM_ALUResult => MEM_ALUResult,
    MEM_WriteData => MEM_WriteData,
    MEM_WriteReg => MEM_WriteReg,
    MEM_PC4 => MEM_PC4,
    MEM_Halt => MEM_Halt);

 MEMWB_Register: MEMWB_reg
   port map(CLK => s_CLK,
     MEMWB_WriteEn => '1',  --TODO: add stall
     MEMWB_flush => iRST,   --TODO: add flush

    --Inputs (MEM)
    MEM_RegWrite => MEM_RegWrite,
    MEM_MemtoReg => MEM_MemtoReg,
    MEM_jal => MEM_jal,
    MEM_DMemOut => s_DMemOut,
    MEM_ALUResult => MEM_ALUResult,
    MEM_WriteReg => MEM_WriteReg,
    MEM_PC4 => MEM_PC4,
    MEM_Halt => MEM_Halt,

    --Outputs (WB)
    WB_RegWrite => WB_RegWr,
    WB_MemtoReg => WB_MemtoReg,
    WB_jal => WB_jal,
    WB_DMemOut => WB_DMemOut,
    WB_ALUResult => WB_ALUResult,
    WB_WriteReg => WB_WriteReg,
    WB_PC4 => WB_PC4,
    WB_Halt => WB_Halt);	

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
 
	IFID_reset <= '0';
	IFID_WriteEn <= '1';
	IF_PC4 <= x"11111111";
	IF_Inst <= x"12345678";
	IF_flush <= '0';
	


    wait for cCLK_PER;  
    IFID_reset <= '0';
	IFID_WriteEn <= '1';
	IF_PC4 <= x"11111112";
	IF_Inst <= x"12345679";
	IF_flush <= '0';
	
   ID_fnCode <= ID_Inst(5 downto 0);
   ID_rs <= ID_Inst(25 downto 21);
   ID_rt <= ID_Inst(20 downto 16);
   ID_rd <= ID_Inst(15 downto 11);
   ID_Shift_amount <= ID_Inst(10 downto 6);
   
     ID_PC4 <= ID_PC4;
     ID_RegDst <= '0';
     ID_MemtoReg <= '0';
     ID_ALUOp <= "111111";
     ID_MemWrite <= '1';
     ID_ALUSrc <= '0';
     ID_ReWrite <= '0';
     ID_Shift <= '1';
     ID_UpperImm <= '0';
     ID_Jr <= '0';
     ID_jal <= '1';
     ID_Rs_data <= x"33333333";
     ID_Rt_data <= x"22222222";
     ID_32Imm <= x"10101010";
     ID_rs <= ID_rs;
     ID_rt <= ID_rt;
     ID_rd <= ID_rd;
     ID_Funct <= ID_fnCode;
     ID_Shift_Amount <= ID_Shift_amount;
     ID_Halt <= '0';
	 
    wait for cCLK_PER;  

    IFID_reset <= '0';
	IFID_WriteEn <= '1';
	IF_PC4 <= x"11111113";
	IF_Inst <= x"12345680";
	IF_flush <= '0';
	
	wait for cCLK_PER;

    IFID_reset <= '0';
	IFID_WriteEn <= '1';
	IF_PC4 <= x"00000000";
	IF_Inst <= x"10000000";
	IF_flush <= '0';	
	
	wait for cCLK_PER;
	wait for cCLK_PER;
  wait;
  end process;
  
end arch;