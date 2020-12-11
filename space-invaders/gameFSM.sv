module gameFSM(
    input reset,  input clk, input player_start, input finished, 
    output start, is_playing, is_finished
);

enum {
    BEGIN,
    GAME_START,
    GAME_OVER,
    CONT
} state, next_state;

// outputs at each state
always_ff @ (posedge clk) begin
    state <= next_state;

    if(state == BEGIN) begin
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
        BEGIN: next_state = player_start ? GAME_START : BEGIN;
        GAME_START: next_state = CONT;
        GAME_OVER: next_state = player_start ? GAME_START : GAME_OVER;
        CONT: finished ? GAME_OVER : CONT;
        default: BEGIN;
    endcase
    if(reset) begin
        next_state = BEGIN;
    end
end

endmodule