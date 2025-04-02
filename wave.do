onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {common signals} /fifo_tb/dut/clk_i
add wave -noupdate -expand -group {common signals} /fifo_tb/dut/rst_i
add wave -noupdate -expand -group {WRITE SIGNALS} /fifo_tb/dut/wr_en_i
add wave -noupdate -expand -group {WRITE SIGNALS} -radix unsigned /fifo_tb/dut/wdata_i
add wave -noupdate -expand -group {WRITE SIGNALS} /fifo_tb/dut/full_o
add wave -noupdate -expand -group {WRITE SIGNALS} /fifo_tb/dut/wr_error_o
add wave -noupdate -expand -group READ_SIGNALS /fifo_tb/dut/rd_en_i
add wave -noupdate -expand -group READ_SIGNALS -radix unsigned /fifo_tb/dut/rdata_o
add wave -noupdate -expand -group READ_SIGNALS /fifo_tb/dut/empty_o
add wave -noupdate -expand -group READ_SIGNALS /fifo_tb/dut/rd_error_o
add wave -noupdate -expand -group {INTERNAL SIGNALS} /fifo_tb/dut/rd_ptr
add wave -noupdate -expand -group {INTERNAL SIGNALS} /fifo_tb/dut/wr_tgl_f
add wave -noupdate -expand -group {INTERNAL SIGNALS} /fifo_tb/dut/rd_tgl_f
add wave -noupdate -expand -group {INTERNAL SIGNALS} /fifo_tb/dut/wr_ptr
add wave -noupdate -expand -group {INTERNAL SIGNALS} /fifo_tb/dut/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {83 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 164
configure wave -valuecolwidth 40
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
WaveRestoreZoom {0 ps} {299 ps}
