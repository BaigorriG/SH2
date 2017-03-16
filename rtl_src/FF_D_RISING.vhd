library ieee; 
use ieee.std_logic_1164.all;
--Modelo de Flip Flop D

entity FF_D_RISING is
	port
	(
		-- Input ports
		D		: in  std_logic;
		Clk	: in  std_logic;		--Reloj
		Set	: in	std_logic;		--Seteo asincrónico
		Reset	: in	std_logic;
		En		: in	std_logic;

		-- Output ports
		Q	: out std_logic
	);
end FF_D_RISING;

architecture flow of FF_D_RISING is
begin
	ff_d_clk: process (Clk, Set, Reset,En)
	begin
		if	(En='0') then null;
		elsif (Set='1') then				
				Q<='1';
		elsif (Reset='1') then
				Q<='0';
		elsif (rising_edge(Clk)) then
				Q<=D;
		end if;
	end process;
end flow;
