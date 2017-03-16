library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity conv_hexagonal is
	port(
		clk		: in std_logic;
		x			: in signed (9 downto 0);
		y			: in signed (9 downto 0);
		
		cuadrante	: out unsigned (2 downto 0);
		radio			: out unsigned (9 downto 0)
		);
end conv_hexagonal;

architecture beh of conv_hexagonal is

	constant raiz_3int	:	integer	:= 1773;
	constant	raiz_3		:	signed (11 downto 0)	:= to_signed(raiz_3int,12);
	
	signal	r_3_x_completo		:	signed (21 downto 0);
	signal	r_3_x					:	signed (11 downto 0);
	signal	r_3_x_neg			:	signed (11 downto 0);
		
	signal	y_ext					:	signed (11 downto 0);
	signal	y_neg					:	signed (11 downto 0);
	
	signal	radio_aux			:	signed (11 downto 0);
	
begin

	r_3_x_completo	<= x * raiz_3;
	r_3_x				<= r_3_x_completo (21 downto 10);
	r_3_x_neg		<= -r_3_x;
	
	y_ext				<= (y(9) & y(9) & y);
	y_neg				<= -y_ext;
	
	convertir : process (clk)
		begin
			if (rising_edge(clk)) then
				if (y_ext > to_signed(0,12)) then
					if (y_ext < r_3_x) then								-- cuadrante 0
						cuadrante	<= to_unsigned(0,3);
						radio_aux	<= y_ext + r_3_x;
						radio			<= unsigned(radio_aux (10 downto 1));
						
					elsif (y_ext < r_3_x_neg) then					-- cuadrante 2
						cuadrante	<= to_unsigned(2,3);
						radio_aux	<= y_ext + r_3_x_neg;
						radio			<= unsigned(radio_aux (10 downto 1));
						
					else														-- cuadrante 1
						cuadrante	<= to_unsigned(1,3);
--						radio			<= unsigned(std_logic_vector(y));
						radio_aux	<= y_ext + y_ext;
						radio			<= unsigned(radio_aux (10 downto 1));
					end if;
				else
					if (y_ext > r_3_x) then								-- cuadrante 3
						cuadrante	<= to_unsigned(3,3);
						radio_aux	<= y_neg + r_3_x_neg;
						radio			<= unsigned(radio_aux (10 downto 1));
						
					elsif (y_ext > r_3_x_neg) then					-- cuadrante 5
						cuadrante	<= to_unsigned(5,3);
						radio_aux	<= y_neg + r_3_x;
						radio			<= unsigned(radio_aux (10 downto 1));
						
					else														-- cuadrante 4
						cuadrante	<= to_unsigned(4,3);
--						radio			<= unsigned(std_logic_vector(-y));
						radio_aux	<= y_neg + y_neg;
						radio			<= unsigned(radio_aux (10 downto 1));
					end if;
				end if;
--				radio <= unsigned( resize(x*x + y*y,10));
			end if;
		end process;

end beh;