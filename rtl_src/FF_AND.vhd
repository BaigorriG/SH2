library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FF_AND is
	port(
		Clk	: in	std_logic;
		IN1	: in	std_logic;
		IN2	: in	std_logic;
		
		OUT1	: out	std_logic
	);
end FF_AND;


architecture beh of FF_AND is
	signal FF_OUT1, FF_OUT2 : std_logic;
	
	component FF_D_RISING is
	port(
		D		: in  std_logic;
		Clk	: in  std_logic;
		Set	: in	std_logic;
		Reset	: in	std_logic;
		En		: in	std_logic;
		
		Q	: out std_logic
	);
	
end component;
	
begin

FF1: FF_D_RISING port map(
		D		=>IN1,
		Clk	=>CLK,
		Set	=>'0',
		Reset	=>'0',
		En		=>'1',
		
		Q		=>FF_OUT1
	);
	
FF2: FF_D_RISING port map(
		D		=>FF_OUT1,
		Clk	=>CLK,
		Set	=>'0',
		Reset	=>'0',
		En		=>'1',
		
		Q		=>FF_OUT2
	);

OUT1 <= IN2 and FF_OUT2;

end beh;