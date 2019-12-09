-------------------------------------------------------------------------
-- Jacob Vaughn
-- Nickolas Mitchell
-------------------------------------------------------------------------

-- Forward_Unit.vhd
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_misc.all;

entity Forward_Unit is
  port(WB_RegWrite     : in std_logic;
       WB_RegisterRd   : in std_logic_vector(4 downto 0);
       MEM_RegWrite    : in std_logic;
       MEM_RegisterRd  : in std_logic_vector(4 downto 0);
       EX_RegWrite     : in std_logic;
       EX_RegisterRd   : in std_logic_vector(4 downto 0);
       ID_RegisterRs   : in std_logic_vector(4 downto 0);
       ID_RegisterRt   : in std_logic_vector(4 downto 0);
       ForwardA        : out std_logic_vector(1 downto 0);
       ForwardB        : out std_logic_vector(1 downto 0));
end Forward_Unit;

architecture arch of Forward_Unit is

component Equal_5bit is
  generic(N : integer := 5);
  port( i_A  : in std_logic_vector(N-1 downto 0);
      i_B  : in std_logic_vector(N-1 downto 0);
         o_Equal  : out std_logic);

end component;

 --signals
signal       WB_Rd_Equ_0            : std_logic;
signal       WB_Rd_Equ_ID_Rs     : std_logic;
signal       WB_Rd_Equ_ID_Rt     : std_logic;
signal       NotMEM_Rd_Equ_0           : std_logic;
signal       MEM_Rd_Equ_ID_Rs    : std_logic;
signal       MEM_Rd_Equ_ID_Rt    : std_logic;
signal       NotEX_Rd_Equ_0           : std_logic;
signal       EX_Rd_Equ_ID_Rs    : std_logic;
signal       EX_Rd_Equ_ID_Rt    : std_logic;

signal       WB_Wr_and_NotWB_Rd_Equ_0 : std_logic;
signal       WB_Wr_and_NotWB_Rd_Equ_0_AND_WB_Rd_Equ_ID_Rs : std_logic;
signal       WB_Wr_and_NotWB_Rd_Equ_0_AND_WB_Rd_Equ_ID_Rt : std_logic;
signal       MEM_Wr_and_NotMEM_Rd_Equ_0 : std_logic;
signal       MEM_Wr_and_NotMEM_Rd_Equ_0_AND_MEM_Rd_Equ_ID_Rs : std_logic;
signal       MEM_Wr_and_NotMEM_Rd_Equ_0_AND_MEM_Rd_Equ_ID_Rt : std_logic;
signal       EX_Wr_and_NotEX_Rd_Equ_0 : std_logic;
signal       EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_Equ_ID_Rs : std_logic;
signal       EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_Equ_ID_Rt : std_logic;

signal       WB_and_NotMEM_Rs : std_logic;
signal       WB_and_NotMEM_Rs_and_NotEX_Rs : std_logic;
signal       WB_and_NotMEM_Rt : std_logic;
signal       WB_and_NotMEM_Rt_and_NotEX_Rt : std_logic;

begin

Equal_WB_Rd_Equ_0: Equal_5bit
  port map( i_A => WB_RegisterRd,
          i_B => "00000",
             o_Equal => WB_Rd_Equ_0);

Equal_WB_Rd_Equ_ID_Rs: Equal_5bit
  port map( i_A => WB_RegisterRd,
          i_B => EX_RegisterRs,
             o_Equal => WB_Rd_Equ_ID_Rs);

Equal_WB_Rd_Equ_ID_Rt: Equal_5bit
  port map( i_A => WB_RegisterRd,
          i_B => EX_RegisterRt,
             o_Equal => WB_Rd_Equ_ID_Rt);

Equal_MEM_Rd_Equ_0: Equal_5bit
  port map( i_A => MEM_RegisterRd,
          i_B => "00000",
             o_Equal => MEM_Rd_Equ_0);

