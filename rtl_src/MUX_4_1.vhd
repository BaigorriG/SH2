library ieee;
use ieee.std_logic_1164.all;

entity MUX_4_1 is
port
	(
		in0,in1,in2,in3	: in  std_logic;
		sel	: in	std_logic_vector(1 downto 0);
		out1	: out	std_logic
	);
end MUX_4_1;

architecture flujo of MUX_4_1 is
begin
	with sel select
	out1 <=	in0	when "00",
				in1	when "01",
				in2	when "10",
				in3	when "11",
				'X'	when others;
end flujo;
		

		