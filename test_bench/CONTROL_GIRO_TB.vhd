-- prueba del componente control de giro

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

----------------------------------------------
------ entidad vacia
entity control_giro_tb is
end control_giro_tb;

----------------------------------------------
----------------------------------------------

architecture test of control_giro_tb is
	
-- declaracion del DUT

	component control_giro is
		port(
				clk					:	in	std_logic;
				reset					:	in	std_logic;
				Actualizar			:	in	std_logic;
				Random				:	in	std_logic_vector(63 downto 0);
				subir_velocidad	:	in	std_logic;
				
				velocidad_prueba	:	out	unsigned(5 downto 0);
				angulo				:	out	unsigned(9 downto 0)
			);
	end component control_giro;
	
-- delcaracion de otros componentes

	component CONTADOR is
		generic(max:integer:=16);
		port
		(
			-- Input ports
			Clk	: in  std_logic;
			EN		: in	std_logic;
			Rst	: in	std_logic;
			
			-- Output portss
			ovf: out std_logic
		);
	end component;

----------------------------------------------
-- señales del DUT
	signal	clk					: std_logic := '0';
	signal	reset					: std_logic := '1';
	signal	actualizar			: std_logic;
	signal	random				: std_logic_vector(63 downto 0);
	signal	subir_velocidad	: std_logic;
	
	signal	velocidad_prueba	: unsigned(5 downto 0);
	signal	angulo				: unsigned(9 downto 0);

-- otras señales
	
----------------------------------------------
----------------------------------------------
-- comportamiento
begin

----------------------------------------------
-- instanciacion del DUT

	tb_dut: control_giro 
		port map (
					clk					=>	clk,
					reset					=>	reset,
					Actualizar			=>	Actualizar,
					Random				=>	Random,
					subir_velocidad	=>	subir_velocidad,
					
					velocidad_prueba	=>	velocidad_prueba,
					angulo				=>	angulo
					);

-- instanciacion otros componentes
	ContSpeedUp: CONTADOR generic map(600)
		port map	(
					Clk	=>clk,
					EN		=>actualizar,
					Rst	=>reset,
					
					ovf	=>subir_velocidad
					);
	
----------------------------------------------
-- generacion de señales

-- clock de 25MHz
	clk <= not(clk) after 20 ns;
	
-- reset
	reset <= '0' after 50 ns;
	
-- otras
	actualizar <= '1';
	random <= STD_LOGIC_VECTOR(TO_UNSIGNED(0,64));
	
end test;