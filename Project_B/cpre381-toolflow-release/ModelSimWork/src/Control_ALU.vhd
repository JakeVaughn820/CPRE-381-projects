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

entity Control_ALU is
  port (i_opCode	: in std_logic_vector(5 downto 0);
	i_fnCode 	: in std_logic_vector(5 downto 0);
	o_ALU_operation	: out std_logic_vector(5 downto 0));

end Control_ALU;

architecture my_ALUctl of Control_ALU is

--Either look at opCode or fnCode
signal s_and	: std_logic_vector(5 downto 0);
signal s_or	: std_logic_vector(5 downto 0);
signal s_add 	: std_logic_vector(5 downto 0);
signal s_xor 	: std_logic_vector(5 downto 0);
signal s_slt	: std_logic_vector(5 downto 0); --Shift Less Than
signal s_nor	: std_logic_vector(5 downto 0);
signal s_nand	: std_logic_vector(5 downto 0);
signal s_sub	: std_logic_vector(5 downto 0);
signal s_sra	: std_logic_vector(5 downto 0); --Arithmetic Shift Right
signal s_slr	: std_logic_vector(5 downto 0); --Logical Shigt Right
signal s_sll	: std_logic_vector(5 downto 0); --Shift Left

begin

s_and	<= "000000";	--Done
s_or	<= "000001";    --Done
s_add 	<= "000010";  	--Working on
s_xor 	<= "000011";
s_slt	<= "011100";
s_nor	<= "110000";
s_nand	<= "110001";
s_sub	<= "011010";
s_sra	<= "111100"; 	--Arithmetic Shift Right
s_slr	<= "111101";  	--Logical Shigt Right
s_sll	<= "111110"; 	--Shift Left

o_ALU_operation  <=	--AND
			s_and when(i_fnCode = "100000" or i_opCode = "001100") else

			--OR
			s_or when(i_fnCode = "100101" or i_opCode = "001101") else

			--ADD
			s_add when(


			--Branching and jumping
			"000000";

end my_ALUctl;
