//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


/* 

    ***************************** start screen *****************************
        inputs: is_start_title, is_start_message
                start_title_hex_data, start_message_hex_data

    ***************************** in game *****************************
        inputs: is_enemy, is_player, is_bullet
            enemy_data, player_data, bullet_data

    ***************************** post game *****************************

*/

module  color_mapper (  input [9:0] DrawX, DrawY, Ball_size,
                        input bullet_in
                        input start, //for purely the start screen, color not neeed.
                        input [9:0] bulletX, bulletY,
                        input [7:0] enemy_R, enemy_G, enemy_B,
                        player_R, player_G, player_B,
                        bullet_R, bullet_G, bullet_B,
                        background_R, background_G, background_B,
                        output logic collision
                       output logic [7:0]  Red, Green, Blue );
    
    logic ball_on, bullet_on;
	logic temp_collide; 
    int DistX, DistY, Size;
	assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size = Ball_size;

    //Bullet should just be a straight vertical line of size 3 pixels. We can
    //adjust this according to however we want.

    int bullet_distY;
    assign bullet_distY = DrawY - bulletY;

    always_comb
    begin: bullet_on_proc
        if(bullet_in)
        begin
            if(bullet_distY < 4 && bulletX == DrawX)
                bullet_on = 1'b1;
        end
        else
            bullet_on = 1'b0;
    end
       
    always_comb
    begin:RGB_Display
        // check if start is on.
        if(start == 1'b1 &&
			DrawX >= 280 &&
			DrawX < 360 &&
			DrawY >= 208 &&
			DrawY < 272)
        begin
            R <= 8'hFF; // The start screen should just be a graphic with one color, easy.
            G <= 8'hFF;
            B <= 8'hFF;
        end
        // check if player on
        if(player_on == 1'b1)
        begin
            R <= player_R;
            G <= player_G;
            B <= player_B;
        end
        // check if enemy on
        if(enemy_on == 1'b1) 
        begin
            if(bullet_on)
            begin
                R <= background_R;
                G <= background_G;
                B <= background_B;
                temp_collide <= 1'b1;
            end else
            begin
                R <= 8'hFF; // default color for bullet
                G <= 8'hFF;
                B <= 8'hFF; 
                temp_collide <= 1'b0;
            end
        end



    end 
    
endmodule
