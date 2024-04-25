`timescale 1ns / 1ps

module SSDMultiplexClock(
    input clk_in,               // 100 MHz input clock
    output reg clk_out       // output clock
);

// Parameter to hold the required count value for half the period of the output clock
parameter COUNT = 50_000 - 1;  // Subtract 1 because counting starts from 0

// Register to count the cycles
reg [23:0] counter = 0;        // Wide enough to count up to COUNT - 1 ( log2(COUNT) = max_bits )

always @(posedge clk_in) begin
    if (counter == COUNT) begin
        clk_out <= ~clk_out;   // Toggle the output clock
        counter <= 0;          // Reset the counter
    end else begin
        counter <= counter + 1;  // Increment the counter
    end
end

endmodule