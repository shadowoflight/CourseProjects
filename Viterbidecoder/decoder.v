//Please copy the code as it is to avoid unnecessary tabs and white-spaces. The code is adjusted in
this file in such a way that once copied and pasted in modelsim the spaces and works fine.

//Verilog code for viterbi decoder (with testbench).

//module for instantiating con_encoder and vierbi_decoder_op
module coder_ip(clk, res, ip, op, viterbi_decoder_op);
input clk, res;
input ip;
output [1:0] op;
output viterbi_decoder_op;
convolutional_encoder enco(clk, res, ip, op);
viterbi_decoder_new deco(clk, res, op, viterbi_decoder_op );
endmodule
//module for encoding in put data by convolutional method
module convolutional_encoder(clk, res, ip, op );
input clk,res;
input ip;
output [1:0]op;
reg delay;
wire [1:0] delay2;
reg [1:0] op;
reg [4:0] regi;
reg en;
parameter s0=5&#39;b11101,s1=5&#39;b10011; //polynomial expression for constraint 5
always @(posedge clk or negedge res)
if(!res)
delay &lt;=1&#39;b0;
else
delay &lt;=ip;
always @(posedge clk or negedge res)
if(!res)
op&lt;=2&#39;b0;
else
op&lt;=delay2;
always @(posedge clk or negedge res)
if(!res)
regi &lt;= 5&#39;b0;
else
regi&lt;= {regi[3:0],delay};
assign delay2[0] = regi[4]&amp;s0[4]^regi[3]&amp;s0[3]^regi[2]&amp;s0[2]^regi[1]&amp;s0[1]^regi[0]&amp;s0[0]; //output
assign delay2[1] = regi[4]&amp;s1[4]^regi[3]&amp;s1[3]^regi[2]&amp;s1[2]^regi[1]&amp;s1[1]^regi[0]&amp;s1[0]; //output
endmodule

//module for inputing encoded data and tracing back address
module read_data(clk, res, sequence,code_enco,viterbi_decoder_op);

input clk, res, sequence;
input code_enco;
output viterbi_decoder_op;
parameter L=7;
reg sq,read;
reg [5:0] address;
reg [L:0] out_data_reg;
wire delay2;
reg viterbi_decoder_op;
always @(posedge clk or negedge res)
if(!res)
address &lt;= 0;
else if(code_enco &amp;&amp;(sq==0&amp;&amp;address==L))
address &lt;= L;
else if(code_enco &amp;&amp; (sq==1&amp;&amp;address==0))
address &lt;= 0;
else if(code_enco &amp;&amp; sq==0)
address &lt;=address+1&#39;b1;
else if(code_enco &amp;&amp; sq==1)
address &lt;=address-1&#39;b1;
always @(posedge clk or negedge res)
if(!res)
sq &lt;=0;
else if((sq==0 &amp;&amp; address==L)||(sq==1 &amp;&amp; address==0))
sq &lt;= ~sq;
always @(posedge clk or negedge res)
if(!res)
out_data_reg &lt;= 16&#39;b0;
else
out_data_reg[address] &lt;= sequence;
always @(posedge clk or negedge res)
if(!res)
read &lt;= 1&#39;b0;
else if (address==L)
read &lt;= 1&#39;b1;
assign delay2 = (read)?out_data_reg[address]:1&#39;bx;
always @(posedge clk or negedge res)
if(!res)
viterbi_decoder_op &lt;= 1&#39;b0;
else
viterbi_decoder_op &lt;= delay2;
endmodule

//module for decoding the encoded data {BMU,PMU,SMU -traceback}
module viterbi_decoder_new(clk, res, input_code,viterbi_decoder_op);
input clk,res;
input [1:0]input_code; //encoded data

