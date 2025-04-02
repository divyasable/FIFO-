/*`include "sync_fifo.v"

module fifo_tb();
parameter WIDTH=8;
parameter DEPTH=16;
parameter PTR_WIDTH=$clog2(DEPTH);
parameter N=8;

reg clk_i,rst_i,wr_en_i,rd_en_i;
reg [WIDTH-1:0]wdata_i;
wire full_o,empty_o,wr_error_o,rd_error_o;
wire [WIDTH-1:0]rdata_o;

reg [8*30:1]testcase;

sync_fifo #(WIDTH,DEPTH,PTR_WIDTH)dut(.*);

always #5 clk_i=~clk_i;       

initial begin
	clk_i=0;     //initialy clk is 0, then according to always/time period it will toggle
	rst_i=1;    //initialy reset is 1
	rst_logic(); //task call
	repeat(2)@(posedge clk_i);   //till 2 positive edge clk cycle my reset will be high 
	rst_i=0;
   	$value$plusargs("testcase=%0s",testcase);
		$display("testcase=%0s", testcase);
	case (testcase)
"ALL_WRITES":begin 
				write_logic(DEPTH);
			end
			"ALL_WRITES_ALL_READS":begin 
				write_logic(DEPTH);
				read_logic(DEPTH);
			end
			"N_WRITES_N_READS":begin 
				write_logic(N);
				read_logic(N);
			end
			"WRITE_ERROR":begin 
				write_logic(DEPTH+1);
			end
			"READ_ERROR":begin 
				write_logic(DEPTH);
				read_logic(DEPTH+1);
			end
			"CONCURRENT_WRITE_READS":begin 
				fork 
					write_logic(DEPTH);
					read_logic(DEPTH);
				join
			end
	endcase

	#100;
	$finish;
end
task rst_logic();
begin
	wdata_i=0;
	wr_en_i=0;
	rd_en_i=0;
end
endtask

task write_logic(input reg[PTR_WIDTH:0]num_writes);
integer i;
begin
		for(i=0;i<num_writes;i=i+1)begin   //16 writes
			@(posedge clk_i);
			wr_en_i=1;
	    	wdata_i=$random;
		end
			@(posedge clk_i);
			rst_logic();
end
endtask

task read_logic(input reg[PTR_WIDTH:0]num_reads );
integer i;
begin
		for(i=0;i<num_reads;i=i+1)begin //16 reads	
			@(posedge clk_i);	
			rd_en_i=1;
		end
			@(posedge clk_i);
			rst_logic();

end
endtask

endmodule

*/
`include "sync_fifo.v"
module fifo_tb();
parameter WIDTH=8;
parameter DEPTH=16;
parameter PTR_WIDTH=$clog2(DEPTH);
parameter N=18;
reg clk_i,rst_i,wr_en_i,rd_en_i;
reg [WIDTH-1:0]wdata_i;
wire full_o,empty_o,wr_error_o,rd_error_o;
wire [WIDTH-1:0]rdata_o;

reg [8*30:1]testcase;
sync_fifo #(WIDTH,DEPTH,PTR_WIDTH)dut(.*);

always #5 clk_i=~clk_i;

initial begin
	clk_i=0;
	rst_i=1;
	rst_logic();
	repeat(2)@(posedge clk_i);
	rst_i=0;
	$value$plusargs("testcase=%0s",testcase);
	$display("testcase=%0s",testcase);
	case(testcase)
			"ALL_WRITES":begin 
				write_logic(DEPTH);
			end
			"ALL_WRITES_ALL_READS":begin 
				write_logic(DEPTH);
				read_logic(DEPTH);
			end
			"N_WRITES_N_READS":begin 
				write_logic(N);
				read_logic(N);
			end
			"WRITE_ERROR":begin 
				write_logic(DEPTH+1);
			end
			"READ_ERROR":begin 
				write_logic(DEPTH);
				read_logic(DEPTH+1);
			end
			"CONCURRENT_WRITE_READS":begin 
				fork 
					write_logic(DEPTH);
					read_logic(DEPTH);
				join
			end
	endcase

	#100;
	$finish;

end
task rst_logic();
begin 
	wdata_i=0;
	wr_en_i=0;
	rd_en_i=0;
end
endtask

task write_logic(input reg[PTR_WIDTH:0]num_writes);
integer i;
begin 
	for(i=0;i<num_writes;i=i+1)begin
		@(posedge clk_i);
		wr_en_i=1;
		wdata_i=$random;
	end
		@(posedge clk_i);
		rst_logic();
end
endtask
task read_logic(input reg [PTR_WIDTH:0]num_reads);
integer i;
begin 
	for(i=0;i<num_reads;i=i+1)begin
		@(posedge clk_i);
		rd_en_i=1;
	end
		@(posedge clk_i);
		rst_logic();
end
endtask
endmodule

