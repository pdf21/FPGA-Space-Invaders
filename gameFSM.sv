module gameFSM(
    input reset, input [19:0] invaders_left, input clk,
    input invader_line[3:0],
    output FSMout
);

parameter BEGIN = 2'b00;
parameter CONT = 2'b01;
parameter WIN = 2'b10;
parameter GAMEOVER = 2'b11;

initial
begin
    FSMout = BEGIN;
end

always_ff (posedge clk)
begin
    if(reset) 
        FSMout <= BEGIN; // Resets the game from the beginning.
    else if(invader_line == 14) // NEED TO INSERT CONDITION FOR INVADER LINE.
        FSMout <= GAMEOVER; // means that you lose 
    else if(invaders_left == 0)
        FSMout <= BEGIN;
    else
        FSMout <= CONT; // continue with the game
end