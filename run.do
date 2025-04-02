vlib work
vlog sync_fifo_tb.v
vsim fifo_tb +testcase=CONCURRENT_WRITE_READS
#add wave -r sim:/fifo_tb/dut/*
do wave.do
run -all
