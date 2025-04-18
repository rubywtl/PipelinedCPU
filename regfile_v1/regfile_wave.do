onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /regstim/ClockDelay
add wave -noupdate -label clk /regstim/clk
add wave -noupdate -label ReadReg1 -radix unsigned -radixshowbase 0 /regstim/ReadRegister1
add wave -noupdate -label ReadReg2 -radix unsigned -radixshowbase 0 /regstim/ReadRegister2
add wave -noupdate -label WriteReg -radix unsigned -radixshowbase 0 /regstim/WriteRegister
add wave -noupdate -label WriteData -radix unsigned -radixshowbase 0 /regstim/WriteData
add wave -noupdate -label RegWrite /regstim/RegWrite
add wave -noupdate -label ReadData1 -radix unsigned -radixshowbase 0 /regstim/ReadData1
add wave -noupdate -label ReadData2 -radix unsigned -radixshowbase 0 /regstim/ReadData2
add wave -noupdate -label i -expand /regstim/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16049633 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 406
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 2
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {554182604 ps}
