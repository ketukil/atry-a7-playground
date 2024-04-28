module BinaryToBcd(
    input [15:0] binary,           // 16-bit binary input
    output reg [7:0] bcd_1100,   // BCD output for hundreds digit
    output reg [7:0] bcd_0011    // BCD output for tens digit
);

integer i;
reg [19:0] bcd;  // Internal BCD representation

always @(binary) begin
    // Initialize BCD result
    bcd = 0;

    // Loop through each bit of the binary input
    for (i = 15; i >= 0; i = i - 1) begin
        // Add 3 to BCD digits if they exceed 4
        if (bcd[3:0] > 4)
            bcd[3:0] = bcd[3:0] + 3;
        if (bcd[7:4] > 4)
            bcd[7:4] = bcd[7:4] + 3;
        if (bcd[11:8] > 4)
            bcd[11:8] = bcd[11:8] + 3;
        if (bcd[15:12] > 4)
            bcd[15:12] = bcd[15:12] + 3;
        if (bcd[19:16] > 4)
            bcd[19:16] = bcd[19:16] + 3;

        // Shift left by 1
        bcd = bcd << 1;
        bcd[0] = binary[i]; // Insert the bit into BCD's least significant bit
    end

    // Assign outputs to individual BCD digits
    bcd_0011 = bcd[7:0];
    bcd_1100 = bcd[15:8];

end

endmodule
