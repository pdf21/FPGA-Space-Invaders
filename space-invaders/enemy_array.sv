module enemy_array
(
    input   logic   Clk , frame_clk, Reset, Start, delete_enemies, hit, is_playing(is_playing,
    input   logic   [9:0] DrawX, DrawY,
    output  logic   enemy_on,
    output  logic   [7:0] enemy_R, enemy_G, enemy_B
);
    logic [9:0] L_Edge, R_Edge, U_Edge, D_Edge;
    logic enemy_direction_X, enemy_direction_Y, delete_enemies;
enum {
    INIT,
    MOVE_LEFT,
    MOVE_RIGHT,
    MOVE_DOWN_RIGHT,
    MOVE_DOWN_LEFT,
    LOST
} state, next_state;

//  logic for each states
always_ff @(posedge frame_clk)begin
    state <= next_state;

    if(state == INIT) begin
        L_Edge <= 10'd0;
        R_Edge <= 10'd487;
        U_Edge <= 10'd0;
        D_Edge <= 10'd143;
        delete_enemies <= 1'b0;
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

    if (state == LOST) begin
        delete_enemies <= 1'b1;
    end
end

logic reached_edge;
logic reached_max;
// edge case checking
always_comb begin
    if (R_Edge == 10'd639) begin
        reached_edge <= 1'b1;
    end
    else if (L_Edge == 10'd00) begin
        reached_edge <= 1'b1;
    end
    else begin
        reached_edge <= 1'b0;
    end

    if (D_Edge == 10'd355) begin
        reached_max <= 1'b1;
    end
    else begin
        reached_max <= 1'b0;
    end

end


// next state handler
always_ff @(posedge Clk)begin
    case(state)
        INIT:           state_next = start ? MOVE_RIGHT : INIT;
        MOVE_LEFT:      state_next = !reached_edge ? MOVE_LEFT : MOVE_DOWN_RIGHT;
        MOVE_RIGHT:     state_next = !reached_edge ? MOVE_RIGHT : MOVE_DOWN_LEFT;
        MOVE_DOWN_RIGHT:state_next = !reached_max ? MOVE_RIGHT : LOST;
        MOVE_DOWN_LEFT: state_next = !reached_max ? MOVE_LEFT : LOST;
end

// output of enemy_on and enemy data
always_comb begin
    enemy_on <= ee1_on + ee2_on + ee3_on + ee4_on + ee5_on + ee6_on + ee7_on + em1_on + em2_on + em3_on + em4_on + em5_on + em6_on + em7_on + eh1_on + eh2_on + eh3_on + eh4_on + eh5_on + eh6_on + eh7_on;
    enemy_R <= ee1_R + ee2_R + ee3_R + ee4_R + ee5_R + ee6_R + ee7_R + em1_R + em2_R + em3_R + em4_R + em5_R + em6_R + em7_R + eh1_R + eh2_R + eh3_R + eh4_R + eh5_R + eh6_R + eh7_R;
    enemy_G <= ee1_G + ee2_G + ee3_G + ee4_G + ee5_G + ee6_G + ee7_G + em1_G + em2_G + em3_G + em4_G + em5_G + em6_G + em7_G + eh1_G + eh2_G + eh3_G + eh4_G + eh5_G + eh6_G + eh7_G;
    enemy_B <= ee1_B + ee2_B + ee3_B + ee4_B + ee5_B + ee6_B + ee7_B + em1_B + em2_B + em3_B + em4_B + em5_B + em6_B + em7_B + eh1_B + eh2_B + eh3_B + eh4_B + eh5_B + eh6_B + eh7_B;
end


/////////////                                       EASY ENEMIES                                  /////////////////////////


logic ee1_on;
logic   [7:0] ee1_R, ee1_G, ee1_B;
enemy_easy ee1(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
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
enemy_easy ee2(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'd73), 
    .enemy_initial_y(10'd0),
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
enemy_easy ee3(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'd146), 
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
enemy_easy ee4(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'd219), 
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
enemy_easy ee5(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'd292), 
    .enemy_initial_y(10'b0),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(ee5_on),
    .enemy_R(ee5_R),
    .enemy_G(ee5_G),
    .enemy_B(ee5_B)
);

logic ee6_on;
logic   [7:0] ee6_R, ee6_G, ee6_B;
enemy_easy ee6(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'd365), 
    .enemy_initial_y(10'b0),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(ee6_on),
    .enemy_R(ee6_R),
    .enemy_G(ee6_G),
    .enemy_B(ee6_B)
);

logic ee7_on;
logic   [7:0] ee7_R, ee7_G, ee7_B;
enemy_easy ee7(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'd438), 
    .enemy_initial_y(10'b0),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(ee7_on),
    .enemy_R(ee7_R),
    .enemy_G(ee7_G),
    .enemy_B(ee7_B)
);
////////////////////////////////////// MEDIUM ENEMIES
logic em1_on;
logic   [7:0] em1_R, em1_G, em1_B;
enemy_medium em1(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'b0), 
    .enemy_initial_y(10'd50),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(em1_on),
    .enemy_R(em1_R),
    .enemy_G(em1_G),
    .enemy_B(em1_B)
);

logic em2_on;
logic   [7:0] em2_R, em2_G, em2_B;
enemy_medium em2(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'd73), 
    .enemy_initial_y(10'd50),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(em2_on),
    .enemy_R(em2_R),
    .enemy_G(em2_G),
    .enemy_B(em2_B)
);

logic em3_on;
logic   [7:0] em3_R, em3_G, em3_B;
enemy_medium em3(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'd146), 
    .enemy_initial_y(10'd50),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(em3_on),
    .enemy_R(em3_R),
    .enemy_G(em3_G),
    .enemy_B(em3_B)
);

logic em4_on;
logic   [7:0] em4_R, em4_G, em4_B;
enemy_medium em4(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'd219), 
    .enemy_initial_y(10'd50),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(em4_on),
    .enemy_R(em4_R),
    .enemy_G(em4_G),
    .enemy_B(em4_B)
);

logic em5_on;
logic   [7:0] em5_R, em5_G, em5_B;
enemy_medium em5(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'd292), 
    .enemy_initial_y(10'd50),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(em5_on),
    .enemy_R(em5_R),
    .enemy_G(em5_G),
    .enemy_B(em5_B)
);

logic em6_on;
logic   [7:0] em6_R, em6_G, em6_B;
enemy_medium em6(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'd365), 
    .enemy_initial_y(10'd50),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(em6_on),
    .enemy_R(em6_R),
    .enemy_G(em6_G),
    .enemy_B(em6_B)
);

logic em7_on;
logic   [7:0] em7_R, em7_G, em7_B;
enemy_medium em7(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'd438), 
    .enemy_initial_y(10'd50),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(em7_on),
    .enemy_R(em7_R),
    .enemy_G(em7_G),
    .enemy_B(em7_B)
);

///////////////////         ENEMIES HARD
logic eh1_on;
logic   [7:0] eh1_R, eh1_G, eh1_B;
enemy_medium eh1(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'b0), 
    .enemy_initial_y(10'd100),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(eh1_on),
    .enemy_R(eh1_R),
    .enemy_G(eh1_G),
    .enemy_B(eh1_B)
);

logic eh2_on;
logic   [7:0] eh2_R, eh2_G, eh2_B;
enemy_medium eh2(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'd73), 
    .enemy_initial_y(10'd100),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(eh2_on),
    .enemy_R(eh2_R),
    .enemy_G(eh2_G),
    .enemy_B(eh2_B)
);

logic eh3_on;
logic   [7:0] eh3_R, eh3_G, eh3_B;
enemy_medium eh3(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'd146), 
    .enemy_initial_y(10'd100),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(eh3_on),
    .enemy_R(eh3_R),
    .enemy_G(eh3_G),
    .enemy_B(eh3_B)
);

logic eh4_on;
logic   [7:0] eh4_R, eh4_G, eh4_B;
enemy_medium eh4(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'd219), 
    .enemy_initial_y(10'd100),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(eh4_on),
    .enemy_R(eh4_R),
    .enemy_G(eh4_G),
    .enemy_B(eh4_B)
);

logic eh5_on;
logic   [7:0] eh5_R, eh5_G, eh5_B;
enemy_medium eh5(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'd292), 
    .enemy_initial_y(10'd100),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(eh5_on),
    .enemy_R(eh5_R),
    .enemy_G(eh5_G),
    .enemy_B(eh5_B)
);

logic eh6_on;
logic   [7:0] eh6_R, eh6_G, eh6_B;
enemy_medium eh6(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'd365), 
    .enemy_initial_y(10'd100),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(eh6_on),
    .enemy_R(eh6_R),
    .enemy_G(eh6_G),
    .enemy_B(eh6_B)
);

logic eh7_on;
logic   [7:0] eh7_R, eh7_G, eh7_B;
enemy_medium eh7(
    .Reset(Reset),
    .frame_clk,
    .Clk(Clk),
    .delete_enemies(delete_enemies),
    .hit(hit),
    .is_playing(is_playing),
    .enemy_direction_X,
    .enemy_direction_Y,
    .enemy_initial_x(10'd438), 
    .enemy_initial_y(10'd100),
    .DrawX,
    .DrawY,
    .start(Start),
    .enemy_on(eh7_on),
    .enemy_R(eh7_R),
    .enemy_G(eh7_G),
    .enemy_B(eh7_B)
);

endmodule