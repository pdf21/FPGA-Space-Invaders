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
    logic   [9:0] enemy_x, enemy_y;
    parameter enemy_step_X, enemy_step_Y;
    logic [7:0] enemy_sprite_R, enemy_Sprite_G, enemy_Sprite_B;
    // handles positioning
    always_ff @ (posedge frame_clk)
    begin
        if(Reset == 1'b1)
        begin: just_started
            // start at top right, should move to the left
            enemy_x <= enemy_start_x;
            enemy_y <= enemy_start_y;
            enemy_enable <= 1'b1;

        end
        else 
        begin
            if(enemy_direction_X == 1'b1)begin
                enemy_step_X = 1;
            end
            else
            begin
                enemy_step_X = -1;
            end
            if(enemy_direction_Y == 1'b1)
            begin
                enemy_step_Y = -1;
            end 
            else
            begin
                enemy_step_y = 0;
            end

            enemy_x <= enemy_x + enemy_step_X;
            enemy_y <= enemy_y + enemy_step_Y;
        end
    end

    // handles drawing logic
    always_ff @ (posedge frame_clk)
    begin
        if(DrawX == enemy_x && DrawY == enemy_Y && enemy_enable == 1'b1)
        begin
            enemy_on <= 1'b1;
            enemy_R <= enemy_Sprite_R;
            enemy_G <= enemy_Sprite_G;
            enemy_B <= enemy_Sprite_B;            
        end
        else
        begin
            enemy_on <= 1'b0; 
            enemy_R <= enemy_Sprite_R;
            enemy_G <= enemy_Sprite_G;
            enemy_B <= enemy_Sprite_B;            
        end
    end

endmodule

