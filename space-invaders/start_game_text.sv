module start_logic(
    input Reset,
    input 
);

module start_game_text(
    input [10:0] address,
    output [7:0] out_data
);
    parameter ADDR_WIDTH = 11;
    parameter DATA_WIDTH = 8;
    parameter[0: 2**ADDR_WIDTH-1][DATA_WIDTH - 1:0] ROM = {
        8'b00000000, // 0
        8'b00000000, // 1
        8'b11111100, // 2 ******
        8'b01100110, // 3  **  **
        8'b01100110, // 4  **  **
        8'b01100110, // 5  **  **
        8'b01111100, // 6  *****
        8'b01100000, // 7  **
        8'b01100000, // 8  **
        8'b01100000, // 9  **
        8'b01100000, // a  **
        8'b11110000, // b ****
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f
        8'b00000000, // 0
        8'b00000000, // 1
        8'b11111100, // 2 ******
        8'b01100110, // 3  **  **
        8'b01100110, // 4  **  **
        8'b01100110, // 5  **  **
        8'b01111100, // 6  *****
        8'b01101100, // 7  ** **
        8'b01100110, // 8  **  **
        8'b01100110, // 9  **  **
        8'b01100110, // a  **  **
        8'b11100110, // b ***  **
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f
        8'b00000000, // 0
        8'b00000000, // 1
        8'b11111110, // 2 *******
        8'b01100110, // 3  **  **
        8'b01100010, // 4  **   *
        8'b01101000, // 5  ** *
        8'b01111000, // 6  ****
        8'b01101000, // 7  ** *
        8'b01100000, // 8  **
        8'b01100010, // 9  **   *
        8'b01100110, // a  **  **
        8'b11111110, // b *******
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f
        8'b00000000, // 0
        8'b00000000, // 1
        8'b01111100, // 2  *****
        8'b11000110, // 3 **   **
        8'b11000110, // 4 **   **
        8'b01100000, // 5  **
        8'b00111000, // 6   ***
        8'b00001100, // 7     **
        8'b00000110, // 8      **
        8'b11000110, // 9 **   **
        8'b11000110, // a **   **
        8'b01111100, // b  *****
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f
        8'b00000000, // 0
        8'b00000000, // 1
        8'b01111100, // 2  *****
        8'b11000110, // 3 **   **
        8'b11000110, // 4 **   **
        8'b01100000, // 5  **
        8'b00111000, // 6   ***
        8'b00001100, // 7     **
        8'b00000110, // 8      **
        8'b11000110, // 9 **   **
        8'b11000110, // a **   **
        8'b01111100, // b  *****
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f
        8'b00000000, // 0
        8'b00000000, // 1
        8'b00000000, // 2
        8'b00000000, // 3
        8'b00000000, // 4
        8'b00000000, // 5
        8'b00000000, // 6
        8'b00000000, // 7
        8'b00000000, // 8
        8'b00000000, // 9
        8'b00000000, // a
        8'b00000000, // b
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f
        8'b00000000, // 0
        8'b00000000, // 1
        8'b11111111, // 2 ********
        8'b11011011, // 3 ** ** **
        8'b10011001, // 4 *  **  *
        8'b00011000, // 5    **
        8'b00011000, // 6    **
        8'b00011000, // 7    **
        8'b00011000, // 8    **
        8'b00011000, // 9    **
        8'b00011000, // a    **
        8'b00111100, // b   ****
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f
        8'b00000000, // 0
        8'b00000000, // 1
        8'b01111100, // 2  *****
        8'b11000110, // 3 **   **
        8'b11000110, // 4 **   **
        8'b11000110, // 5 **   **
        8'b11000110, // 6 **   **
        8'b11000110, // 7 **   **
        8'b11000110, // 8 **   **
        8'b11000110, // 9 **   **
        8'b11000110, // a **   **
        8'b01111100, // b  *****
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f
        8'b00000000, // 0
        8'b00000000, // 1
        8'b00000000, // 2
        8'b00000000, // 3
        8'b00000000, // 4
        8'b00000000, // 5
        8'b00000000, // 6
        8'b00000000, // 7
        8'b00000000, // 8
        8'b00000000, // 9
        8'b00000000, // a
        8'b00000000, // b
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f
        8'b00000000, // 0
        8'b00000000, // 1
        8'b01111100, // 2  *****
        8'b11000110, // 3 **   **
        8'b11000110, // 4 **   **
        8'b01100000, // 5  **
        8'b00111000, // 6   ***
        8'b00001100, // 7     **
        8'b00000110, // 8      **
        8'b11000110, // 9 **   **
        8'b11000110, // a **   **
        8'b01111100, // b  *****
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f
        8'b00000000, // 0
        8'b00000000, // 1
        8'b11111111, // 2 ********
        8'b11011011, // 3 ** ** **
        8'b10011001, // 4 *  **  *
        8'b00011000, // 5    **
        8'b00011000, // 6    **
        8'b00011000, // 7    **
        8'b00011000, // 8    **
        8'b00011000, // 9    **
        8'b00011000, // a    **
        8'b00111100, // b   ****
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f
        8'b00000000, // 0
        8'b00000000, // 1
        8'b00010000, // 2    *
        8'b00111000, // 3   ***
        8'b01101100, // 4  ** **
        8'b11000110, // 5 **   **
        8'b11000110, // 6 **   **
        8'b11111110, // 7 *******
        8'b11000110, // 8 **   **
        8'b11000110, // 9 **   **
        8'b11000110, // a **   **
        8'b11000110, // b **   **
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f
        8'b00000000, // 0
        8'b00000000, // 1
        8'b11111100, // 2 ******
        8'b01100110, // 3  **  **
        8'b01100110, // 4  **  **
        8'b01100110, // 5  **  **
        8'b01111100, // 6  *****
        8'b01101100, // 7  ** **
        8'b01100110, // 8  **  **
        8'b01100110, // 9  **  **
        8'b01100110, // a  **  **
        8'b11100110, // b ***  **
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f
        8'b00000000, // 0
        8'b00000000, // 1
        8'b11111111, // 2 ********
        8'b11011011, // 3 ** ** **
        8'b10011001, // 4 *  **  *
        8'b00011000, // 5    **
        8'b00011000, // 6    **
        8'b00011000, // 7    **
        8'b00011000, // 8    **
        8'b00011000, // 9    **
        8'b00011000, // a    **
        8'b00111100, // b   ****
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f
    };
    assign out_data = ROM[address];

endmodule;