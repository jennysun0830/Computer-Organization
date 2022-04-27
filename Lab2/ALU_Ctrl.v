//Subject:     CO project 2 - ALU Controller
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
module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter

       
//Select exact operation
always @(*) begin
    if(ALUOp_i==3'b010)begin
        if(funct_i==6'h20) ALUCtrl_o<=4'b0010;
        else if(funct_i==6'h22) ALUCtrl_o<=4'b0110;
        else if(funct_i==6'h24) ALUCtrl_o<=4'b0000;
        else if(funct_i==6'h25) ALUCtrl_o<=4'b0001;
        else if(funct_i==6'h2a) ALUCtrl_o<=4'b0111;
    end
    else if(ALUOp_i==3'b001) ALUCtrl_o<=4'b0110;
    else if(ALUOp_i==3'b101) ALUCtrl_o<=4'b0010;
    else if(ALUOp_i==3'b110) ALUCtrl_o<=4'b0111;
end

endmodule     





                    
                    