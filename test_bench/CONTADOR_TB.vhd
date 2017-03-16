library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY CONTADOR_TB IS
END ENTITY;

ARCHITECTURE TB OF CONTADOR_TB IS

component CONTADOR is
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
end component;

SIGNAL CLK, EN, RST: STD_LOGIC:='1';
SIGNAL OVF:	STD_LOGIC;
BEGIN
C1: CONTADOR GENERIC MAP(600) PORT MAP(CLK,EN,RST,OVF);
CLK <= NOT(CLK) AFTER 20ns;
PROCESS
BEGIN

RST<='0';
WAIT UNTIL RISING_EDGE(OVF);
WAIT UNTIL RISING_EDGE(OVF);
ASSERT(FALSE) REPORT "FIN" SEVERITY FAILURE;

END PROCESS;

END ARCHITECTURE;