output viterbi_decoder_op; //decoded output
parameter s0=5&#39;b11101,s1=5&#39;b10011,L=6&#39;d7; //polynomial for constraint=5;
wire sequence;
reg [3:0]M[0:15]; //metric declaration
reg [3:0]S_ip[0:15];
wire [3:0]M0[0:15];
wire [3:0]M1[0:15];
reg [L:0]D[0:15];
reg [3:0] s_out;
wire [7:0] state0,state1,state2,state3,state4,state5,state6;
wire [7:0] state7,state8,state9,state10,state11,state12,state13;
wire [3:0] state;
reg [5:0] code_depth;
reg code_enco;
reg depth;
wire out_en;
always @(posedge clk or negedge res)
if(!res)
code_depth&lt;=6&#39;d0;
else if(depth==1&#39;b0&amp;&amp;code_depth==L)
code_depth&lt;=L;
else if(depth==1&#39;b1&amp;&amp;code_depth==6&#39;d0)
code_depth&lt;=6&#39;d0;
else if(depth==1&#39;b0)
code_depth&lt;=code_depth+1&#39;b1;
else
code_depth&lt;=code_depth-1&#39;b1;
//metrics determination
assign M0[0]=S_ip[0]+(input_code[0]^(0&amp;s0[0]^
0&amp;s0[1]^0&amp;s0[2]^0&amp;s0[3]^0&amp;s0[4]))+(input_code[1]^(0&amp;s1[0]^ 0&amp;s1[1]^0&amp;s1[2]^0&amp;s1[3]^0&amp;s1[4]));
assign
M1[0]=S_ip[8]+(input_code[0]^(0&amp;s0[0]^0&amp;s0[1]^0&amp;s0[2]^0&amp;s0[3]^1&amp;s0[4]))+(input_code[1]^(0&amp;s1[
0]^ 0&amp;s1[1]^0&amp;s1[2]^0&amp;s1[3]^1&amp;s1[4]));
assign M0[1]=S_ip[0]+(input_code[0]^(1&amp;s0[0]^
0&amp;s0[1]^0&amp;s0[2]^0&amp;s0[3]^0&amp;s0[4]))+(input_code[1]^(1&amp;s1[0]^ 0&amp;s1[1]^0&amp;s1[2]^0&amp;s1[3]^0&amp;s1[4]));
assign
M1[1]=S_ip[8]+(input_code[0]^(1&amp;s0[0]^0&amp;s0[1]^0&amp;s0[2]^0&amp;s0[3]^1&amp;s0[4]))+(input_code[1]^(1&amp;s1[
0]^ 0&amp;s1[1]^0&amp;s1[2]^0&amp;s1[3]^1&amp;s1[4]));
assign M0[2]=S_ip[1]+(input_code[0]^(0&amp;s0[0]^
1&amp;s0[1]^0&amp;s0[2]^0&amp;s0[3]^0&amp;s0[4]))+(input_code[1]^(0&amp;s1[0]^ 1&amp;s1[1]^0&amp;s1[2]^0&amp;s1[3]^0&amp;s1[4]));
assign
M1[2]=S_ip[9]+(input_code[0]^(0&amp;s0[0]^1&amp;s0[1]^0&amp;s0[2]^0&amp;s0[3]^1&amp;s0[4]))+(input_code[1]^(0&amp;s1[
0]^ 1&amp;s1[1]^0&amp;s1[2]^0&amp;s1[3]^1&amp;s1[4]));
assign M0[3]=S_ip[1]+(input_code[0]^(1&amp;s0[0]^
1&amp;s0[1]^0&amp;s0[2]^0&amp;s0[3]^0&amp;s0[4]))+(input_code[1]^(1&amp;s1[0]^ 1&amp;s1[1]^0&amp;s1[2]^0&amp;s1[3]^0&amp;s1[4]));
assign
M1[3]=S_ip[9]+(input_code[0]^(1&amp;s0[0]^1&amp;s0[1]^0&amp;s0[2]^0&amp;s0[3]^1&amp;s0[4]))+(input_code[1]^(1&amp;s1[
0]^ 1&amp;s1[1]^0&amp;s1[2]^0&amp;s1[3]^1&amp;s1[4]));
assign M0[4]=S_ip[2]+(input_code[0]^(0&amp;s0[0]^
0&amp;s0[1]^1&amp;s0[2]^0&amp;s0[3]^0&amp;s0[4]))+(input_code[1]^(0&amp;s1[0]^ 0&amp;s1[1]^1&amp;s1[2]^0&amp;s1[3]^0&amp;s1[4]));

assign
M1[4]=S_ip[10]+(input_code[0]^(0&amp;s0[0]^0&amp;s0[1]^1&amp;s0[2]^0&amp;s0[3]^1&amp;s0[4]))+(input_code[1]^(0&amp;s
1[0]^ 0&amp;s1[1]^1&amp;s1[2]^0&amp;s1[3]^1&amp;s1[4]));
assign M0[5]=S_ip[2]+(input_code[0]^(1&amp;s0[0]^
0&amp;s0[1]^1&amp;s0[2]^0&amp;s0[3]^0&amp;s0[4]))+(input_code[1]^(1&amp;s1[0]^ 0&amp;s1[1]^1&amp;s1[2]^0&amp;s1[3]^0&amp;s1[4]));
assign
M1[5]=S_ip[10]+(input_code[0]^(1&amp;s0[0]^0&amp;s0[1]^1&amp;s0[2]^0&amp;s0[3]^1&amp;s0[4]))+(input_code[1]^(1&amp;s
1[0]^ 0&amp;s1[1]^1&amp;s1[2]^0&amp;s1[3]^1&amp;s1[4]));
assign M0[6]=S_ip[3]+(input_code[0]^(0&amp;s0[0]^
1&amp;s0[1]^1&amp;s0[2]^0&amp;s0[3]^0&amp;s0[4]))+(input_code[1]^(0&amp;s1[0]^ 1&amp;s1[1]^1&amp;s1[2]^0&amp;s1[3]^0&amp;s1[4]));
assign
M1[6]=S_ip[11]+(input_code[0]^(0&amp;s0[0]^1&amp;s0[1]^1&amp;s0[2]^0&amp;s0[3]^1&amp;s0[4]))+(input_code[1]^(0&amp;s
1[0]^ 1&amp;s1[1]^1&amp;s1[2]^0&amp;s1[3]^1&amp;s1[4]));
assign M0[7]=S_ip[3]+(input_code[0]^(1&amp;s0[0]^
1&amp;s0[1]^1&amp;s0[2]^0&amp;s0[3]^0&amp;s0[4]))+(input_code[1]^(1&amp;s1[0]^ 1&amp;s1[1]^1&amp;s1[2]^0&amp;s1[3]^0&amp;s1[4]));
assign
M1[7]=S_ip[11]+(input_code[0]^(1&amp;s0[0]^1&amp;s0[1]^1&amp;s0[2]^0&amp;s0[3]^1&amp;s0[4]))+(input_code[1]^(1&amp;s
1[0]^ 1&amp;s1[1]^1&amp;s1[2]^0&amp;s1[3]^1&amp;s1[4]));
assign M0[8]=S_ip[4]+(input_code[0]^(0&amp;s0[0]^
0&amp;s0[1]^0&amp;s0[2]^1&amp;s0[3]^0&amp;s0[4]))+(input_code[1]^(0&amp;s1[0]^ 0&amp;s1[1]^0&amp;s1[2]^1&amp;s1[3]^0&amp;s1[4]));
assign
M1[8]=S_ip[12]+(input_code[0]^(0&amp;s0[0]^0&amp;s0[1]^0&amp;s0[2]^1&amp;s0[3]^1&amp;s0[4]))+(input_code[1]^(0&amp;s
1[0]^ 0&amp;s1[1]^0&amp;s1[2]^1&amp;s1[3]^1&amp;s1[4]));
assign M0[9]=S_ip[4]+(input_code[0]^(1&amp;s0[0]^
0&amp;s0[1]^0&amp;s0[2]^1&amp;s0[3]^0&amp;s0[4]))+(input_code[1]^(1&amp;s1[0]^ 0&amp;s1[1]^0&amp;s1[2]^1&amp;s1[3]^0&amp;s1[4]));
assign
M1[9]=S_ip[12]+(input_code[0]^(1&amp;s0[0]^0&amp;s0[1]^0&amp;s0[2]^1&amp;s0[3]^1&amp;s0[4]))+(input_code[1]^(1&amp;s
1[0]^ 0&amp;s1[1]^0&amp;s1[2]^1&amp;s1[3]^1&amp;s1[4]));
assign M0[10]=S_ip[5]+(input_code[0]^(0&amp;s0[0]^
1&amp;s0[1]^0&amp;s0[2]^1&amp;s0[3]^0&amp;s0[4]))+(input_code[1]^(0&amp;s1[0]^ 1&amp;s1[1]^0&amp;s1[2]^1&amp;s1[3]^0&amp;s1[4]));
assign
M1[10]=S_ip[13]+(input_code[0]^(0&amp;s0[0]^1&amp;s0[1]^0&amp;s0[2]^1&amp;s0[3]^1&amp;s0[4]))+(input_code[1]^(0&amp;
s1[0]^ 1&amp;s1[1]^0&amp;s1[2]^1&amp;s1[3]^1&amp;s1[4]));
assign M0[11]=S_ip[5]+(input_code[0]^(1&amp;s0[0]^
1&amp;s0[1]^0&amp;s0[2]^1&amp;s0[3]^0&amp;s0[4]))+(input_code[1]^(1&amp;s1[0]^ 1&amp;s1[1]^0&amp;s1[2]^1&amp;s1[3]^0&amp;s1[4]));
assign
M1[11]=S_ip[13]+(input_code[0]^(1&amp;s0[0]^1&amp;s0[1]^0&amp;s0[2]^1&amp;s0[3]^1&amp;s0[4]))+(input_code[1]^(1&amp;
s1[0]^ 1&amp;s1[1]^0&amp;s1[2]^1&amp;s1[3]^1&amp;s1[4]));
assign M0[12]=S_ip[6]+(input_code[0]^(0&amp;s0[0]^
0&amp;s0[1]^1&amp;s0[2]^1&amp;s0[3]^0&amp;s0[4]))+(input_code[1]^(0&amp;s1[0]^ 0&amp;s1[1]^1&amp;s1[2]^1&amp;s1[3]^0&amp;s1[4]));
assign
M1[12]=S_ip[14]+(input_code[0]^(0&amp;s0[0]^0&amp;s0[1]^1&amp;s0[2]^1&amp;s0[3]^1&amp;s0[4]))+(input_code[1]^(0&amp;
s1[0]^ 0&amp;s1[1]^1&amp;s1[2]^1&amp;s1[3]^1&amp;s1[4]));
assign M0[13]=S_ip[6]+(input_code[0]^(1&amp;s0[0]^
0&amp;s0[1]^1&amp;s0[2]^1&amp;s0[3]^0&amp;s0[4]))+(input_code[1]^(1&amp;s1[0]^ 0&amp;s1[1]^1&amp;s1[2]^1&amp;s1[3]^0&amp;s1[4]));
assign
M1[13]=S_ip[14]+(input_code[0]^(1&amp;s0[0]^0&amp;s0[1]^1&amp;s0[2]^1&amp;s0[3]^1&amp;s0[4]))+(input_code[1]^(1&amp;
s1[0]^ 0&amp;s1[1]^1&amp;s1[2]^1&amp;s1[3]^1&amp;s1[4]));

assign M0[14]=S_ip[7]+(input_code[0]^(0&amp;s0[0]^
1&amp;s0[1]^1&amp;s0[2]^1&amp;s0[3]^0&amp;s0[4]))+(input_code[1]^(0&amp;s1[0]^ 1&amp;s1[1]^1&amp;s1[2]^1&amp;s1[3]^0&amp;s1[4]));
assign
M1[14]=S_ip[15]+(input_code[0]^(0&amp;s0[0]^1&amp;s0[1]^1&amp;s0[2]^1&amp;s0[3]^1&amp;s0[4]))+(input_code[1]^(0&amp;
s1[0]^ 1&amp;s1[1]^1&amp;s1[2]^1&amp;s1[3]^1&amp;s1[4]));
assign M0[15]=S_ip[7]+(input_code[0]^(1&amp;s0[0]^
1&amp;s0[1]^1&amp;s0[2]^1&amp;s0[3]^0&amp;s0[4]))+(input_code[1]^(1&amp;s1[0]^ 1&amp;s1[1]^1&amp;s1[2]^1&amp;s1[3]^0&amp;s1[4]));
assign
M1[15]=S_ip[15]+(input_code[0]^(1&amp;s0[0]^1&amp;s0[1]^1&amp;s0[2]^1&amp;s0[3]^1&amp;s0[4]))+(input_code[1]^(1&amp;
s1[0]^ 1&amp;s1[1]^1&amp;s1[2]^1&amp;s1[3]^1&amp;s1[4]));
always @(posedge clk)
if(res)
begin
D[0][code_depth] &lt;= (M0[0]&lt;=M1[0])?0:1;
D[1][code_depth] &lt;= (M0[1]&lt;=M1[1])?0:1;
D[2][code_depth] &lt;= (M0[2]&lt;=M1[2])?0:1;
D[3][code_depth] &lt;= (M0[3]&lt;=M1[3])?0:1;
D[4][code_depth] &lt;= (M0[4]&lt;=M1[4])?0:1;
D[5][code_depth] &lt;= (M0[2]&lt;=M1[5])?0:1;
D[6][code_depth] &lt;= (M0[6]&lt;=M1[6])?0:1;
D[7][code_depth] &lt;= (M0[7]&lt;=M1[7])?0:1;
D[8][code_depth] &lt;= (M0[8]&lt;=M1[8])?0:1;
D[9][code_depth] &lt;= (M0[9]&lt;=M1[9])?0:1;
D[10][code_depth]&lt;= (M0[10]&lt;=M1[10])?0:1;
D[11][code_depth]&lt;= (M0[11]&lt;=M1[11])?0:1;
D[12][code_depth]&lt;= (M0[12]&lt;=M1[12])?0:1;
D[13][code_depth]&lt;= (M0[13]&lt;=M1[13])?0:1;
D[14][code_depth]&lt;= (M0[14]&lt;=M1[14])?0:1;
D[15][code_depth]&lt;= (M0[15]&lt;=M1[15])?0:1;
end
always @(posedge clk or negedge res)
if(!res)
begin
S_ip[0] &lt;= 8&#39;b0;
S_ip[1] &lt;= 8&#39;b0;
S_ip[2] &lt;= 8&#39;b0;
S_ip[3] &lt;= 8&#39;b0;
S_ip[4] &lt;= 8&#39;b0;
S_ip[5] &lt;= 8&#39;b0;
S_ip[6] &lt;= 8&#39;b0;
S_ip[7] &lt;= 8&#39;b0;
S_ip[8] &lt;= 8&#39;b0;
S_ip[9] &lt;= 8&#39;b0;
S_ip[10]&lt;= 8&#39;b0;
S_ip[11]&lt;= 8&#39;b0;
S_ip[12]&lt;= 8&#39;b0;
S_ip[13]&lt;= 8&#39;b0;
S_ip[14]&lt;= 8&#39;b0;
S_ip[15]&lt;= 8&#39;b0;
end
else
begin
S_ip[0] &lt;= (M0[0]&lt;=M1[0])?M0[0]:M1[0]; //determination of smallest path metric at each stage

S_ip[1] &lt;= (M0[1]&lt;=M1[1])?M0[1]:M1[1];
S_ip[2] &lt;= (M0[2]&lt;=M1[2])?M0[2]:M1[2];
S_ip[3] &lt;= (M0[3]&lt;=M1[3])?M0[3]:M1[3];
S_ip[4] &lt;= (M0[4]&lt;=M1[4])?M0[4]:M1[4];
S_ip[5] &lt;= (M0[5]&lt;=M1[5])?M0[5]:M1[5];
S_ip[6] &lt;= (M0[6]&lt;=M1[6])?M0[6]:M1[6];
S_ip[7] &lt;= (M0[7]&lt;=M1[7])?M0[7]:M1[7];
S_ip[8] &lt;= (M0[8]&lt;=M1[8])?M0[8]:M1[8];
S_ip[9] &lt;= (M0[9]&lt;=M1[9])?M0[9]:M1[9];
S_ip[10]&lt;= (M0[10]&lt;=M1[10])?M0[10]:M1[10];
S_ip[11]&lt;= (M0[11]&lt;=M1[11])?M0[11]:M1[11];
S_ip[12]&lt;= (M0[12]&lt;=M1[12])?M0[12]:M1[12];
S_ip[13]&lt;= (M0[13]&lt;=M1[13])?M0[13]:M1[13];
S_ip[14]&lt;= (M0[14]&lt;=M1[14])?M0[14]:M1[14];
S_ip[15]&lt;= (M0[15]&lt;=M1[15])?M0[15]:M1[15];
end
always @(posedge clk or negedge res)
if(!res)
depth &lt;= 1&#39;b0;
else if((depth==1&#39;b0&amp;&amp;code_depth==L)||(depth==1&#39;b1&amp;&amp;code_depth==0))
depth &lt;= ~depth;
assign state0 = (S_ip[0]&lt;S_ip[1])?{S_ip[0],4&#39;d0}:{S_ip[1],4&#39;d1};
assign state1 = (S_ip[2]&lt;S_ip[3])?{S_ip[2],4&#39;d2}:{S_ip[3],4&#39;d3};
assign state2 = (S_ip[4]&lt;S_ip[5])?{S_ip[4],4&#39;d4}:{S_ip[5],4&#39;d5};
assign state3 = (S_ip[6]&lt;S_ip[7])?{S_ip[6],4&#39;d6}:{S_ip[7],4&#39;d7};
assign state4 = (S_ip[8]&lt;S_ip[9])?{S_ip[8],4&#39;d8}:{S_ip[9],4&#39;d9};
assign state5 = (S_ip[10]&lt;S_ip[11])?{S_ip[10],4&#39;d10}:{S_ip[11],4&#39;d11};
assign state6 = (S_ip[12]&lt;S_ip[13])?{S_ip[12],4&#39;d12}:{S_ip[13],4&#39;d13};
assign state7 = (S_ip[14]&lt;S_ip[15])?{S_ip[14],4&#39;d14}:{S_ip[15],4&#39;d15};
assign state8 = (state0[7:4]&lt;state1[7:4])?state0:state1;
assign state9 = (state2[7:4]&lt;state3[7:4])?state2:state3;
assign state10 = (state4[7:4]&lt;state5[7:4])?state4:state5;
assign state11 = (state6[7:4]&lt;state7[7:4])?state6:state7;
assign state12 = (state8[7:4]&lt;state9[7:4])?state8:state9;
assign state13 = (state10[7:4]&lt;state11[7:4])?state10:state11;
assign state = (state12[7:4]&lt;state13[7:4])?state12[3:0]:state13[3:0];
always @(posedge clk or negedge res)
if(!res)
s_out &lt;= 4&#39;b0;
else if(code_enco&amp;&amp;((depth==1&#39;b1&amp;&amp;code_depth==L)||(depth==1&#39;b0&amp;&amp;code_depth==0)))
s_out &lt;= {D[state][code_depth],state[3:1]};
else if(code_enco)
s_out &lt;= {D[s_out][code_depth],s_out[3:1]};
always @(posedge clk or negedge res)
if(!res)
code_enco &lt;= 1&#39;b0;
else if(code_depth == L)
code_enco &lt;= 1&#39;b1;
assign out_en = code_enco &amp;&amp;((depth==1&#39;b1 &amp;&amp; code_depth==L)||(depth==1&#39;b0 &amp;&amp;
code_depth==0));
assign sequence = (out_en)?state[0]:s_out[0];
read_data dut(clk, res, sequence, code_enco, viterbi_decoder_op);

endmodule
