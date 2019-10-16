-------------------------------------------------------------------------
-- Jacob Vaughn
-- Nickolas Mitchell
-------------------------------------------------------------------------

-- MIPS_processor_V3.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity MIPS_processor_V3 is
  port(i_CLK        : in std_logic;     -- Clock input

       i_rs         : in std_logic_vector(4 downto 0);     -- Read address 1
       i_rt         : in std_logic_vector(4 downto 0);     -- Read address 2
       i_rd         : in std_logic_vector(4 downto 0);     -- Write address

       i_ALUSrc     : in std_logic;  -- rt or Immediate
       i_ALUOp      : in std_logic_vector(5 downto 0); --Operation for the ALU
                                                       --000000 : AND
                                                       --000001 : or
                                                       --000010 : add
                                                       --000011 : xor
                                                       --011100 : slt
                                                       --110000 : NOR
                                                       --110001 : NAND
                                                       --011010 : Sub
                                                       --111100 : arithmetic shift right
                                                       --111101 : logical shift right
                                                       --111110 : Shift left

       i_regWrite   : in std_logic;  -- Write to reg?
       i_mem_we     : in std_logic;  -- Write to mem?
       i_MemtoReg   : in std_logic;  -- lw

       i_immediate  : in std_logic_vector(15 downto 0));     -- Data value input
       
end MIPS_processor_V3;

architecture arch of MIPS_processor_V3 is

--components
component RegFile
  port(i_CLK        : in std_logic;     -- Clock input
       i_read_write : in std_logic;     -- read/Write enable
       i_rs         : in std_logic_vector(4 downto 0);     -- Read address 1
       i_rt         : in std_logic_vector(4 downto 0);     -- Read address 2
       i_rd         : in std_logic_vector(4 downto 0);     -- Write address
       i_reset      : in std_logic;     -- Reset registers
       i_data       : in std_logic_vector(31 downto 0);     -- Data value input
       o_rs_data    : out std_logic_vector(31 downto 0);   -- Data value output
       o_rt_data    : out std_logic_vector(31 downto 0));   -- Data value output
end component;

component Add_Sub
  generic(N : integer := 32);
  port( i_A  : in std_logic_vector(N-1 downto 0);
	i_B  : in std_logic_vector(N-1 downto 0);
	i_nAdd_Sub  : in std_logic;
       	o_S  : out std_logic_vector(N-1 downto 0);
        o_Cout  : out std_logic);

end component;

component mux2_1_D is
  generic(N : integer := 32);
  port( i_A  : in std_logic_vector(N-1 downto 0);
	i_B  : in std_logic_vector(N-1 downto 0);
	i_X  : in std_logic;
        o_Y  : out std_logic_vector(N-1 downto 0));

end component;

component mem
	generic (
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10
	        );
	port (
		clk		: in std_logic;
		addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '1';
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	     );
end component;

component zero_sign_ext_16_32bit
  port( i_16in  : in std_logic_vector(15 downto 0);
        i_sel   : in std_logic;
        o_32out : out std_logic_vector(31 downto 0));

end component;

component ALU_and_Shifter
  port(A         : in   std_logic_vector(31 downto 0);
       B         : in   std_logic_vector(31 downto 0);
       ALUOp     : in   std_logic_vector(5 downto 0);
       Shift_Amount : in   std_logic_vector(4 downto 0);
       F         : out  std_logic_vector(31 downto 0);
       Carryout  : out  std_logic;
       Overflow  : out  std_logic;
       Zero      : out  std_logic); 
end component;
--end components

--signals
signal       s_rs_data    : std_logic_vector(31 downto 0);
signal       s_rt_data    : std_logic_vector(31 downto 0);
signal       s_mem_q      : std_logic_vector(31 downto 0);
signal       s_32Imm      : std_logic_vector(31 downto 0);

signal       s_ALUSrc_out     : std_logic_vector(31 downto 0);
signal       s_MemtoReg_out   : std_logic_vector(31 downto 0);

signal       s_Cout : std_logic;

signal       s_Overflow : std_logic;
signal       s_Zero       : std_logic;
signal       s_ALU_result : std_logic_vector(31 downto 0);


--end signals

begin

   RegFile1: RegFile
   port map(i_CLK => i_CLK,
            i_read_write => i_regWrite,
            i_rs => i_rs,
            i_rt => i_rt,
            i_rd => i_rd,
            i_reset => '0',
            i_data => s_MemtoReg_out,
            o_rs_data => s_rs_data,
            o_rt_data => s_rt_data);

   ALUSrc: mux2_1_D
   port map(i_A => s_rt_data,
	    i_B => s_32Imm,
	    i_X => i_ALUSrc,
       	    o_Y => s_ALUSrc_out);

   dmem: mem
   port map( clk => i_CLK,
             addr => s_ALU_result(9 downto 0),
             data => s_rt_data,
             we => i_mem_we,
             q => s_mem_q);

   Ext1: zero_sign_ext_16_32bit
   port map( i_16in => i_immediate,
             i_sel => '1',
             o_32out => s_32Imm);

   MemtoReg: mux2_1_D
   port map(i_A => s_ALU_result,
	    i_B => s_mem_q,
	    i_X => i_MemtoReg,
       	    o_Y => s_MemtoReg_out);

  ALU1: ALU_and_Shifter
  port map(A => s_rs_data,
       B => s_ALUSrc_out,
       ALUOp => i_ALUOp,
       Shift_Amount => i_immediate(4 downto 0),
       F => s_ALU_result,
       Carryout => s_Cout,
       Overflow => s_Overflow,
       Zero => s_Zero); 

end arch;