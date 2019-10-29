-------------------------------------------------------------------------
-- Jacob Vaughn
-------------------------------------------------------------------------

-- Mux31_1.vhd
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Mux31_1 is
  port(i_data0        : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data1        : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data2        : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data3        : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data4        : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data5        : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data6        : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data7        : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data8        : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data9        : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data10       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data11       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data12       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data13       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data14       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data15       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data16       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data17       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data18       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data19       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data20       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data21       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data22       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data23       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data24       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data25       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data26       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data27       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data28       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data29       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data30       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_data31       : in  STD_LOGIC_VECTOR (31 downto 0);
       i_Sel          : in std_logic_vector(4 downto 0);     -- Data value input
       o_data          : out std_logic_vector(31 downto 0));   -- Data value output

end Mux31_1;

architecture Behavioral of Mux31_1 is

begin

process(i_Sel,i_data0,i_data1,i_data2,i_data3,i_data4,i_data5,i_data6,i_data7,
i_data8,i_data9,i_data10,i_data11,i_data12,i_data13,i_data14,i_data15,
i_data16,i_data17,i_data18,i_data19,i_data20,i_data21,i_data22,i_data23,
i_data24,i_data25,i_data26,i_data27,i_data28,i_data29,i_data30,i_data31)
begin
    case i_Sel is
    when "00000" => o_data <= i_data0;
    when "00001" => o_data <= i_data1;
    when "00010" => o_data <= i_data2;
    when "00011" => o_data <= i_data3;
    when "00100" => o_data <= i_data4;
    when "00101" => o_data <= i_data5;
    when "00110" => o_data <= i_data6;
    when "00111" => o_data <= i_data7;
    when "01000" => o_data <= i_data8;
    when "01001" => o_data <= i_data9;
    when "01010" => o_data <= i_data10;
    when "01011" => o_data <= i_data11;
    when "01100" => o_data <= i_data12;
    when "01101" => o_data <= i_data13;
    when "01110" => o_data <= i_data14;
    when "01111" => o_data <= i_data15;
    when "10000" => o_data <= i_data16;
    when "10001" => o_data <= i_data17;
    when "10010" => o_data <= i_data18;
    when "10011" => o_data <= i_data19;
    when "10100" => o_data <= i_data20;
    when "10101" => o_data <= i_data21;
    when "10110" => o_data <= i_data22;
    when "10111" => o_data <= i_data23;
    when "11000" => o_data <= i_data24;
    when "11001" => o_data <= i_data25;
    when "11010" => o_data <= i_data26;
    when "11011" => o_data <= i_data27;
    when "11100" => o_data <= i_data28;
    when "11101" => o_data <= i_data29;
    when "11110" => o_data <= i_data30;
    when "11111" => o_data <= i_data31;

    when others => o_data <= "00000000000000000000000000000000";
    end case;

end process;
end Behavioral;