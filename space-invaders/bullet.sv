module bullet(
    input Reset, input frame_clk, input [7:0] keycode,
    input hit, // send in logic for whether or not the bullet has collided, determined in colormapper.
    input [9:0] player_X_position,
    output [9:0] bullet_X, bullet_Y
    output bullet_on_screen // logic for whether or not the bullet should be there.
);

logic [9:0] bullet_X_pos, bullet_Y_pos, bullet_Y_motion, bullet_size;
logic exists, travel;

parameter bullet_Y_step = -1;
parameter bullet_Y_max = 0;
parameter bullet_Y_start = /* SOME START VALUE */ ;

assign bullet_size = /* SOME KIND OF NUMBER HERE */ ;

always_ff(posedge frame_clk or posedge Reset)
begin: bullet_move
    if(Reset) begin
        exists <= 1'b0;
        bullet_Y_motion <= 0;
        bullet_Y_pos <= bullet_Y_start;
    end
    else begin
            if(keycode == 8'hXX) // keycode for space
            begin
                exists <= 1'b1;
                bullet_Y_motion <= bullet_Y_step;
            end

            if(bullet_Y_max >= bullet_Y_pos + bullet_Y_motion || hit == 1'b1) // reaches ceiling / is hit.
            begin
                exists <= 1'b0;
                bullet_Y_pos <= bullet_Y_start;
                bullet_Y_motion <= 0;
            end
            else
            begin
                exists <= exists; // retain current state
                bullet_Y_motion <= bullet_Y_motion; // continue moving or staying still
            end         
    end
    travel <= exists;
    bullet_Y_pos <= bullet_Y_pos + bullet_Y_motion;
    bullet_X_pos <= player_X_position;
end

assign bullet_X = bullet_X_pos;
assign bullet_Y = bullet_Y_position;
assign bullet_on_screen = travel;

endmodule

