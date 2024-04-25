module SSDBinDecoder(
    input mux_clk,             // Multipexer Clock input
    input [7:0] data,      // 8-bit data input (data[3:0] for one display, data[7:4] for the other)
    output reg sel,        // Display select output
    output reg [6:0] digit // Segment outputs (a, b, c, d, e, f, g)
);

// Segment decoding for numbers 0 to 9 and letters A to F on a common cathode 7-segment display
reg [6:0] segment_datas[0:15];

initial begin
    // Define the segment datas for each digit and letter
    segment_datas[0]  = 7'b0111111; // '0'
    segment_datas[1]  = 7'b0000110; // '1'
    segment_datas[2]  = 7'b1011011; // '2'
    segment_datas[3]  = 7'b1001111; // '3'
    segment_datas[4]  = 7'b1100110; // '4'
    segment_datas[5]  = 7'b1101101; // '5'
    segment_datas[6]  = 7'b1111101; // '6'
    segment_datas[7]  = 7'b0000111; // '7'
    segment_datas[8]  = 7'b1111111; // '8'
    segment_datas[9]  = 7'b1101111; // '9'
    segment_datas[10] = 7'b1110111; // 'A'
    segment_datas[11] = 7'b1111100; // 'b'
    segment_datas[12] = 7'b0111001; // 'C'
    segment_datas[13] = 7'b1011110; // 'd'
    segment_datas[14] = 7'b1111001; // 'E'
    segment_datas[15] = 7'b1110001; // 'F'
end

// Alternate between the two displays
always @(posedge mux_clk) begin
    if (sel == 0) begin
        sel <= 1; // Switch to the second display
        digit <= segment_datas[data[7:4]]; // Display upper 4 bits
    end
    else begin
        sel <= 0; // Switch back to the first display
        digit <= segment_datas[data[3:0]]; // Display lower 4 bits
    end
end

endmodule
