-------------------------------------------------------------------------
-- Jacob Vaughn
-- Nickolas Mitchell
-------------------------------------------------------------------------

-- Hazard_detection_Unit.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity Hazard_detection_Unit is
  port(ID_RegisterRs    : in std_logic_vector(4 downto 0);
       ID_RegisterRt    : in std_logic_vector(4 downto 0);
       EX_MemRead       : in std_logic;
       EX_RegisterRt    : in std_logic_vector(4 downto 0);
       MEM_MemRead      : in std_logic;
       MEM_WriteRegister: in std_logic_vector(4 downto 0);
	   EX_RegWrite     : in std_logic;
       EX_RegisterRd   : in std_logic_vector(4 downto 0);
       PCWrite          : out std_logic;
       IFID_Write       : out std_logic;
       Mux_Stall        : out std_logic);
end Hazard_detection_Unit;

architecture arch of Hazard_detection_Unit is

component Equal_5bit is
  generic(N : integer := 5);
  port( i_A  : in std_logic_vector(N-1 downto 0);
      i_B  : in std_logic_vector(N-1 downto 0);
         o_Equal  : out std_logic);

end component;

 --signals

signal       EXRt_EQUAL_IDRs            : std_logic;
signal       EXRt_EQUAL_IDRt            : std_logic;
signal       EXRt_EQUAL_IDRs_OR_EXRt_EQUAL_IDRt : std_logic;
signal       EX_MemRead_AND_EXRt_EQUAL_IDRs_OR_EXRt_EQUAL_IDRt    : std_logic;

signal       MEM_WriteRegister_EQUAL_IDRs            : std_logic;
signal       MEM_WriteRegister_EQUAL_IDRt            : std_logic;
signal       MEM_WriteRegister_EQUAL_IDRs_OR_MEM_WriteRegister_EQUAL_IDRt : std_logic;

signal       EX_Rd_Equ_0        : std_logic;
signal       EX_Rd_Equ_ID_Rs    : std_logic;
signal       EX_Rd_Equ_ID_Rt    : std_logic;

signal       EX_Wr_and_NotEX_Rd_Equ_0 : std_logic;
signal       EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_Equ_ID_Rs : std_logic;
signal       EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_Equ_ID_Rt : std_logic;

signal       MEM_MemRead_AND_MEM_WriteRegister_EQUAL_IDRs_OR_MEM_WriteRegister_EQUAL_IDRt    : std_logic;
signal       EX_MemRead_AND_EXRt_EQUAL_IDRs_OR_EXRt_EQUAL_IDRt_NOR_MEM_MemRead_AND_MEM_WriteRegister_EQUAL_IDRs_OR_MEM_WriteRegister_EQUAL_IDRt : std_logic;
signal       EX_MemRead_AND_EXRt_EQUAL_IDRs_OR_EXRt_EQUAL_IDRt_OR_MEM_MemRead_AND_MEM_WriteRegister_EQUAL_IDRs_OR_MEM_WriteRegister_EQUAL_IDRt : std_logic;
signal       EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_Equ_ID_Rs_OR_EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_Equ_ID_Rt : std_logic;
begin

EXRt_EQUAL_IDRs_Equal: Equal_5bit
  port map( i_A => EX_RegisterRt,
            i_B => ID_RegisterRs,
            o_Equal => EXRt_EQUAL_IDRs);

EXRt_EQUAL_IDRt_Equal: Equal_5bit
  port map( i_A => EX_RegisterRt,
            i_B => ID_RegisterRt,
            o_Equal => EXRt_EQUAL_IDRt);

MEM_WriteRegister_EQUAL_IDRs_Equal: Equal_5bit
  port map( i_A => MEM_WriteRegister,
            i_B => ID_RegisterRs,
            o_Equal => MEM_WriteRegister_EQUAL_IDRs);

MEM_WriteRegister_EQUAL_IDRt_Equal: Equal_5bit
  port map( i_A => MEM_WriteRegister,
            i_B => ID_RegisterRt,
            o_Equal => MEM_WriteRegister_EQUAL_IDRt);

