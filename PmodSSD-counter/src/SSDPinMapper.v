`timescale 1ns / 1ps

module SSDPinMapper(
    input sel,        // Display select 0 = LSB, 1 = MSB
    input [6:0] digit,  // 7-segment display data input
    
    output reg [7:0] PmodPort1, // Output port 1 (equivalent to ja or jc)
    output reg [7:0] PmodPort2  // Output port 2 (equivalent to jb or jd)
);
    // Always block to handle mapping logic
    always @* begin
        // Clear outputs
        PmodPort1 <= 0;
        PmodPort2 <= 0;
        // Map digit to PmodPort1 and PmodPort2
        // Pmod_JA, Pmod_JC
        PmodPort1[4] <= digit[0]; 
        PmodPort1[5] <= digit[1];
        PmodPort1[6] <= digit[2];
        PmodPort1[7] <= digit[3];
        // Pmod_JB, Pmod_JD
        PmodPort2[4] <= digit[4];
        PmodPort2[5] <= digit[5];
        PmodPort2[6] <= digit[6];
        PmodPort2[7] <= sel;
    end
endmodule

