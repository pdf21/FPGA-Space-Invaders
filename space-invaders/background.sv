module background(
    input   logic Reset, input logic frame_clk, input logic Clk, input is_playing,
    input   logic [9:0] DrawX, DrawY,
    input   logic start,
    output  logic enemy_on,
    output  logic [7:0] bg_R, bg_G, bg_B
);
    logic   enemy_enable;
    logic   [9:0] enemy_x, enemy_y, next_enemy_y;
    parameter enemy_step_X, enemy_step_Y;

    int IMAGE_WIDTH = 9'd640; 
    int IMAGE_HEIGHT = 9'd480;

    logic [18:0] pos; //position inside memory ARRAY
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
    always_comb begin
        if(is_playing == 1'b1) begin
            start_background = 1'b1;
        end
    end

    backgroundRAM my_background(
        .data_in(5'b0),
        .write_address(19'b0),
        .read_address(read_addr),
        .we(1'b0),
        .Clk(Clk),
        .data_out({enemy_sprite_R, enemy_sprite_G, enemy_sprite_B})
    );
    // 2 always: outputs of each state
             //  handling of next state
    // accessing memory = row no * width + col no
    // always happens:
    always_comb begin
        if(enemy_on == 1'b1) begin
            bg_R <= enemy_sprite_R;
            bg_G <= enemy_sprite_G;
            bg_B <= enemy_sprite_B;
        end
        else begin
            enemy_R <= 8'b0;
            enemy_G <= 8'b0;
            enemy_B <= 8'b0;
        end 
    end

    always_ff @ (posedge Clk) begin
           state <= state_next;

           if(state == START)begin
               enemy_y <= 0;
               pos <= 0;
               enemy_on <= 1'b0;
           end

           if(state == AWAIT_POS)begin
               enemy_x<= 0;
               enemy_on <= 1'b0;
           end

           if(state == DRAW) begin
               enemy_x <= enemy_x + 1;
               pos <= pos + 1;
               enemy_on <= 1'b1;
           end

           if(state == NEXT_LINE) begin
               enemy_y <= enemy_y + 1;
               enemy_on <= 1'b0;
           end
            if (state == BEFORE_GAME_START) begin
                enemy_on <= 1'b0;
            end

            if (state == FINISHED) begin
                enemy_on <= 1'b0;
            end

           if(Reset) begin
               state <= IDLE;
               enemy_x <= 0;
               enemy_y <= 0;
               pos <= 0;
               enemy_on <= 1'b0;
           end
    end
             
    logic final_pixel;
    logic final_line;

    always_comb begin
        final_pixel = (enemy_x == IMAGE_WIDTH - 1);
        final_line = (enemy_y == IMAGE_HEIGHT - 1);
    end
    

    always_comb begin
        case(state)
            BEFORE_GAME_START: state_next = start_game ? IDLE : BEFORE_GAME_START;
            IDLE:       state_next = is_playing ? START: IDLE;
            START:      state_next = AWAIT_POS;
            AWAIT_POS:  state_next = enemy_x == Draw_X ? DRAW : AWAIT_POS;
            DRAW:       state_next = !last_pixel ? DRAW : (!last_line ? NEXT_LINE : IDLE);
            NEXT_LINE:  state_next = AWAIT_POS;
            FINISHED:   state_next = is_playing ? IDLE:FINISHED;
            default:    state_next = IDLE;
        endcase
    end
    
endmodule