-------------------------------------------------------------------------
-- Nickolas Mitchell, Jacob Vaughn
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
s_add 	<= "000010";  	--Done
s_xor 	<= "000011";
s_slt	<= "011100";
s_nor	<= "110000";
s_nand	<= "110001";
s_sub	<= "011010";
s_sra	<= "111100"; 	--Arithmetic Shift Right
s_slr	<= "111101";  	--Logical Shigt Right
s_sll	<= "111110"; 	--Shift Left

o_ALU_operation  <=	--AND		      and                    andi
			s_and when(i_fnCode = "100100" or i_opCode = "001100") else

			--OR                 or                     ori
			s_or when(i_fnCode = "100101" or i_opCode = "001101") else

			--ADD                  addi                   add                    addiu                  addu                     lw                     sw    
			s_add when(i_opCode = "001000" or i_fnCode = "100000" or i_opCode = "001001" or i_fnCode = "100001" or i_opCode = "100011" or i_opCode = "101011") else

			--XOR                 xor                    xori
			s_xor when(i_fnCode = "100110" or i_opCode = "001110") else 

			--SLT                 slt                    slti                   sltiu                  sltu
			s_slt when(i_fnCode = "101010" or i_opCode = "001010" or i_opCode = "001011" or i_fnCode = "101011") else

			--NOR                 nor
			s_nor when(i_fnCode = "100111") else

			--NAND (Does nothing for now)
			s_nand when(i_fnCode = "111111") else

			--SUB                 sub                    subu
			s_sub when(i_fnCode = "100010" or i_fnCode = "100011") else

			--SRA                 sra                    srav
			s_sra when(i_fnCode = "000011" or i_fnCode = "000111") else

			--SLR                 srl                     srlv
			s_slr when(i_fnCode = "000010" or  i_fnCode = "000110") else

			--SLL                 sll                     sllv                      lui
			s_sll when(i_fnCode = "000000" or i_fnCode = "000100" or i_opCode = "001111") else

			--Branching and jumping
			"000000";

end my_ALUctl;
