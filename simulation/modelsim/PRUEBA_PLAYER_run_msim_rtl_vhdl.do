transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {E:/Mega/Facultad/FPGA/SuperHexagon2/pckgs/HexaPackage.vhd}
vcom -93 -work work {E:/Mega/Facultad/FPGA/SuperHexagon2/rtl_src/SENOCOSENO.vhd}
vcom -93 -work work {E:/Mega/Facultad/FPGA/SuperHexagon2/rtl_src/LFSR_64.vhd}
vcom -93 -work work {E:/Mega/Facultad/FPGA/SuperHexagon2/rtl_src/JUEGO_FSM.vhd}
vcom -93 -work work {E:/Mega/Facultad/FPGA/SuperHexagon2/rtl_src/GENERADOR_PAREDES.vhd}
vcom -93 -work work {E:/Mega/Facultad/FPGA/SuperHexagon2/rtl_src/FF_D_RISING.vhd}
vcom -93 -work work {E:/Mega/Facultad/FPGA/SuperHexagon2/rtl_src/FF_AND.vhd}
vcom -93 -work work {E:/Mega/Facultad/FPGA/SuperHexagon2/rtl_src/DIFICULTAD.vhd}
vcom -93 -work work {E:/Mega/Facultad/FPGA/SuperHexagon2/rtl_src/CONV_HEXAGONAL.vhd}
vcom -93 -work work {E:/Mega/Facultad/FPGA/SuperHexagon2/rtl_src/CONTROL_GIRO.vhd}
vcom -93 -work work {E:/Mega/Facultad/FPGA/SuperHexagon2/rtl_src/CONTADOR.vhd}
vcom -93 -work work {E:/Mega/Facultad/FPGA/SuperHexagon2/rtl_src/CIRCULO.vhd}
vcom -93 -work work {E:/Mega/Facultad/FPGA/SuperHexagon2/rtl_src/ROTAR.vhd}
vcom -93 -work work {E:/Mega/Facultad/FPGA/SuperHexagon2/rtl_src/PRUEBA_PLAYER.vhd}
vcom -93 -work work {E:/Mega/Facultad/FPGA/SuperHexagon2/rtl_src/PAREDES.vhd}
vcom -93 -work work {E:/Mega/Facultad/FPGA/SuperHexagon2/rtl_src/JUGADOR.vhd}
vcom -93 -work work {E:/Mega/Facultad/FPGA/SuperHexagon2/rtl_src/DIBUJO.vhd}
vcom -93 -work work {E:/Mega/Facultad/FPGA/SuperHexagon2/rtl_src/DESPLAZAXYALCENTRO.vhd}
vcom -93 -work work {E:/Mega/Facultad/FPGA/SuperHexagon2/rtl_src/CONTROLADOR_VGA.vhd}

