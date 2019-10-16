-------------------------------------------------------------------------
-- Jacob Vaughn
-------------------------------------------------------------------------

-- RegFile.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity RegFile is
  port(i_CLK        : in std_logic;     -- Clock input
       i_read_write : in std_logic;     -- read/Write enable
       i_rs         : in std_logic_vector(4 downto 0);     -- Read address 1
       i_rt         : in std_logic_vector(4 downto 0);     -- Read address 2
       i_rd         : in std_logic_vector(4 downto 0);     -- Write address
       i_reset      : in std_logic;     -- Reset registers
       i_data       : in std_logic_vector(31 downto 0);     -- Data value input
       o_rs_data    : out std_logic_vector(31 downto 0);   -- Data value output
       o_rt_data    : out std_logic_vector(31 downto 0));   -- Data value output

end RegFile;

architecture arch of RegFile is

component N_bit_reg
  generic(N : integer := 32);
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output

end component;

component Decoder5_32
  port(i_Sel          : in std_logic_vector(4 downto 0);     -- Data value input
       i_WE           : in std_logic;
       o_Out          : out std_logic_vector(31 downto 0));   -- Data value output

end component;

component Mux31_1
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
       o_data         : out std_logic_vector(31 downto 0));   -- Data value output

end component;

  signal s_DecOut       :   std_logic_vector(31 downto 0);    -- Output from Decoder

  signal s_data0        :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data1        :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data2        :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data3        :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data4        :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data5        :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data6        :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data7        :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data8        :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data9        :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data10       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data11       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data12       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data13       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data14       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data15       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data16       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data17       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data18       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data19       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data20       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data21       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data22       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data23       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data24       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data25       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data26       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data27       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data28       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data29       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data30       :   STD_LOGIC_VECTOR (31 downto 0);
  signal s_data31       :   STD_LOGIC_VECTOR (31 downto 0);
begin

   Dec: Decoder5_32
   port map(i_Sel => i_rd,
            i_WE => i_read_write,
            o_Out => s_DecOut);

   Reg0: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => '1',
        i_WE => '0',
        i_D => x"00000000",
        o_Q => s_data0);

   Reg1: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(1),
        i_D => i_data,
        o_Q => s_data1);

   Reg2: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(2),
        i_D => i_data,
        o_Q => s_data2);

   Reg3: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(3),
        i_D => i_data,
        o_Q => s_data3);

   Reg4: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(4),
        i_D => i_data,
        o_Q => s_data4);

   Reg5: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(5),
        i_D => i_data,
        o_Q => s_data5);

   Reg6: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(6),
        i_D => i_data,
        o_Q => s_data6);

   Reg7: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(7),
        i_D => i_data,
        o_Q => s_data7);

   Reg8: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(8),
        i_D => i_data,
        o_Q => s_data8);

   Reg9: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(9),
        i_D => i_data,
        o_Q => s_data9);

   Reg10: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(10),
        i_D => i_data,
        o_Q => s_data10);

   Reg11: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(11),
        i_D => i_data,
        o_Q => s_data11);

   Reg12: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(12),
        i_D => i_data,
        o_Q => s_data12);

   Reg13: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(13),
        i_D => i_data,
        o_Q => s_data13);

   Reg14: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(14),
        i_D => i_data,
        o_Q => s_data14);

   Reg15: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(15),
        i_D => i_data,
        o_Q => s_data15);

   Reg16: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(16),
        i_D => i_data,
        o_Q => s_data16);

   Reg17: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(17),
        i_D => i_data,
        o_Q => s_data17);

   Reg18: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(18),
        i_D => i_data,
        o_Q => s_data18);

   Reg19: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(19),
        i_D => i_data,
        o_Q => s_data19);

   Reg20: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(20),
        i_D => i_data,
        o_Q => s_data20);

   Reg21: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(21),
        i_D => i_data,
        o_Q => s_data21);

   Reg22: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(22),
        i_D => i_data,
        o_Q => s_data22);

   Reg23: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(23),
        i_D => i_data,
        o_Q => s_data23);

   Reg24: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(24),
        i_D => i_data,
        o_Q => s_data24);

   Reg25: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(25),
        i_D => i_data,
        o_Q => s_data25);

   Reg26: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(26),
        i_D => i_data,
        o_Q => s_data26);

   Reg27: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(27),
        i_D => i_data,
        o_Q => s_data27);

   Reg28: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(28),
        i_D => i_data,
        o_Q => s_data28);

   Reg29: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(29),
        i_D => i_data,
        o_Q => s_data29);

   Reg30: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(30),
        i_D => i_data,
        o_Q => s_data30);

   Reg31: N_bit_reg
   port map(i_CLK => i_CLK,
        i_RST => i_reset,
        i_WE => s_DecOut(31),
        i_D => i_data,
        o_Q => s_data31);

   mux1: Mux31_1
   port map(i_data0 => s_data0,
        i_data1 => s_data1,
        i_data2 => s_data2,
        i_data3 => s_data3,
        i_data4 => s_data4,
        i_data5 => s_data5,
        i_data6 => s_data6,
        i_data7 => s_data7,
        i_data8 => s_data8,
        i_data9 => s_data9,
        i_data10 => s_data10,
        i_data11 => s_data11,
        i_data12 => s_data12,
        i_data13 => s_data13,
        i_data14 => s_data14,
        i_data15 => s_data15,
        i_data16 => s_data16,
        i_data17 => s_data17,
        i_data18 => s_data18,
        i_data19 => s_data19,
        i_data20 => s_data20,
        i_data21 => s_data21,
        i_data22 => s_data22,
        i_data23 => s_data23,
        i_data24 => s_data24,
        i_data25 => s_data25,
        i_data26 => s_data26,
        i_data27 => s_data27,
        i_data28 => s_data28,
        i_data29 => s_data29,
        i_data30 => s_data30,
        i_data31 => s_data31,
        i_Sel => i_rs,
        o_data => o_rs_data);
  
   mux2: Mux31_1
   port map(i_data0 => s_data0,
        i_data1 => s_data1,
        i_data2 => s_data2,
        i_data3 => s_data3,
        i_data4 => s_data4,
        i_data5 => s_data5,
        i_data6 => s_data6,
        i_data7 => s_data7,
        i_data8 => s_data8,
        i_data9 => s_data9,
        i_data10 => s_data10,
        i_data11 => s_data11,
        i_data12 => s_data12,
        i_data13 => s_data13,
        i_data14 => s_data14,
        i_data15 => s_data15,
        i_data16 => s_data16,
        i_data17 => s_data17,
        i_data18 => s_data18,
        i_data19 => s_data19,
        i_data20 => s_data20,
        i_data21 => s_data21,
        i_data22 => s_data22,
        i_data23 => s_data23,
        i_data24 => s_data24,
        i_data25 => s_data25,
        i_data26 => s_data26,
        i_data27 => s_data27,
        i_data28 => s_data28,
        i_data29 => s_data29,
        i_data30 => s_data30,
        i_data31 => s_data31,
        i_Sel => i_rt,
        o_data => o_rt_data);
  
end arch;