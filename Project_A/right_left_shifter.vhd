-------------------------------------------------------------------------
-- Jacob Vaughn
-- Nickolas Mitchell
-------------------------------------------------------------------------

-- right__left_shifter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 32-bit right 
-- left shifter.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity right_left_shifter is
--generic(N : integer:=32);
  port( i_shift			: in std_logic_vector(31 downto 0);
	ctl_bits_to_shift 	: in std_logic_vector(4 downto 0);
	ctl_which_shift		: in std_logic_vector(1 downto 0);	--'00' <= arithmetic shift right     '01' <= logical shift right     '10' <= Shift left 	
	o_shift			: out std_logic_vector(31 downto 0));

end right_left_shifter;

architecture structure of right_left_shifter is

component mux_2to1_32bit 
  port(i_0, i_1 : in std_logic_vector(31 downto 0);
       sel 	: in std_logic;
       o_f 	: out std_logic_vector(31 downto 0));
end component;

--Most significant bit
signal extend : std_logic; 

--Outputs
signal s_mux0, s_mux1, s_mux2, s_mux3 : std_logic_vector(31 downto 0);

signal s_shift, s_shift_temp, o_shift_temp : std_logic_vector(31 downto 0);

signal temp_shift : std_logic_vector(31 downto 0);

signal s1_0, s1_1, s1_2, s1_3, s1_4 : std_logic_vector(31 downto 0); 
 
begin
	
	gen0: for i in 0 to 31 generate 
	s_shift_temp(i) <= i_shift(31-i); 
	end generate;  

	extend <= i_shift(31) when (ctl_which_shift = "00") else '0';
	s_shift <= s_shift_temp when (ctl_which_shift = "10") else i_shift; 

---------------------------------------------------------------
-- Shift right arthmetic & logical
---------------------------------------------------------------

	s1_0 <= extend & s_shift(31 downto 1); 
	task1 : mux_2to1_32bit
       port MAP(i_0	=> s_shift,
		i_1 	=> s1_0,
		sel	=> ctl_bits_to_shift(0),
		o_f	=> s_mux0);


	s1_1 <= extend & extend & s_mux0(31 downto 2);
	task2 : mux_2to1_32bit
       port MAP(i_0	=> s_mux0,
		i_1 	=> s1_1,
		sel	=> ctl_bits_to_shift(1),
		o_f	=> s_mux1);


	s1_2 <= extend & extend & extend & extend & s_mux1(31 downto 4);
	task3 : mux_2to1_32bit
       port MAP(i_0	=> s_mux1,
		i_1 	=> s1_2,
		sel	=> ctl_bits_to_shift(2),
		o_f	=> s_mux2);


	s1_3 <= extend & extend & extend & extend & extend & extend & extend & extend & s_mux2(31 downto 8);
	task4 : mux_2to1_32bit
       port MAP(i_0	=> s_mux2,
		i_1 	=> s1_3,
		sel	=> ctl_bits_to_shift(3),
		o_f	=> s_mux3);


	s1_4 <= extend & extend & extend & extend & extend & extend & extend & extend & extend & extend & extend & extend & extend & extend & extend & extend & s_mux3(31 downto 16);
	task5 : mux_2to1_32bit
       port MAP(i_0	=> s_mux3,
		i_1 	=> s1_4,
		sel	=> ctl_bits_to_shift(4),
		o_f	=> temp_shift);


	gen1: for i in 0 to 31 generate 
	o_shift_temp(i) <= temp_shift(31-i); 
	end generate;

	o_shift <= o_shift_temp when (ctl_which_shift = "10") else temp_shift; 












		--Arithmetic Right Shift
		--if ctl_which_shift = "00" then 
		--	o_shift <= std_logic_vector(shift_right(signed(i_shift), to_integer(unsigned(ctl_bits_to_shift))));
 
		--Logical right Shift
		--elsif ctl_which_shift = "01" then
		--	o_shift <= std_logic_vector(shift_right(unsigned(i_shift), to_integer(unsigned(ctl_bits_to_shift))));
 
		--Left Shift
		--elsif ctl_which_shift = "10" then
		--	o_shift <= std_logic_vector(shift_left(unsigned(i_shift), to_integer(unsigned(ctl_bits_to_shift)))); 
		--end if;
end structure;
