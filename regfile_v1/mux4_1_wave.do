onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label i00 /mux4_1_testbench/i00
add wave -noupdate -label i01 /mux4_1_testbench/i01
add wave -noupdate -label i10 /mux4_1_testbench/i10
add wave -noupdate -label i11 /mux4_1_testbench/i11
add wave -noupdate -label sel0 /mux4_1_testbench/sel0
add wave -noupdate -label sel1 /mux4_1_testbench/sel1
add wave -noupdate -label out /mux4_1_testbench/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {1 ns}
