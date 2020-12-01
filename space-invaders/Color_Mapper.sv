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

module  color_mapper ( input        [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
                                          enemy_on, player_on, bullet_on,
                                    input start, //for purely the start screen, color not neeed.
                        input [7:0] enemy_R, enemy_G, enemy_B,
                                          player_R, player_G, player_B,
                                          bullet_R, bullet_G, bullet_B,
                       output logic [7:0]  Red, Green, Blue );
    
    logic ball_on;
	 
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*Ball_Size, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 12 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	  
    int DistX, DistY, Size;
	assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size = Ball_size;



       
    always_comb
    begin:RGB_Display
        // check if start is on.
        if(start == 1'b1 &&
			DrawX >= 280 &&
			DrawX < 360 &&
			DrawY >= 208 &&
			DrawY < 272)
        begin
            R <= 8'hFF;
            G <= 8'hFF;
            B <= 8'hFF;
        end
        else begin
            R <= 8'h00;
            G <= 8'h00;
            B <= 8'h00;
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
            R <= enemy_R;
            G <= enemy_G;
            B <= enemy_B;
        end
        // check if bullet on
        if(bullet_on == 1'b1)
        begin
            R <= bullet_R;
            G <= bullet_G;
            B <= bullet_B;
        end
    end 
    
endmodule
