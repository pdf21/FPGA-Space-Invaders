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

module  color_mapper (  input logic [9:0] DrawX, DrawY,
                        input logic bullet_in,
                        // input start, //for purely the start screen, color not neeed.
                        input logic [9:0] bulletX, bulletY,
                        input logic [23:0] player_color,
                        input logic [7:0] enemy_R, enemy_G, enemy_B,
                        input logic player_on,
                        input logic enemy_on,
                        input logic [7:0] bg_R, bg_G, bg_B,
                       output logic [7:0]  Red, Green, Blue,
                        output logic hit);
    
    logic VGA_R, VGA_G, VGA_B;
    assign Red = VGA_R;
    assign Green = VGA_G;
    assign Blue = VGA_B;

     logic entity_on;

     logic [7:0] entity_data_R, entity_data_G, entity_data_B;
     always_comb begin
         entity_on <= player_on | enemy_on | bullet_in;
         entity_data_R <= enemy_R | player[23:16];
         entity_data_G <= enemy_G | player[15:8];
         entity_data_B <= enemy_B | player[7:0];
     end

     always_comb begin
         if(enemy_on && bullet_in) begin
             hit <= 1'b1;
         end
         else begin
             hit <= 1'b0;
         end
     end
    
    // int bullet_distY;
    // assign bullet_distY = DrawY - bulletY;
    //&& bullet_distY < 4 && bulletX == DrawX
    
    always_comb
    begin    
        if(bullet_in && DrawX == bulletX && DrawY < bulletY + 4 ) // Draws the bullet.
            begin
                VGA_R <= 8'hFF;
                VGA_G <= 8'hFF;
                VGA_B <= 8'hFF;
            end
        else if(entity_on)
            begin
                VGA_R <= entity_R;
                VGA_G <= entity_G;
                VGA_B <= entity_B;
            end
        else
            begin
                VGA_R <= 8'b0;
                VGA_G <= 8'b0;
                VGA_B <= 8'b0;
            end
            
    end 
    
endmodule
