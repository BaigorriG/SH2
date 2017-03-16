library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.HexaPackage.all;

entity DesplazaXYalCentro is

	port(
		Clk		:	in	std_logic;
		Xin		:	in unsigned(9 downto 0);
		Yin		:	in unsigned(9 downto 0);
		Xout		:	out signed(9 downto 0);
		Yout		:	out signed(9 downto 0)
	);
end DesplazaXYalCentro;

architecture beh of DesplazaXYalCentro is
begin
	Desplazar: process(Clk)
	begin
		if rising_edge(clk) then
			Xout <= signed(std_logic_vector(Xin)) - CENTROX;
			Yout <= signed(std_logic_vector(Yin)) - CENTROY;
		end if;
	end process;
end beh;