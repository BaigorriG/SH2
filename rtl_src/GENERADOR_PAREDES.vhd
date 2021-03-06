library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY GENERADOR_PAREDES IS
	PORT(
		CLK		:	IN	STD_LOGIC;
		RAND		:	IN	STD_LOGIC_VECTOR(63 DOWNTO 0);
		MANTIENE	:	IN	STD_LOGIC;
		ADDR		:	IN	STD_LOGIC_VECTOR(5 DOWNTO 0);
		DATA		:	OUT	STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END ENTITY;
		
ARCHITECTURE BEH OF GENERADOR_PAREDES IS

TYPE RAND_2D	IS ARRAY(0 TO 63) OF STD_LOGIC_VECTOR(5 DOWNTO 0);
TYPE LABE_2D	IS ARRAY(0 TO 127) OF STD_LOGIC_VECTOR(5 DOWNTO 0);

SIGNAL RANDH			:	STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL PAREDES_RAND	:	RAND_2D;
SIGNAL PAREDES_ALT	:	RAND_2D;
SIGNAL PAREDES_LABE	:	LABE_2D;

BEGIN
MANTIENERAND:PROCESS(CLK,MANTIENE)
BEGIN
	IF RISING_EDGE(CLK) THEN
		IF (MANTIENE='0') THEN
			RANDH	<= RAND;
		END IF;
	END IF;
END PROCESS;

PROCESS (ADDR, RANDH,PAREDES_RAND,PAREDES_ALT,PAREDES_LABE)
VARIABLE INDICE:	STD_LOGIC_VECTOR(6 DOWNTO 0);
BEGIN
	CASE ADDR(5 DOWNTO 4) IS
		WHEN "00" =>
				INDICE:="0" & RANDH(1 DOWNTO 0) & ADDR(3 DOWNTO 0);
				DATA <= PAREDES_RAND(TO_INTEGER(UNSIGNED(INDICE)));
		WHEN "01" =>
				INDICE:="0" & RANDH(3 DOWNTO 2) & ADDR(3 DOWNTO 0);
				DATA <= PAREDES_ALT(TO_INTEGER(UNSIGNED(INDICE)));
		WHEN "10" =>
				INDICE:="0" & RANDH(5 DOWNTO 4) & ADDR(3 DOWNTO 0);
				DATA <= PAREDES_RAND(TO_INTEGER(UNSIGNED(INDICE)));
		WHEN "11" =>
				INDICE:=RANDH(8 DOWNTO 6) & ADDR(3 DOWNTO 0);
				DATA <= PAREDES_LABE(TO_INTEGER(UNSIGNED(INDICE)));
	END CASE;
END PROCESS;

PAREDES_RAND(0) <= "101010";
PAREDES_RAND(1) <= "000000";
PAREDES_RAND(2) <= "010101";
PAREDES_RAND(3) <= "000000";
PAREDES_RAND(4) <= "101010";
PAREDES_RAND(5) <= "000000";
PAREDES_RAND(6) <= "010101";
PAREDES_RAND(7) <= "000000";
PAREDES_RAND(8) <= "101010";
PAREDES_RAND(9) <= "000000";
PAREDES_RAND(10) <= "010101";
PAREDES_RAND(11) <= "000000";
PAREDES_RAND(12) <= "101010";
PAREDES_RAND(13) <= "000000";
PAREDES_RAND(14) <= "000000";
PAREDES_RAND(15) <= "000000";

PAREDES_RAND(16) <= "010101";
PAREDES_RAND(17) <= "000000";
PAREDES_RAND(18) <= "101010";
PAREDES_RAND(19) <= "000000";
PAREDES_RAND(20) <= "010101";
PAREDES_RAND(21) <= "000000";
PAREDES_RAND(22) <= "101010";
PAREDES_RAND(23) <= "000000";
PAREDES_RAND(24) <= "010101";
PAREDES_RAND(25) <= "000000";
PAREDES_RAND(26) <= "101010";
PAREDES_RAND(27) <= "000000";
PAREDES_RAND(28) <= "010101";
PAREDES_RAND(29) <= "000000";
PAREDES_RAND(30) <= "000000";
PAREDES_RAND(31) <= "000000";

PAREDES_RAND(32) <= "101010";
PAREDES_RAND(33) <= "000000";
PAREDES_RAND(34) <= "000000";
PAREDES_RAND(35) <= "010101";
PAREDES_RAND(36) <= "000000";
PAREDES_RAND(37) <= "000000";
PAREDES_RAND(38) <= "101110";
PAREDES_RAND(39) <= "000000";
PAREDES_RAND(40) <= "000000";
PAREDES_RAND(41) <= "011011";
PAREDES_RAND(42) <= "000000";
PAREDES_RAND(43) <= "000000";
PAREDES_RAND(44) <= "010101";
PAREDES_RAND(45) <= "000000";
PAREDES_RAND(46) <= "000000";
PAREDES_RAND(47) <= "000000";

PAREDES_RAND(48) <= "010101";
PAREDES_RAND(49) <= "000000";
PAREDES_RAND(50) <= "000000";
PAREDES_RAND(51) <= "101010";
PAREDES_RAND(52) <= "000000";
PAREDES_RAND(53) <= "000000";
PAREDES_RAND(54) <= "111010";
PAREDES_RAND(55) <= "000000";
PAREDES_RAND(56) <= "000000";
PAREDES_RAND(57) <= "101101";
PAREDES_RAND(58) <= "000000";
PAREDES_RAND(59) <= "000000";
PAREDES_RAND(60) <= "101010";
PAREDES_RAND(61) <= "000000";
PAREDES_RAND(62) <= "000000";
PAREDES_RAND(63) <= "000000";

PAREDES_ALT(0) <= "011111";
PAREDES_ALT(1) <= "000000";
PAREDES_ALT(2) <= "000000";
PAREDES_ALT(3) <= "000000";
PAREDES_ALT(4) <= "111011";
PAREDES_ALT(5) <= "000000";
PAREDES_ALT(6) <= "000000";
PAREDES_ALT(7) <= "000000";
PAREDES_ALT(8) <= "011111";
PAREDES_ALT(9) <= "000000";
PAREDES_ALT(10) <= "000000";
PAREDES_ALT(11) <= "000000";
PAREDES_ALT(12) <= "111011";
PAREDES_ALT(13) <= "000000";
PAREDES_ALT(14) <= "000000";
PAREDES_ALT(15) <= "000000";

PAREDES_ALT(16) <= "110111";
PAREDES_ALT(17) <= "000000";
PAREDES_ALT(18) <= "000000";
PAREDES_ALT(19) <= "000000";
PAREDES_ALT(20) <= "111110";
PAREDES_ALT(21) <= "000000";
PAREDES_ALT(22) <= "000000";
PAREDES_ALT(23) <= "000000";
PAREDES_ALT(24) <= "110111";
PAREDES_ALT(25) <= "000000";
PAREDES_ALT(26) <= "000000";
PAREDES_ALT(27) <= "000000";
PAREDES_ALT(28) <= "111110";
PAREDES_ALT(29) <= "000000";
PAREDES_ALT(30) <= "000000";
PAREDES_ALT(31) <= "000000";

PAREDES_ALT(32) <= "111101";
PAREDES_ALT(33) <= "000000";
PAREDES_ALT(34) <= "000000";
PAREDES_ALT(35) <= "000000";
PAREDES_ALT(36) <= "101111";
PAREDES_ALT(37) <= "000000";
PAREDES_ALT(38) <= "000000";
PAREDES_ALT(39) <= "000000";
PAREDES_ALT(40) <= "111101";
PAREDES_ALT(41) <= "000000";
PAREDES_ALT(42) <= "000000";
PAREDES_ALT(43) <= "000000";
PAREDES_ALT(44) <= "101111";
PAREDES_ALT(45) <= "000000";
PAREDES_ALT(46) <= "000000";
PAREDES_ALT(47) <= "000000";

PAREDES_ALT(48) <= "111011";
PAREDES_ALT(49) <= "000000";
PAREDES_ALT(50) <= "000000";
PAREDES_ALT(51) <= "000000";
PAREDES_ALT(52) <= "101111";
PAREDES_ALT(53) <= "000000";
PAREDES_ALT(54) <= "000000";
PAREDES_ALT(55) <= "000000";
PAREDES_ALT(56) <= "111110";
PAREDES_ALT(57) <= "000000";
PAREDES_ALT(58) <= "000000";
PAREDES_ALT(59) <= "000000";
PAREDES_ALT(60) <= "111011";
PAREDES_ALT(61) <= "000000";
PAREDES_ALT(62) <= "000000";
PAREDES_ALT(63) <= "000000";

PAREDES_LABE(0) <= "011111";
PAREDES_LABE(1) <= "000000";
PAREDES_LABE(2) <= "101111";
PAREDES_LABE(3) <= "000000";
PAREDES_LABE(4) <= "110111";
PAREDES_LABE(5) <= "000000";
PAREDES_LABE(6) <= "111011";
PAREDES_LABE(7) <= "000000";
PAREDES_LABE(8) <= "111101";
PAREDES_LABE(9) <= "000000";
PAREDES_LABE(10) <= "111110";
PAREDES_LABE(11) <= "000000";
PAREDES_LABE(12) <= "011111";
PAREDES_LABE(13) <= "000000";
PAREDES_LABE(14) <= "101111";
PAREDES_LABE(15) <= "000000";

PAREDES_LABE(16) <= "111011";
PAREDES_LABE(17) <= "000000";
PAREDES_LABE(18) <= "110111";
PAREDES_LABE(19) <= "000000";
PAREDES_LABE(20) <= "101111";
PAREDES_LABE(21) <= "000000";
PAREDES_LABE(22) <= "011111";
PAREDES_LABE(23) <= "000000";
PAREDES_LABE(24) <= "111110";
PAREDES_LABE(25) <= "000000";
PAREDES_LABE(26) <= "111101";
PAREDES_LABE(27) <= "000000";
PAREDES_LABE(28) <= "111011";
PAREDES_LABE(29) <= "000000";
PAREDES_LABE(30) <= "110111";
PAREDES_LABE(31) <= "000000";

PAREDES_LABE(32) <= "110110";
PAREDES_LABE(33) <= "100100";
PAREDES_LABE(34) <= "101101";
PAREDES_LABE(35) <= "100100";
PAREDES_LABE(36) <= "110110";
PAREDES_LABE(37) <= "100100";
PAREDES_LABE(38) <= "101101";
PAREDES_LABE(39) <= "100100";
PAREDES_LABE(40) <= "110110";
PAREDES_LABE(41) <= "100100";
PAREDES_LABE(42) <= "101101";
PAREDES_LABE(43) <= "100100";
PAREDES_LABE(44) <= "110110";
PAREDES_LABE(45) <= "100100";
PAREDES_LABE(46) <= "101101";
PAREDES_LABE(47) <= "000000";

PAREDES_LABE(48) <= "101101";
PAREDES_LABE(49) <= "100100";
PAREDES_LABE(50) <= "110110";
PAREDES_LABE(51) <= "100100";
PAREDES_LABE(52) <= "101101";
PAREDES_LABE(53) <= "100100";
PAREDES_LABE(54) <= "110110";
PAREDES_LABE(55) <= "100100";
PAREDES_LABE(56) <= "101101";
PAREDES_LABE(57) <= "100100";
PAREDES_LABE(58) <= "110110";
PAREDES_LABE(59) <= "100100";
PAREDES_LABE(60) <= "101101";
PAREDES_LABE(61) <= "100100";
PAREDES_LABE(62) <= "110110";
PAREDES_LABE(63) <= "000000";

PAREDES_LABE(64) <= "110110";
PAREDES_LABE(65) <= "010010";
PAREDES_LABE(66) <= "001001";
PAREDES_LABE(67) <= "100100";
PAREDES_LABE(68) <= "010010";
PAREDES_LABE(69) <= "001001";
PAREDES_LABE(70) <= "100100";
PAREDES_LABE(71) <= "010010";
PAREDES_LABE(72) <= "001001";
PAREDES_LABE(73) <= "100100";
PAREDES_LABE(74) <= "010010";
PAREDES_LABE(75) <= "001001";
PAREDES_LABE(76) <= "100100";
PAREDES_LABE(77) <= "010010";
PAREDES_LABE(78) <= "001001";
PAREDES_LABE(79) <= "000000";


PAREDES_LABE(80) <= "011011";
PAREDES_LABE(81) <= "010010";
PAREDES_LABE(82) <= "100100";
PAREDES_LABE(83) <= "001001";
PAREDES_LABE(84) <= "010010";
PAREDES_LABE(85) <= "100100";
PAREDES_LABE(86) <= "001001";
PAREDES_LABE(87) <= "010010";
PAREDES_LABE(88) <= "100100";
PAREDES_LABE(89) <= "001001";
PAREDES_LABE(90) <= "010010";
PAREDES_LABE(91) <= "100100";
PAREDES_LABE(92) <= "001001";
PAREDES_LABE(93) <= "010010";
PAREDES_LABE(94) <= "100100";
PAREDES_LABE(95) <= "000000";


PAREDES_LABE(96) <= "101111";
PAREDES_LABE(97) <= "100000";
PAREDES_LABE(98) <= "100000";
PAREDES_LABE(99) <= "100000";
PAREDES_LABE(100) <= "100000";
PAREDES_LABE(101) <= "111110";
PAREDES_LABE(102) <= "100000";
PAREDES_LABE(103) <= "100000";
PAREDES_LABE(104) <= "100000";
PAREDES_LABE(105) <= "100000";
PAREDES_LABE(106) <= "101111";
PAREDES_LABE(107) <= "100000";
PAREDES_LABE(108) <= "100000";
PAREDES_LABE(109) <= "100000";
PAREDES_LABE(110) <= "111011";
PAREDES_LABE(111) <= "000000";

PAREDES_LABE(112) <= "100011";
PAREDES_LABE(113) <= "110111";
PAREDES_LABE(114) <= "000001";
PAREDES_LABE(115) <= "001001";
PAREDES_LABE(116) <= "011101";
PAREDES_LABE(117) <= "001001";
PAREDES_LABE(118) <= "000001";
PAREDES_LABE(119) <= "110111";
PAREDES_LABE(120) <= "000001";
PAREDES_LABE(121) <= "001001";
PAREDES_LABE(122) <= "011101";
PAREDES_LABE(123) <= "001001";
PAREDES_LABE(124) <= "000001";
PAREDES_LABE(125) <= "110111";
PAREDES_LABE(126) <= "000000";
PAREDES_LABE(127) <= "000000";


END ARCHITECTURE;