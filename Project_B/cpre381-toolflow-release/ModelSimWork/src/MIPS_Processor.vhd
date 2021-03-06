-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor
-- implementation.

-- 01/29/2019 by H3::Design created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

entity MIPS_Processor is
  generic(N : integer := 32);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;


architecture structure of MIPS_Processor is

  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output

  -- Required register file signals
  signal s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal

  -- Required halt signal -- for simulation
  signal v0             : std_logic_vector(N-1 downto 0); -- TODO: should be assigned to the output of register 2, used to implement the halt SYSCALL
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. This case happens when the syscall instruction is observed and the V0 register is at 0x0000000A. This signal is active high and should only be asserted after the last register and memory writes before the syscall are guaranteed to be completed.

  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

  -- TODO: You may add any additional signals or components your implementation
  --       requires below this comment

component RegFile is
      port(i_CLK        : in std_logic;     -- Clock input
         i_read_write : in std_logic;     -- read/Write enable
         i_rs         : in std_logic_vector(4 downto 0);     -- Read address 1
         i_rt         : in std_logic_vector(4 downto 0);     -- Read address 2
         i_rd         : in std_logic_vector(4 downto 0);     -- Write address
         i_reset      : in std_logic;     -- Reset registers
         i_data       : in std_logic_vector(31 downto 0);     -- Data value input
         o_rs_data    : out std_logic_vector(31 downto 0);   -- Data value output
         o_rt_data    : out std_logic_vector(31 downto 0);   -- Data value output
         o_reg2       : out std_logic_vector(31 downto 0));
end component;

component Add_Sub is
  generic(N : integer := 32);
  port( i_A  : in std_logic_vector(N-1 downto 0);
        i_B  : in std_logic_vector(N-1 downto 0);
        i_nAdd_Sub  : in std_logic;
       	o_S  : out std_logic_vector(N-1 downto 0);
        o_Cout  : out std_logic);
end component;

component mux2_1_D is
   generic(N : integer := 32);
   port( i_A  : in std_logic_vector(N-1 downto 0);
   i_B  : in std_logic_vector(N-1 downto 0);
   i_X  : in std_logic;
   o_Y  : out std_logic_vector(N-1 downto 0));
end component;

component mux_2to1_5bit is
  port(i_0, i_1 : in std_logic_vector(4 downto 0);
       sel 	: in std_logic;
       o_f 	: out std_logic_vector(4 downto 0));
end component;

component N_bit_reg is
  generic(N : integer := 32);
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output

end component;

component zero_sign_ext_16_32bit is
  port( i_16in  : in std_logic_vector(15 downto 0);
        i_sel   : in std_logic;
        o_32out : out std_logic_vector(31 downto 0));
end component;

component ALU_and_Shifter is
  port(A         : in   std_logic_vector(31 downto 0);
       B         : in   std_logic_vector(31 downto 0);
       ALUOp     : in   std_logic_vector(5 downto 0);
       Shift_Amount : in   std_logic_vector(4 downto 0);
       F         : out  std_logic_vector(31 downto 0);
       Carryout  : out  std_logic;
       Overflow  : out  std_logic;
       Zero      : out  std_logic);
end component;

component Control is
  port (i_opCode: in std_logic_vector(5 downto 0);
   i_fnCode	: in std_logic_vector(5 downto 0);
   o_RegDst	: out std_logic;
   o_Jump	: out std_logic;
   o_Beq	: out std_logic;
   o_MemtoReg	: out std_logic;
   o_ALUOp	: out std_logic_vector(5 downto 0);
   o_MemWrite	: out std_logic;
   o_ALUSrc	: out std_logic;
   o_ReWrite	: out std_logic;
   o_Shift : out std_logic;
   o_SignExtend : out std_logic;
   o_UpperImm : out std_logic;
   o_Jal : out std_logic;
   o_Jr : out std_logic;
   o_Bne : out std_logic);
end component;

component Control_ALU is
  port (i_opCode	: in std_logic_vector(5 downto 0);
        i_fnCode 	: in std_logic_vector(5 downto 0);
        o_ALU_operation	: out std_logic_vector(5 downto 0));
