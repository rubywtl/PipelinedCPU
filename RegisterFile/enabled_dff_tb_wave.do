onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /enabled_dff_tb/clock_period
add wave -noupdate /enabled_dff_tb/q
add wave -noupdate /enabled_dff_tb/d
add wave -noupdate /enabled_dff_tb/reset
add wave -noupdate /enabled_dff_tb/clk
add wave -noupdate /enabled_dff_tb/en
add wave -noupdate -expand -group dff /enabled_dff_tb/dut/dff_inst/q
add wave -noupdate -expand -group dff /enabled_dff_tb/dut/dff_inst/d
add wave -noupdate -expand -group dff /enabled_dff_tb/dut/dff_inst/reset
add wave -noupdate -expand -group dff /enabled_dff_tb/dut/dff_inst/clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4000000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {16384 ns}
