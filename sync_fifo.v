//sync fifo
			

//sync fifo
module sync_fifo(clk_i,rst_i,wdata_i,rdata_o,wr_en_i,rd_en_i,full_o,empty_o,wr_error_o,rd_error_o);
parameter WIDTH=8;
parameter DEPTH=16;
parameter PTR_WIDTH=$clog2(DEPTH);

input clk_i,rst_i,wr_en_i,rd_en_i;
input [WIDTH-1:0]wdata_i;
output reg full_o,empty_o,wr_error_o,rd_error_o;
output reg [WIDTH-1:0]rdata_o;

//internal registers
reg [PTR_WIDTH-1:0]wr_ptr,rd_ptr;
reg wr_tgl_f,rd_tgl_f;

reg [WIDTH-1:0]mem[DEPTH-1:0];   		//buffer or memory

integer  i;

//write operation
always@(posedge clk_i)begin 
	if(rst_i)begin   					//rst =1 rest all the write related signals

		wr_error_o=0;
		full_o=0;
		wr_ptr=0;
		wr_tgl_f=0;
		for(i=0;i<DEPTH;i=i+1)mem[i]=0;
	end
	else begin 
		if(wr_en_i==1)begin 				//write operation start
			if(full_o==1)begin 					//bank is full
					wr_error_o=0;
			end
			else begin 						//bank is not full //WRITE operation is perform
					mem[wr_ptr]=wdata_i;		//wr_ptr indicates that where to write   
					if wr_ptr==DEPTH-1)begin 
							wr_ptr=0;			//dont write
							wr_tgl_f=~wr_tgl_f;
					end
					else 
						wr_ptr=wr_ptr+1;
			end
		end
	end
end
//read operation
always@(posedge clk_i)begin 			//work on positive edge clk
	if(rst_i==1)begin 					//reset read related signal
			empty_o=1;					//fifo is empty	
			rd_error_o=0;
			rdata_o=0;
			rd_ptr=0;
			rd_tgl_f=0;
	end
	else begin 
		if(rd_en_i==1)begin 			//rd_en is 1 the should start read operation	
			if(empty_o==1)begin 			//status of FIFO i.e fifo is empty
				rd_error_o=0;					//FIFO is empty still try to read then result rd_error  
			end
			else begin 					//FIFO is not empty nor full so it has some data
				rdata_o=mem[rd_ptr];		//from  (buffer) mem of rd_ptr collect the data and store in rdata
				if(rd_ptr==DEPTH-1)begin
					rd_ptr=0;
					rd_tgl_f=~rd_tgl_f;
				end
				else 
					rd_ptr=rd_ptr+1;
			end
					
		end
	end
end

//full and empty senario
always@(*)begin 						//full_o=0,empty_o=1  //full is the the the fifo is full , empty is one then fifo is empty
//full_o=0,empty_o=1;
	if(wr_ptr==rd_ptr && wr_tgl_f==rd_tgl_f) empty_o=1;				 //fifo is empty
	else empty_o=0;				 //fifo is not empty
	if(wr_ptr==rd_ptr && wr_tgl_f!=rd_tgl_f) full_o=1;				//fifo is full
	else full_o=0;		 //fifo is not full


end

endmodule