Equal_MEM_Rd_Equ_ID_Rs: Equal_5bit
  port map( i_A => MEM_RegisterRd,
          i_B => EX_RegisterRs,
             o_Equal => MEM_Rd_Equ_ID_Rs);

Equal_MEM_Rd_Equ_ID_Rt: Equal_5bit
  port map( i_A => MEM_RegisterRd,
          i_B => EX_RegisterRt,
             o_Equal => MEM_Rd_Equ_ID_Rt);

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



WB_Wr_and_NotWB_Rd_Equ_0 <= WB_RegWrite and (not WB_Rd_Equ_0);
WB_Wr_and_NotWB_Rd_Equ_0_AND_WB_Rd_Equ_ID_Rs <= WB_Wr_and_NotWB_Rd_Equ_0 and WB_Rd_Equ_ID_Rs; --WB portion for rs

MEM_Wr_and_NotMEM_Rd_Equ_0 <= MEM_RegWrite and (not MEM_Rd_Equ_0);
MEM_Wr_and_NotMEM_Rd_Equ_0_AND_MEM_Rd_Equ_ID_Rs <= MEM_Wr_and_NotMEM_Rd_Equ_0 and MEM_Rd_Equ_ID_Rs; --MEM portion for rs

EX_Wr_and_NotEX_Rd_Equ_0 <= EX_RegWrite and (not EX_Rd_Equ_0);
EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_EX_ID_Rs <= EX_Wr_and_NotEX_Rd_Equ_0 and EX_Rd_Equ_ID_Rs; --EX portion for rs

WB_and_NotMEM_Rs <= WB_Wr_and_NotWB_Rd_Equ_0_AND_WB_Rd_Equ_ID_Rs and (not MEM_Wr_and_NotMEM_Rd_Equ_0_AND_MEM_Rd_Equ_ID_Rs); --WB_Rs and (Not MEM_Rs)
WB_and_NotMEM_Rs_and_NotEX_Rs <= WB_and_NotMEM_Rs and (not EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_EX_ID_Rs); --WB_Rs and (not MEM_Rs) and (not EX_Rs)

ForwardA(0) <= WB_and_NotMEM_Rs_and_NotEX_Rs or EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_EX_ID_Rs;
ForwardA(1) <= MEM_Wr_and_NotMEM_Rd_Equ_0_AND_MEM_Rd_Equ_ID_Rs or EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_EX_ID_Rs;

WB_Wr_and_NotWB_Rd_Equ_0_AND_WB_Rd_Equ_ID_Rt <= WB_Wr_and_NotWB_Rd_Equ_0 and WB_Rd_Equ_ID_Rt; --WB portion for rt
MEM_Wr_and_NotMEM_Rd_Equ_0_AND_MEM_Rd_Equ_ID_Rt <= MEM_Wr_and_NotMEM_Rd_Equ_0 and MEM_Rd_Equ_ID_Rt; --MEM portion for rt
EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_EX_ID_Rt <= EX_Wr_and_NotEX_Rd_Equ_0 and EX_Rd_Equ_ID_Rt; --EX portion for rt

WB_and_NotMEM_Rt <= WB_Wr_and_NotWB_Rd_Equ_0_AND_WB_Rd_Equ_ID_Rt and (not MEM_Wr_and_NotMEM_Rd_Equ_0_AND_MEM_Rd_Equ_ID_Rt); --WB_Rt and (Not MEM_Rt)
WB_and_NotMEM_Rt_and_NotEX_Rt <= WB_and_NotMEM_Rt and (not EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_EX_ID_Rt); --WB_Rt and (not MEM_Rt) and (not EX_Rt)

ForwardB(0) <= WB_and_NotMEM_Rt_and_NotEX_Rt or EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_EX_ID_Rt; --WB_Rt or EX_Rt
ForwardB(1) <= MEM_Wr_and_NotMEM_Rd_Equ_0_AND_MEM_Rd_Equ_ID_Rt or EX_Wr_and_NotEX_Rd_Equ_0_AND_EX_Rd_EX_ID_Rt; --MEM_Rt or EX_Rt

end arch;
