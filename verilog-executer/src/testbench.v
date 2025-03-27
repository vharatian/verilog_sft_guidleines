module vga_controller_tb;


    reg clk;

    wire h_sync;

    wire v_sync;

    wire [7:0] red, green, blue;


    initial begin

        clk <= 0;

        forever #10 clk <= ~clk; // 100 MHz clock frequency (50ns period)

    end


    vga_controller UUT (

        .clk(clk),

        .h_sync(h_sync),

        .v_sync(v_sync),

        .red(red),

        .green(green),

        .blue(blue)

    );


    initial begin

        $monitor ("clk=%b, h_sync=%b, v_sync=%b, red=%08b, green=%08b, blue=%08b",

            clk, h_sync, v_sync, red, green, blue);

        #1000000 $finish;

    end

endmodule