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
	   ForwardA        : out std_logic_vector(1 downto 0)
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

signal       WB_RegRd_Equ_0            : std_logic;
signal       MEM_RegRd_Equ_0           : std_logic;
signal       MEM_RegRd_Equ_EX_RegRs    : std_logic;
signal       MEM_RegRd_Equ_EX_RegRt    : std_logic;
signal       WB_RegRd_Equ_EX_RegRs     : std_logic;
signal       WB_RegRd_Equ_EX_RegRt     : std_logic;
Signal       WB_RegWr_and_NotWB_RegRd_Equ_0 : std_logic;
signal       MEM_RegWr_and_MEM_RegRd_Equ_0 : std_logic;
signal       MEM_RegWr_and_MEM_RegRd_Equ_0_AND_MEM_RegRd_Equ_EX_RegRs : std_logic;
signal       MEM_RegWr_and_MEM_RegRd_Equ_0_AND_MEM_RegRd_Equ_EX_RegRt : std_logic;

signal       one_and_two_and_threefour : std_logic;
signal       one_and_two_and_threefour_rt : std_logic;

signal       oneandtwoandthreefour_and_five : std_logic;
signal       oneandtwoandthreefour_and_five_rt : std_logic;
begin

Equal_WB_RegRd_Equ_0: Equal_5bit
  port map( i_A => WB_RegisterRd;
	        i_B => "00000";
       	    o_Equal => WB_RegRd_Equ_0);
		
Equal_MEM_RegRd_Equ_0: Equal_5bit
  port map( i_A => MEM_RegisterRd;
	        i_B => "00000";
       	    o_Equal => MEM_RegRd_Equ_0);

Equal_MEM_RegRd_Equ_EX_RegRs: Equal_5bit
  port map( i_A => MEM_RegisterRd;
	        i_B => EX_RegisterRs;
       	    o_Equal => MEM_RegRd_Equ_EX_RegRs);

Equal_WB_RegRd_Equ_EX_RegRs: Equal_5bit
  port map( i_A => WB_RegisterRd;
	        i_B => EX_RegisterRs;
       	    o_Equal => WB_RegRd_Equ_EX_RegRs);
			
Equal_MEM_RegRd_Equ_EX_RegRt: Equal_5bit
  port map( i_A => MEM_RegisterRd;
	        i_B => EX_RegisterRt;
       	    o_Equal => MEM_RegRd_Equ_EX_RegRt);

Equal_WB_RegRd_Equ_EX_RegRt: Equal_5bit
  port map( i_A => WB_RegisterRd;
	        i_B => EX_RegisterRt;
       	    o_Equal => WB_RegRd_Equ_EX_RegRt);

WB_RegWr_and_NotWB_RegRd_Equ_0 <= WB_RegWrite and (not WB_RegRd_Equ_0);

MEM_RegWr_and_MEM_RegRd_Equ_0 <= MEM_RegWrite and (not MEM_RegRd_Equ_0);

MEM_RegWr_and_MEM_RegRd_Equ_0_AND_MEM_RegRd_Equ_EX_RegRs <= MEM_RegWr_and_MEM_RegRd_Equ_0 and (not MEM_RegRd_Equ_EX_RegRs);

oneandtwo_and_not_threefour <= WB_RegWr_and_NotWB_RegRd_Equ_0 and (not MEM_RegWr_and_MEM_RegRd_Equ_0_AND_MEM_RegRd_Equ_EX_RegRs);

oneandtwoandthreefour_and_five <= oneandtwo_and_not_threefour and MEM_RegRd_Equ_EX_RegRs;

forwardA(0) <= oneandtwoandthreefour_and_five;

MEM_RegWr_and_MEM_RegRd_Equ_0_AND_MEM_RegRd_Equ_EX_RegRt <= MEM_RegWr_and_MEM_RegRd_Equ_0 and (not MEM_RegRd_Equ_EX_RegRt);

oneandtwo_and_not_threefour_rt <= WB_RegWr_and_NotWB_RegRd_Equ_0 and (not MEM_RegWr_and_MEM_RegRd_Equ_0_AND_MEM_RegRd_Equ_EX_RegRs);

oneandtwoandthreefour_and_five_rt <= oneandtwo_and_not_threefour_rt and MEM_RegRd_Equ_EX_RegRt;

forwardB(0) <= oneandtwoandthreefour_and_five_rt;
end arch;
