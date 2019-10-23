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
	o_ALUOp		: out std_logic_vector(1 downto 0);
	o_MemWrite	: out std_logic;
	o_ALUSrc	: out std_logic;
	o_ReWrite	: out std_logic); 

end Control;

architecture dataflow of Control is

begin

	o_RegDst	<=	
	o_Jump 		<= '1' when (i_opCode = "000010") else '0';
	o_Branch	<=
	--o_MemRead	<=
	o_MemtoReg	<=
	o_ALUOp		<=
	o_MemWrite	<=
	o_ALUSrc	<=
	o_ReWrite	<=
	














   process(i_opCode, i_fnCode)
   	begin
	case i_opCode and i_fnCode is


 



   	end case;
    end process;
end dataflow;






