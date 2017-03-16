library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CONTADOR_BCD is
	port
	(
		-- Input ports
		Clk	: in  std_logic;		--Reloj
		EN		: in	std_logic;		--Entrada de habilitación
		Rst	: in	std_logic;		--
		

		-- Output ports
		count	: out std_logic_vector(3 downto 0);
		ovf	: out std_logic			--Overflow.
	);
end CONTADOR_BCD;

architecture beh of CONTADOR_BCD is
signal count_aux:	unsigned(3 downto 0);
begin
count <= std_logic_vector(count_aux);
clock_event: process (Clk, Rst, count_aux, EN)
	begin
		if(Rst='1') then --Reset Asincrónico
			count_aux <= (others=>'0');
			ovf<='0';
		elsif(rising_edge(Clk)) then
			ovf<='0';
			if(to_integer(count_aux) = 10) then
			ovf <= '1';
			count_aux <= (others=>'0');
			elsif(EN='1') then
				ovf<='0';
				count_aux <= count_aux +1;
			end if;
		end if;
end process;

end beh;