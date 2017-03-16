library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.HexaPackage.all;

ENTITY SUPERHEXAGON2016 IS
	PORT(
		CLK					:	IN	STD_LOGIC;
		CLR					:	IN	STD_LOGIC;
		DIF_SWITCH			:	IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
		RX						:	IN	STD_LOGIC;
		BT_IZQ				:	IN	STD_LOGIC;
		BT_DER				:	IN	STD_LOGIC;
		BT_START				:	IN	STD_LOGIC;
		
		CLK_VGA				:	OUT	STD_LOGIC;
		HSYNC					:	OUT	STD_LOGIC;
		VSYNC					:	OUT	STD_LOGIC;
		VGA_SYNC_N			:	OUT	STD_LOGIC;
		VGA_BLANK_N			:	OUT	STD_LOGIC;
		ROJO,VERDE,AZUL	:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
		Leds_Rojo			:	out	std_logic_vector(7 downto 0);
		Leds_Verde			:	out 	std_logic_vector(7 downto 0);
		SEGUNDOS				:	OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);
		SEGUNDOSX10			:	OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);
		SEGUNDOSX100		:	OUT	STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
END ENTITY;

----------------------------------------------------------------------------------------------------------------
ARCHITECTURE BEH OF SUPERHEXAGON2016 IS

COMPONENT PLL IS
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC ;
		c1		: OUT STD_LOGIC ;
		c2		: OUT STD_LOGIC 
	);
END COMPONENT;

COMPONENT PRUEBA_PLAYER IS
	PORT(
		CLK25MHZ				:	IN	STD_LOGIC;
		CLR					:	IN	STD_LOGIC;
		DIF_SWITCH			:	IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
		Nuevo_juego			:	in	std_logic;
		Boton_der			:	in	std_logic;
		Boton_izq			:	in	std_logic;
		
		CLK_VGA				:	OUT	STD_LOGIC;
		HSYNC					:	OUT	STD_LOGIC;
		VSYNC					:	OUT	STD_LOGIC;
		VGA_SYNC_N			:	OUT	STD_LOGIC;
		VGA_BLANK_N			:	OUT	STD_LOGIC;
		ROJO,VERDE,AZUL	:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
		Leds_Rojo			:	out	std_logic_vector(7 downto 0);
		Leds_Verde			:	out 	std_logic_vector(7 downto 0);
		SEGUNDOS				:	OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);
		SEGUNDOSX10			:	OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);
		SEGUNDOSX100		:	OUT	STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
END COMPONENT;

COMPONENT RS232_RX IS
	PORT(
		CLK:			IN	STD_LOGIC;
		RST:			IN	STD_LOGIC;
		RX:			IN	STD_LOGIC;
		
		DATA_OK:		OUT STD_LOGIC;
		DATAOUT:		OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
END COMPONENT;


SIGNAL CLK25MHZ,CLKBAUD	:	STD_LOGIC;
SIGNAL DATA				:	STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL IZQ,DER,START	:	STD_LOGIC;

BEGIN

IZQ <= DATA(1) OR NOT(BT_IZQ);
DER <= DATA(0) OR NOT(BT_DER);
START<= DATA(2) OR NOT(BT_START);


PLL1:	PLL PORT MAP(
		areset		=> CLR,
		inclk0		=>	CLK,
		c0				=>	CLK25MHZ,
		c1				=>	CLKBAUD,
		c2				=>	OPEN
	);


JUEGO: PRUEBA_PLAYER PORT MAP(
		CLK25MHZ				=>CLK25MHZ,
		CLR					=>CLR,
		DIF_SWITCH			=>DIF_SWITCH,
		Nuevo_juego			=>START,
		Boton_der			=>DER,
		Boton_izq			=>IZQ,
		
		CLK_VGA				=>CLK_VGA,
		HSYNC					=>HSYNC,
		VSYNC					=>VSYNC,
		VGA_SYNC_N			=>VGA_SYNC_N,
		VGA_BLANK_N			=>VGA_BLANK_N,
		ROJO					=>ROJO,
		VERDE					=>VERDE,
		AZUL					=>AZUL,
		Leds_Rojo			=>Leds_Rojo,
		Leds_Verde			=>Leds_Verde,
		SEGUNDOS				=>SEGUNDOS,
		SEGUNDOSX10			=>SEGUNDOSX10,
		SEGUNDOSX100		=>SEGUNDOSX100
		);
		
RECEPTOR_BLUETOOTH: RS232_RX PORT MAP(
		CLK		=>CLKBAUD,
		RST		=>CLR,
		RX			=>RX,
		
		DATA_OK	=>OPEN,
		DATAOUT	=>DATA
		);
		
END ARCHITECTURE;