library ieee; 
use ieee.std_logic_1164.all;

--CONTADOR LINEAR FEEDBACK SHIFT REGISTER.

entity LFSR_64 is
	port
	(
		-- Input ports
		Clk	: in  std_logic;		--Entrada de reloj
		Set	: in	std_logic;		--Entrada de seteo
		En		: in	std_logic;

		-- Output ports
		b		: out std_logic_vector(63 downto 0)
	);
end LFSR_64;

architecture shift of LFSR_64 is
	
	component FF_D_RISING is
		port
		(
			-- Input ports
			D		: in  std_logic;
			Clk	: in  std_logic;		--Reloj
			Set	: in	std_logic;		--Seteo asincrónico
			Reset	: in	std_logic;
			En		: in	std_logic;

			-- Output ports
			Q		: out std_logic
		);
	end component;

	signal XOR1: std_logic;								--Salida de XOR
	signal int: std_logic_vector(63 downto 0);		--Conexiones internas del contador, sirven como salidas también.
	
begin

	XOR1<=int(63) XOR int(62) xor int(60) XOR int(59);		
	
	LFSR: for i in 63 downto 0 generate
		i64: if (i<64 and i>0) generate
			bit32: FF_D_RISING port map(D=>int(i-1), Clk=>Clk, Set=>Set,Q=>int(i),reset=>'0',En=>En);	--demas bits de salida
		end generate i64;
		i0: if(i=0) generate
			bit0: FF_D_RISING port map(D=>XOR1,Clk=>Clk,Set=>Set,Q=>int(i),reset=>'0',En=>En);			--Primer bit
		end generate i0;
	end generate LFSR;
	
	b<=int;
	
end shift;
	