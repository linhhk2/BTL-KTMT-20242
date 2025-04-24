module Data_Memory(
    input clk,
    input rst,
    input MemRead,
    input MemWrite,
    input [31:0] address,
    input [31:0] write_data,
    output [31:0] read_data
);
    reg [31:0] D_Memory [0:63];
    integer k;

    assign read_data = (MemRead) ? D_Memory[address] : 32'b0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (k = 0; k < 64; k = k + 1)
                D_Memory[k] = 32'b0;
        end else begin
            D_Memory[17] = 56;
            D_Memory[15] = 65;

            if (MemWrite) begin
                D_Memory[address] = write_data;
            end
        end
    end

endmodule
