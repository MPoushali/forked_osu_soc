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
       tpllh$A$Y = 0.22:0.22:0.22,
       tphhl$A$Y = 0.23:0.23:0.23;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule

`endcelldefine
