//-------------------------------------------------------------------------
//                                                                       --
//                                                                       --
//      For use with ECE 385 Lab 62                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab62 (

      ///////// Clocks /////////
      input     MAX10_CLK1_50, 

      ///////// KEY /////////
      input    [ 1: 0]   KEY,

      ///////// SW /////////
      input    [ 9: 0]   SW,

      ///////// LEDR /////////
      output   [ 9: 0]   LEDR,

      ///////// HEX /////////
      output   [ 7: 0]   HEX0,
      output   [ 7: 0]   HEX1,
      output   [ 7: 0]   HEX2,
      output   [ 7: 0]   HEX3,
      output   [ 7: 0]   HEX4,
      output   [ 7: 0]   HEX5,

      ///////// SDRAM /////////
      output             DRAM_CLK,
      output             DRAM_CKE,
      output   [12: 0]   DRAM_ADDR,
      output   [ 1: 0]   DRAM_BA,
      inout    [15: 0]   DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_UDQM,
      output             DRAM_CS_N,
      output             DRAM_WE_N,
      output             DRAM_CAS_N,
      output             DRAM_RAS_N,

      ///////// VGA /////////
      output             VGA_HS,
      output             VGA_VS,
      output   [ 3: 0]   VGA_R,
      output   [ 3: 0]   VGA_G,
      output   [ 3: 0]   VGA_B,


      ///////// ARDUINO /////////
      inout    [15: 0]   ARDUINO_IO,
      inout              ARDUINO_RESET_N 

);




logic Reset_h, vssig, blank, sync, VGA_Clk,Button;


//=======================================================
//  REG/WIRE declarations
//=======================================================
	logic SPI0_CS_N, SPI0_SCLK, SPI0_MISO, SPI0_MOSI, USB_GPX, USB_IRQ, USB_RST;
	logic [3:0] hex_num_4, hex_num_3, hex_num_1, hex_num_0; //4 bit input hex digits
	logic [1:0] signs;
	logic [1:0] hundreds;
	logic [9:0] drawxsig, drawysig, ballxsig, ballysig, ballsizesig;
	logic [7:0] Red, Blue, Green;
	logic [7:0] keycode;

//=======================================================
//  Structural coding
//=======================================================
	
	//Assign one button to reset
	assign {Reset_h}=~ (KEY[0]);
	assign Button_h = ~(KEY[1]);

	//Our A/D converter is only 12 bit
	assign VGA_R = Red[7:4];
	assign VGA_B = Blue[7:4];
	assign VGA_G = Green[7:4];

//instantiate a vga_controller, ball, and color_mapper here with the ports.

vga_controller vga(.Clk(MAX10_CLK1_50),       // 50 MHz clock
						.Reset(Reset_h),     // reset signal
                  .hs(VGA_HS),        // Horizontal sync pulse.  Active low
						.vs(VGA_VS),        // Vertical sync pulse.  Active low
						.pixel_clk(VGA_CLK), // 25 MHz pixel clock output
						.blank(blank),     // Blanking interval indicator.  Active low.
						.sync(sync),      // Composite Sync signal.  Active low.  We don't use it in this lab,
										//   but the video DAC on the DE2 board requires an input for it.
						.DrawX(drawxsig),     // horizontal coordinate
						.DrawY(drawysig) // vertical coordinate

);

ball balls(
					.Reset(Reset_h), .frame_clk(VGA_VS),
					.keycode(keycode),
               .BallX(ballxsig), .BallY(ballysig), .BallS(ballsizesig)
);

color_mapper color(
	.BallX(ballxsig), .BallY(ballysig), .DrawX(drawxsig), .DrawY(drawysig), .Ball_size(ballsizesig),.Clk(MAX10_CLK1_50),.Button(Button_h),
	.Red(Red), .Green(Green), .Blue(Blue)
);

//bar_graph bar(
//
//	// System clock
//	.MAX10_CLK1_50(MAX10_CLK1_50),
//	// Button
//	.Reset(Reset_h),
//	// Switch input
//	.SW(SW),
//	// VGA
//	.VGA_R(Red),.VGA_G(Green),.VGA_B(Blue)
//);

endmodule
