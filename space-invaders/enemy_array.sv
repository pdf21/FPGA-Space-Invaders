module enemy_array
(
    input   logic   50CLK, frame_clk, Reset, Start,
    input   logic   [9:0] DrawX, DrawY,
    output  logic   enemy_on,
    output  logic   enemy_data
);
    logic [9:0] L_Edge, R_Edge, U_Edge, D_Edge;
    logic enemy_direction_X, enemy_direction_Y;
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
        enemy_direction_X <= 1'b0;
        enemy_direction_Y <= 1'b0;
    end

    if(state == MOVE_RIGHT) begin
        L_Edge <= L_Edge + 10'd01;
        R_Edge <= R_Edge + 10'd01;        
        enemy_direction_X <= 1'b1;
        enemy_direction_Y <= 1'b0;
    end

    if(state == MOVE_DOWN_RIGHT) begin
        U_Edge <= U_Edge + 10'd01;
        D_Edge <= D_Edge + 10'd01;
        L_Edge <= L_Edge + 10'd01;
        R_Edge <= R_Edge + 10'd01;    
        enemy_direction_X <= 1'b1;
        enemy_direction_Y <= 1'b1;
    end

    if(state == MOVE_DOWN_LEFT) begin
        U_Edge <= U_Edge + 10'd01;
        D_Edge <= D_Edge + 10'd01;
        L_Edge <= L_Edge - 10'd01;
        R_Edge <= R_Edge - 10'd01;
        enemy_direction_X <= 1'b0;
        enemy_direction_Y <= 1'b1;
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

/////////////                                       EASY ENEMIES                                  /////////////////////////
logic ee1_on;
logic   [7:0] ee1_R, ee1_G, ee1_B;
enemy_easy ee1(
    .Reset(Reset),
    .frame_clk,
    .Clk(50CLK),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'b0), 
    .enemy_initial_y(10'b0),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(ee1_on),
    .enemy_R(ee1_R),
    .enemy_G(ee1_G),
    .enemy_B(ee1_B)
);

logic ee1_on;
logic   [7:0] ee1_R, ee1_G, ee1_B;
enemy_easy ee1(
    .Reset(Reset),
    .frame_clk,
    .Clk(50CLK),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'b0), 
    .enemy_initial_y(10'b0),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(ee1_on),
    .enemy_R(ee1_R),
    .enemy_G(ee1_G),
    .enemy_B(ee1_B)
);

logic ee2_on;
logic   [7:0] ee2_R, ee2_G, ee2_B;
enemy_easy ee1(
    .Reset(Reset),
    .frame_clk,
    .Clk(50CLK),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'b0), 
    .enemy_initial_y(10'b0),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(ee1_on),
    .enemy_R(ee2_R),
    .enemy_G(ee2_G),
    .enemy_B(ee2_B)
);

logic ee3_on;
logic   [7:0] ee3_R, ee3_G, ee3_B;
enemy_easy ee1(
    .Reset(Reset),
    .frame_clk,
    .Clk(50CLK),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'b0), 
    .enemy_initial_y(10'b0),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(ee3_on),
    .enemy_R(ee3_R),
    .enemy_G(ee3_G),
    .enemy_B(ee3_B)
);

logic ee4_on;
logic   [7:0] ee4_R, ee4_G, ee4_B;
enemy_easy ee1(
    .Reset(Reset),
    .frame_clk,
    .Clk(50CLK),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'b0), 
    .enemy_initial_y(10'b0),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(ee4_on),
    .enemy_R(ee4_R),
    .enemy_G(ee4_G),
    .enemy_B(ee4_B)
);

logic ee5_on;
logic   [7:0] ee5_R, ee5_G, ee5_B;
enemy_easy ee1(
    .Reset(Reset),
    .frame_clk,
    .Clk(50CLK),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'b0), 
    .enemy_initial_y(10'b0),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(ee5_on),
    .enemy_R(ee5_R),
    .enemy_G(ee5_G),
    .enemy_B(ee5_B)
);

endmodule