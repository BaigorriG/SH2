library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_giro is 
port(
	clk					:	in	std_logic;
	reset					:	in	std_logic;
	Actualizar			:	in	std_logic;
	Random				:	in	std_logic_vector(63 downto 0);
	subir_velocidad	:	in	std_logic;
	velocidad_prueba	:	out	unsigned(5 downto 0);
	angulo				:	out	unsigned(9 downto 0)
);
end control_giro;

architecture beh of control_giro is
	signal velocidad		:	unsigned(9 downto 0);
	signal cambiar_giro	:	unsigned(8 downto 0);
	signal direccion		:	std_logic;
	signal angulo_aux		:	unsigned(9 downto 0);

begin
velocidad_prueba<=velocidad(5 downto 0);
AUMENTAR_VELOCIDAD	:	process (clk)
begin
	if (rising_edge(clk)) then
		if (reset='1') then
			velocidad <= to_unsigned(1,10);
		elsif (subir_velocidad='1') then
			velocidad <= velocidad + 1;
			--velocidad <= to_unsigned(0,10);
		end if;
	end if;
end process;

CAMBIAR_DIRECCION	:	process (clk,reset,actualizar,cambiar_giro)
begin
	if (rising_edge(clk)) then
		if (reset='1') then
			cambiar_giro <= to_unsigned(0,9);
		elsif (actualizar='1') then
			if (cambiar_giro = to_unsigned(0,9)) then
				cambiar_giro <= unsigned(random(16 downto 9)) + to_unsigned(60,9);
				direccion <= not(direccion);
			else
				cambiar_giro <= cambiar_giro - to_unsigned(1,9);
			end if;
		end if;
	end if;
end process;


AUMENTAR_ANGULO :		process (clk, actualizar, direccion,reset)
begin
	if (rising_edge(clk)) then
		if (reset='1') then
			angulo_aux<= to_unsigned(0,10);
		elsif (actualizar='1') then
			if (direccion='1') then
				angulo_aux <= angulo_aux + velocidad;
			else
				angulo_aux <= angulo_aux - velocidad;
			end if;
		end if;
	end if;
end process;

angulo <= angulo_aux;

end beh;
