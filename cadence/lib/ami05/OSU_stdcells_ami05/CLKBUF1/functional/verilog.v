// Created by ihdl
`timescale 1ns/10ps

`celldefine

module CLKBUF1 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.25:0.25:0.25,
       tphhl$A$Y = 0.26:0.26:0.26;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule

`endcelldefine
