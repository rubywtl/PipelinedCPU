onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /register_testbench/write_data
add wave -noupdate /register_testbench/read_data
add wave -noupdate /register_testbench/clk
add wave -noupdate /register_testbench/write_enable
add wave -noupdate /register_testbench/reset
add wave -noupdate -expand -group {dffr[0]} {/register_testbench/register/dff[0]/dff_inst/q}
add wave -noupdate -expand -group {dffr[0]} {/register_testbench/register/dff[0]/dff_inst/d}
add wave -noupdate -expand -group {dffr[0]} {/register_testbench/register/dff[0]/dff_inst/reset}
add wave -noupdate -expand -group {dffr[0]} {/register_testbench/register/dff[0]/not_en}
add wave -noupdate -expand -group {dffr[0]} {/register_testbench/register/dff[0]/left}
add wave -noupdate -expand -group {dffr[0]} {/register_testbench/register/dff[0]/right}
add wave -noupdate -expand -group {dffr[0]} {/register_testbench/register/dff[0]/result}
add wave -noupdate -group {dffr[63]} {/register_testbench/register/dff[62]/dff_inst/q}
add wave -noupdate -group {dffr[63]} {/register_testbench/register/dff[62]/dff_inst/d}
add wave -noupdate -group {dffr[63]} {/register_testbench/register/dff[62]/dff_inst/reset}
add wave -noupdate -group {dffr[63]} {/register_testbench/register/dff[62]/dff_inst/clk}
add wave -noupdate -group {dffr[63]} {/register_testbench/register/dff[63]/not_en}
add wave -noupdate -group {dffr[63]} {/register_testbench/register/dff[63]/left}
add wave -noupdate -group {dffr[63]} {/register_testbench/register/dff[63]/right}
add wave -noupdate -group {dffr[63]} {/register_testbench/register/dff[63]/result}
add wave -noupdate -group {dffr[62]} {/register_testbench/register/dff[62]/dff_inst/q}
add wave -noupdate -group {dffr[62]} {/register_testbench/register/dff[62]/dff_inst/d}
add wave -noupdate -group {dffr[62]} {/register_testbench/register/dff[62]/dff_inst/reset}
add wave -noupdate -group {dffr[62]} {/register_testbench/register/dff[62]/dff_inst/clk}
add wave -noupdate -group {dffr[62]} {/register_testbench/register/dff[62]/not_en}
add wave -noupdate -group {dffr[62]} {/register_testbench/register/dff[62]/left}
add wave -noupdate -group {dffr[62]} {/register_testbench/register/dff[62]/right}
add wave -noupdate -group {dffr[62]} {/register_testbench/register/dff[62]/result}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {814 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 82
configure wave -valuecolwidth 188
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
WaveRestoreZoom {0 ps} {3504 ps}