end component;

--signals
  --control
  signal s_RegDst : std_logic;
  signal s_Jump : std_logic;
  signal s_Beq : std_logic;
  signal s_MemtoReg : std_logic;
  signal s_ALUOp : std_logic_vector(5 downto 0);
  signal s_ALUSrc : std_logic;
  signal s_Shift : std_logic;
  signal s_SignExtend : std_logic;
  signal s_UpperImm : std_logic;
  signal s_Jal : std_logic;
  signal s_Jr : std_logic;
  signal s_Bne : std_logic;

  signal       s_pc_plus4 : std_logic_vector(31 downto 0);
  signal       s_rs_data    : std_logic_vector(31 downto 0);
  signal       s_rt_data    : std_logic_vector(31 downto 0);
  signal       s_reg2 : std_logic_vector(31 downto 0);
  signal       s_32Imm      : std_logic_vector(31 downto 0);
  signal       s_32Imm_Shiftleft2 : std_logic_vector(31 downto 0);
  signal       s_PC_PlusImm      : std_logic_vector(31 downto 0);
  signal       s_shift_amount : std_logic_vector(4 downto 0);
  signal       s_ALU_operation  : std_logic_vector(5 downto 0);
  signal       s_JumpAddress      : std_logic_vector(31 downto 0);

  signal       s_Cout : std_logic;
  signal       s_Overflow : std_logic;
  signal       s_Zero       : std_logic;
  signal       s_ALU_result : std_logic_vector(31 downto 0);
  signal       s_Beq_and_Zero : std_logic;
  signal       s_NotBne_Nor_Zero : std_logic;
  signal       s_BranchSel : std_logic;

  signal       s_shift_out  : std_logic_vector(4 downto 0);
  signal       s_ALUSrc_out     : std_logic_vector(31 downto 0);
  signal       s_RegDst_out  : std_logic_vector(4 downto 0);
  signal       s_MemtoReg_out     : std_logic_vector(31 downto 0);
  signal       s_BranchMux  : std_logic_vector(31 downto 0);
  signal       s_JumpMux  : std_logic_vector(31 downto 0);
  signal       s_JrMux  : std_logic_vector(31 downto 0);
  signal       s_ResetMux_out  : std_logic_vector(31 downto 0);
  
