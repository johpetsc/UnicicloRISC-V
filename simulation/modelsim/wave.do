onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /processador_tb/i1/pc_out
add wave -noupdate -radix hexadecimal /processador_tb/i1/instruction
add wave -noupdate -radix unsigned /processador_tb/i1/rs1
add wave -noupdate -radix unsigned /processador_tb/i1/rs2
add wave -noupdate -radix unsigned /processador_tb/i1/rd
add wave -noupdate -radix hexadecimal /processador_tb/i1/imm_result
add wave -noupdate -radix hexadecimal /processador_tb/i1/breg_ula/r1
add wave -noupdate -radix hexadecimal /processador_tb/i1/breg_ula/res_mux
add wave -noupdate -radix hexadecimal /processador_tb/i1/ula_result
add wave -noupdate /processador_tb/i1/controle_alu_src
add wave -noupdate -radix hexadecimal /processador_tb/i1/memoria/dataout
add wave -noupdate -radix hexadecimal /processador_tb/i1/memoria/DataMux
add wave -noupdate -radix hexadecimal /processador_tb/i1/memoria/res
add wave -noupdate /processador_tb/i1/controle/RegWrite
add wave -noupdate -childformat {{/processador_tb/i1/breg_ula/xregs/reg(0) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(1) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(2) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(3) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(4) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(5) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(6) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(7) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(8) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(9) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(10) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(11) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(12) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(13) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(14) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(15) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(16) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(17) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(18) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(19) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(20) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(21) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(22) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(23) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(24) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(25) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(26) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(27) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(28) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(29) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(30) -radix hexadecimal} {/processador_tb/i1/breg_ula/xregs/reg(31) -radix hexadecimal}} -expand -subitemconfig {/processador_tb/i1/breg_ula/xregs/reg(0) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(1) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(2) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(3) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(4) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(5) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(6) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(7) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(8) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(9) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(10) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(11) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(12) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(13) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(14) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(15) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(16) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(17) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(18) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(19) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(20) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(21) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(22) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(23) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(24) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(25) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(26) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(27) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(28) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(29) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(30) {-height 15 -radix hexadecimal} /processador_tb/i1/breg_ula/xregs/reg(31) {-height 15 -radix hexadecimal}} /processador_tb/i1/breg_ula/xregs/reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {21 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 232
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {30 ps}
