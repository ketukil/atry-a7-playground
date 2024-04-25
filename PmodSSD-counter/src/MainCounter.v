`timescale 1ns / 1ps


module MainCounter(
    input clk,               // 100 MHz clock input
    output reg [7:0] count_low,  // 8-bit output for the low byte of the counter
    output reg [7:0] count_high  // 8-bit output for the high byte of the counter
);

// Define the constant for the maximum count to achieve a 100 Hz update rate
parameter MAX_COUNT = 1_000_000 - 1;

// Internal register for keeping track of the clock cycles
reg [31:0] clock_divider = 0; // 24 bits to count up to 10,000,000

// Full 16-bit counter not directly exposed as output
reg [15:0] full_count = 0;

// Counter logic
always @(posedge clk) begin
    if (clock_divider == MAX_COUNT) begin
        clock_divider <= 0;       // Reset clock divider
        full_count <= full_count + 1;  // Increment the 16-bit counter
        count_low <= full_count[7:0];  // Update the low byte
        count_high <= full_count[15:8]; // Update the high byte
    end else begin
        clock_divider <= clock_divider + 1;  // Increment the clock cycle counter
    end
end

endmodule
