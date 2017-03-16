--PRUEBA DEL BLOQUE DIBUJO SÓLO.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.HexaPackage.all;

ENTITY PRUEBA_PLAYER IS
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
END ENTITY;


ARCHITECTURE BEH OF PRUEBA_PLAYER IS

SIGNAL RED_OUT,GREEN_OUT,BLUE_OUT		:	STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL RED,GREEN,BLUE		:	STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL X,Y						:	UNSIGNED(9 DOWNTO 0);
SIGNAL XC,YC					:	SIGNED(9 downto 0);
SIGNAL XCR,YCR					:	SIGNED(9 downto 0);
SIGNAL END_FRAME,PRE_FRAME	:	STD_LOGIC;
SIGNAL GAME_OVER				:	STD_LOGIC;
SIGNAL W_DIFICULTAD			:	STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL Vuelve_jugador,Actualizar				:	std_logic;
SIGNAL angulo					:	unsigned(9 downto 0);
SIGNAL RESET					:	STD_LOGIC;
SIGNAL RAND						:	STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL Subir_velocidad		:	STD_LOGIC;
signal XP_actual				:	signed(9 downto 0);
signal YP_actual				: 	signed(9 downto 0);
signal XP_ant					:	signed(9 downto 0);
signal YP_ant					: 	signed(9 downto 0);
signal cuadranteAux			: 	STD_LOGIC_VECTOR (2 downto 0);
signal cuadranteR				:	unsigned (2 downto 0);
signal radioR					:	unsigned (9 downto 0);
signal MANTENER				:	STD_LOGIC;
signal ALTERNA					:	std_logic;
SIGNAL DIBUJA_PLAYER			:	STD_LOGIC;
SIGNAL DIBUJA_PAREDES		:	STD_LOGIC;
SIGNAL DIBUJA_ISLA			:	STD_LOGIC;
SIGNAL DIRECCION				:	STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL DATOS					:	STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL CVISIBLE				:	STD_LOGIC;
SIGNAL CNUEVO					:	STD_LOGIC;
SIGNAL COMP1,COMP2			:	STD_LOGIC;



BEGIN
ROJO <= RED_OUT & "0000";
VERDE<=  GREEN_OUT & "0000";
AZUL <=  BLUE_OUT & "0000";
CLK_VGA<=CLK25MHZ;

DRIVER_VGA: CONTROLADOR_VGA
	PORT MAP(
		CLK			=>CLK25MHZ,
		CLR			=>CLR,
		RED_IN		=>RED,
		GREEN_IN		=>GREEN,
		BLUE_IN		=>BLUE,
		
		HSYNC			=>HSYNC,
		VSYNC			=>VSYNC,
		VGA_SYNC_N	=>VGA_SYNC_N,
		VGA_BLANK_N	=>VGA_BLANK_N,
		X				=>X,
		Y				=>Y,
		RED			=>RED_OUT,
		GREEN			=>GREEN_OUT,
		BLUE			=>BLUE_OUT,
		END_FRAME	=>END_FRAME,
		PRE_FRAME	=>PRE_FRAME
	);

Juego_Fsm1: Juego_Fsm port map(
		Clk				=>CLK25MHZ,
		Frame_inicio	=>PRE_FRAME,
		Frame_fin		=>END_FRAME,
		Nuevo_juego		=>Nuevo_juego,
		Colision			=>CNUEVO,					--REVISAR
		Reset				=>CLR,
		
		Actualizar		=>Actualizar,
		Rst				=>RESET,
		Game_over		=>GAME_OVER
	);
	
CoordenadasCentro: DesplazaXYalCentro port map(
		Clk		=>CLK25MHZ,
		Xin		=>X,
		Yin		=>Y,
		Xout		=>XC,
		Yout		=>YC
	);

Rotar1: rotar port map(
		clk			=>CLK25MHZ,
		Actualizar	=>Actualizar,
		X_in			=>XC,
		Y_in			=>YC,
		angulo		=>angulo,
		
		X_out			=>XCR,
		Y_out			=>YCR
	);
	
ContSpeedUp: CONTADOR generic map(600)
	port map(
		Clk	=>CLK25MHZ,
		EN		=>Actualizar,
		Rst	=>RESET,
		
		ovf	=>Subir_velocidad
	);
	
