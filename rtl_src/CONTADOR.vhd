library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CONTADOR is
	generic(max:integer:=16);
	port
	(
		-- Input ports
		Clk	: in  std_logic;		--Reloj
		EN		: in	std_logic;		--Entrada de habilitación
		Rst	: in	std_logic;		--
		

		-- Output ports
		ovf	: out std_logic			--Overflow.
	);
end CONTADOR;

architecture beh of CONTADOR is

signal ovf_aux: std_logic;

	function Log2( input:integer ) return integer is
		variable temp,log:integer;
	begin
		temp:=input;
		log:=0;
		while (temp /= 0) loop
		temp:=temp/2;
		log:=log+1;
   end loop;
   return log;
	end function Log2;
	
	constant	bits: integer:= Log2(max-1);
	signal count:	unsigned(bits-1 downto 0);
begin

clock_event: process (Clk, Rst, count, EN)
	begin
		if(Rst='1') then --Reset Asincrónico
			count <= (others=>'0');
			ovf<='0';
		elsif(rising_edge(Clk)) then
			ovf<='0';
			if(to_integer(count) = max-1) then
			ovf <= '1';
			count <= (others=>'0');
			elsif(EN='1') then
				ovf<='0';
				count <= count +1;
			end if;
		end if;
end process;

end beh;