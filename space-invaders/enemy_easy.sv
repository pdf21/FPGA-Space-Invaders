module enemy_easy(
    input Reset, input frame_clk, input [7:0] keycode,
    input enemy_direction_X, // 0 = move left, 1 = move right
    input enemy_direction_Y, // 0 = stay, 1 = move down
    input [9:0] enemy_start_x, enemy_start_y,
    input [9:0] DrawX, DrawY,
    output      enemy_on,
    output[7:0] enemy_R, enemy_G, enemy_B
);
    logic   enemy_enable;
    logic   [9:0] enemy_x, enemy_y, next_enemy_y;
    parameter enemy_step_X, enemy_step_Y;
    int IMAGE_WIDTH = 6'd50; 
    int IMAGE_HEIGHT = 6'd50;
    // find position in memory : DrawX - startX
    logic   [23:0] read_addr;
    enum {
        IDLE,           // when dead or game have not yet started
        START,          // game just started, await for sprite drawing
        AWAIT_POS,      // wait next horizontal position
        DRAW,           // output the RGB
        NEXT_LINE       // wait for next row
    } state, next_state;

    // states IDLE, START, AWAIT_POS, DRAW, NEXT_LINE

    alienRAM my_alien(
        .data_in(5'b0),
        .write_address(19'b0),
        .read_address(read_addr),
        .we(0'b0),
        .Clk(frame_clk),
        .data_out({enemy_sprite_R, enemy_sprite_G, enemy_sprite_B})
    );
    // 2 always: outputs of each state
             //  handling of next state
    // accessing memory = row no * width + col no
    
    // always happens:
    always_comb begin


        if(enemy_on == 1'b1) begin
            enemy_R <= enemy_sprite_R;
            enemy_G <= enemy_sprite_G;
            enemy_B <= enemy_sprite_B;
        end
        else begin
            enemy_R <= 8'b0;
            enemy_G <= 8'b0;
            enemy_B <= 8'b0;
        end 
    end

    always_ff @(posedge Clk) begin
        state <= next_state;
        curr_x <= Draw
        if (state == START)begin
            enemy_on <= 1'b1;
            enemy_x <= 10'b0;
            enemy_y <= 10'b0;
            read_addr <= 23'b0;
            next_enemy_y <= 10'b0000000001;
        end

        if (state == AWAIT_POS) begin
            // 
            enemy_on <= 1'b0;
            enemy_x <= 0;
        end

        if (state == DRAW) begin
            enemy_x <= enemy_x + 1;
            read_addr <= read_addr + 1;
            enemy_on <= 1'b1;
        end

        if (state == NEXT_LINE) begin
            enemy_y <= next_enemy_y;
            next_enemy_y <= next_enemy_y + 1;
        end

        if(Reset) begin
            state <= IDLE;
        end
    end

    always_comb begin
        case(state)
            IDLE:       next_state = start? START:IDLE;
            START:      next_state = AWAIT_POS;
            AWAIT_POS:  begin
                
                    // measure or check if current x is within the boundaries of the sprite rectangle
            end
            DRAW:       next_state = !last_pixel ? DRAW : (!last_line ? NEXT_LINE : IDLE);
            NEXT_LINE:  next_state = AWAIT_POS;
            default:    next_state = IDLE;
        endcase
    end

    // handles positioning

    // IDLE = do nothing, if game start, then goes to start


//     always_ff @ (posedge frame_clk)
//     begin
//         if(Reset == 1'b1)
//         begin: just_started
//             // start at top right, should move to the left
//             enemy_x <= enemy_start_x;
//             enemy_y <= enemy_start_y;
//             enemy_enable <= 1'b1;

//         end
//         else 
//         begin
//             if(enemy_direction_X == 1'b1)begin
//                 enemy_step_X = 1;
//             end
//             else
//             begin
//                 enemy_step_X = -1;
//             end
//             if(enemy_direction_Y == 1'b1)
//             begin
//                 enemy_step_Y = -1;
//             end 
//             else
//             begin
//                 enemy_step_y = 0;
//             end

//             enemy_x <= enemy_x + enemy_step_X;
//             enemy_y <= enemy_y + enemy_step_Y;
//         end
//     end

//     // handles drawing logic
//     always_ff @ (posedge frame_clk)
//     begin
//         if(DrawX == enemy_x && DrawY == enemy_Y && enemy_enable == 1'b1)
//         begin
//             enemy_on <= 1'b1;
//             enemy_R <= enemy_Sprite_R;
//             enemy_G <= enemy_Sprite_G;
//             enemy_B <= enemy_Sprite_B;            
//         end
//         else
//         begin
//             enemy_on <= 1'b0; 
//             enemy_R <= enemy_Sprite_R;
//             enemy_G <= enemy_Sprite_G;
//             enemy_B <= enemy_Sprite_B;            
//         end
//     end

// endmodule

