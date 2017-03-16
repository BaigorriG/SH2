library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Dificultad is
	port(
		Clk	:	in std_logic;
		switches	:	in	std_logic_vector(1 downto 0);
		gameover	:	in	std_logic;
		
		Dificultad	:	out std_logic_vector(1 downto 0);
		Leds_Rojo	:	out std_logic_vector(7 downto 0);
		Leds_Verde	:	out std_logic_vector(7 downto 0)
	);
end Dificultad;

architecture beh of Dificultad is
begin
Setea_dificultad: Process(Clk,gameover,switches)
begin
	if (rising_edge(Clk)) then
		if(gameover='0') then
			Leds_Verde<=(others=>'1');
		elsif (gameover='1') then
			Leds_Verde<=(others=>'0');
			if (switches="00") then
				Leds_Rojo<= "00000011";
			elsif (switches = "01") then
				Leds_Rojo<= "00001111";
			elsif (switches = "10") then
				Leds_Rojo<= "00111111";
			elsif (switches = "11") then
				Leds_Rojo<= "11111111";
			end if;
			dificultad<=switches;
		end if;
	end if;
end process;
end beh;