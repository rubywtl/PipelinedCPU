onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dec_5to32_testbench/out
add wave -noupdate /dec_5to32_testbench/in
add wave -noupdate /dec_5to32_testbench/write_enable
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {21517 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 210
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {7290 ps} {34353 ps}
