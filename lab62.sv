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




logic Reset_h, vssig, blank, sync, VGA_Clk;


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

////=======================================================
////  Structural coding
////=======================================================
//	assign ARDUINO_IO[10] = SPI0_CS_N;
//	assign ARDUINO_IO[13] = SPI0_SCLK;
//	assign ARDUINO_IO[11] = SPI0_MOSI;
//	assign ARDUINO_IO[12] = 1'bZ;
//	assign SPI0_MISO = ARDUINO_IO[12];
//	
//	assign ARDUINO_IO[9] = 1'bZ; 
//	assign USB_IRQ = ARDUINO_IO[9];
//		
//	//Assignments specific to Circuits At Home UHS_20
//	assign ARDUINO_RESET_N = USB_RST;
//	assign ARDUINO_IO[7] = USB_RST;//USB reset 
//	assign ARDUINO_IO[8] = 1'bZ; //this is GPX (set to input)
//	assign USB_GPX = 1'b0;//GPX is not needed for standard USB host - set to 0 to prevent interrupt
//	
//	//Assign uSD CS to '1' to prevent uSD card from interfering with USB Host (if uSD card is plugged in)
//	assign ARDUINO_IO[6] = 1'b1;
//	
//	//HEX drivers to convert numbers to HEX output
//	HexDriver hex_driver4 (hex_num_4, HEX4[6:0]);
//	assign HEX4[7] = 1'b1;
//	
//	HexDriver hex_driver3 (hex_num_3, HEX3[6:0]);
//	assign HEX3[7] = 1'b1;
//	
//	HexDriver hex_driver1 (hex_num_1, HEX1[6:0]);
//	assign HEX1[7] = 1'b1;
//	
//	HexDriver hex_driver0 (hex_num_0, HEX0[6:0]);
//	assign HEX0[7] = 1'b1;
//	
//	//fill in the hundreds digit as well as the negative sign
//	assign HEX5 = {1'b1, ~signs[1], 3'b111, ~hundreds[1], ~hundreds[1], 1'b1};
//	assign HEX2 = {1'b1, ~signs[0], 3'b111, ~hundreds[0], ~hundreds[0], 1'b1};
//	
//	
	//Assign one button to reset
	assign {Reset_h}=~ (KEY[0]);

//Our A/D converter is only 12 bit
assign VGA_R = Red[7:4];
assign VGA_B = Blue[7:4];
assign VGA_G = Green[7:4];
//	
//	
//	lab62_soc u0 (
//		.clk_clk                           (MAX10_CLK1_50),  //clk.clk
//		.reset_reset_n                     (1'b1),           //reset.reset_n
//		.altpll_0_locked_conduit_export    (),               //altpll_0_locked_conduit.export
//		.altpll_0_phasedone_conduit_export (),               //altpll_0_phasedone_conduit.export
//		.altpll_0_areset_conduit_export    (),               //altpll_0_areset_conduit.export
//		.key_external_connection_export    (KEY),            //key_external_connection.export
//
//		//SDRAM
//		.sdram_clk_clk(DRAM_CLK),                            //clk_sdram.clk
//		.sdram_wire_addr(DRAM_ADDR),                         //sdram_wire.addr
//		.sdram_wire_ba(DRAM_BA),                             //.ba
//		.sdram_wire_cas_n(DRAM_CAS_N),                       //.cas_n
//		.sdram_wire_cke(DRAM_CKE),                           //.cke
//		.sdram_wire_cs_n(DRAM_CS_N),                         //.cs_n
//		.sdram_wire_dq(DRAM_DQ),                             //.dq
//		.sdram_wire_dqm({DRAM_UDQM,DRAM_LDQM}),              //.dqm
//		.sdram_wire_ras_n(DRAM_RAS_N),                       //.ras_n
//		.sdram_wire_we_n(DRAM_WE_N),                         //.we_n
//
//		//USB SPI	
//		.spi0_SS_n(SPI0_CS_N),
//		.spi0_MOSI(SPI0_MOSI),
//		.spi0_MISO(SPI0_MISO),
//		.spi0_SCLK(SPI0_SCLK),
//		
//		//USB GPIO
//		.usb_rst_export(USB_RST),
//		.usb_irq_export(USB_IRQ),
//		.usb_gpx_export(USB_GPX),
//		
//		//LEDs and HEX
//		.hex_digits_export({hex_num_4, hex_num_3, hex_num_1, hex_num_0}),
//		.leds_export({hundreds, signs, LEDR}),
//		.keycode_export(keycode)
//		
//	 );

