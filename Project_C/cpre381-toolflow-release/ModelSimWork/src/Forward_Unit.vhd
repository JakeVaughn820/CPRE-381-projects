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
	   EX_RegisterRs   : in std_logic_vector(4 downto 0);
	   EX_RegisterRt   : in std_logic_vector(4 downto 0);
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
signal       MEM_Rd_Equ_0           : std_logic;
signal       MEM_Rd_Equ_EX_Rs    : std_logic;
signal       MEM_Rd_Equ_EX_Rt    : std_logic;
signal       WB_Rd_Equ_EX_Rs     : std_logic;
signal       WB_Rd_Equ_EX_Rt     : std_logic;
Signal       WB_Wr_and_NotWB_Rd_Equ_0 : std_logic;
signal       MEM_Wr_and_MEM_Rd_Equ_0 : std_logic;
signal       MEM_Wr_and_MEM_Rd_Equ_0_AND_MEM_Rd_Equ_EX_Rs : std_logic;
signal       MEM_Wr_and_MEM_Rd_Equ_0_AND_MEM_Rd_Equ_EX_Rt : std_logic;

signal       oneandtwo_and_not_threefour : std_logic;
signal       oneandtwo_and_not_threefour_rt : std_logic;

signal       oneandtwoandthreefour_and_five : std_logic;
signal       oneandtwoandthreefour_and_five_rt : std_logic;
begin

Equal_WB_Rd_Equ_0: Equal_5bit
  port map( i_A => WB_RegisterRd,
	        i_B => "00000",
       	    o_Equal => WB_Rd_Equ_0);
		
Equal_MEM_Rd_Equ_0: Equal_5bit
  port map( i_A => MEM_RegisterRd,
	        i_B => "00000",
       	    o_Equal => MEM_Rd_Equ_0);

Equal_MEM_Rd_Equ_EX_Rs: Equal_5bit
  port map( i_A => MEM_RegisterRd,
	        i_B => EX_RegisterRs,
       	    o_Equal => MEM_Rd_Equ_EX_Rs);
			
Equal_MEM_Rd_Equ_EX_Rt: Equal_5bit
  port map( i_A => MEM_RegisterRd,
	        i_B => EX_RegisterRt,
       	    o_Equal => MEM_Rd_Equ_EX_Rt);
			
Equal_WB_Rd_Equ_EX_Rs: Equal_5bit
  port map( i_A => WB_RegisterRd,
	        i_B => EX_RegisterRs,
       	    o_Equal => WB_Rd_Equ_EX_Rs);
			
Equal_WB_Rd_Equ_EX_Rt: Equal_5bit
  port map( i_A => WB_RegisterRd,
	        i_B => EX_RegisterRt,
       	    o_Equal => WB_Rd_Equ_EX_Rt);

WB_Wr_and_NotWB_Rd_Equ_0 <= WB_RegWrite and (not WB_Rd_Equ_0);  --line one and two

MEM_Wr_and_MEM_Rd_Equ_0 <= MEM_RegWrite and (not MEM_Rd_Equ_0); --line three

MEM_Wr_and_MEM_Rd_Equ_0_AND_MEM_Rd_Equ_EX_Rs <= MEM_Wr_and_MEM_Rd_Equ_0 and MEM_Rd_Equ_EX_Rs;  --line four and three

oneandtwo_and_not_threefour <= WB_Wr_and_NotWB_Rd_Equ_0 and (not MEM_Wr_and_MEM_Rd_Equ_0_AND_MEM_Rd_Equ_EX_Rs); --line one and two and not(threefour)

oneandtwoandthreefour_and_five <= oneandtwo_and_not_threefour and WB_Rd_Equ_EX_Rs; --All lines are anded together

ForwardA(0) <= oneandtwoandthreefour_and_five;
ForwardA(1) <= MEM_Wr_and_MEM_Rd_Equ_0_AND_MEM_Rd_Equ_EX_Rs;

MEM_Wr_and_MEM_Rd_Equ_0_AND_MEM_Rd_Equ_EX_Rt <= MEM_Wr_and_MEM_Rd_Equ_0 and MEM_Rd_Equ_EX_Rt; --line four and three for rt

oneandtwo_and_not_threefour_rt <= WB_Wr_and_NotWB_Rd_Equ_0 and (not MEM_Wr_and_MEM_Rd_Equ_0_AND_MEM_Rd_Equ_EX_Rt); --line one and two and not(threefour) for rt

oneandtwoandthreefour_and_five_rt <= oneandtwo_and_not_threefour_rt and WB_Rd_Equ_EX_Rt; --All lines anded for rt

ForwardB(0) <= oneandtwoandthreefour_and_five_rt;
ForwardB(1) <= MEM_Wr_and_MEM_Rd_Equ_0_AND_MEM_Rd_Equ_EX_Rt;


end arch;
