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

entity Control is
  port (i_opCode	: in std_logic_vector(5 downto 0);
   i_fnCode	: in std_logic_vector(5 downto 0);
   o_RegDst	: out std_logic;
   o_Jump		: out std_logic;
   o_Beq	: out std_logic;
   o_MemtoReg	: out std_logic;
   o_ALUOp		: out std_logic_vector(5 downto 0);
   o_MemWrite	: out std_logic;
   o_ALUSrc	: out std_logic;
   o_ReWrite	: out std_logic;
   o_Shift : out std_logic;
   o_SignExtend : out std_logic;
   o_UpperImm : out std_logic;
   o_Jal : out std_logic;
   o_Jr : out std_logic;
   o_Bne : out std_logic);
end Control;

architecture my_ctl of Control is

begin
   --0 for 		                    addiu 		            andi                   andi                    lui                    lw                      xori                   ori                   slti                   sltiu                  sw                     beq                    bne
   o_RegDst <= '0' when(i_opCode = "001001" or i_opCode = "001000" or i_opCode = "001100"  or i_opCode = "001111" or i_opCode = "100011" or i_opCode = "001110" or i_opCode = "001101" or i_opCode = "001010" or i_opCode = "001011" or i_opCode = "101011" or i_opCode = "000100" or i_opCode = "000101") else '1';

   --1 for                          j                      jal
   o_Jump <= '1' when(i_opCode = "000010" or i_opCode = "000011") else '0';

   --1 for                         beq
   o_Beq <= '1' when(i_opCode = "000100") else '0';

   --1 for                             lw
   o_MemtoReg <= '1' when(i_opCode = "100011") else '0';

   -- Send opCode to ALU control block
   o_ALUOp <= i_opCode;

   --1 for                             sw
   o_MemWrite <= '1' when(i_opCode = "101011") else '0';

   --1 for                           addi                   addiu                   andi                  lui                    xori                   ori                    slti                   sltiu                  sw                    lw
   o_ALUSrc <= '1' when(i_opCode = "001000" or i_opCode = "001001" or i_opCode = "001100" or i_opCode = "001111" or i_opCode = "001110" or i_opCode = "001101" or i_opCode = "001010" or i_opCode = "001011" or i_opCode = "101011" or i_opCode = "100011") else '0';

   --1 for                			addi                   add                    addiu                  addu                   and                    andi                   lui                    lw                     nor                    xor                    xori                   or                     ori                    slt                    slti                   sltui                  sltu                   sll                    srl                    sra                    sllv                   srlv                   srav                   sub                    subu                   jal
   o_ReWrite <= '1' when(i_opcode = "001000" or i_fnCode = "100000" or i_opCode = "001001" or i_fnCode = "100001" or i_fnCode = "100100" or i_opCode = "001100" or i_opCode = "001111" or i_opCode = "100011" or i_fnCode = "100111" or i_fnCode = "100110" or i_opCode = "001110" or i_fnCode = "100101" or i_opCode = "001101" or i_fnCode = "101010" or i_opCode = "001010" or i_opCode = "001011" or i_fnCode = "101011" or i_fnCode = "000000" or i_fnCode = "000010" or i_fnCode = "000011" or i_fnCode = "000100" or i_fnCode = "000110" or i_fnCode = "000110" or i_fnCode = "100010" or i_fnCode = "100011" or i_opCode = "000011") else '0';                                                                                                                                                                                                       --asdfasd
   
   --1 for                          sllv                   srlv                   srav
   o_Shift <= '1' when((i_fnCode = "000100" or i_fnCode = "000110" or i_fnCode = "000111") and i_opCode = "000000") else '0';

   --1 for                                andi                  xori                     ori
   o_SignExtend <= '1' when(i_opCode = "001100" or i_opCode = "001110" or i_opCode = "001101") else '0';

   --1 for                             lui
   o_UpperImm <= '1' when(i_opCode = "001111") else '0';

   --1 for                        jal
   o_Jal <= '1' when(i_opCode = "000011") else '0';

   --1 for                          jr
   o_Jr <= '1' when((i_fnCode = "001000" and i_opCode = "000000")) else '0';

   --1 for                         bne
   o_Bne <= '1' when(i_opCode = "000101") else '0';

end my_ctl;
