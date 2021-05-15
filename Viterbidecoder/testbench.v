//testbench for encoder and decoder
module test_bench;
  reg clk,res;
  wire ip;
  reg [15:0] data_input;
  wire [1:0] op;
  wire viterbi_decoder_op;
  reg [6:0] Nr;
initial
  begin
    clk=0;
    res=0;
    Nr=$dist_normal(9,0,9);
    data_input=16'b1101001100000000; //example inputs:0000000000000000 expected output: 0000000000000000 , input:1111111111111111 expected output:1111111111111111
    #10 res=1;
  end
always #5clk=~clk;
always @(posedge clk)
 	 if(res)
 	 begin
  	 data_input<={data_input[14:0],data_input[15]};
  	 end

assign  ip = data_input[15];
     
coder_ip dut(clk, res, ip, op, viterbi_decoder_op);
endmodule
//vierbi decoder for convolutional data rate 1/2.


