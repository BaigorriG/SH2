library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY SUPERHEXAGON2_TB IS
END ENTITY;

ARCHITECTURE TB OF SUPERHEXAGON2_TB IS

COMPONENT SUPERHEXAGON2 IS
	PORT(
		CLK			:	IN	STD_LOGIC;
		CLR			:	IN	STD_LOGIC;
		Nuevo_juego	:	in	std_logic;
	
		HSYNC			:	OUT	STD_LOGIC;
		VSYNC			:	OUT	STD_LOGIC;
		VGA_SYNC_N	:	OUT	STD_LOGIC;
		VGA_BLANK_N	:	OUT	STD_LOGIC;
		cuadrante	: 	out 	unsigned (2 downto 0);
		radio			: 	out 	unsigned (9 downto 0);
		cuadranteR	: 	out 	unsigned (2 downto 0);
		radioR		: 	out 	unsigned (9 downto 0)
	);
END COMPONENT;

SIGNAL CLK				:	STD_LOGIC:='0';
SIGNAL CLR				:	STD_LOGIC:='0';
SIGNAL Nuevo_juego	:	std_logic:='0';

SIGNAL cuadrante		: 	unsigned (2 downto 0);
SIGNAL radio			: 	unsigned (9 downto 0);
SIGNAL cuadranteR		: 	unsigned (2 downto 0);
SIGNAL radioR			: 	unsigned (9 downto 0);

BEGIN

GAME: SUPERHEXAGON2 	PORT MAP(
		CLK			=>CLK,
		CLR			=>CLR,
		Nuevo_juego	=>Nuevo_juego,
	
		HSYNC			=>OPEN,
		VSYNC			=>OPEN,
		VGA_SYNC_N	=>OPEN,
		VGA_BLANK_N	=>OPEN,
		cuadrante	=>cuadrante,
		radio			=>radio,
		cuadranteR	=>cuadranteR,
		radioR		=>radioR
	);
	
CLK <= NOT(CLK) after 20ns;

PROCESS 
BEGIN
CLR<='1';
WAIT UNTIL(RISING_EDGE(CLK));
CLR<='0';
WAIT UNTIL(RISING_EDGE(CLK));
Nuevo_juego<='1';
WAIT UNTIL(RISING_EDGE(CLK));
Nuevo_juego<='0';
ASSERT(FALSE) REPORT "CLR" SEVERITY NOTE;
WAIT FOR 100ms;
ASSERT(FALSE) REPORT "FIN" SEVERITY FAILURE;
END PROCESS;

END ARCHITECTURE;