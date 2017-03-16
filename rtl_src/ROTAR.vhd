library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.HexaPackage.all;

entity rotar is
	port(
		clk			:	in std_logic;
		Actualizar	:	in std_logic;
		X_in			:	in signed(9 downto 0);
		Y_in			:	in signed(9 downto 0);
		angulo		:	in	unsigned(9 downto 0);
		
		X_out			:	out	signed(9 downto 0);
		Y_out			:	out	signed(9 downto 0)
	);
end rotar;

architecture beh of rotar is

signal seno		:	signed(11 downto 0);
signal coseno	:	signed(11 downto 0);

signal X_aux	:	signed (21 downto 0);
signal Y_aux	:	signed (21 downto 0);

begin

SC:senocoseno port map(clk=>clk,angulo=>angulo,seno=>seno,coseno=>coseno);

X_aux <= X_in*coseno - Y_in*seno;
Y_aux <= X_in*seno + Y_in*coseno;


Actualiza_XY	:	process(clk)
begin
if (rising_edge(clk)) then
	x_out <= X_aux(21 downto 12);
	y_out <= y_aux(21 downto 12);
end if;
end process;

end beh;