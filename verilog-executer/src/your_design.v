module vga_controller (

    input  clk,

    output reg h_sync,

    output reg v_sync,

    output reg [7:0] red,

    output reg [7:0] green,

    output reg [7:0] blue

);


    localparam WIDTH     = 640;

    localparam HEIGHT    = 480;

    localparam H_FRONT_PORCH = 16;

    localparam H_SYNC_PULSE  = 96;

    localparam H_BACK_PORCH  = 48;

    localparam V_FRONT_PORCH = 10;

    localparam V_SYNC_PULSE  = 2;

    localparam V_BACK_PORCH  = 33;


    reg [11:0] h_count = 0;

    reg [10:0] v_count = 0;

    reg [7:0] pixel_color = 0;


    always @(posedge clk) begin

        h_count <= h_count + 1;

        

        if (h_count >= WIDTH + H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH) begin

            h_count <= 0;

            v_count <= v_count + 1;

        end


        if (v_count >= HEIGHT + V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH) begin

            v_count <= 0;

            h_count <= 0;

            pixel_color <= 0;

        end


        h_sync <= (h_count >= WIDTH + H_FRONT_PORCH && h_count < WIDTH + H_FRONT_PORCH + H_SYNC_PULSE);

        v_sync <= (v_count >= HEIGHT + V_FRONT_PORCH && v_count < HEIGHT + V_FRONT_PORCH + V_SYNC_PULSE);


        // Set pixel colors: we'll keep it simple with solid black for this example

        if (h_count < WIDTH && v_count < HEIGHT) begin

            pixel_color <= 8'hFF; // White color

        end


        red <= pixel_color; // For simplicity, same for all RGB

        green <= pixel_color;

        blue <= pixel_color;

    end

endmodule