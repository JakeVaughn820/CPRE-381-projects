-------------------------------------------------------------------------
-- Nickolas Mitchell
-------------------------------------------------------------------------


-- regFile.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a 32-bit register file
--
--
-- NOTES:
-- 9/11/2019 Created by Nick
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity regFile is
Generic(N : integer:=32); 
   port(waddr 		: in std_logic_vector(4 downto 0);	--Write Address
        w_enable 	: in std_logic; 			--Write enable
	rd		: in std_logic_vector(31 downto 0);	--Write
	rt		: in std_logic_vector(4 downto 0); 	--Read(1)
	rs		: in std_logic_vector(4 downto 0); 	--Read(2)
	i_rst		: in std_logic;				--Reset
	i_clk		: in std_logic;				--Clock
	out1		: out std_logic_vector(31 downto 0); 	--Output(1)
        out2		: out std_logic_vector(31 downto 0)); 	--Output(2)
end regFile;

architecture structure of regFile is 

---------------------------------------------------------------------
			----Components----
---------------------------------------------------------------------
component nbit_register
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_A         : in std_logic_vector(N - 1 downto 0);     -- Data value input
       o_A         : out std_logic_vector(N - 1 downto 0));   -- Data value output
end component;

component decoder
  port(i_x 	: in std_logic_vector(4 downto 0);
       enable   : in std_logic; 
       o_f  	: out std_logic_vector(31 downto 0));
end component; 

component mux_32to1
  port(i_0, i_1, i_2, i_3, i_4, i_5, i_6, i_7, i_8, i_9 		: in std_logic_vector(31 downto 0);
       i_10, i_11, i_12, i_13, i_14, i_15, i_16, i_17, i_18, i_19 	: in std_logic_vector(31 downto 0); 
       i_20, i_21, i_22, i_23, i_24, i_25, i_26, i_27, i_28, i_29 	: in std_logic_vector(31 downto 0); 
       i_30, i_31 							: in std_logic_vector(31 downto 0); 
       sel 	: in std_logic_vector(4 downto 0);
       o_f 	: out std_logic_vector(31 downto 0));
end component;

---------------------------------------------------------------------
			----Structure----
---------------------------------------------------------------------  

--Decoder write enable (output for decoder) 
signal d_we : std_logic_vector(31 downto 0);

--Register output
signal r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31 : std_logic_vector(31 downto 0); 

begin    

---------------------------------------------------------
		----Decoder----
---------------------------------------------------------
decode : decoder
	port MAP(i_x	=> waddr,
	         enable => w_enable,
		 o_f	=> d_we);  

---------------------------------------------------------
		----Registers----
---------------------------------------------------------
reg0 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> '0',
		i_A	=> rd,
		o_A	=> r0);
		 
reg1 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(1),
		i_A	=> rd,
		o_A	=> r1);

reg2 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(2),
		i_A	=> rd,
		o_A	=> r2);

reg3 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(3),
		i_A	=> rd,
		o_A	=> r3);

reg4 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(4),
		i_A	=> rd,
		o_A	=> r4);

reg5 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(5),
		i_A	=> rd,
		o_A	=> r5);

reg6 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(6),
		i_A	=> rd,
		o_A	=> r6);

reg7 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(7),
		i_A	=> rd,
		o_A	=> r7);

reg8 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(8),
		i_A	=> rd,
		o_A	=> r8);

reg9 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(9),
		i_A	=> rd,
		o_A	=> r9);

reg10 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(10),
		i_A	=> rd,
		o_A	=> r10);
		 
reg11 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(11),
		i_A	=> rd,
		o_A	=> r11);

reg12 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(12),
		i_A	=> rd,
		o_A	=> r12);

reg13 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(13),
		i_A	=> rd,
		o_A	=> r13);

reg14 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(14),
		i_A	=> rd,
		o_A	=> r14);

reg15 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(15),
		i_A	=> rd,
		o_A	=> r15);

reg16 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(16),
		i_A	=> rd,
		o_A	=> r16);

reg17 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(17),
		i_A	=> rd,
		o_A	=> r17);

reg18 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(18),
		i_A	=> rd,
		o_A	=> r18);

reg19 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(19),
		i_A	=> rd,
		o_A	=> r19);

reg20 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(20),
		i_A	=> rd,
		o_A	=> r20);
		 
reg21 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(21),
		i_A	=> rd,
		o_A	=> r21);

reg22 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(22),
		i_A	=> rd,
		o_A	=> r22);

reg23 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(23),
		i_A	=> rd,
		o_A	=> r23);

reg24 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(24),
		i_A	=> rd,
		o_A	=> r24);

reg25 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(25),
		i_A	=> rd,
		o_A	=> r25);

reg26 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(26),
		i_A	=> rd,
		o_A	=> r26);

reg27 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(27),
		i_A	=> rd,
		o_A	=> r27);

reg28 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(28),
		i_A	=> rd,
		o_A	=> r28);

reg29 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(29),
		i_A	=> rd,
		o_A	=> r29);

reg30 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(30),
		i_A	=> rd,
		o_A	=> r30);

reg31 : nbit_register
       port MAP(i_CLK	=> i_clk,	
		i_RST	=> i_rst,
		i_WE	=> d_we(31),
		i_A	=> rd,
		o_A	=> r31);

---------------------------------------------------------
		----Multiplexers----
---------------------------------------------------------
mux1 : mux_32to1
       port MAP(i_0	=> r0,
		i_1 	=> r1, 
		i_2 	=> r2, 
		i_3 	=> r3, 	
		i_4 	=> r4, 
		i_5 	=> r5, 
		i_6	=> r6, 
		i_7 	=> r7,
		i_8	=> r8, 		
		i_9 	=> r9,		
		i_10 	=> r10,
		i_11	=> r11,  
		i_12 	=> r12, 
		i_13	=> r13,  
		i_14 	=> r14, 
		i_15 	=> r15, 
		i_16 	=> r16, 
		i_17 	=> r17,
		i_18 	=> r18, 
		i_19 	=> r19, 
       		i_20 	=> r20,
		i_21 	=> r21,
		i_22	=> r22,  
		i_23	=> r23, 
		i_24 	=> r24, 
		i_25 	=> r25, 
		i_26	=> r26, 
		i_27	=> r27, 
		i_28	=> r28, 
		i_29 	=> r29, 	
       		i_30 	=> r30,
		i_31 	=> r31, 						 
       		sel 	=> rt, 
       		o_f 	=> out1); 

mux2 : mux_32to1
       port MAP(i_0	=> r0,
		i_1 	=> r1, 
		i_2 	=> r2, 
		i_3 	=> r3, 	
		i_4 	=> r4, 
		i_5 	=> r5, 
		i_6	=> r6, 
		i_7 	=> r7,
		i_8	=> r8, 		
		i_9 	=> r9,		
		i_10 	=> r10,
		i_11	=> r11,  
		i_12 	=> r12, 
		i_13	=> r13,  
		i_14 	=> r14, 
		i_15 	=> r15, 
		i_16 	=> r16, 
		i_17 	=> r17,
		i_18 	=> r18, 
		i_19 	=> r19, 
       		i_20 	=> r20,
		i_21 	=> r21,
		i_22	=> r22,  
		i_23	=> r23, 
		i_24 	=> r24, 
		i_25 	=> r25, 
		i_26	=> r26, 
		i_27	=> r27, 
		i_28	=> r28, 
		i_29 	=> r29, 	
       		i_30 	=> r30,
		i_31 	=> r31, 						 
       		sel 	=> rs, 
       		o_f 	=> out2); 














end structure; 
