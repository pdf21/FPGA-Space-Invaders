module enemy_array
(
    input   logic   50CLK, frame_clk, Reset, Start,
);
    logic [9:0] L_Edge, R_Edge, U_Edge, D_Edge;
    logic enemy_direction;
enum {
    INIT,
    MOVE_LEFT,
    MOVE_RIGHT,
    MOVE_DOWN_RIGHT,
    MOVE_DOWN_LEFT,
    CRASH
} state, next_state;

// 
always_ff @(posedge frame_clk)begin
    state <= next_state;

    if(state == INIT) begin
        L_Edge <= 10'd0;
        R_Edge <= 10'd487;
        U_Edge <= 10'd0;
        D_Edge <= 10'd143;
    end
    
    if(state == MOVE_LEFT) begin
        L_Edge <= L_Edge - 10'd01;
        R_Edge <= R_Edge - 10'd01;
        enemy_direction_x <= 1'b0;
        enemy_direction_y <= 1'b0;
    end

    if(state == MOVE_RIGHT) begin
        L_Edge <= L_Edge + 10'd01;
        R_Edge <= R_Edge + 10'd01;        
        enemy_direction_x <= 1'b1;
        enemy_direction_y <= 1'b0;
    end

    if(state == MOVE_DOWN_RIGHT) begin
        U_Edge <= U_Edge + 10'd01;
        D_Edge <= D_Edge + 10'd01;
        L_Edge <= L_Edge + 10'd01;
        R_Edge <= R_Edge + 10'd01;    
        enemy_direction_X <= 1'b1;
        enemy_direction_y <= 1'b1;
    end

    if(state == MOVE_DOWN_LEFT) begin
        U_Edge <= U_Edge + 10'd01;
        D_Edge <= D_Edge + 10'd01;
        L_Edge <= L_Edge - 10'd01;
        R_Edge <= R_Edge - 10'd01;
        enemy_direction_X <= 1'b0;
        enemy_direction_y <= 1'b1;
    end
end

logic reached_edge;

always_ff @(posedge 50CLK) begin
    if (R_Edge == 10'd639) begin
        reached_edge <= 1'b1;
    end
    if (L_Edge == 10'd00) begin
        reached_edge <= 1'b1;
    end
    else begin
        reached_edge <= 1'b0;
    end
end

always_ff @(posedge 50CLK)begin
    case(state)
        INIT:           state_next = start ? MOVE_LEFT : INIT;
        MOVE_LEFT:      state_next = reached_edge ? MOVE_DOWN_RIGHT : MOVE_LEFT;
        MOVE_RIGHT:     state_next = reached_edge ? MOVE_DOWN_LEFT : MOVE_RIGHT;
        MOVE_DOWN_RIGHT:state_next = MOVE_RIGHT;
        MOVE_DOWN_LEFT: state_next = MOVE_LEFT;
end

endmodule