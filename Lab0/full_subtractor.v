`timescale 1ns / 1ps

module Full_Subtractor(
    In_A, In_B, Borrow_in, Difference, Borrow_out
    );
    input In_A, In_B, Borrow_in;
    output Difference, Borrow_out;
    wire Difference_buffer,Borrow_buffer1,Borrow_buffer2;
    
    // implement full subtractor circuit, your code starts from here.
    // use half subtractor in this module, fulfill I/O ports connection.
    Half_Subtractor HSUB (
        .In_A(), 
        .In_B(), 
        .Difference(), 
        .Borrow_out()
    );
    Half_Subtractor HS1(In_A,In_B,Difference_buffer,Borrow_buffer1);
    Half_Subtractor HS2(Difference_buffer,Borrow_in,Difference,Borrow_buffer2);
    or(Borrow_out,Borrow_buffer1,Borrow_buffer2);

endmodule