ControlGiro1:control_giro port map(
		clk					=>CLK25MHZ,
		reset					=>RESET,
		Actualizar			=>Actualizar,
		Random				=>RAND,
		Subir_velocidad	=>Subir_velocidad,
		velocidad_prueba	=>OPEN,
		angulo				=>angulo
	);

Player: jugador port map(
		Clk				=>CLK25MHZ,
		Actualizar		=>Actualizar,
		Dificultad		=>W_DIFICULTAD,
		Boton_der		=>Boton_der,
		Boton_izq		=>Boton_izq,
		
		X_actual			=>XP_actual,
		Y_actual			=>YP_actual,
		X_anterior		=>XP_ant,
		Y_anterior		=>YP_ant
	);

Circle: CIRCULO PORT MAP(
		CLK		=>	CLK25MHZ,
		X1			=>	XCR,
		Y1			=>	YCR,
		X2			=>	XP_actual,
		Y2			=>	YP_actual,
		
		DIBUJA	=>	DIBUJA_PLAYER
	);
	
Gen_paredes: GENERADOR_PAREDES PORT MAP(
		CLK		=>CLK25MHZ,
		RAND		=>RAND,
		MANTIENE	=>MANTENER,
		ADDR		=>DIRECCION,
		DATA		=>DATOS
	);

Pared: PAREDES PORT MAP(
		CLK				=>CLK25MHZ,
		RESET				=>Reset,
		ACTUALIZAR		=>Actualizar,
		DIFICULTAD		=>W_DIFICULTAD,
		DATA				=>DATOS,
		CUADRANTE		=>cuadranteR,
		RADIO				=>radioR,
		
		MANTIENE			=>MANTENER,
		DATA_ADDR		=>DIRECCION,
		CUADRANTE_OUT	=>cuadranteAux,
		VISIBLE			=>DIBUJA_PAREDES,
		ISLA				=>DIBUJA_ISLA
	);	

Draw: DIBUJO PORT MAP(
		CLK		=>CLK25MHZ,
		ALTERNA	=>ALTERNA,
		CCOLOR	=>subir_velocidad,
		DPAREDES	=>DIBUJA_PAREDES,
		DISLA		=>DIBUJA_ISLA,
		DJUGADOR	=>DIBUJA_PLAYER,
		CUADRANTE=>cuadranteAux,
		RAND		=>RAND,
		
		ROJO		=>RED,
		VERDE		=>GREEN,
		AZUL		=>BLUE
	);
	
GeneradorAleatorio:LFSR_64 port map(
		Clk	=> CLK25MHZ,
		Set	=>	CLR,
		En		=>	'1',

		b		=>	RAND
	);

Rect2Hex2: conv_hexagonal port map(
		clk			=>CLK25MHZ,
		x				=>XCR,
		y				=>YCR,
		
		cuadrante	=>cuadranteR,
		radio			=>radioR
	);
	
ContAlterna: CONTADOR generic map(60)
	port map(
		Clk	=>CLK25MHZ,
		EN		=>Actualizar,
		Rst	=>RESET,
		
		ovf	=>ALTERNA
	);
	
Dif: Dificultad port map(
		Clk			=>CLK25MHZ,
		switches		=>DIF_SWITCH,
		gameover		=>GAME_OVER,
		
		Dificultad	=>W_DIFICULTAD,
		Leds_Rojo	=>Leds_Rojo,
		Leds_Verde	=>Leds_Verde
	);

FF_AND1:	FF_AND port map(
		Clk	=>CLK25MHZ,
		IN1	=>DIBUJA_PLAYER,
		IN2	=>DIBUJA_PAREDES,
		
		OUT1	=>CNUEVO
	);
	
PUNTAJE1: PUNTAJE PORT MAP(
		CLK			=>CLK25MHZ,
		ACTUALIZAR	=>Actualizar,
		GAME_OVER	=>GAME_OVER,
		RESET			=>RESET,
		
		SEGUNDOS		=>SEGUNDOS,
		SEGUNDOSX10	=>SEGUNDOSX10,
		SEGUNDOSX100=>SEGUNDOSX100
	);
	

END ARCHITECTURE;