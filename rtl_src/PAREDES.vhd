library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.HexaPackage.all;
-- carga las paredes desde generador de paredes, las mueve y las dibuja
-- tambien dibuja la isla

entity paredes IS
	port(
		clk				:		in	std_logic;
		reset				:		in	std_logic;
		actualizar		:		in	std_logic;
		dificultad		:		in	std_logic_vector(1 downto 0);
		data				:		in	std_logic_vector(5 downto 0);
		cuadrante		:		in	unsigned(2 downto 0);
		radio				:		in	unsigned(9 downto 0);
		
		mantiene			:		out	std_logic;
		data_addr		:		out	std_logic_vector(5 downto 0);
		cuadrante_out	:		out	std_logic_vector(2 downto 0);
		visible			:		out	std_logic;
		isla				:		out	std_logic
	);
end entity;

architecture beh of paredes is

	type t_2d_a is array(0 to 127) of std_logic_vector(5 downto 0);
	
	signal paredes_a	:	t_2d_a;	-- arreglo donde se cargan 8 grupos de paredes
	signal centro		:	unsigned (13 downto 0);	-- indica el centro de la pantalla (7,7)
	signal offset		:	unsigned (11 downto 0);	-- direccion de paredes_a que tiene que dibujar (7,5)
	signal puntero		:	unsigned (6 downto 0);	-- puntero que pasa los datos desde generador de paredes y los pone en paredes_a
	
	signal mantiene_aux	: std_logic;
	
begin
	
	offset <= centro (13 downto 2) + resize(radio,12);	-- distancia de la coordenada al centro de la pantalla
																		-- offset (7,5) = centro (7,5) + radio (5,5)
																		-- offset = centro + radio/32
	
	--------------------------------------------------------------------------------
	-- carga el valor inicial del reset y lo mueve dependiendo de la dificultad
	mueve_centro: process(clk, reset, dificultad, actualizar)
	begin
		if rising_edge(clk) then
			if (reset='1') then
				centro <= to_unsigned(6144,14);	-- 96,0 (mitad de la segunda parte) 
			elsif (actualizar = '1') then
				case dificultad is
					when "00" => centro <= centro + to_unsigned(6,14);		-- 0,09375
					when "01" => centro <= centro + to_unsigned(9,14);		-- 0,140625
					when "10" => centro <= centro + to_unsigned(12,14);	-- 0,1875
					when "11" => centro <= centro + to_unsigned(15,14);	-- 0,234375
				end case;
			end if;
		end if;
	end process;
	
	--------------------------------------------------------------------------------
	-- activa visible cuando debe dibujar una paredes
	activa_visible: process(clk, cuadrante, radio, offset)
		variable aux	: std_logic_vector (5 downto 0);
		
	begin
		if rising_edge(clk) then
			cuadrante_out <= std_logic_vector(cuadrante);
			
			visible <= '0';
			isla <= '0';
			
			if (radio < to_unsigned(28,10)) then	-- hexagono negro en el centro
				isla <= '1';
			elsif (radio < to_unsigned(32,10)) then -- pared del hexagono central
				visible <= '1';
			else
				aux := paredes_a ( to_integer(offset(11 downto 5)));
				visible <= aux (to_integer(cuadrante));
			end if;
		end if;
	end process;
	
	--------------------------------------------------------------------------------
	-- carga del arreglo de paredes
	
	data_addr <= std_logic_vector(puntero(5 downto 0));
	
	mantiene <= mantiene_aux;															-- mantiene la parte estocastica cuando
	mantiene_aux <= '1' when ((puntero (5 downto 0) /= to_unsigned(0,6)) or -- esta en medio de pasar 4 grupos
									(puntero = to_unsigned(0,7) and bit2bool(centro(13))) or	-- puntero esta al principio y centro en la segunda mitad
									(puntero = to_unsigned(64,7) and not(bit2bool(centro(13))))) -- puntero esta a la mitad y centro esta en la primer parte
								else '0';
	
	
	-- carga todo el arreglo con 0 al resetear y despues carga cada mitad del arreglo
	carga_paredes_a: process (clk, reset, data)
	begin
		if rising_edge(clk) then
			if (reset = '1') then
				puntero <= to_unsigned(64,7);
				for i in 0 to 127 loop
					paredes_a(i) <= std_logic_vector(to_unsigned(0,6));
				end loop;
			elsif (mantiene_aux = '1') then
				paredes_a(to_integer(puntero))<= data;
				puntero <= puntero + 1;
			end if;
		end if;
	end process;

end architecture;