logic [23:0] s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15;
logic [23:0] x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15;
logic input_ready,frame_completed;

FastFourierTransform fft(.*,.Clk(MAX10_CLK1_50),.Reset(Reset_h),.Ready(input_ready),.frame_completed(frame_completed));

// RAM initialization
logic [14:0] RAM_ADDR;
logic [15:0] RAM_IN, RAM_OUT;
logic RAM_RDEN, RAM_WREN;

ram ram0(.address(RAM_ADDR),.clock(MAX10_CLK1_50),.data(RAM_IN),.rden(RAM_RDEN),.wren(RAM_WREN),.q(RAM_OUT));

// FSM 
logic [5:0] sample_index,next_sample_index;
logic sample_writeen,address_increment;
enum logic [2:0] {halt,wait_for_mem0,wait_for_mem1,write,increment} curr_state, next_state;

always_ff @ (posedge MAX10_CLK1_50 or posedge Reset_h)
begin

	if(Reset_h)
		begin
		curr_state <= halt;
		sample_index <= 6'd0;
		RAM_ADDR <= 15'h0;
		end
	else if (~Reset_h && address_increment)
		begin
		RAM_ADDR <= RAM_ADDR + 15'd1;
		curr_state <= next_state;
		sample_index <= next_sample_index;
		end
	else
		begin
		curr_state <= next_state;
		sample_index <= next_sample_index;
		end
end

// increment address and record data from memory
always_ff @ (posedge MAX10_CLK1_50)
begin
	if (sample_writeen)
	begin
		case(sample_index)
			6'd0:
				s0 <= 16'd0; // RAM_OUT;
			6'd1:
				s1 <= 16'd1;// RAM_OUT;
			6'd2:
				s2 <= 16'd2;// RAM_OUT;
			6'd3:
				s3 <= 16'd3;// RAM_OUT;
			6'd4:
				s4 <= 16'd4;// RAM_OUT;
			6'd5:
				s5 <= 16'd5;// RAM_OUT;
			6'd6:
				s6 <= 16'd6;// RAM_OUT;
			6'd7:
				s7 <= 16'd7;// RAM_OUT;
			6'd8:
				s8 <= 16'd8;// RAM_OUT;
			6'd9:
				s9 <= 16'd9;// RAM_OUT;
			6'd10:
				s10 <= 16'd10;// RAM_OUT;
			6'd11:
				s11 <= 16'd11;// RAM_OUT;
			6'd12:
				s12 <= 16'd12;// RAM_OUT;
			6'd13:
				s13 <= 16'd13;// RAM_OUT;
			6'd14:
				s14 <= 16'd14;// RAM_OUT;
			6'd15:
				s15 <= 16'd15;// RAM_OUT;
		endcase
	end
end

always_comb 
begin

	// default values for control signals
	address_increment = 1'b0;
	sample_writeen = 1'b0;
	RAM_RDEN = 1'b0;
	RAM_WREN = 1'b0;
	next_sample_index = sample_index;
	next_state = curr_state;
	input_ready = 1'b0;

	case(curr_state)
	
	halt:
		begin
		if(frame_completed)
			next_state = wait_for_mem0;
		else
			next_state = halt;
		next_sample_index = 6'd0;
		input_ready = 1'b1;
		end
	wait_for_mem0:
		begin
		next_state = wait_for_mem1;
		RAM_RDEN = 1'b1;
		end
	wait_for_mem1:
		begin
		next_state = write;
		RAM_RDEN = 1'b1;
		end
	write:
		begin
		sample_writeen = 1'b1;
		next_state = increment;
		RAM_RDEN = 1'b1;
		end
	increment:
		begin
		address_increment = 1'b1;
		if(sample_index == 6'd15)
			begin
			next_sample_index = 6'd0;
			next_state = halt;
			input_ready = 1'b1;
			end
		else 
			begin
			next_sample_index = sample_index + 6'd1;
			next_state = wait_for_mem0;
			end
		end
	default:
		begin
		next_state = halt;
		next_sample_index = 6'dx;
		end
	endcase

end

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
