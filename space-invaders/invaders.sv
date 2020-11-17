// CREATED BY YEI

module invaders(
    input logic clk, input logic reset, 
    input logic bullet_x, input logic bullet_y,
    output logic [19:0] invaders_out, output logic [2:0] invaders_row,
    output logic hit
);

logic direction; // 0 = right, 1 = left

initial
begin
    invaders_out = 20'b00000000000000000111;
    invaders_row = 3'b111;
    direction = 0;
end

always_ff(posedge clk)
begin
    if(reset)
    begin
        invaders_out = 20'b00000000000000000111;
        invaders_row = 3'b111;
        direction = 0;
    end
    else if (bullet_x)
end