Equal_EX_Rd_Equ_0: Equal_5bit
  port map( i_A => EX_RegisterRd,
          i_B => "00000",
             o_Equal => EX_Rd_Equ_0);

Equal_EX_Rd_Equ_ID_Rs: Equal_5bit
  port map( i_A => EX_RegisterRd,
          i_B => ID_RegisterRs,
             o_Equal => EX_Rd_Equ_ID_Rs);
			 
Equal_EX_Rd_Equ_ID_Rt: Equal_5bit
  port map( i_A => EX_RegisterRd,
          i_B => ID_RegisterRt,
             o_Equal => EX_Rd_Equ_ID_Rt);
			 
EXRt_EQUAL_IDRs_OR_EXRt_EQUAL_IDRt <= EXRt_EQUAL_IDRs OR EXRt_EQUAL_IDRt;
EX_MemRead_AND_EXRt_EQUAL_IDRs_OR_EXRt_EQUAL_IDRt <= EX_MemRead AND EXRt_EQUAL_IDRs_OR_EXRt_EQUAL_IDRt;

MEM_WriteRegister_EQUAL_IDRs_OR_MEM_WriteRegister_EQUAL_IDRt <= MEM_WriteRegister_EQUAL_IDRs OR MEM_WriteRegister_EQUAL_IDRt;
MEM_MemRead_AND_MEM_WriteRegister_EQUAL_IDRs_OR_MEM_WriteRegister_EQUAL_IDRt <= MEM_MemRead AND MEM_WriteRegister_EQUAL_IDRs_OR_MEM_WriteRegister_EQUAL_IDRt;

--Forwarding logic but to stall instead
EX_Wr_and_NotEX_Rd_Equ_0 <= EX_RegWrite and (not EX_Rd_Equ_0);
EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_Equ_ID_Rs <= EX_Wr_and_NotEX_Rd_Equ_0 and EX_Rd_Equ_ID_Rs; --EX portion for rs
EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_Equ_ID_Rt <= EX_Wr_and_NotEX_Rd_Equ_0 and EX_Rd_Equ_ID_Rt; --EX portion for rt
EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_Equ_ID_Rs_OR_EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_Equ_ID_Rt <= EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_Equ_ID_Rs OR EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_Equ_ID_Rt;


--ORing
EX_MemRead_AND_EXRt_EQUAL_IDRs_OR_EXRt_EQUAL_IDRt_OR_MEM_MemRead_AND_MEM_WriteRegister_EQUAL_IDRs_OR_MEM_WriteRegister_EQUAL_IDRt <= EX_MemRead_AND_EXRt_EQUAL_IDRs_OR_EXRt_EQUAL_IDRt OR MEM_MemRead_AND_MEM_WriteRegister_EQUAL_IDRs_OR_MEM_WriteRegister_EQUAL_IDRt;

PCWrite <= EX_MemRead_AND_EXRt_EQUAL_IDRs_OR_EXRt_EQUAL_IDRt_OR_MEM_MemRead_AND_MEM_WriteRegister_EQUAL_IDRs_OR_MEM_WriteRegister_EQUAL_IDRt NOR EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_Equ_ID_Rs_OR_EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_Equ_ID_Rt;
IFID_Write <= EX_MemRead_AND_EXRt_EQUAL_IDRs_OR_EXRt_EQUAL_IDRt_OR_MEM_MemRead_AND_MEM_WriteRegister_EQUAL_IDRs_OR_MEM_WriteRegister_EQUAL_IDRt NOR EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_Equ_ID_Rs_OR_EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_Equ_ID_Rt;
Mux_Stall <= EX_MemRead_AND_EXRt_EQUAL_IDRs_OR_EXRt_EQUAL_IDRt_OR_MEM_MemRead_AND_MEM_WriteRegister_EQUAL_IDRs_OR_MEM_WriteRegister_EQUAL_IDRt OR EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_Equ_ID_Rs_OR_EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_Equ_ID_Rt;

end arch;
