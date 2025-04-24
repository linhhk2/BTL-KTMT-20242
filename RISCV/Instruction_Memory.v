module Instruction_Memory(
    input wire rst,
    input wire clk,
    input wire [31:0] read_address,           // byte address
    output wire [31:0] instruction_out
);

    reg [31:0] I_Mem [0:127];  // 128 lệnh, đánh chỉ số từ 0 đến 127
    integer k;

    // Truy xuất lệnh: chia 4 vì read_address là byte-address
    assign instruction_out = I_Mem[read_address[31:2]];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Clear memory
            for (k = 0; k < 128; k = k + 1) begin
                I_Mem[k] = 32'b0;
            end

            // Nạp chương trình vào I_Mem (theo word index, không phải byte index)
            I_Mem[0] = 32'b00000000000000000000000000000000;             // nop
            I_Mem[1] = 32'b0000000_11001_10000_000_01101_0110011;        // add x13, x16, x25
            I_Mem[2] = 32'b0100000_00011_01000_000_00101_0110011;        // sub x5, x8, x3
            I_Mem[3] = 32'b0000000_00011_00010_111_00001_0110011;        // and x1, x2, x3
            I_Mem[4] = 32'b0000000_00101_00011_110_00110_0110011;        // or x6, x3, x5
            I_Mem[5] = 32'b0000000_00101_00011_100_00111_0110011;        // xor x7, x3, x5
            I_Mem[6] = 32'b0000000_00011_00010_001_01000_0110011;        // sll x8, x2, x3
            I_Mem[7] = 32'b0000000_00011_00010_101_01001_0110011;        // srl x9, x2, x3
            I_Mem[8] = 32'b0100000_00011_00010_101_01010_0110011;        // sra x10, x2, x3

            // I-type: srai x5, x3, 8
            I_Mem[9] = 32'b0100000_01000_00011_101_00101_0010011;        // srai x5, x3, 8
        end
    end

endmodule
