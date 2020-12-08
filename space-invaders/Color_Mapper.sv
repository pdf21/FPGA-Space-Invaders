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

module  color_mapper (  input [9:0] DrawX, DrawY,
                        input bullet_in,
                        // input start, //for purely the start screen, color not neeed.
                        input [9:0] bulletX, bulletY, playerX,
                        input [23:0] player_color,
                        // input [7:0] enemy_R, enemy_G, enemy_B,
                        // player_R, player_G, player_B,
                        // bullet_R, bullet_G, bullet_B,
                        // background_R, background_G, background_B,
                        // output logic collision
                       output logic [7:0]  Red, Green, Blue);
    
    logic VGA_R, VGA_G, VGA_B;
    logic bullet_on, player_on;
    assign Red = VGA_R;
    assign Green = VGA_G;
    assign Blue = VGA_B;


    //Bullet should just be a straight vertical line of size 3 pixels. We can
    //adjust this according to however we want.

    int bullet_distY;
    assign bullet_distY = DrawY - bulletY;
/*
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
    */

    always_comb
    begin: player_on_proc
        if(DrawY >= 100 && DrawY <= 137 && DrawX == playerX) // 150 is the height on the screen of the player
            player_on = 1'b1;
        else
            player_on = 1'b0;
    end
       
    
    always_comb
    begin    
    if(bullet_in && bullet_distY < 4 && bulletX == DrawX) // Draws the bullet.
        begin
            VGA_R = 8'hFF;
            VGA_G = 8'hFF;
            VGA_B = 8'hFF;
        end
    else if(player_on)
        begin
            VGA_R = player_color[23:16];
            VGA_G = player_color[15:8];
            VGA_B = player_color[7:0];
        end
    else
        begin
            VGA_R = 8'h00;
            VGA_G = 8'h00;
            VGA_B = 8'h00;
        end

    end 
    
endmodule