begin

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;


  IMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);

  DMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2),
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);

  s_Halt <='1' when (s_Inst(31 downto 26) = "000000") and (s_Inst(5 downto 0) = "001100") and (v0 = "00000000000000000000000000001010") else '0';

  -- TODO: Implement the rest of your processor below this comment!
   ResetMux: mux2_1_D
      port map(i_A => s_JrMux,
               i_B => x"00400000",
               i_X => iRST,
               o_Y => s_ResetMux_out);
			   
   PC: N_bit_reg
      port map(i_CLK => iCLK,
               i_RST => '0',
               i_WE => '1',
               i_D => s_ResetMux_out,
               o_Q => s_NextInstAddr);

   PC_Plus4: Add_Sub
      port map(i_A => x"00000004",
               i_B => s_NextInstAddr,
               i_nAdd_Sub => '0',
               o_S => s_pc_plus4,
               o_Cout => open);

   Control1: Control
      port map(i_opCode => s_Inst(31 downto 26),
               i_fnCode => s_Inst(5 downto 0),
               o_RegDst => s_RegDst,
               o_Jump => s_Jump,
               o_Beq => s_Beq,
               o_MemtoReg => s_MemtoReg,
               o_ALUOp => s_ALUOp,
               o_MemWrite => s_DMemWr,
               o_ALUSrc => s_ALUSrc,
               o_ReWrite => s_RegWr,
               o_Shift => s_shift,
               o_SignExtend => s_SignExtend,
               o_UpperImm => s_UpperImm,
               o_Jal => s_Jal,
               o_Jr => s_Jr,
               o_Bne => s_Bne);

   RegDst: mux_2to1_5bit
      port map(i_0 => s_Inst(20 downto 16),
               i_1 => s_Inst(15 downto 11),
               sel => s_RegDst,
               o_f => s_RegDst_out);

   JalRegDst: mux_2to1_5bit
      port map(i_0 => s_RegDst_out,
               i_1 => "11111",
               sel => s_Jal,
               o_f => s_RegWrAddr);

   RegFile1: RegFile
      port map(i_CLK => iCLK,
            i_read_write => s_RegWr,
            i_rs => s_Inst(25 downto 21),
            i_rt => s_Inst(20 downto 16),
            i_rd => s_RegWrAddr,
            i_reset => iRST,
            i_data => s_RegWrData,
            o_rs_data => s_rs_data,
            o_rt_data => s_rt_data,
            o_reg2 => s_reg2);

   s_DMemData <= s_rt_data;
   v0 <= s_reg2;

   ALUSrc: mux2_1_D
      port map(i_A => s_rt_data,
               i_B => s_32Imm,
               i_X => s_ALUSrc,
               o_Y => s_ALUSrc_out);

   Ext1: zero_sign_ext_16_32bit
      port map( i_16in => s_Inst(15 downto 0),
                i_sel => s_SignExtend,
                o_32out => s_32Imm);

   MemtoReg: mux2_1_D
      port map(i_A => s_ALU_result,
               i_B => s_DMemOut,
               i_X => s_MemtoReg,
               o_Y => s_MemtoReg_out);

   JalMemtoReg: mux2_1_D
      port map(i_A => s_MemtoReg_out,
               i_B => s_pc_plus4,
               i_X => s_Jal,
               o_Y => s_RegWrData);

   Control_ALU1: Control_ALU
     port map (i_opCode => s_ALUOp,
               i_fnCode => s_Inst(5 downto 0),
               o_ALU_operation => s_ALU_operation);

   ALU1: ALU_and_Shifter
     port map(A => s_rs_data,
              B => s_ALUSrc_out,
              ALUOp => s_ALU_operation,
              Shift_Amount => s_shift_amount,
              F => s_ALU_result,
              Carryout => s_Cout,
              Overflow => s_Overflow,
              Zero => s_Zero);

   Shift: mux_2to1_5bit
      port map(i_0 => s_Inst(10 downto 6),
               i_1 => s_rs_data(4 downto 0),
               sel => s_shift,
               o_f => s_shift_out);

   UpperImm: mux_2to1_5bit
      port map(i_0 => s_shift_out,
               i_1 => "10000",
               sel => s_UpperImm,
               o_f => s_shift_amount);

   s_DMemAddr <= s_ALU_result;
   oALUOut <= s_ALU_result;

   --32 Imm shifted left two
   s_32Imm_Shiftleft2(31 downto 2) <= s_32Imm(29 downto 0);
   s_32Imm_Shiftleft2(1 downto 0) <= "00";

   PC_PC_PlusImm: Add_Sub
      port map(i_A => s_pc_plus4,
               i_B => s_32Imm_Shiftleft2,
               i_nAdd_Sub => '0',
               o_S => s_PC_PlusImm,
               o_Cout => open);


   --Logic for Beq and Bne
   s_Beq_and_Zero <= s_Beq AND s_Zero;
   s_NotBne_Nor_Zero <= (Not(s_Bne) NOR s_Zero);
   s_BranchSel <= (s_Beq_and_Zero OR s_NotBne_Nor_Zero);

   Branchmux: mux2_1_D
      port map(i_A => s_pc_plus4,
               i_B => s_PC_PlusImm,
               i_X => s_BranchSel,
               o_Y => s_BranchMux);

   --Find jump address for Jump
   s_JumpAddress(27 downto 2) <= s_Inst(25 downto 0);
   s_JumpAddress(1 downto 0) <= "00";
   s_JumpAddress(31 downto 28) <= s_pc_plus4(31 downto 28);

   Jumpmux: mux2_1_D
      port map(i_A => s_BranchMux,
               i_B => s_JumpAddress,
               i_X => s_Jump,
               o_Y => s_JumpMux);

   Jrmux: mux2_1_D
      port map(i_A => s_JumpMux,
               i_B => s_rs_data,
               i_X => s_Jr,
               o_Y => s_JrMux);


end structure;
