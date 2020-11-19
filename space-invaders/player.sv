module player(
    input Reset, input frame_clk, input [7:0] keycode,
    output[9:0] player_X, player_s
    output shoot_bullet
);

    logic [9:0] player_X_Pos, player_X_Motion, player_size;
    logic shoot, shooting;
    logic need_move; //2 can go any direction, 1 for need to move right, 0 for need to move left.
    parameter [9:0] player_X_Center=320;  // Center position on the X axis
    parameter [9:0] player_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] player_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] player_X_Step= 1;      // Step size on the X axis



    assign player_size = 4;  //NEED TO DETERMINE SIZE


   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_player
        if (Reset)  // Asynchronous Reset
        begin 
				player_X_Motion <= 10'd0; //player_X_Step;
				player_X_Pos <= player_X_Center;
                shoot = 0;
        end
           
        else 
        begin 					  
				if ( (player_X_Pos + player_size) >= player_X_Max )
					begin
                        player_X_Motion <= 0;
                        need_move <= 0;
                        shoot <= 0;
                    end					  
				else if ( (player_X_Pos - player_size) <= player_X_Min )
					begin
                      player_X_Motion <= 0;
                      need_move <= 1;
                      shoot <= 0;
                    end
				else if (keycode == 8'h04 && need_move != 1) // A
                    begin
                      player_X_Motion <= (~(player_X_Step)+1'b1);
                      need_move <= 2;
                      shoot <= 0;
                    end
                else if( keycode == 8'h07 && need_move != 0) // D
                    begin
                      player_X_Motion <= player_X_Step;
                      need_move <= 2;
                      shoot <= 0;
                    end
                else if(keycode == 8'hXX) // NEED TO ADD SPACE KEYCODE HERE, NOT SURE WHAT THIS IS
                    shoot <= 1;
                else
                begin
                    player_X_Motion <= 0;
                    need_move <= 2;
                    shoot <= 0;
                end

				shooting <= shoot;
				player_X_Pos <= (player_X_Pos + player_X_Motion);
		end
    end
       
    assign Player_X = player_X_Pos;
    assign shoot_bullet = shooting;
    assign player_s = player_size;