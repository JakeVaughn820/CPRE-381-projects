-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------

-- mux_5to1_1bit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation Signal Control block 
-- To be used in Project B Phase I
--
--
-- NOTES:
-- Created on 10/16/2019 by Nick Mitchell
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Control is
  port (i_opCode	: in std_logic_vector(5 downto 0);
	i_fnCode	: in std_logic_vector(5 downto 0);
	o_RegDst	: out std_logic;
	o_Jump		: out std_logic;
	o_Branch	: out std_logic; 
	--o_MemRead	: out std_logic; 
	o_MemtoReg	: out std_logic;
	o_ALUOp		: out std_logic_vector(2 downto 0);
	o_MemWrite	: out std_logic;
	o_ALUSrc	: out std_logic;
	o_ReWrite	: out std_logic); 

end Control;

architecture my_ctl of Control is

begin

	o_RegDst	<= '0' when (i_opCode = "100011" ) else '1';	--Only 0 when 'lw'	
	o_Jump 		<= '1' when (i_opCode = "000010" or i_opCode = "000011" or i_opCode = "001000") else '0';	--Only 1 when 'j' or 'jal' or 'jr'
	o_Branch	<= '1' when (i_opCode = "000100" or i_opCode = "000101");	--Only 1 when 'beq' or 'bne'
	--o_MemRead	<= '1' when (i_opCode = "100011");	--Only 1 when 'lw'
	o_MemtoReg	<= '1' when (i_opCode = "100011");	--Only 1 when 'lw'
	o_ALUOp		<= "XXX";
	o_MemWrite	<= '1' when(i_opCode = "101011");	--Only 1 when 'sw' 
	o_ALUSrc	<= '1' when(i_opCode = "100011" or i_opCode = "101011");	--Only 1 when 'lw' or 'sw'
	o_ReWrite	<= '0' when (i_opCode = "101011" or i_opCode = "000100") else '1';	--Only 0 when 'sw' or 'beq'
	
end my_ctl;






