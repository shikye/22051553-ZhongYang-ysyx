// Generated by CIRCT unknown git version
module Mux(	// <stdin>:2:10
  input        clk,
               reset,
  input  [2:0] io_value0,
               io_value1,
  input        io_sel,
  output [2:0] io_out);

  assign io_out = io_sel ? io_value1 : io_value0;	// <stdin>:2:10, Mux.scala:11:{30,39,74}
endmodule

