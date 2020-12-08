module player(
    input Reset, input frame_clk, input [7:0] keycode,
    output[9:0] player_X
);

    logic [9:0] player_X_Pos, player_X_Motion, player_size;
    logic need_move; //2 can go any direction, 1 for need to move right, 0 for need to move left.
    parameter [9:0] player_X_Center=320;  // Center position on the X axis 320
    parameter [9:0] player_X_Min=20;       // Leftmost point on the X axis Min = 0
    parameter [9:0] player_X_Max=600;     // Rightmost point on the X axis Max = 639
    parameter [9:0] player_X_Step= 1;      // Step size on the X axis
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_player
        if (Reset)  // Asynchronous Reset
        begin 
          player_X_Motion <= 0; //player_X_Step;
          player_X_Pos <= player_X_Center;
        end           
        else 
        begin 					  
            if ( (player_X_Pos) >= player_X_Max )
                        begin
                            player_X_Motion <= 0;
                            need_move <= 0;
                        end					  
            else if ( (player_X_Pos) <= player_X_Min )
                        begin
                          player_X_Motion <= 0;
                          need_move <= 1;
                        end
            else if (keycode == 8'h04 && need_move != 1) // A
                        begin
                          player_X_Motion <= (~(player_X_Step)+1'b1);
                          need_move <= 2;
                        end
            else if( keycode == 8'h07 && need_move != 0) // D
                    begin
                      player_X_Motion <= player_X_Step;
                      need_move <= 2;
                    end
            else
                begin
                  player_X_Motion <= 0;
                  need_move <= 2;
                end
            player_X_Pos <= (player_X_Pos + player_X_Motion);
        end
    end       
    assign Player_X = player_X_Pos;

endmodule