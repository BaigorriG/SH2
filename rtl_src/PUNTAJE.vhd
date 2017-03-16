library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.HexaPackage.all;

ENTITY PUNTAJE IS
	PORT(
		CLK			:	IN	STD_LOGIC;
		ACTUALIZAR	:	IN	STD_LOGIC;
		GAME_OVER	:	IN	STD_LOGIC;
		RESET			:	IN	STD_LOGIC;
		
		SEGUNDOS		:	OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);
		SEGUNDOSX10	:	OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);
		SEGUNDOSX100:	OUT	STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE BEH OF PUNTAJE IS

COMPONENT CONTADOR_BCD is
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
END COMPONENT;

component DEC_HEX_7SEG is
	port(
		in1	: in  std_logic_vector(3 downto 0);
		out1	: out std_logic_vector(0 to 6)
	);
end component;

SIGNAL OVFFRAMES,OVFSEG,OVFSEGX10:	STD_LOGIC;
SIGNAL COUNTSEG,COUNTSEGX10,COUNTSEGX100:	STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
CONTFRAMES: CONTADOR generic map(60)
	port map(
		Clk	=>Clk,
		EN		=>ACTUALIZAR,
		Rst	=>RESET,
		
		ovf	=>OVFFRAMES
	);

CONTSEG: CONTADOR_BCD port map(
		Clk	=>Clk,
		EN		=>OVFFRAMES,
		Rst	=>RESET,
		count =>COUNTSEG,
		ovf	=>OVFSEG
	);
	
CONTSEGX10: CONTADOR_BCD port map(
		Clk	=>Clk,
		EN		=>OVFSEG,
		Rst	=>RESET,
		count =>COUNTSEGX10,
		ovf	=>OVFSEGX10
	);

CONTSEGX100: CONTADOR_BCD port map(
		Clk	=>Clk,
		EN		=>OVFSEGX10,
		Rst	=>RESET,
		count =>COUNTSEGX100,
		ovf	=>OPEN
	);
SEGUNDOS_DEC: DEC_HEX_7SEG PORT MAP(COUNTSEG,SEGUNDOS);
SEGUNDOSX10_DEC: DEC_HEX_7SEG PORT MAP(COUNTSEGX10,SEGUNDOSX10);
SEGUNDOSX100_DEC: DEC_HEX_7SEG PORT MAP(COUNTSEGX100,SEGUNDOSX100);

END ARCHITECTURE;