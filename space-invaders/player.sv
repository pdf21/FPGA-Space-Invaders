module player(
    input logic Reset, frame_clk, Clk, 
    input logic [7:0] keycode,
    // input logic [9:0] player_initial_x, player_initial_y,
    input logic [9:0] DrawX, DrawY,
    output logic player_on,
    output logic [23:0] player_color
);

    parameter [9:0] player_X_Center=320;  // Center position on the X axis 320
    parameter [9:0] player_X_Min=20;       // Leftmost point on the X axis Min = 0
    parameter [9:0] player_X_Max=600;     // Rightmost point on the X axis Max = 639
    parameter [9:0] player_X_Step= 1;      // Step size on the X axis
    parameter [9:0] player_Y_Center = 420;


    logic [9:0] player_start_X, player_start_Y; // position on screen

    int IMAGE_WIDTH = 10'd36; 
    int IMAGE_HEIGHT = 10'd40;
    
    logic [9:0] player_X_Pos, player_Y_Pos; // position on sprite

    enum {
        IDLE,       // awaiting start signal
        START,      // prepare for new sprite drawing
        AWAIT_POS,  // await horizontal position
        DRAW,       // draw pixel
        NEXT_LINE   // prepare for next sprite line
    } state, next_state;
   
   logic start_draw;

   logic [18:0] read_address;

  //  initial begin
  //   player_start_X = player_X_Center;
  //   player_start_Y = player_Y_Center;
  //  end

   always_comb begin // Check when to draw
     if(DrawX == player_start_X + player_X_Pos && DrawY == player_start_Y + player_Y_Pos)
        start_draw = 1'b1;
      else
        start_draw = 1'b0;
   end

   always_ff @ (posedge frame_clk) begin // MOTION
        if(keycode == 8'h04 && player_start_X > 0) // A
          player_start_X <= player_start_X - 5;
        else if (keycode == 8'h07 && player_start_X < 563) // D
          player_start_X <= player_start_X + 5;
        else if (Reset) begin
          player_start_X = player_X_Center;
          player_start_Y = player_Y_Center;
        end
        else
          player_start_X <= player_start_X;
   end

   player_spriteRAM player_inst(
        .data_In(5'b0),
        .write_address(19'b0),
        .read_address(read_address),
        .we(1'b0),
        .Clk(frame_clk),
        .data_Out(player_color)
   );
  
  always_ff @ (posedge frame_clk) begin
    state <= next_state;

    if(state == START) begin
        player_Y_Pos <= 0;
        read_address <= 0;
        player_on <= 1'b0;
    end

    if(state == AWAIT_POS) begin
        player_X_Pos <= 0;
        player_on <= 1'b0;
    end

    if(state == DRAW) begin
        player_X_Pos <= player_X_Pos + 1;
        read_address <= read_address + 1;
        player_on <= 1'b1;
    end

    if(state == NEXT_LINE) begin
        player_Y_Pos <= player_Y_Pos + 1;
        player_on <= 1'b0;
    end

    if(Reset) begin
      state <= IDLE;
      player_X_Pos <= 0;
      player_Y_Pos <= 0;
      read_address <= 0;
      player_on <= 1'b0;            
    end
  end

  logic last_pixel, last_line;
  always_comb begin
      last_pixel = (player_X_Pos == IMAGE_WIDTH-1);
      last_line  = (player_Y_Pos == IMAGE_HEIGHT-1);
  end

  // determine next state
  always_comb begin
        case(state)
            IDLE:       next_state = start_draw ? START : IDLE;
            START:      next_state = AWAIT_POS;
            AWAIT_POS:  next_state = (DrawX == player_X_Pos) ? DRAW : AWAIT_POS;
            DRAW:       next_state = !last_pixel ? DRAW : (!last_line ? NEXT_LINE : IDLE);
            NEXT_LINE:  next_state = AWAIT_POS;
            default:    next_state = IDLE;
        endcase
  end

endmodule