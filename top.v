`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2014/07/28 15:03:27
// Design Name:
// Module Name: top
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module top(
    resetn,
    lcdclk,
    pb,
    sel,
    in_switching,
    carryin,
    lcd_rs,
    lcd_rw,
    lcd_en,
    lcd_data
 
);

input resetn;
input lcdclk;
input [2:0] pb;
input [5:0] sel;
input in_switching;
input carryin;
output lcd_rs;
output lcd_rw;
output lcd_en;
output [7:0] lcd_data;


wire resetn, lcdclk, lcd_rs, lcd_rw, lcd_en;
wire [7:0]lcd_data;
wire [2:0] pb;
wire [5:0] sel;
wire carryin;
wire [11:0] key_value_a;
wire [11:0] key_value_b;
wire [11:0] alu_out_value;


wire done;
wire done_div;

reg load;
reg gcd_load=0;
reg delay1,delay2;

textlcd utextlcd(
    .resetn(resetn),
    .lcdclk(lcdclk),
    .alu_out_value(alu_out_value),
    .pb(pb),
    .sel(sel),
    .in_switching(in_switching),
    .carryin(carryin),
    .lcd_rs(lcd_rs),
    .lcd_rw(lcd_rw),
    .lcd_en(lcd_en),
    .lcd_data(lcd_data),
    .key_value_a(key_value_a),
    .key_value_b(key_value_b)
   );
   
 alu ualu (
   .sel(sel),
   .carryin(carryin),
   .a_1(key_value_a),
   .b_1(key_value_b),
   .y(alu_out_value)
   );


  always @(posedge lcdclk)
     begin
     if(sel[5:0]==6'b101_000)
     begin
     load <= carryin;
     delay1 <= load;
     delay2 <= delay1;
         if(delay1 == 1 && delay2 == 0)
             gcd_load <= 1;
         else 
             gcd_load <= 0;
     end
     end

 
   endmodule