module top(input [6:0] btn,
           output [7:0] led,
           output wifi_gpio0);
              
   parameter BUTTON_CLOCK = 5; // The "Left" button on the ULX3S board
   parameter BUTTON_DATA  = 4; // The "Down" button
   parameter BUTTON_RESET = 6; // The "Right" button
   
   parameter LED_CLOCK = 0;
   parameter LED_DATA  = 1;
   parameter LED_RESET = 2;
   
   parameter LED_OUTPUT = 7;
   
   // Assign an LED to the output of the flipflop, connect the inputs to the buttons
   flipflop flipflop_1 (
   	.clock (btn[BUTTON_CLOCK]),
   	.reset (btn[BUTTON_RESET]),
   	.q     (btn[BUTTON_DATA]),
   	.d     (led[LED_OUTPUT])
   );
   
   // Assign the three input buttons to the LEDs   
   assign led[LED_CLOCK] = btn[BUTTON_CLOCK];
   assign led[LED_DATA] = btn[BUTTON_DATA];
   assign led[LED_RESET] = btn[BUTTON_RESET];
   
   // Turn off the unused LEDs
   assign led[6:3] = 4'b0000;
   
   // Disable the wifi
   assign wifi_gpio0 = 1'b1;

endmodule

module flipflop(input clock,
                input reset,
                input q,
                output reg d);
      
   // The D-type flipflop copies the input to the output on a clock edge
   // and resets to zero if the reset signal is asserted
   always @(posedge clock or posedge reset)
   begin
      if (reset)
         d <= 1'b0;
      else
         d <= q;
   end
   
endmodule
