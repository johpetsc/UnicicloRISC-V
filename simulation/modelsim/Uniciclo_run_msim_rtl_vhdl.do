transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/bitte/Prog/UnicicloRISC-V/genImm32.vhd}
vcom -93 -work work {C:/Users/bitte/Prog/UnicicloRISC-V/memoriaIns.vhd}
vcom -93 -work work {C:/Users/bitte/Prog/UnicicloRISC-V/memoriaDados.vhd}
vcom -93 -work work {C:/Users/bitte/Prog/UnicicloRISC-V/riscv_pkg.vhd}
vcom -93 -work work {C:/Users/bitte/Prog/UnicicloRISC-V/ula.vhd}
vcom -93 -work work {C:/Users/bitte/Prog/UnicicloRISC-V/xregs.vhd}
vcom -93 -work work {C:/Users/bitte/Prog/UnicicloRISC-V/mux.vhd}
vcom -93 -work work {C:/Users/bitte/Prog/UnicicloRISC-V/somador.vhd}
vcom -93 -work work {C:/Users/bitte/Prog/UnicicloRISC-V/controle.vhd}
vcom -93 -work work {C:/Users/bitte/Prog/UnicicloRISC-V/controleULA.vhd}
vcom -93 -work work {C:/Users/bitte/Prog/UnicicloRISC-V/pc.vhd}
vcom -93 -work work {C:/Users/bitte/Prog/UnicicloRISC-V/fetch.vhd}
vcom -93 -work work {C:/Users/bitte/Prog/UnicicloRISC-V/breg_ula.vhd}
vcom -93 -work work {C:/Users/bitte/Prog/UnicicloRISC-V/memoria.vhd}
vcom -93 -work work {C:/Users/bitte/Prog/UnicicloRISC-V/processador.vhd}

vcom -93 -work work {C:/Users/bitte/Prog/UnicicloRISC-V/processador_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneii -L rtl_work -L work -voptargs="+acc"  processador_tb

add wave *
view structure
view signals
run 40 ps