module gameFSM(
    input logic reset,  input logic clk, input logic [7:0] keycode, input logic finished, 
    output logic start, is_playing, is_finished
);

enum {
    BEGINNING,
    GAME_START,
    GAME_OVER,
    CONT
} state, next_state;

// outputs at each state
always_ff @ (posedge clk) begin
    state <= next_state;

    if(state == BEGINNING) begin
        start <= 1'b0;
    end

    if(state == GAME_START) begin
        start <= 1'b1;
    end

    if(state == GAME_OVER) begin
        start <= 1'b0;
        is_finished <= 1'b1;
    end

    if(state == CONT) begin
        start <= 1'b0;
        is_playing <= 1'b1;
    end
end

// handling next state
always_ff @ (posedge clk) begin
    case (state)
        BEGINNING: next_state = (keycode != 8'b0) ? GAME_START : BEGINNING; // press any key
        GAME_START: next_state = CONT;
        GAME_OVER: next_state = (keycode == 8'd44) ? GAME_START : GAME_OVER; // PRESS SPACE
        CONT: next_state = finished ? GAME_OVER : CONT;
        default: next_state = BEGINNING;
    endcase
    if(reset)
    begin
        next_state = BEGINNING;
    end
end

endmodule