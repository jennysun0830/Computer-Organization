//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
`timescale 1ns/1ps
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire [31:0] PC_in;
wire [31:0] PC_out;
wire [31:0] instr;
wire [31:0] signed_extend;
wire RegDst;
wire RegWrite;
wire Branch;
wire ALUsrc;
wire [2:0] ALUop;
wire [31:0] ReadData1;
wire [31:0] ReadData2;
wire [3:0] ALU_ctrl;
wire [31:0] ALUsrc_MUX;
wire [31:0] Add1;
wire [31:0] Add2;
wire [31:0]shift_left;
wire branch_MUX;
wire [4:0] WriteReg;
wire [31:0] ALU_result;
wire zero;
wire next_PC_ctrl=Branch&zero;

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(PC_in[31:0]) ,   
	    .pc_out_o(PC_out[31:0]) 
	    );
	
Adder Adder1(
        .src1_i(32'd4),     
	    .src2_i(PC_out[31:0]),     
	    .sum_o(Add1[31:0])    
	    );
	
Instr_Memory IM(
        .pc_addr_i(PC_out[31:0]),  
	    .instr_o(instr[31:0])    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr[20:16]),
        .data1_i(instr[15:11]),
        .select_i(RegDst),
        .data_o(WriteReg)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instr[25:21]) ,  
        .RTaddr_i(instr[20:16]) ,  
        .RDaddr_i(WriteReg) ,  
        .RDdata_i(ALU_result[31:0])  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(ReadData1[31:0]) ,  
        .RTdata_o(ReadData2[31:0])   
        );
	
Decoder Decoder(
        .instr_op_i(instr[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALU_op_o(ALUop[2:0]),   
	    .ALUSrc_o(ALUsrc),   
	    .RegDst_o(RegDst),   
		.Branch_o(Branch)   
	    );

ALU_Ctrl AC(
        .funct_i(instr[5:0]),   
        .ALUOp_i(ALUop[2:0]),   
        .ALUCtrl_o(ALU_ctrl[3:0]) 
        );
	
Sign_Extend SE(
        .data_i(instr[15:0]),
        .data_o(signed_extend[31:0])
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(ReadData2[31:0]),
        .data1_i(signed_extend[31:0]),
        .select_i(ALUsrc),
        .data_o(ALUsrc_MUX)
        );	
		
ALU ALU(
        .src1_i(ReadData1[31:0]),
	    .src2_i(ALUsrc_MUX[31:0]),
	    .ctrl_i(ALU_ctrl[3:0]),
	    .result_o(ALU_result[31:0]),
		.zero_o(zero)
	    );
		
Adder Adder2(
        .src1_i(Add1[31:0]),     
	    .src2_i(shift_left[31:0]),     
	    .sum_o(Add2[31:0])      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(signed_extend[31:0]),
        .data_o(shift_left[31:0])
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(Add1[31:0]),
        .data1_i(Add2[31:0]),
        .select_i(next_PC_ctrl),
        .data_o(PC_in[31:0])
        );	

endmodule
		  


