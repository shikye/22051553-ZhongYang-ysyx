module ysyx_22051553_Fetch(
  input         clock,
  input         reset,
  output [63:0] io_fdio_pc,
  output        io_pc_valid,
  output [63:0] io_pc_bits,
  input         io_fcfe_jump_flag,
  input  [63:0] io_fcfe_jump_pc,
  input         io_fcfe_flush,
  input         io_fcfe_stall
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg  started; // @[Fetch.scala 25:26]
  reg [63:0] pc; // @[Fetch.scala 28:21]
  reg [63:0] old_pc; // @[Fetch.scala 29:25]
  wire  _next_pc_T_2 = io_fcfe_flush & io_fcfe_jump_flag; // @[Fetch.scala 36:36]
  wire [63:0] _next_pc_T_4 = io_fcfe_jump_pc + 64'h4; // @[Fetch.scala 36:85]
  wire [63:0] _next_pc_T_7 = pc + 64'h4; // @[Fetch.scala 37:37]
  wire [63:0] _next_pc_T_8 = started ? _next_pc_T_7 : pc; // @[Mux.scala 101:16]
  wire [63:0] next_pc = _next_pc_T_2 ? _next_pc_T_4 : _next_pc_T_8; // @[Mux.scala 101:16]
  wire  _io_fdio_pc_T_3 = pc == old_pc; // @[Fetch.scala 54:17]
  wire [63:0] _io_fdio_pc_T_4 = _io_fdio_pc_T_3 ? next_pc : pc; // @[Mux.scala 101:16]
  wire [63:0] _io_fdio_pc_T_5 = _next_pc_T_2 ? io_fcfe_jump_pc : _io_fdio_pc_T_4; // @[Mux.scala 101:16]
  assign io_fdio_pc = io_fcfe_stall ? old_pc : _io_fdio_pc_T_5; // @[Mux.scala 101:16]
  assign io_pc_valid = started; // @[Fetch.scala 71:23]
  assign io_pc_bits = io_fcfe_stall ? old_pc : _io_fdio_pc_T_5; // @[Mux.scala 101:16]
  always @(posedge clock) begin
    if (reset) begin // @[Fetch.scala 25:26]
      started <= 1'h0; // @[Fetch.scala 25:26]
    end else begin
      started <= 1'h1; // @[Fetch.scala 26:13]
    end
    if (reset) begin // @[Fetch.scala 28:21]
      pc <= 64'h30000000; // @[Fetch.scala 28:21]
    end else if (io_fcfe_stall) begin // @[Fetch.scala 43:14]
      pc <= old_pc;
    end else if (_next_pc_T_2) begin // @[Mux.scala 101:16]
      pc <= _next_pc_T_4;
    end else if (started) begin // @[Mux.scala 101:16]
      pc <= _next_pc_T_7;
    end
    if (reset) begin // @[Fetch.scala 29:25]
      old_pc <= 64'h0; // @[Fetch.scala 29:25]
    end else if (started) begin // @[Fetch.scala 45:18]
      old_pc <= io_fdio_pc;
    end else begin
      old_pc <= 64'h0;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  started = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  pc = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  old_pc = _RAND_2[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_22051553_ControlUnit(
  input  [31:0] io_inst,
  output [1:0]  io_jump_type,
  output        io_branch_type,
  output [1:0]  io_opa_type,
  output [2:0]  io_opb_type,
  output [2:0]  io_imm_type,
  output [5:0]  io_alu_op,
  output [1:0]  io_wb_type,
  output [2:0]  io_sd_type,
  output [2:0]  io_ld_type,
  output [1:0]  io_csr_type
);
  wire  _controlsig_T_1 = 32'h13 == io_inst; // @[Lookup.scala 31:38]
  wire [31:0] _controlsig_T_2 = io_inst & 32'h7f; // @[Lookup.scala 31:38]
  wire  _controlsig_T_3 = 32'h17 == _controlsig_T_2; // @[Lookup.scala 31:38]
  wire  _controlsig_T_5 = 32'h37 == _controlsig_T_2; // @[Lookup.scala 31:38]
  wire  _controlsig_T_7 = 32'h6f == _controlsig_T_2; // @[Lookup.scala 31:38]
  wire [31:0] _controlsig_T_8 = io_inst & 32'h707f; // @[Lookup.scala 31:38]
  wire  _controlsig_T_9 = 32'h67 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_11 = 32'h63 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_13 = 32'h1063 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_15 = 32'h4063 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_17 = 32'h5063 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_19 = 32'h6063 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_21 = 32'h7063 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_23 = 32'h3 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_25 = 32'h1003 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_27 = 32'h2003 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_29 = 32'h4003 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_31 = 32'h5003 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_33 = 32'h6003 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_35 = 32'h3003 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_37 = 32'h23 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_39 = 32'h1023 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_41 = 32'h2023 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_43 = 32'h3023 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_45 = 32'h13 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_47 = 32'h2013 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_49 = 32'h3013 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_51 = 32'h4013 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_53 = 32'h6013 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_55 = 32'h7013 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire [31:0] _controlsig_T_56 = io_inst & 32'hfc00707f; // @[Lookup.scala 31:38]
  wire  _controlsig_T_57 = 32'h1013 == _controlsig_T_56; // @[Lookup.scala 31:38]
  wire  _controlsig_T_59 = 32'h5013 == _controlsig_T_56; // @[Lookup.scala 31:38]
  wire  _controlsig_T_61 = 32'h40005013 == _controlsig_T_56; // @[Lookup.scala 31:38]
  wire [31:0] _controlsig_T_62 = io_inst & 32'hfe00707f; // @[Lookup.scala 31:38]
  wire  _controlsig_T_63 = 32'h33 == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_65 = 32'h40000033 == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_67 = 32'h1033 == _controlsig_T_56; // @[Lookup.scala 31:38]
  wire  _controlsig_T_69 = 32'h2033 == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_71 = 32'h3033 == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_73 = 32'h4033 == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_75 = 32'h5033 == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_77 = 32'h40005033 == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_79 = 32'h6033 == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_81 = 32'h7033 == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_83 = 32'h2000033 == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_85 = 32'h2001033 == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_87 = 32'h2002033 == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_89 = 32'h2003033 == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_91 = 32'h2004033 == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_93 = 32'h2005033 == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_95 = 32'h2006033 == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_97 = 32'h2007033 == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_99 = 32'h1b == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_101 = 32'h101b == _controlsig_T_56; // @[Lookup.scala 31:38]
  wire  _controlsig_T_103 = 32'h501b == _controlsig_T_56; // @[Lookup.scala 31:38]
  wire  _controlsig_T_105 = 32'h4000501b == _controlsig_T_56; // @[Lookup.scala 31:38]
  wire  _controlsig_T_107 = 32'h3b == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_109 = 32'h4000003b == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_111 = 32'h103b == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_113 = 32'h503b == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_115 = 32'h4000503b == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_117 = 32'h200003b == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_119 = 32'h200403b == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_121 = 32'h200503b == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_123 = 32'h200603b == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_125 = 32'h200703b == _controlsig_T_62; // @[Lookup.scala 31:38]
  wire  _controlsig_T_127 = 32'h1073 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_129 = 32'h2073 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_131 = 32'h3073 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_133 = 32'h5073 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_135 = 32'h6073 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire  _controlsig_T_137 = 32'h7073 == _controlsig_T_8; // @[Lookup.scala 31:38]
  wire [1:0] _controlsig_T_202 = _controlsig_T_9 ? 2'h2 : 2'h0; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_203 = _controlsig_T_7 ? 2'h1 : _controlsig_T_202; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_204 = _controlsig_T_5 ? 2'h0 : _controlsig_T_203; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_205 = _controlsig_T_3 ? 2'h0 : _controlsig_T_204; // @[Lookup.scala 34:39]
  wire  _controlsig_T_270 = _controlsig_T_9 ? 1'h0 : _controlsig_T_11 | (_controlsig_T_13 | (_controlsig_T_15 | (
    _controlsig_T_17 | (_controlsig_T_19 | _controlsig_T_21)))); // @[Lookup.scala 34:39]
  wire  _controlsig_T_271 = _controlsig_T_7 ? 1'h0 : _controlsig_T_270; // @[Lookup.scala 34:39]
  wire  _controlsig_T_272 = _controlsig_T_5 ? 1'h0 : _controlsig_T_271; // @[Lookup.scala 34:39]
  wire  _controlsig_T_273 = _controlsig_T_3 ? 1'h0 : _controlsig_T_272; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_274 = _controlsig_T_137 ? 2'h3 : 2'h0; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_275 = _controlsig_T_135 ? 2'h3 : _controlsig_T_274; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_276 = _controlsig_T_133 ? 2'h3 : _controlsig_T_275; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_277 = _controlsig_T_131 ? 2'h2 : _controlsig_T_276; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_278 = _controlsig_T_129 ? 2'h2 : _controlsig_T_277; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_279 = _controlsig_T_127 ? 2'h2 : _controlsig_T_278; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_280 = _controlsig_T_125 ? 2'h2 : _controlsig_T_279; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_281 = _controlsig_T_123 ? 2'h2 : _controlsig_T_280; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_282 = _controlsig_T_121 ? 2'h2 : _controlsig_T_281; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_283 = _controlsig_T_119 ? 2'h2 : _controlsig_T_282; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_284 = _controlsig_T_117 ? 2'h2 : _controlsig_T_283; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_285 = _controlsig_T_115 ? 2'h2 : _controlsig_T_284; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_286 = _controlsig_T_113 ? 2'h2 : _controlsig_T_285; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_287 = _controlsig_T_111 ? 2'h2 : _controlsig_T_286; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_288 = _controlsig_T_109 ? 2'h2 : _controlsig_T_287; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_289 = _controlsig_T_107 ? 2'h2 : _controlsig_T_288; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_290 = _controlsig_T_105 ? 2'h2 : _controlsig_T_289; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_291 = _controlsig_T_103 ? 2'h2 : _controlsig_T_290; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_292 = _controlsig_T_101 ? 2'h2 : _controlsig_T_291; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_293 = _controlsig_T_99 ? 2'h2 : _controlsig_T_292; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_294 = _controlsig_T_97 ? 2'h2 : _controlsig_T_293; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_295 = _controlsig_T_95 ? 2'h2 : _controlsig_T_294; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_296 = _controlsig_T_93 ? 2'h2 : _controlsig_T_295; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_297 = _controlsig_T_91 ? 2'h2 : _controlsig_T_296; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_298 = _controlsig_T_89 ? 2'h2 : _controlsig_T_297; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_299 = _controlsig_T_87 ? 2'h2 : _controlsig_T_298; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_300 = _controlsig_T_85 ? 2'h2 : _controlsig_T_299; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_301 = _controlsig_T_83 ? 2'h2 : _controlsig_T_300; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_302 = _controlsig_T_81 ? 2'h2 : _controlsig_T_301; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_303 = _controlsig_T_79 ? 2'h2 : _controlsig_T_302; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_304 = _controlsig_T_77 ? 2'h2 : _controlsig_T_303; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_305 = _controlsig_T_75 ? 2'h2 : _controlsig_T_304; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_306 = _controlsig_T_73 ? 2'h2 : _controlsig_T_305; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_307 = _controlsig_T_71 ? 2'h2 : _controlsig_T_306; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_308 = _controlsig_T_69 ? 2'h2 : _controlsig_T_307; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_309 = _controlsig_T_67 ? 2'h2 : _controlsig_T_308; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_310 = _controlsig_T_65 ? 2'h2 : _controlsig_T_309; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_311 = _controlsig_T_63 ? 2'h2 : _controlsig_T_310; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_312 = _controlsig_T_61 ? 2'h2 : _controlsig_T_311; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_313 = _controlsig_T_59 ? 2'h2 : _controlsig_T_312; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_314 = _controlsig_T_57 ? 2'h2 : _controlsig_T_313; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_315 = _controlsig_T_55 ? 2'h2 : _controlsig_T_314; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_316 = _controlsig_T_53 ? 2'h2 : _controlsig_T_315; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_317 = _controlsig_T_51 ? 2'h2 : _controlsig_T_316; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_318 = _controlsig_T_49 ? 2'h2 : _controlsig_T_317; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_319 = _controlsig_T_47 ? 2'h2 : _controlsig_T_318; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_320 = _controlsig_T_45 ? 2'h2 : _controlsig_T_319; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_321 = _controlsig_T_43 ? 2'h2 : _controlsig_T_320; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_322 = _controlsig_T_41 ? 2'h2 : _controlsig_T_321; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_323 = _controlsig_T_39 ? 2'h2 : _controlsig_T_322; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_324 = _controlsig_T_37 ? 2'h2 : _controlsig_T_323; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_325 = _controlsig_T_35 ? 2'h2 : _controlsig_T_324; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_326 = _controlsig_T_33 ? 2'h2 : _controlsig_T_325; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_327 = _controlsig_T_31 ? 2'h2 : _controlsig_T_326; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_328 = _controlsig_T_29 ? 2'h2 : _controlsig_T_327; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_329 = _controlsig_T_27 ? 2'h2 : _controlsig_T_328; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_330 = _controlsig_T_25 ? 2'h2 : _controlsig_T_329; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_331 = _controlsig_T_23 ? 2'h2 : _controlsig_T_330; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_332 = _controlsig_T_21 ? 2'h2 : _controlsig_T_331; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_333 = _controlsig_T_19 ? 2'h2 : _controlsig_T_332; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_334 = _controlsig_T_17 ? 2'h2 : _controlsig_T_333; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_335 = _controlsig_T_15 ? 2'h2 : _controlsig_T_334; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_336 = _controlsig_T_13 ? 2'h2 : _controlsig_T_335; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_337 = _controlsig_T_11 ? 2'h2 : _controlsig_T_336; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_338 = _controlsig_T_9 ? 2'h1 : _controlsig_T_337; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_339 = _controlsig_T_7 ? 2'h1 : _controlsig_T_338; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_340 = _controlsig_T_5 ? 2'h0 : _controlsig_T_339; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_341 = _controlsig_T_3 ? 2'h1 : _controlsig_T_340; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_342 = _controlsig_T_137 ? 3'h4 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_343 = _controlsig_T_135 ? 3'h4 : _controlsig_T_342; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_344 = _controlsig_T_133 ? 3'h0 : _controlsig_T_343; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_345 = _controlsig_T_131 ? 3'h4 : _controlsig_T_344; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_346 = _controlsig_T_129 ? 3'h4 : _controlsig_T_345; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_347 = _controlsig_T_127 ? 3'h0 : _controlsig_T_346; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_348 = _controlsig_T_125 ? 3'h2 : _controlsig_T_347; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_349 = _controlsig_T_123 ? 3'h2 : _controlsig_T_348; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_350 = _controlsig_T_121 ? 3'h2 : _controlsig_T_349; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_351 = _controlsig_T_119 ? 3'h2 : _controlsig_T_350; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_352 = _controlsig_T_117 ? 3'h2 : _controlsig_T_351; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_353 = _controlsig_T_115 ? 3'h2 : _controlsig_T_352; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_354 = _controlsig_T_113 ? 3'h2 : _controlsig_T_353; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_355 = _controlsig_T_111 ? 3'h2 : _controlsig_T_354; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_356 = _controlsig_T_109 ? 3'h2 : _controlsig_T_355; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_357 = _controlsig_T_107 ? 3'h2 : _controlsig_T_356; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_358 = _controlsig_T_105 ? 3'h1 : _controlsig_T_357; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_359 = _controlsig_T_103 ? 3'h1 : _controlsig_T_358; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_360 = _controlsig_T_101 ? 3'h1 : _controlsig_T_359; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_361 = _controlsig_T_99 ? 3'h1 : _controlsig_T_360; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_362 = _controlsig_T_97 ? 3'h2 : _controlsig_T_361; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_363 = _controlsig_T_95 ? 3'h2 : _controlsig_T_362; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_364 = _controlsig_T_93 ? 3'h2 : _controlsig_T_363; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_365 = _controlsig_T_91 ? 3'h2 : _controlsig_T_364; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_366 = _controlsig_T_89 ? 3'h2 : _controlsig_T_365; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_367 = _controlsig_T_87 ? 3'h2 : _controlsig_T_366; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_368 = _controlsig_T_85 ? 3'h2 : _controlsig_T_367; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_369 = _controlsig_T_83 ? 3'h2 : _controlsig_T_368; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_370 = _controlsig_T_81 ? 3'h2 : _controlsig_T_369; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_371 = _controlsig_T_79 ? 3'h2 : _controlsig_T_370; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_372 = _controlsig_T_77 ? 3'h2 : _controlsig_T_371; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_373 = _controlsig_T_75 ? 3'h2 : _controlsig_T_372; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_374 = _controlsig_T_73 ? 3'h2 : _controlsig_T_373; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_375 = _controlsig_T_71 ? 3'h2 : _controlsig_T_374; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_376 = _controlsig_T_69 ? 3'h2 : _controlsig_T_375; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_377 = _controlsig_T_67 ? 3'h2 : _controlsig_T_376; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_378 = _controlsig_T_65 ? 3'h2 : _controlsig_T_377; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_379 = _controlsig_T_63 ? 3'h2 : _controlsig_T_378; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_380 = _controlsig_T_61 ? 3'h1 : _controlsig_T_379; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_381 = _controlsig_T_59 ? 3'h1 : _controlsig_T_380; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_382 = _controlsig_T_57 ? 3'h1 : _controlsig_T_381; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_383 = _controlsig_T_55 ? 3'h1 : _controlsig_T_382; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_384 = _controlsig_T_53 ? 3'h1 : _controlsig_T_383; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_385 = _controlsig_T_51 ? 3'h1 : _controlsig_T_384; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_386 = _controlsig_T_49 ? 3'h1 : _controlsig_T_385; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_387 = _controlsig_T_47 ? 3'h1 : _controlsig_T_386; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_388 = _controlsig_T_45 ? 3'h1 : _controlsig_T_387; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_389 = _controlsig_T_43 ? 3'h1 : _controlsig_T_388; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_390 = _controlsig_T_41 ? 3'h1 : _controlsig_T_389; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_391 = _controlsig_T_39 ? 3'h1 : _controlsig_T_390; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_392 = _controlsig_T_37 ? 3'h1 : _controlsig_T_391; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_393 = _controlsig_T_35 ? 3'h1 : _controlsig_T_392; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_394 = _controlsig_T_33 ? 3'h1 : _controlsig_T_393; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_395 = _controlsig_T_31 ? 3'h1 : _controlsig_T_394; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_396 = _controlsig_T_29 ? 3'h1 : _controlsig_T_395; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_397 = _controlsig_T_27 ? 3'h1 : _controlsig_T_396; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_398 = _controlsig_T_25 ? 3'h1 : _controlsig_T_397; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_399 = _controlsig_T_23 ? 3'h1 : _controlsig_T_398; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_400 = _controlsig_T_21 ? 3'h2 : _controlsig_T_399; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_401 = _controlsig_T_19 ? 3'h2 : _controlsig_T_400; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_402 = _controlsig_T_17 ? 3'h2 : _controlsig_T_401; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_403 = _controlsig_T_15 ? 3'h2 : _controlsig_T_402; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_404 = _controlsig_T_13 ? 3'h2 : _controlsig_T_403; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_405 = _controlsig_T_11 ? 3'h2 : _controlsig_T_404; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_406 = _controlsig_T_9 ? 3'h3 : _controlsig_T_405; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_407 = _controlsig_T_7 ? 3'h3 : _controlsig_T_406; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_408 = _controlsig_T_5 ? 3'h1 : _controlsig_T_407; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_409 = _controlsig_T_3 ? 3'h1 : _controlsig_T_408; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_410 = _controlsig_T_137 ? 3'h5 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_411 = _controlsig_T_135 ? 3'h5 : _controlsig_T_410; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_412 = _controlsig_T_133 ? 3'h5 : _controlsig_T_411; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_413 = _controlsig_T_131 ? 3'h0 : _controlsig_T_412; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_414 = _controlsig_T_129 ? 3'h0 : _controlsig_T_413; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_415 = _controlsig_T_127 ? 3'h0 : _controlsig_T_414; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_416 = _controlsig_T_125 ? 3'h0 : _controlsig_T_415; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_417 = _controlsig_T_123 ? 3'h0 : _controlsig_T_416; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_418 = _controlsig_T_121 ? 3'h0 : _controlsig_T_417; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_419 = _controlsig_T_119 ? 3'h0 : _controlsig_T_418; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_420 = _controlsig_T_117 ? 3'h0 : _controlsig_T_419; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_421 = _controlsig_T_115 ? 3'h0 : _controlsig_T_420; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_422 = _controlsig_T_113 ? 3'h0 : _controlsig_T_421; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_423 = _controlsig_T_111 ? 3'h0 : _controlsig_T_422; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_424 = _controlsig_T_109 ? 3'h0 : _controlsig_T_423; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_425 = _controlsig_T_107 ? 3'h0 : _controlsig_T_424; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_426 = _controlsig_T_105 ? 3'h0 : _controlsig_T_425; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_427 = _controlsig_T_103 ? 3'h0 : _controlsig_T_426; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_428 = _controlsig_T_101 ? 3'h0 : _controlsig_T_427; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_429 = _controlsig_T_99 ? 3'h0 : _controlsig_T_428; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_430 = _controlsig_T_97 ? 3'h0 : _controlsig_T_429; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_431 = _controlsig_T_95 ? 3'h0 : _controlsig_T_430; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_432 = _controlsig_T_93 ? 3'h0 : _controlsig_T_431; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_433 = _controlsig_T_91 ? 3'h0 : _controlsig_T_432; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_434 = _controlsig_T_89 ? 3'h0 : _controlsig_T_433; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_435 = _controlsig_T_87 ? 3'h0 : _controlsig_T_434; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_436 = _controlsig_T_85 ? 3'h0 : _controlsig_T_435; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_437 = _controlsig_T_83 ? 3'h0 : _controlsig_T_436; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_438 = _controlsig_T_81 ? 3'h0 : _controlsig_T_437; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_439 = _controlsig_T_79 ? 3'h0 : _controlsig_T_438; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_440 = _controlsig_T_77 ? 3'h0 : _controlsig_T_439; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_441 = _controlsig_T_75 ? 3'h0 : _controlsig_T_440; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_442 = _controlsig_T_73 ? 3'h0 : _controlsig_T_441; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_443 = _controlsig_T_71 ? 3'h0 : _controlsig_T_442; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_444 = _controlsig_T_69 ? 3'h0 : _controlsig_T_443; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_445 = _controlsig_T_67 ? 3'h0 : _controlsig_T_444; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_446 = _controlsig_T_65 ? 3'h0 : _controlsig_T_445; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_447 = _controlsig_T_63 ? 3'h0 : _controlsig_T_446; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_448 = _controlsig_T_61 ? 3'h0 : _controlsig_T_447; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_449 = _controlsig_T_59 ? 3'h0 : _controlsig_T_448; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_450 = _controlsig_T_57 ? 3'h0 : _controlsig_T_449; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_451 = _controlsig_T_55 ? 3'h0 : _controlsig_T_450; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_452 = _controlsig_T_53 ? 3'h0 : _controlsig_T_451; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_453 = _controlsig_T_51 ? 3'h0 : _controlsig_T_452; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_454 = _controlsig_T_49 ? 3'h0 : _controlsig_T_453; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_455 = _controlsig_T_47 ? 3'h0 : _controlsig_T_454; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_456 = _controlsig_T_45 ? 3'h0 : _controlsig_T_455; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_457 = _controlsig_T_43 ? 3'h3 : _controlsig_T_456; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_458 = _controlsig_T_41 ? 3'h3 : _controlsig_T_457; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_459 = _controlsig_T_39 ? 3'h3 : _controlsig_T_458; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_460 = _controlsig_T_37 ? 3'h3 : _controlsig_T_459; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_461 = _controlsig_T_35 ? 3'h0 : _controlsig_T_460; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_462 = _controlsig_T_33 ? 3'h0 : _controlsig_T_461; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_463 = _controlsig_T_31 ? 3'h0 : _controlsig_T_462; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_464 = _controlsig_T_29 ? 3'h0 : _controlsig_T_463; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_465 = _controlsig_T_27 ? 3'h0 : _controlsig_T_464; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_466 = _controlsig_T_25 ? 3'h0 : _controlsig_T_465; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_467 = _controlsig_T_23 ? 3'h0 : _controlsig_T_466; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_468 = _controlsig_T_21 ? 3'h0 : _controlsig_T_467; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_469 = _controlsig_T_19 ? 3'h0 : _controlsig_T_468; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_470 = _controlsig_T_17 ? 3'h0 : _controlsig_T_469; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_471 = _controlsig_T_15 ? 3'h0 : _controlsig_T_470; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_472 = _controlsig_T_13 ? 3'h0 : _controlsig_T_471; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_473 = _controlsig_T_11 ? 3'h0 : _controlsig_T_472; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_474 = _controlsig_T_9 ? 3'h0 : _controlsig_T_473; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_475 = _controlsig_T_7 ? 3'h2 : _controlsig_T_474; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_476 = _controlsig_T_5 ? 3'h1 : _controlsig_T_475; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_477 = _controlsig_T_3 ? 3'h1 : _controlsig_T_476; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_478 = _controlsig_T_137 ? 6'h28 : 6'h3f; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_479 = _controlsig_T_135 ? 6'h9 : _controlsig_T_478; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_480 = _controlsig_T_133 ? 6'h0 : _controlsig_T_479; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_481 = _controlsig_T_131 ? 6'h28 : _controlsig_T_480; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_482 = _controlsig_T_129 ? 6'h9 : _controlsig_T_481; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_483 = _controlsig_T_127 ? 6'h0 : _controlsig_T_482; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_484 = _controlsig_T_125 ? 6'h27 : _controlsig_T_483; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_485 = _controlsig_T_123 ? 6'h26 : _controlsig_T_484; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_486 = _controlsig_T_121 ? 6'h25 : _controlsig_T_485; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_487 = _controlsig_T_119 ? 6'h24 : _controlsig_T_486; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_488 = _controlsig_T_117 ? 6'h23 : _controlsig_T_487; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_489 = _controlsig_T_115 ? 6'h22 : _controlsig_T_488; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_490 = _controlsig_T_113 ? 6'h21 : _controlsig_T_489; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_491 = _controlsig_T_111 ? 6'h20 : _controlsig_T_490; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_492 = _controlsig_T_109 ? 6'h1f : _controlsig_T_491; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_493 = _controlsig_T_107 ? 6'h1e : _controlsig_T_492; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_494 = _controlsig_T_105 ? 6'h1d : _controlsig_T_493; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_495 = _controlsig_T_103 ? 6'h1c : _controlsig_T_494; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_496 = _controlsig_T_101 ? 6'h1b : _controlsig_T_495; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_497 = _controlsig_T_99 ? 6'h1a : _controlsig_T_496; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_498 = _controlsig_T_97 ? 6'h19 : _controlsig_T_497; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_499 = _controlsig_T_95 ? 6'h18 : _controlsig_T_498; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_500 = _controlsig_T_93 ? 6'h17 : _controlsig_T_499; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_501 = _controlsig_T_91 ? 6'h16 : _controlsig_T_500; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_502 = _controlsig_T_89 ? 6'h15 : _controlsig_T_501; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_503 = _controlsig_T_87 ? 6'h14 : _controlsig_T_502; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_504 = _controlsig_T_85 ? 6'h13 : _controlsig_T_503; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_505 = _controlsig_T_83 ? 6'h12 : _controlsig_T_504; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_506 = _controlsig_T_81 ? 6'h10 : _controlsig_T_505; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_507 = _controlsig_T_79 ? 6'h9 : _controlsig_T_506; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_508 = _controlsig_T_77 ? 6'hc : _controlsig_T_507; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_509 = _controlsig_T_75 ? 6'hb : _controlsig_T_508; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_510 = _controlsig_T_73 ? 6'h8 : _controlsig_T_509; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_511 = _controlsig_T_71 ? 6'h6 : _controlsig_T_510; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_512 = _controlsig_T_69 ? 6'h4 : _controlsig_T_511; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_513 = _controlsig_T_67 ? 6'ha : _controlsig_T_512; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_514 = _controlsig_T_65 ? 6'h1 : _controlsig_T_513; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_515 = _controlsig_T_63 ? 6'h0 : _controlsig_T_514; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_516 = _controlsig_T_61 ? 6'hf : _controlsig_T_515; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_517 = _controlsig_T_59 ? 6'he : _controlsig_T_516; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_518 = _controlsig_T_57 ? 6'hd : _controlsig_T_517; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_519 = _controlsig_T_55 ? 6'h10 : _controlsig_T_518; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_520 = _controlsig_T_53 ? 6'h9 : _controlsig_T_519; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_521 = _controlsig_T_51 ? 6'h8 : _controlsig_T_520; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_522 = _controlsig_T_49 ? 6'h6 : _controlsig_T_521; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_523 = _controlsig_T_47 ? 6'h4 : _controlsig_T_522; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_524 = _controlsig_T_45 ? 6'h0 : _controlsig_T_523; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_525 = _controlsig_T_43 ? 6'h0 : _controlsig_T_524; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_526 = _controlsig_T_41 ? 6'h0 : _controlsig_T_525; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_527 = _controlsig_T_39 ? 6'h0 : _controlsig_T_526; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_528 = _controlsig_T_37 ? 6'h0 : _controlsig_T_527; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_529 = _controlsig_T_35 ? 6'h0 : _controlsig_T_528; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_530 = _controlsig_T_33 ? 6'h0 : _controlsig_T_529; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_531 = _controlsig_T_31 ? 6'h0 : _controlsig_T_530; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_532 = _controlsig_T_29 ? 6'h0 : _controlsig_T_531; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_533 = _controlsig_T_27 ? 6'h0 : _controlsig_T_532; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_534 = _controlsig_T_25 ? 6'h0 : _controlsig_T_533; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_535 = _controlsig_T_23 ? 6'h0 : _controlsig_T_534; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_536 = _controlsig_T_21 ? 6'h7 : _controlsig_T_535; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_537 = _controlsig_T_19 ? 6'h6 : _controlsig_T_536; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_538 = _controlsig_T_17 ? 6'h5 : _controlsig_T_537; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_539 = _controlsig_T_15 ? 6'h4 : _controlsig_T_538; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_540 = _controlsig_T_13 ? 6'h3 : _controlsig_T_539; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_541 = _controlsig_T_11 ? 6'h2 : _controlsig_T_540; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_542 = _controlsig_T_9 ? 6'h0 : _controlsig_T_541; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_543 = _controlsig_T_7 ? 6'h0 : _controlsig_T_542; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_544 = _controlsig_T_5 ? 6'h0 : _controlsig_T_543; // @[Lookup.scala 34:39]
  wire [5:0] _controlsig_T_545 = _controlsig_T_3 ? 6'h0 : _controlsig_T_544; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_549 = _controlsig_T_131 ? 2'h3 : _controlsig_T_276; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_550 = _controlsig_T_129 ? 2'h3 : _controlsig_T_549; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_551 = _controlsig_T_127 ? 2'h3 : _controlsig_T_550; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_552 = _controlsig_T_125 ? 2'h1 : _controlsig_T_551; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_553 = _controlsig_T_123 ? 2'h1 : _controlsig_T_552; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_554 = _controlsig_T_121 ? 2'h1 : _controlsig_T_553; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_555 = _controlsig_T_119 ? 2'h1 : _controlsig_T_554; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_556 = _controlsig_T_117 ? 2'h1 : _controlsig_T_555; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_557 = _controlsig_T_115 ? 2'h1 : _controlsig_T_556; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_558 = _controlsig_T_113 ? 2'h1 : _controlsig_T_557; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_559 = _controlsig_T_111 ? 2'h1 : _controlsig_T_558; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_560 = _controlsig_T_109 ? 2'h1 : _controlsig_T_559; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_561 = _controlsig_T_107 ? 2'h1 : _controlsig_T_560; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_562 = _controlsig_T_105 ? 2'h1 : _controlsig_T_561; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_563 = _controlsig_T_103 ? 2'h1 : _controlsig_T_562; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_564 = _controlsig_T_101 ? 2'h1 : _controlsig_T_563; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_565 = _controlsig_T_99 ? 2'h1 : _controlsig_T_564; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_566 = _controlsig_T_97 ? 2'h1 : _controlsig_T_565; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_567 = _controlsig_T_95 ? 2'h1 : _controlsig_T_566; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_568 = _controlsig_T_93 ? 2'h1 : _controlsig_T_567; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_569 = _controlsig_T_91 ? 2'h1 : _controlsig_T_568; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_570 = _controlsig_T_89 ? 2'h1 : _controlsig_T_569; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_571 = _controlsig_T_87 ? 2'h1 : _controlsig_T_570; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_572 = _controlsig_T_85 ? 2'h1 : _controlsig_T_571; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_573 = _controlsig_T_83 ? 2'h1 : _controlsig_T_572; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_574 = _controlsig_T_81 ? 2'h1 : _controlsig_T_573; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_575 = _controlsig_T_79 ? 2'h1 : _controlsig_T_574; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_576 = _controlsig_T_77 ? 2'h1 : _controlsig_T_575; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_577 = _controlsig_T_75 ? 2'h1 : _controlsig_T_576; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_578 = _controlsig_T_73 ? 2'h1 : _controlsig_T_577; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_579 = _controlsig_T_71 ? 2'h1 : _controlsig_T_578; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_580 = _controlsig_T_69 ? 2'h1 : _controlsig_T_579; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_581 = _controlsig_T_67 ? 2'h1 : _controlsig_T_580; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_582 = _controlsig_T_65 ? 2'h1 : _controlsig_T_581; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_583 = _controlsig_T_63 ? 2'h1 : _controlsig_T_582; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_584 = _controlsig_T_61 ? 2'h1 : _controlsig_T_583; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_585 = _controlsig_T_59 ? 2'h1 : _controlsig_T_584; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_586 = _controlsig_T_57 ? 2'h1 : _controlsig_T_585; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_587 = _controlsig_T_55 ? 2'h1 : _controlsig_T_586; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_588 = _controlsig_T_53 ? 2'h1 : _controlsig_T_587; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_589 = _controlsig_T_51 ? 2'h1 : _controlsig_T_588; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_590 = _controlsig_T_49 ? 2'h1 : _controlsig_T_589; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_591 = _controlsig_T_47 ? 2'h1 : _controlsig_T_590; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_592 = _controlsig_T_45 ? 2'h1 : _controlsig_T_591; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_593 = _controlsig_T_43 ? 2'h0 : _controlsig_T_592; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_594 = _controlsig_T_41 ? 2'h0 : _controlsig_T_593; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_595 = _controlsig_T_39 ? 2'h0 : _controlsig_T_594; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_596 = _controlsig_T_37 ? 2'h0 : _controlsig_T_595; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_597 = _controlsig_T_35 ? 2'h2 : _controlsig_T_596; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_598 = _controlsig_T_33 ? 2'h2 : _controlsig_T_597; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_599 = _controlsig_T_31 ? 2'h2 : _controlsig_T_598; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_600 = _controlsig_T_29 ? 2'h2 : _controlsig_T_599; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_601 = _controlsig_T_27 ? 2'h2 : _controlsig_T_600; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_602 = _controlsig_T_25 ? 2'h2 : _controlsig_T_601; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_603 = _controlsig_T_23 ? 2'h2 : _controlsig_T_602; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_604 = _controlsig_T_21 ? 2'h0 : _controlsig_T_603; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_605 = _controlsig_T_19 ? 2'h0 : _controlsig_T_604; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_606 = _controlsig_T_17 ? 2'h0 : _controlsig_T_605; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_607 = _controlsig_T_15 ? 2'h0 : _controlsig_T_606; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_608 = _controlsig_T_13 ? 2'h0 : _controlsig_T_607; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_609 = _controlsig_T_11 ? 2'h0 : _controlsig_T_608; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_610 = _controlsig_T_9 ? 2'h1 : _controlsig_T_609; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_611 = _controlsig_T_7 ? 2'h1 : _controlsig_T_610; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_612 = _controlsig_T_5 ? 2'h1 : _controlsig_T_611; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_613 = _controlsig_T_3 ? 2'h1 : _controlsig_T_612; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_661 = _controlsig_T_43 ? 3'h4 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_662 = _controlsig_T_41 ? 3'h3 : _controlsig_T_661; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_663 = _controlsig_T_39 ? 3'h2 : _controlsig_T_662; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_664 = _controlsig_T_37 ? 3'h1 : _controlsig_T_663; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_665 = _controlsig_T_35 ? 3'h0 : _controlsig_T_664; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_666 = _controlsig_T_33 ? 3'h0 : _controlsig_T_665; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_667 = _controlsig_T_31 ? 3'h0 : _controlsig_T_666; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_668 = _controlsig_T_29 ? 3'h0 : _controlsig_T_667; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_669 = _controlsig_T_27 ? 3'h0 : _controlsig_T_668; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_670 = _controlsig_T_25 ? 3'h0 : _controlsig_T_669; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_671 = _controlsig_T_23 ? 3'h0 : _controlsig_T_670; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_672 = _controlsig_T_21 ? 3'h0 : _controlsig_T_671; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_673 = _controlsig_T_19 ? 3'h0 : _controlsig_T_672; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_674 = _controlsig_T_17 ? 3'h0 : _controlsig_T_673; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_675 = _controlsig_T_15 ? 3'h0 : _controlsig_T_674; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_676 = _controlsig_T_13 ? 3'h0 : _controlsig_T_675; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_677 = _controlsig_T_11 ? 3'h0 : _controlsig_T_676; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_678 = _controlsig_T_9 ? 3'h0 : _controlsig_T_677; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_679 = _controlsig_T_7 ? 3'h0 : _controlsig_T_678; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_680 = _controlsig_T_5 ? 3'h0 : _controlsig_T_679; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_681 = _controlsig_T_3 ? 3'h0 : _controlsig_T_680; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_733 = _controlsig_T_35 ? 3'h4 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_734 = _controlsig_T_33 ? 3'h7 : _controlsig_T_733; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_735 = _controlsig_T_31 ? 3'h6 : _controlsig_T_734; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_736 = _controlsig_T_29 ? 3'h5 : _controlsig_T_735; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_737 = _controlsig_T_27 ? 3'h3 : _controlsig_T_736; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_738 = _controlsig_T_25 ? 3'h2 : _controlsig_T_737; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_739 = _controlsig_T_23 ? 3'h1 : _controlsig_T_738; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_740 = _controlsig_T_21 ? 3'h0 : _controlsig_T_739; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_741 = _controlsig_T_19 ? 3'h0 : _controlsig_T_740; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_742 = _controlsig_T_17 ? 3'h0 : _controlsig_T_741; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_743 = _controlsig_T_15 ? 3'h0 : _controlsig_T_742; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_744 = _controlsig_T_13 ? 3'h0 : _controlsig_T_743; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_745 = _controlsig_T_11 ? 3'h0 : _controlsig_T_744; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_746 = _controlsig_T_9 ? 3'h0 : _controlsig_T_745; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_747 = _controlsig_T_7 ? 3'h0 : _controlsig_T_746; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_748 = _controlsig_T_5 ? 3'h0 : _controlsig_T_747; // @[Lookup.scala 34:39]
  wire [2:0] _controlsig_T_749 = _controlsig_T_3 ? 3'h0 : _controlsig_T_748; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_751 = _controlsig_T_135 ? 2'h2 : _controlsig_T_274; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_752 = _controlsig_T_133 ? 2'h1 : _controlsig_T_751; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_753 = _controlsig_T_131 ? 2'h3 : _controlsig_T_752; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_754 = _controlsig_T_129 ? 2'h2 : _controlsig_T_753; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_755 = _controlsig_T_127 ? 2'h1 : _controlsig_T_754; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_756 = _controlsig_T_125 ? 2'h0 : _controlsig_T_755; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_757 = _controlsig_T_123 ? 2'h0 : _controlsig_T_756; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_758 = _controlsig_T_121 ? 2'h0 : _controlsig_T_757; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_759 = _controlsig_T_119 ? 2'h0 : _controlsig_T_758; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_760 = _controlsig_T_117 ? 2'h0 : _controlsig_T_759; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_761 = _controlsig_T_115 ? 2'h0 : _controlsig_T_760; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_762 = _controlsig_T_113 ? 2'h0 : _controlsig_T_761; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_763 = _controlsig_T_111 ? 2'h0 : _controlsig_T_762; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_764 = _controlsig_T_109 ? 2'h0 : _controlsig_T_763; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_765 = _controlsig_T_107 ? 2'h0 : _controlsig_T_764; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_766 = _controlsig_T_105 ? 2'h0 : _controlsig_T_765; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_767 = _controlsig_T_103 ? 2'h0 : _controlsig_T_766; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_768 = _controlsig_T_101 ? 2'h0 : _controlsig_T_767; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_769 = _controlsig_T_99 ? 2'h0 : _controlsig_T_768; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_770 = _controlsig_T_97 ? 2'h0 : _controlsig_T_769; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_771 = _controlsig_T_95 ? 2'h0 : _controlsig_T_770; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_772 = _controlsig_T_93 ? 2'h0 : _controlsig_T_771; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_773 = _controlsig_T_91 ? 2'h0 : _controlsig_T_772; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_774 = _controlsig_T_89 ? 2'h0 : _controlsig_T_773; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_775 = _controlsig_T_87 ? 2'h0 : _controlsig_T_774; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_776 = _controlsig_T_85 ? 2'h0 : _controlsig_T_775; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_777 = _controlsig_T_83 ? 2'h0 : _controlsig_T_776; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_778 = _controlsig_T_81 ? 2'h0 : _controlsig_T_777; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_779 = _controlsig_T_79 ? 2'h0 : _controlsig_T_778; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_780 = _controlsig_T_77 ? 2'h0 : _controlsig_T_779; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_781 = _controlsig_T_75 ? 2'h0 : _controlsig_T_780; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_782 = _controlsig_T_73 ? 2'h0 : _controlsig_T_781; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_783 = _controlsig_T_71 ? 2'h0 : _controlsig_T_782; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_784 = _controlsig_T_69 ? 2'h0 : _controlsig_T_783; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_785 = _controlsig_T_67 ? 2'h0 : _controlsig_T_784; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_786 = _controlsig_T_65 ? 2'h0 : _controlsig_T_785; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_787 = _controlsig_T_63 ? 2'h0 : _controlsig_T_786; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_788 = _controlsig_T_61 ? 2'h0 : _controlsig_T_787; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_789 = _controlsig_T_59 ? 2'h0 : _controlsig_T_788; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_790 = _controlsig_T_57 ? 2'h0 : _controlsig_T_789; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_791 = _controlsig_T_55 ? 2'h0 : _controlsig_T_790; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_792 = _controlsig_T_53 ? 2'h0 : _controlsig_T_791; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_793 = _controlsig_T_51 ? 2'h0 : _controlsig_T_792; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_794 = _controlsig_T_49 ? 2'h0 : _controlsig_T_793; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_795 = _controlsig_T_47 ? 2'h0 : _controlsig_T_794; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_796 = _controlsig_T_45 ? 2'h0 : _controlsig_T_795; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_797 = _controlsig_T_43 ? 2'h0 : _controlsig_T_796; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_798 = _controlsig_T_41 ? 2'h0 : _controlsig_T_797; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_799 = _controlsig_T_39 ? 2'h0 : _controlsig_T_798; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_800 = _controlsig_T_37 ? 2'h0 : _controlsig_T_799; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_801 = _controlsig_T_35 ? 2'h0 : _controlsig_T_800; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_802 = _controlsig_T_33 ? 2'h0 : _controlsig_T_801; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_803 = _controlsig_T_31 ? 2'h0 : _controlsig_T_802; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_804 = _controlsig_T_29 ? 2'h0 : _controlsig_T_803; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_805 = _controlsig_T_27 ? 2'h0 : _controlsig_T_804; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_806 = _controlsig_T_25 ? 2'h0 : _controlsig_T_805; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_807 = _controlsig_T_23 ? 2'h0 : _controlsig_T_806; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_808 = _controlsig_T_21 ? 2'h0 : _controlsig_T_807; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_809 = _controlsig_T_19 ? 2'h0 : _controlsig_T_808; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_810 = _controlsig_T_17 ? 2'h0 : _controlsig_T_809; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_811 = _controlsig_T_15 ? 2'h0 : _controlsig_T_810; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_812 = _controlsig_T_13 ? 2'h0 : _controlsig_T_811; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_813 = _controlsig_T_11 ? 2'h0 : _controlsig_T_812; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_814 = _controlsig_T_9 ? 2'h0 : _controlsig_T_813; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_815 = _controlsig_T_7 ? 2'h0 : _controlsig_T_814; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_816 = _controlsig_T_5 ? 2'h0 : _controlsig_T_815; // @[Lookup.scala 34:39]
  wire [1:0] _controlsig_T_817 = _controlsig_T_3 ? 2'h0 : _controlsig_T_816; // @[Lookup.scala 34:39]
  assign io_jump_type = _controlsig_T_1 ? 2'h0 : _controlsig_T_205; // @[Lookup.scala 34:39]
  assign io_branch_type = _controlsig_T_1 ? 1'h0 : _controlsig_T_273; // @[Lookup.scala 34:39]
  assign io_opa_type = _controlsig_T_1 ? 2'h0 : _controlsig_T_341; // @[Lookup.scala 34:39]
  assign io_opb_type = _controlsig_T_1 ? 3'h0 : _controlsig_T_409; // @[Lookup.scala 34:39]
  assign io_imm_type = _controlsig_T_1 ? 3'h0 : _controlsig_T_477; // @[Lookup.scala 34:39]
  assign io_alu_op = _controlsig_T_1 ? 6'h3f : _controlsig_T_545; // @[Lookup.scala 34:39]
  assign io_wb_type = _controlsig_T_1 ? 2'h0 : _controlsig_T_613; // @[Lookup.scala 34:39]
  assign io_sd_type = _controlsig_T_1 ? 3'h0 : _controlsig_T_681; // @[Lookup.scala 34:39]
  assign io_ld_type = _controlsig_T_1 ? 3'h0 : _controlsig_T_749; // @[Lookup.scala 34:39]
  assign io_csr_type = _controlsig_T_1 ? 2'h0 : _controlsig_T_817; // @[Lookup.scala 34:39]
endmodule
module ysyx_22051553_Eximm(
  input  [31:0] io_inst,
  input  [2:0]  io_imm_type,
  output [63:0] io_eximm
);
  wire [51:0] _io_eximm_T_2 = io_inst[31] ? 52'hfffffffffffff : 52'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _io_eximm_T_4 = {_io_eximm_T_2,io_inst[31:20]}; // @[Cat.scala 33:92]
  wire [31:0] _io_eximm_T_7 = io_inst[31] ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _io_eximm_T_10 = {_io_eximm_T_7,io_inst[31:12],12'h0}; // @[Cat.scala 33:92]
  wire [43:0] _io_eximm_T_13 = io_inst[31] ? 44'hfffffffffff : 44'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _io_eximm_T_17 = {_io_eximm_T_13,io_inst[19:12],io_inst[20],io_inst[30:21],1'h0}; // @[Cat.scala 33:92]
  wire [63:0] _io_eximm_T_23 = {_io_eximm_T_2,io_inst[31:25],io_inst[11:7]}; // @[Cat.scala 33:92]
  wire [50:0] _io_eximm_T_26 = io_inst[31] ? 51'h7ffffffffffff : 51'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _io_eximm_T_31 = {_io_eximm_T_26,io_inst[31],io_inst[7],io_inst[30:25],io_inst[11:8],1'h0}; // @[Cat.scala 33:92]
  wire [63:0] _io_eximm_T_34 = 3'h0 == io_imm_type ? _io_eximm_T_4 : 64'h0; // @[Mux.scala 81:58]
  wire [63:0] _io_eximm_T_36 = 3'h1 == io_imm_type ? _io_eximm_T_10 : _io_eximm_T_34; // @[Mux.scala 81:58]
  wire [63:0] _io_eximm_T_38 = 3'h2 == io_imm_type ? _io_eximm_T_17 : _io_eximm_T_36; // @[Mux.scala 81:58]
  wire [63:0] _io_eximm_T_40 = 3'h3 == io_imm_type ? _io_eximm_T_23 : _io_eximm_T_38; // @[Mux.scala 81:58]
  wire [63:0] _io_eximm_T_42 = 3'h4 == io_imm_type ? _io_eximm_T_31 : _io_eximm_T_40; // @[Mux.scala 81:58]
  assign io_eximm = 3'h5 == io_imm_type ? {{59'd0}, io_inst[19:15]} : _io_eximm_T_42; // @[Mux.scala 81:58]
endmodule
module ysyx_22051553_Decode(
  input         clock,
  input         reset,
  input         io_inst_valid,
  input  [63:0] io_inst_bits_data,
  input         io_inst_io_inst_valid,
  input  [63:0] io_inst_io_inst_bits,
  output        io_inst_io_load_use,
  input  [63:0] io_fdio_pc,
  output [4:0]  io_rfio_reg1_raddr,
  output [4:0]  io_rfio_reg2_raddr,
  input  [63:0] io_rfio_reg1_rdata,
  input  [63:0] io_rfio_reg2_rdata,
  output [63:0] io_deio_op_a,
  output [63:0] io_deio_op_b,
  output [4:0]  io_deio_reg_waddr,
  output        io_deio_branch_type,
  output [63:0] io_deio_branch_addr,
  output [5:0]  io_deio_alu_op,
  output [5:0]  io_deio_shamt,
  output [1:0]  io_deio_wb_type,
  output [2:0]  io_deio_sd_type,
  output [63:0] io_deio_reg2_rdata,
  output [2:0]  io_deio_ld_type,
  output [63:0] io_deio_csr_t,
  output [11:0] io_deio_csr_waddr,
  output        io_deio_csr_wen,
  output        io_deio_has_inst,
  output        io_jump_flag,
  output [63:0] io_jump_pc,
  output        io_load_use,
  input         io_branch,
  input         io_stall,
  input         io_flush,
  output [4:0]  io_fwde_reg1_raddr,
  output [4:0]  io_fwde_reg2_raddr,
  input         io_fwde_fw_sel1,
  input         io_fwde_fw_sel2,
  input  [63:0] io_fwde_fw_data1,
  input  [63:0] io_fwde_fw_data2,
  output [11:0] io_fwde_csr_raddr,
  input         io_fwde_csr_fw_sel,
  input  [63:0] io_fwde_csr_fw_data,
  output [11:0] io_csrs_csr_raddr,
  input  [63:0] io_csrs_csr_rdata
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] cu_io_inst; // @[Decode.scala 57:20]
  wire [1:0] cu_io_jump_type; // @[Decode.scala 57:20]
  wire  cu_io_branch_type; // @[Decode.scala 57:20]
  wire [1:0] cu_io_opa_type; // @[Decode.scala 57:20]
  wire [2:0] cu_io_opb_type; // @[Decode.scala 57:20]
  wire [2:0] cu_io_imm_type; // @[Decode.scala 57:20]
  wire [5:0] cu_io_alu_op; // @[Decode.scala 57:20]
  wire [1:0] cu_io_wb_type; // @[Decode.scala 57:20]
  wire [2:0] cu_io_sd_type; // @[Decode.scala 57:20]
  wire [2:0] cu_io_ld_type; // @[Decode.scala 57:20]
  wire [1:0] cu_io_csr_type; // @[Decode.scala 57:20]
  wire [31:0] eximm_io_inst; // @[Decode.scala 58:23]
  wire [2:0] eximm_io_imm_type; // @[Decode.scala 58:23]
  wire [63:0] eximm_io_eximm; // @[Decode.scala 58:23]
  wire [31:0] _inst_T_3 = io_fdio_pc[2] ? io_inst_bits_data[63:32] : io_inst_bits_data[31:0]; // @[Decode.scala 67:12]
  wire [31:0] _inst_T_5 = io_inst_io_inst_valid ? io_inst_io_inst_bits[31:0] : 32'h13; // @[Decode.scala 71:12]
  wire [31:0] inst = io_inst_valid ? _inst_T_3 : _inst_T_5; // @[Decode.scala 66:16]
  wire [11:0] csr_num = inst[31:20]; // @[Decode.scala 80:20]
  wire [4:0] rs1 = inst[19:15]; // @[Decode.scala 81:16]
  wire [4:0] rs2 = inst[24:20]; // @[Decode.scala 82:16]
  wire [4:0] rd = inst[11:7]; // @[Decode.scala 83:15]
  reg [4:0] lu_rd; // @[Decode.scala 89:24]
  wire [4:0] _lu_rd_T_1 = |cu_io_ld_type ? rd : 5'h0; // @[Decode.scala 95:17]
  wire  _load_use_T_1 = rs1 == lu_rd; // @[Decode.scala 97:64]
  wire  _load_use_T_4 = rs2 == lu_rd; // @[Decode.scala 97:125]
  wire  _load_use_T_9 = |cu_io_sd_type & _load_use_T_4; // @[Decode.scala 98:24]
  wire  _load_use_T_10 = cu_io_opa_type == 2'h2 & rs1 == lu_rd | cu_io_opb_type == 3'h2 & rs2 == lu_rd | _load_use_T_9; // @[Decode.scala 97:137]
  wire  _load_use_T_11 = cu_io_jump_type == 2'h2; // @[Decode.scala 98:65]
  wire  _load_use_T_14 = _load_use_T_10 | cu_io_jump_type == 2'h2 & _load_use_T_1; // @[Decode.scala 98:44]
  wire  load_use = _load_use_T_14 & lu_rd != 5'h0; // @[Decode.scala 99:7]
  wire [63:0] _io_deio_op_a_T = io_fwde_fw_sel1 ? io_fwde_fw_data1 : io_rfio_reg1_rdata; // @[Decode.scala 119:38]
  wire [63:0] _io_deio_op_a_T_2 = 2'h1 == cu_io_opa_type ? io_fdio_pc : 64'h0; // @[Mux.scala 81:58]
  wire [63:0] _io_deio_op_a_T_4 = 2'h2 == cu_io_opa_type ? _io_deio_op_a_T : _io_deio_op_a_T_2; // @[Mux.scala 81:58]
  wire [63:0] _io_deio_op_b_T = io_fwde_fw_sel2 ? io_fwde_fw_data2 : io_rfio_reg2_rdata; // @[Decode.scala 129:38]
  wire [63:0] _io_deio_op_b_T_1 = io_fwde_csr_fw_sel ? io_fwde_csr_fw_data : io_csrs_csr_rdata; // @[Decode.scala 131:37]
  wire [63:0] _io_deio_op_b_T_5 = 3'h1 == cu_io_opb_type ? eximm_io_eximm : 64'h0; // @[Mux.scala 81:58]
  wire [63:0] _io_deio_op_b_T_7 = 3'h2 == cu_io_opb_type ? _io_deio_op_b_T : _io_deio_op_b_T_5; // @[Mux.scala 81:58]
  wire [63:0] _io_deio_op_b_T_9 = 3'h3 == cu_io_opb_type ? 64'h4 : _io_deio_op_b_T_7; // @[Mux.scala 81:58]
  wire [50:0] _io_deio_branch_addr_T_2 = inst[31] ? 51'h7ffffffffffff : 51'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _io_deio_branch_addr_T_7 = {_io_deio_branch_addr_T_2,inst[31],inst[7],inst[30:25],inst[11:8],1'h0}; // @[Cat.scala 33:92]
  wire  _io_jump_flag_T = cu_io_jump_type == 2'h1; // @[Decode.scala 151:38]
  wire [63:0] _io_jump_pc_T_2 = io_fdio_pc + eximm_io_eximm; // @[Decode.scala 155:71]
  wire [63:0] _io_jump_pc_T_6 = _io_deio_op_a_T + eximm_io_eximm; // @[Decode.scala 156:121]
  wire [63:0] _io_jump_pc_T_8 = _io_jump_pc_T_6 & 64'hfffffffffffffffe; // @[Decode.scala 156:139]
  wire [63:0] _io_jump_pc_T_9 = _load_use_T_11 ? _io_jump_pc_T_8 : 64'h80000000; // @[Mux.scala 101:16]
  ysyx_22051553_ControlUnit cu ( // @[Decode.scala 57:20]
    .io_inst(cu_io_inst),
    .io_jump_type(cu_io_jump_type),
    .io_branch_type(cu_io_branch_type),
    .io_opa_type(cu_io_opa_type),
    .io_opb_type(cu_io_opb_type),
    .io_imm_type(cu_io_imm_type),
    .io_alu_op(cu_io_alu_op),
    .io_wb_type(cu_io_wb_type),
    .io_sd_type(cu_io_sd_type),
    .io_ld_type(cu_io_ld_type),
    .io_csr_type(cu_io_csr_type)
  );
  ysyx_22051553_Eximm eximm ( // @[Decode.scala 58:23]
    .io_inst(eximm_io_inst),
    .io_imm_type(eximm_io_imm_type),
    .io_eximm(eximm_io_eximm)
  );
  assign io_inst_io_load_use = _load_use_T_14 & lu_rd != 5'h0; // @[Decode.scala 99:7]
  assign io_rfio_reg1_raddr = inst[19:15]; // @[Decode.scala 81:16]
  assign io_rfio_reg2_raddr = inst[24:20]; // @[Decode.scala 82:16]
  assign io_deio_op_a = 2'h3 == cu_io_opa_type ? eximm_io_eximm : _io_deio_op_a_T_4; // @[Mux.scala 81:58]
  assign io_deio_op_b = 3'h4 == cu_io_opb_type ? _io_deio_op_b_T_1 : _io_deio_op_b_T_9; // @[Mux.scala 81:58]
  assign io_deio_reg_waddr = inst[11:7]; // @[Decode.scala 83:15]
  assign io_deio_branch_type = cu_io_branch_type; // @[Decode.scala 136:25]
  assign io_deio_branch_addr = io_fdio_pc + _io_deio_branch_addr_T_7; // @[Decode.scala 137:39]
  assign io_deio_alu_op = cu_io_alu_op; // @[Decode.scala 138:20]
  assign io_deio_shamt = inst[25:20]; // @[Decode.scala 84:18]
  assign io_deio_wb_type = cu_io_wb_type; // @[Decode.scala 140:21]
  assign io_deio_sd_type = cu_io_sd_type; // @[Decode.scala 141:21]
  assign io_deio_reg2_rdata = io_fwde_fw_sel2 ? io_fwde_fw_data2 : io_rfio_reg2_rdata; // @[Decode.scala 142:30]
  assign io_deio_ld_type = cu_io_ld_type; // @[Decode.scala 143:21]
  assign io_deio_csr_t = io_fwde_csr_fw_sel ? io_fwde_csr_fw_data : io_csrs_csr_rdata; // @[Decode.scala 144:25]
  assign io_deio_csr_waddr = |cu_io_csr_type ? csr_num : 12'h0; // @[Decode.scala 145:29]
  assign io_deio_csr_wen = |cu_io_csr_type; // @[Decode.scala 146:39]
  assign io_deio_has_inst = inst == 32'h13 | io_flush ? 1'h0 : 1'h1; // @[Decode.scala 148:28]
  assign io_jump_flag = cu_io_jump_type == 2'h1 | _load_use_T_11; // @[Decode.scala 151:63]
  assign io_jump_pc = _io_jump_flag_T ? _io_jump_pc_T_2 : _io_jump_pc_T_9; // @[Mux.scala 101:16]
  assign io_load_use = _load_use_T_14 & lu_rd != 5'h0; // @[Decode.scala 99:7]
  assign io_fwde_reg1_raddr = inst[19:15]; // @[Decode.scala 81:16]
  assign io_fwde_reg2_raddr = inst[24:20]; // @[Decode.scala 82:16]
  assign io_fwde_csr_raddr = inst[31:20]; // @[Decode.scala 80:20]
  assign io_csrs_csr_raddr = inst[31:20]; // @[Decode.scala 80:20]
  assign cu_io_inst = inst; // @[Decode.scala 174:16]
  assign eximm_io_inst = inst; // @[Decode.scala 176:19]
  assign eximm_io_imm_type = cu_io_imm_type; // @[Decode.scala 177:23]
  always @(posedge clock) begin
    if (reset) begin // @[Decode.scala 89:24]
      lu_rd <= 5'h0; // @[Decode.scala 89:24]
    end else if (io_branch) begin // @[Decode.scala 92:17]
      lu_rd <= 5'h0;
    end else if (!(io_stall)) begin // @[Decode.scala 93:17]
      if (load_use) begin // @[Decode.scala 94:17]
        lu_rd <= 5'h0;
      end else begin
        lu_rd <= _lu_rd_T_1;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  lu_rd = _RAND_0[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_22051553_BoothMul(
  input         clock,
  input         reset,
  input         io_mul_valid,
  input         io_mulw,
  input  [1:0]  io_mul_signed,
  input  [63:0] io_multiplicand,
  input  [63:0] io_multiplier,
  output        io_out_valid,
  output [63:0] io_result_hi,
  output [63:0] io_result_lo
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [95:0] _RAND_3;
  reg [159:0] _RAND_4;
  reg [159:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  reg  out_valid; // @[BoothMul.scala 30:28]
  reg [63:0] result_hi; // @[BoothMul.scala 31:28]
  reg [63:0] result_lo; // @[BoothMul.scala 32:28]
  reg [66:0] multiplierReg; // @[BoothMul.scala 43:32]
  reg [131:0] multiplicandReg; // @[BoothMul.scala 44:34]
  reg [131:0] resultReg; // @[BoothMul.scala 45:28]
  reg  state; // @[BoothMul.scala 47:24]
  wire [2:0] choose = {io_mulw,io_mul_signed}; // @[Cat.scala 33:92]
  reg [5:0] shiftCounter; // @[BoothMul.scala 52:31]
  reg [5:0] total; // @[BoothMul.scala 53:24]
  wire [5:0] _total_T_1 = 3'h0 == choose ? 6'h21 : 6'h0; // @[Mux.scala 81:58]
  wire [5:0] _total_T_3 = 3'h2 == choose ? 6'h21 : _total_T_1; // @[Mux.scala 81:58]
  wire [5:0] _total_T_5 = 3'h3 == choose ? 6'h20 : _total_T_3; // @[Mux.scala 81:58]
  wire [5:0] _total_T_7 = 3'h4 == choose ? 6'h11 : _total_T_5; // @[Mux.scala 81:58]
  wire [5:0] _total_T_9 = 3'h6 == choose ? 6'h11 : _total_T_7; // @[Mux.scala 81:58]
  wire [66:0] _multiplierReg_T = {2'h0,io_multiplier,1'h0}; // @[Cat.scala 33:92]
  wire [1:0] _multiplierReg_T_4 = io_multiplier[63] ? 2'h3 : 2'h0; // @[Bitwise.scala 77:12]
  wire [66:0] _multiplierReg_T_5 = {_multiplierReg_T_4,io_multiplier,1'h0}; // @[Cat.scala 33:92]
  wire [66:0] _multiplierReg_T_7 = {34'h0,io_multiplier[31:0],1'h0}; // @[Cat.scala 33:92]
  wire [1:0] _multiplierReg_T_12 = io_multiplier[31] ? 2'h3 : 2'h0; // @[Bitwise.scala 77:12]
  wire [66:0] _multiplierReg_T_14 = {32'h0,_multiplierReg_T_12,io_multiplier[31:0],1'h0}; // @[Cat.scala 33:92]
  wire [66:0] _multiplierReg_T_16 = 3'h0 == choose ? _multiplierReg_T : 67'h0; // @[Mux.scala 81:58]
  wire [66:0] _multiplierReg_T_18 = 3'h2 == choose ? _multiplierReg_T : _multiplierReg_T_16; // @[Mux.scala 81:58]
  wire [66:0] _multiplierReg_T_20 = 3'h3 == choose ? _multiplierReg_T_5 : _multiplierReg_T_18; // @[Mux.scala 81:58]
  wire [66:0] _multiplierReg_T_22 = 3'h4 == choose ? _multiplierReg_T_7 : _multiplierReg_T_20; // @[Mux.scala 81:58]
  wire [66:0] _multiplierReg_T_24 = 3'h6 == choose ? _multiplierReg_T_7 : _multiplierReg_T_22; // @[Mux.scala 81:58]
  wire [131:0] _multiplicandReg_T = {68'h0,io_multiplicand}; // @[Cat.scala 33:92]
  wire [67:0] _multiplicandReg_T_3 = io_multiplicand[63] ? 68'hfffffffffffffffff : 68'h0; // @[Bitwise.scala 77:12]
  wire [131:0] _multiplicandReg_T_4 = {_multiplicandReg_T_3,io_multiplicand}; // @[Cat.scala 33:92]
  wire [131:0] _multiplicandReg_T_10 = {100'h0,io_multiplicand[31:0]}; // @[Cat.scala 33:92]
  wire [99:0] _multiplicandReg_T_13 = io_multiplicand[31] ? 100'hfffffffffffffffffffffffff : 100'h0; // @[Bitwise.scala 77:12]
  wire [131:0] _multiplicandReg_T_15 = {_multiplicandReg_T_13,io_multiplicand[31:0]}; // @[Cat.scala 33:92]
  wire [131:0] _multiplicandReg_T_22 = 3'h0 == choose ? _multiplicandReg_T : 132'h0; // @[Mux.scala 81:58]
  wire [131:0] _multiplicandReg_T_24 = 3'h2 == choose ? _multiplicandReg_T_4 : _multiplicandReg_T_22; // @[Mux.scala 81:58]
  wire [131:0] _multiplicandReg_T_26 = 3'h3 == choose ? _multiplicandReg_T_4 : _multiplicandReg_T_24; // @[Mux.scala 81:58]
  wire [131:0] _multiplicandReg_T_28 = 3'h4 == choose ? _multiplicandReg_T_10 : _multiplicandReg_T_26; // @[Mux.scala 81:58]
  wire [131:0] _multiplicandReg_T_30 = 3'h6 == choose ? _multiplicandReg_T_15 : _multiplicandReg_T_28; // @[Mux.scala 81:58]
  wire [131:0] _multiplicandReg_T_32 = 3'h7 == choose ? _multiplicandReg_T_15 : _multiplicandReg_T_30; // @[Mux.scala 81:58]
  wire  _GEN_0 = io_mul_valid & ~out_valid | state; // @[BoothMul.scala 64:45 65:23 47:24]
  wire [131:0] _GEN_3 = io_mul_valid & ~out_valid ? _multiplicandReg_T_32 : multiplicandReg; // @[BoothMul.scala 64:45 93:33 44:34]
  wire [131:0] _GEN_4 = io_mul_valid & ~out_valid ? 132'h0 : resultReg; // @[BoothMul.scala 107:27 45:28 64:45]
  wire [132:0] _resultReg_T_1 = {multiplicandReg, 1'h0}; // @[BoothMul.scala 126:54]
  wire [132:0] _resultReg_T_4 = 133'h0 - _resultReg_T_1; // @[BoothMul.scala 127:38]
  wire [131:0] _resultReg_T_6 = 132'h0 - multiplicandReg; // @[BoothMul.scala 128:38]
  wire [131:0] _resultReg_T_10 = 3'h1 == multiplierReg[2:0] ? multiplicandReg : 132'h0; // @[Mux.scala 81:58]
  wire [131:0] _resultReg_T_12 = 3'h2 == multiplierReg[2:0] ? multiplicandReg : _resultReg_T_10; // @[Mux.scala 81:58]
  wire [132:0] _resultReg_T_14 = 3'h3 == multiplierReg[2:0] ? _resultReg_T_1 : {{1'd0}, _resultReg_T_12}; // @[Mux.scala 81:58]
  wire [132:0] _resultReg_T_16 = 3'h4 == multiplierReg[2:0] ? _resultReg_T_4 : _resultReg_T_14; // @[Mux.scala 81:58]
  wire [132:0] _resultReg_T_18 = 3'h5 == multiplierReg[2:0] ? {{1'd0}, _resultReg_T_6} : _resultReg_T_16; // @[Mux.scala 81:58]
  wire [132:0] _resultReg_T_20 = 3'h6 == multiplierReg[2:0] ? {{1'd0}, _resultReg_T_6} : _resultReg_T_18; // @[Mux.scala 81:58]
  wire [132:0] _resultReg_T_22 = 3'h7 == multiplierReg[2:0] ? 133'h0 : _resultReg_T_20; // @[Mux.scala 81:58]
  wire [132:0] _GEN_32 = {{1'd0}, resultReg}; // @[BoothMul.scala 121:40]
  wire [132:0] _resultReg_T_24 = _GEN_32 + _resultReg_T_22; // @[BoothMul.scala 121:40]
  wire [133:0] _GEN_33 = {multiplicandReg, 2'h0}; // @[BoothMul.scala 134:52]
  wire [134:0] _multiplicandReg_T_33 = {{1'd0}, _GEN_33}; // @[BoothMul.scala 134:52]
  wire [66:0] _multiplierReg_T_27 = {{2'd0}, multiplierReg[66:2]}; // @[BoothMul.scala 135:48]
  wire [5:0] _shiftCounter_T_1 = shiftCounter + 6'h1; // @[BoothMul.scala 137:46]
  wire  _GEN_7 = shiftCounter == total | out_valid; // @[BoothMul.scala 114:41 116:27 30:28]
  wire [132:0] _GEN_10 = shiftCounter == total ? {{1'd0}, resultReg} : _resultReg_T_24; // @[BoothMul.scala 114:41 121:27 45:28]
  wire [134:0] _GEN_11 = shiftCounter == total ? {{3'd0}, multiplicandReg} : _multiplicandReg_T_33; // @[BoothMul.scala 114:41 134:33 44:34]
  wire [132:0] _GEN_18 = state ? _GEN_10 : {{1'd0}, resultReg}; // @[BoothMul.scala 55:18 45:28]
  wire [134:0] _GEN_19 = state ? _GEN_11 : {{3'd0}, multiplicandReg}; // @[BoothMul.scala 55:18 44:34]
  wire [134:0] _GEN_30 = ~state ? {{3'd0}, _GEN_3} : _GEN_19; // @[BoothMul.scala 55:18]
  wire [132:0] _GEN_31 = ~state ? {{1'd0}, _GEN_4} : _GEN_18; // @[BoothMul.scala 55:18]
  wire [134:0] _GEN_35 = reset ? 135'h0 : _GEN_30; // @[BoothMul.scala 44:{34,34}]
  wire [132:0] _GEN_36 = reset ? 133'h0 : _GEN_31; // @[BoothMul.scala 45:{28,28}]
  assign io_out_valid = out_valid; // @[BoothMul.scala 35:18]
  assign io_result_hi = result_hi; // @[BoothMul.scala 36:18]
  assign io_result_lo = result_lo; // @[BoothMul.scala 37:18]
  always @(posedge clock) begin
    if (reset) begin // @[BoothMul.scala 30:28]
      out_valid <= 1'h0; // @[BoothMul.scala 30:28]
    end else if (~state) begin // @[BoothMul.scala 55:18]
      out_valid <= 1'h0; // @[BoothMul.scala 57:23]
    end else if (state) begin // @[BoothMul.scala 55:18]
      out_valid <= _GEN_7;
    end
    if (reset) begin // @[BoothMul.scala 31:28]
      result_hi <= 64'h0; // @[BoothMul.scala 31:28]
    end else if (~state) begin // @[BoothMul.scala 55:18]
      result_hi <= 64'h0; // @[BoothMul.scala 58:23]
    end else if (state) begin // @[BoothMul.scala 55:18]
      if (shiftCounter == total) begin // @[BoothMul.scala 114:41]
        result_hi <= resultReg[127:64]; // @[BoothMul.scala 117:27]
      end
    end
    if (reset) begin // @[BoothMul.scala 32:28]
      result_lo <= 64'h0; // @[BoothMul.scala 32:28]
    end else if (~state) begin // @[BoothMul.scala 55:18]
      result_lo <= 64'h0; // @[BoothMul.scala 59:23]
    end else if (state) begin // @[BoothMul.scala 55:18]
      if (shiftCounter == total) begin // @[BoothMul.scala 114:41]
        result_lo <= resultReg[63:0]; // @[BoothMul.scala 118:27]
      end
    end
    if (reset) begin // @[BoothMul.scala 43:32]
      multiplierReg <= 67'h0; // @[BoothMul.scala 43:32]
    end else if (~state) begin // @[BoothMul.scala 55:18]
      if (io_mul_valid & ~out_valid) begin // @[BoothMul.scala 64:45]
        if (3'h7 == choose) begin // @[Mux.scala 81:58]
          multiplierReg <= _multiplierReg_T_14;
        end else begin
          multiplierReg <= _multiplierReg_T_24;
        end
      end
    end else if (state) begin // @[BoothMul.scala 55:18]
      if (!(shiftCounter == total)) begin // @[BoothMul.scala 114:41]
        multiplierReg <= _multiplierReg_T_27; // @[BoothMul.scala 135:31]
      end
    end
    multiplicandReg <= _GEN_35[131:0]; // @[BoothMul.scala 44:{34,34}]
    resultReg <= _GEN_36[131:0]; // @[BoothMul.scala 45:{28,28}]
    if (reset) begin // @[BoothMul.scala 47:24]
      state <= 1'h0; // @[BoothMul.scala 47:24]
    end else if (~state) begin // @[BoothMul.scala 55:18]
      state <= _GEN_0;
    end else if (state) begin // @[BoothMul.scala 55:18]
      if (shiftCounter == total) begin // @[BoothMul.scala 114:41]
        state <= 1'h0; // @[BoothMul.scala 115:23]
      end
    end
    if (reset) begin // @[BoothMul.scala 52:31]
      shiftCounter <= 6'h0; // @[BoothMul.scala 52:31]
    end else if (~state) begin // @[BoothMul.scala 55:18]
      shiftCounter <= 6'h0; // @[BoothMul.scala 61:26]
    end else if (state) begin // @[BoothMul.scala 55:18]
      if (!(shiftCounter == total)) begin // @[BoothMul.scala 114:41]
        shiftCounter <= _shiftCounter_T_1; // @[BoothMul.scala 137:30]
      end
    end
    if (reset) begin // @[BoothMul.scala 53:24]
      total <= 6'h0; // @[BoothMul.scala 53:24]
    end else if (~state) begin // @[BoothMul.scala 55:18]
      if (io_mul_valid & ~out_valid) begin // @[BoothMul.scala 64:45]
        if (3'h7 == choose) begin // @[Mux.scala 81:58]
          total <= 6'h10;
        end else begin
          total <= _total_T_9;
        end
      end else begin
        total <= 6'h0; // @[BoothMul.scala 62:19]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  out_valid = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  result_hi = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  result_lo = _RAND_2[63:0];
  _RAND_3 = {3{`RANDOM}};
  multiplierReg = _RAND_3[66:0];
  _RAND_4 = {5{`RANDOM}};
  multiplicandReg = _RAND_4[131:0];
  _RAND_5 = {5{`RANDOM}};
  resultReg = _RAND_5[131:0];
  _RAND_6 = {1{`RANDOM}};
  state = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  shiftCounter = _RAND_7[5:0];
  _RAND_8 = {1{`RANDOM}};
  total = _RAND_8[5:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_22051553_Divider(
  input         clock,
  input         reset,
  input         io_div_valid,
  input         io_divw,
  input         io_div_signed,
  input  [63:0] io_dividend,
  input  [63:0] io_divisor,
  output        io_out_valid,
  output [63:0] io_quotient
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [127:0] _RAND_2;
  reg [95:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  reg  out_valid; // @[Divider.scala 33:28]
  reg [63:0] quotient; // @[Divider.scala 34:27]
  reg [127:0] partial_remainder; // @[Divider.scala 43:36]
  reg [64:0] sub65; // @[Divider.scala 44:24]
  reg [32:0] sub33; // @[Divider.scala 45:24]
  reg  sign_quo; // @[Divider.scala 49:27]
  reg  sign_rem; // @[Divider.scala 50:27]
  reg [1:0] state; // @[Divider.scala 52:24]
  wire [1:0] choose = {io_divw,io_div_signed}; // @[Cat.scala 33:92]
  reg [6:0] shiftCounter; // @[Divider.scala 57:31]
  wire [63:0] _dividend_T_1 = ~io_dividend; // @[Divider.scala 86:57]
  wire [63:0] _dividend_T_3 = _dividend_T_1 + 64'h1; // @[Divider.scala 86:70]
  wire [63:0] _dividend_T_4 = io_dividend[63] ? _dividend_T_3 : io_dividend; // @[Divider.scala 86:39]
  wire [31:0] _dividend_T_8 = ~io_dividend[31:0]; // @[Divider.scala 90:57]
  wire [31:0] _dividend_T_10 = _dividend_T_8 + 32'h1; // @[Divider.scala 90:76]
  wire [31:0] _dividend_T_12 = io_dividend[31] ? _dividend_T_10 : io_dividend[31:0]; // @[Divider.scala 90:39]
  wire [63:0] _dividend_T_14 = 2'h1 == choose ? _dividend_T_4 : io_dividend; // @[Mux.scala 81:58]
  wire [63:0] _dividend_T_16 = 2'h2 == choose ? {{32'd0}, io_dividend[31:0]} : _dividend_T_14; // @[Mux.scala 81:58]
  wire [63:0] _dividend_T_18 = 2'h3 == choose ? {{32'd0}, _dividend_T_12} : _dividend_T_16; // @[Mux.scala 81:58]
  wire [63:0] _GEN_2 = io_div_valid & ~out_valid ? _dividend_T_18 : 64'h0; // @[Divider.scala 76:45 81:26]
  wire [63:0] dividend = 2'h0 == state ? _GEN_2 : 64'h0; // @[Divider.scala 68:18]
  wire [127:0] _partial_remainder_T_1 = {32'h0,dividend[31:0],64'h0}; // @[Cat.scala 33:92]
  wire [127:0] _partial_remainder_T_2 = {64'h0,dividend}; // @[Cat.scala 33:92]
  wire [63:0] _divisor_T_1 = ~io_divisor; // @[Divider.scala 104:56]
  wire [63:0] _divisor_T_3 = _divisor_T_1 + 64'h1; // @[Divider.scala 104:68]
  wire [63:0] _divisor_T_4 = io_divisor[63] ? _divisor_T_3 : io_divisor; // @[Divider.scala 104:39]
  wire [31:0] _divisor_T_8 = ~io_divisor[31:0]; // @[Divider.scala 108:56]
  wire [31:0] _divisor_T_10 = _divisor_T_8 + 32'h1; // @[Divider.scala 108:74]
  wire [31:0] _divisor_T_12 = io_divisor[31] ? _divisor_T_10 : io_divisor[31:0]; // @[Divider.scala 108:39]
  wire [63:0] _divisor_T_14 = 2'h1 == choose ? _divisor_T_4 : io_divisor; // @[Mux.scala 81:58]
  wire [63:0] _divisor_T_16 = 2'h2 == choose ? {{32'd0}, io_divisor[31:0]} : _divisor_T_14; // @[Mux.scala 81:58]
  wire [63:0] _divisor_T_18 = 2'h3 == choose ? {{32'd0}, _divisor_T_12} : _divisor_T_16; // @[Mux.scala 81:58]
  wire [63:0] _GEN_4 = io_div_valid & ~out_valid ? _divisor_T_18 : 64'h0; // @[Divider.scala 76:45 99:25]
  wire [63:0] divisor = 2'h0 == state ? _GEN_4 : 64'h0; // @[Divider.scala 68:18]
  wire [32:0] _sub33_T_1 = {1'h0,divisor[31:0]}; // @[Cat.scala 33:92]
  wire [32:0] _sub33_T_2 = ~_sub33_T_1; // @[Divider.scala 112:26]
  wire [32:0] _sub33_T_4 = _sub33_T_2 + 33'h1; // @[Divider.scala 112:56]
  wire [64:0] _sub65_T = {1'h0,divisor}; // @[Cat.scala 33:92]
  wire [64:0] _sub65_T_1 = ~_sub65_T; // @[Divider.scala 113:26]
  wire [64:0] _sub65_T_3 = _sub65_T_1 + 65'h1; // @[Divider.scala 113:50]
  wire [1:0] _sign_quo_T_2 = {io_dividend[31],io_divisor[31]}; // @[Cat.scala 33:92]
  wire  _sign_quo_T_8 = 2'h3 == _sign_quo_T_2 ? 1'h0 : 2'h2 == _sign_quo_T_2 | 2'h1 == _sign_quo_T_2; // @[Mux.scala 81:58]
  wire [1:0] _sign_quo_T_11 = {io_dividend[63],io_divisor[63]}; // @[Cat.scala 33:92]
  wire  _sign_quo_T_17 = 2'h3 == _sign_quo_T_11 ? 1'h0 : 2'h2 == _sign_quo_T_11 | 2'h1 == _sign_quo_T_11; // @[Mux.scala 81:58]
  wire  _sign_quo_T_18 = io_divw ? _sign_quo_T_8 : _sign_quo_T_17; // @[Divider.scala 116:24]
  wire  _sign_rem_T_6 = 2'h2 == _sign_quo_T_2 ? 1'h0 : 1'h1; // @[Mux.scala 81:58]
  wire  _sign_rem_T_8 = 2'h3 == _sign_quo_T_2 ? 1'h0 : _sign_rem_T_6; // @[Mux.scala 81:58]
  wire  _sign_rem_T_15 = 2'h2 == _sign_quo_T_11 ? 1'h0 : 1'h1; // @[Mux.scala 81:58]
  wire  _sign_rem_T_17 = 2'h3 == _sign_quo_T_11 ? 1'h0 : _sign_rem_T_15; // @[Mux.scala 81:58]
  wire  _sign_rem_T_18 = io_divw ? _sign_rem_T_8 : _sign_rem_T_17; // @[Divider.scala 138:24]
  wire [31:0] _quotient_T_1 = quotient[31:0]; // @[Divider.scala 163:44]
  wire [1:0] _GEN_9 = ~sign_quo & ~sign_rem ? 2'h0 : 2'h3; // @[Divider.scala 166:45 167:27 170:27]
  wire  _GEN_10 = ~sign_quo & ~sign_rem | out_valid; // @[Divider.scala 166:45 168:31 33:28]
  wire [33:0] _temp_34_T_1 = {1'h0,partial_remainder[127:95]}; // @[Cat.scala 33:92]
  wire [33:0] _temp_34_T_2 = {1'h0,sub33}; // @[Cat.scala 33:92]
  wire [33:0] _temp_34_T_4 = _temp_34_T_1 + _temp_34_T_2; // @[Divider.scala 174:70]
  wire [33:0] _GEN_17 = shiftCounter == 7'h20 ? 34'h0 : _temp_34_T_4; // @[Divider.scala 161:40 174:25]
  wire [33:0] _GEN_48 = 2'h1 == state ? _GEN_17 : 34'h0; // @[Divider.scala 68:18]
  wire [33:0] temp_34 = 2'h0 == state ? 34'h0 : _GEN_48; // @[Divider.scala 68:18]
  wire [127:0] _partial_remainder_T_6 = {temp_34[31:0],partial_remainder[94:0],1'h0}; // @[Cat.scala 33:92]
  wire [63:0] _quotient_T_4 = {quotient[62:0],1'h1}; // @[Divider.scala 177:63]
  wire [127:0] _partial_remainder_T_8 = {partial_remainder[126:0],1'h0}; // @[Cat.scala 33:92]
  wire [63:0] _quotient_T_7 = {quotient[62:0],1'h0}; // @[Divider.scala 180:63]
  wire [127:0] _GEN_11 = temp_34[33] ? _partial_remainder_T_6 : _partial_remainder_T_8; // @[Divider.scala 175:34 176:39 179:39]
  wire [63:0] _GEN_12 = temp_34[33] ? $signed(_quotient_T_4) : $signed(_quotient_T_7); // @[Divider.scala 175:34 177:30 180:30]
  wire [6:0] _shiftCounter_T_1 = shiftCounter + 7'h1; // @[Divider.scala 183:46]
  wire [65:0] _temp_66_T_1 = {1'h0,partial_remainder[127:63]}; // @[Cat.scala 33:92]
  wire [65:0] _temp_66_T_2 = {1'h0,sub65}; // @[Cat.scala 33:92]
  wire [65:0] _temp_66_T_4 = _temp_66_T_1 + _temp_66_T_2; // @[Divider.scala 199:70]
  wire [65:0] _GEN_27 = shiftCounter == 7'h40 ? 66'h0 : _temp_66_T_4; // @[Divider.scala 188:40 199:25]
  wire [65:0] _GEN_40 = 2'h2 == state ? _GEN_27 : 66'h0; // @[Divider.scala 68:18]
  wire [65:0] _GEN_51 = 2'h1 == state ? 66'h0 : _GEN_40; // @[Divider.scala 68:18]
  wire [65:0] temp_66 = 2'h0 == state ? 66'h0 : _GEN_51; // @[Divider.scala 68:18]
  wire [127:0] _partial_remainder_T_11 = {temp_66[63:0],partial_remainder[62:0],1'h0}; // @[Cat.scala 33:92]
  wire [127:0] _GEN_22 = temp_66[65] ? _partial_remainder_T_11 : _partial_remainder_T_8; // @[Divider.scala 200:34 201:39 204:39]
  wire [63:0] _GEN_23 = temp_66[65] ? $signed(_quotient_T_4) : $signed(_quotient_T_7); // @[Divider.scala 200:34 202:30 205:30]
  wire [1:0] _GEN_25 = shiftCounter == 7'h40 ? _GEN_9 : state; // @[Divider.scala 188:40 52:24]
  wire  _GEN_26 = shiftCounter == 7'h40 ? _GEN_10 : out_valid; // @[Divider.scala 188:40 33:28]
  wire [127:0] _GEN_28 = shiftCounter == 7'h40 ? partial_remainder : _GEN_22; // @[Divider.scala 188:40 43:36]
  wire [63:0] _GEN_29 = shiftCounter == 7'h40 ? $signed(quotient) : $signed(_GEN_23); // @[Divider.scala 188:40 34:27]
  wire [6:0] _GEN_30 = shiftCounter == 7'h40 ? shiftCounter : _shiftCounter_T_1; // @[Divider.scala 188:40 208:30 57:31]
  wire [63:0] _quotient_T_15 = ~quotient; // @[Divider.scala 216:29]
  wire [63:0] _quotient_T_18 = $signed(_quotient_T_15) + 64'sh1; // @[Divider.scala 216:39]
  wire [63:0] _GEN_31 = sign_quo ? $signed(_quotient_T_18) : $signed(quotient); // @[Divider.scala 215:27 216:26 34:27]
  wire [1:0] _GEN_33 = 2'h3 == state ? 2'h0 : state; // @[Divider.scala 68:18 212:19 52:24]
  wire  _GEN_34 = 2'h3 == state | out_valid; // @[Divider.scala 68:18 213:23 33:28]
  wire [63:0] _GEN_35 = 2'h3 == state ? $signed(_GEN_31) : $signed(quotient); // @[Divider.scala 68:18 34:27]
  assign io_out_valid = out_valid; // @[Divider.scala 38:18]
  assign io_quotient = quotient; // @[Divider.scala 39:29]
  always @(posedge clock) begin
    if (reset) begin // @[Divider.scala 33:28]
      out_valid <= 1'h0; // @[Divider.scala 33:28]
    end else if (2'h0 == state) begin // @[Divider.scala 68:18]
      out_valid <= 1'h0; // @[Divider.scala 70:23]
    end else if (2'h1 == state) begin // @[Divider.scala 68:18]
      if (shiftCounter == 7'h20) begin // @[Divider.scala 161:40]
        out_valid <= _GEN_10;
      end
    end else if (2'h2 == state) begin // @[Divider.scala 68:18]
      out_valid <= _GEN_26;
    end else begin
      out_valid <= _GEN_34;
    end
    if (reset) begin // @[Divider.scala 34:27]
      quotient <= 64'sh0; // @[Divider.scala 34:27]
    end else if (2'h0 == state) begin // @[Divider.scala 68:18]
      quotient <= 64'sh0; // @[Divider.scala 71:22]
    end else if (2'h1 == state) begin // @[Divider.scala 68:18]
      if (shiftCounter == 7'h20) begin // @[Divider.scala 161:40]
        quotient <= {{32{_quotient_T_1[31]}},_quotient_T_1}; // @[Divider.scala 163:26]
      end else begin
        quotient <= _GEN_12;
      end
    end else if (2'h2 == state) begin // @[Divider.scala 68:18]
      quotient <= _GEN_29;
    end else begin
      quotient <= _GEN_35;
    end
    if (reset) begin // @[Divider.scala 43:36]
      partial_remainder <= 128'h0; // @[Divider.scala 43:36]
    end else if (2'h0 == state) begin // @[Divider.scala 68:18]
      if (io_div_valid & ~out_valid) begin // @[Divider.scala 76:45]
        if (io_divw) begin // @[Divider.scala 94:41]
          partial_remainder <= _partial_remainder_T_1;
        end else begin
          partial_remainder <= _partial_remainder_T_2;
        end
      end
    end else if (2'h1 == state) begin // @[Divider.scala 68:18]
      if (!(shiftCounter == 7'h20)) begin // @[Divider.scala 161:40]
        partial_remainder <= _GEN_11;
      end
    end else if (2'h2 == state) begin // @[Divider.scala 68:18]
      partial_remainder <= _GEN_28;
    end
    if (reset) begin // @[Divider.scala 44:24]
      sub65 <= 65'h0; // @[Divider.scala 44:24]
    end else if (2'h0 == state) begin // @[Divider.scala 68:18]
      if (io_div_valid & ~out_valid) begin // @[Divider.scala 76:45]
        sub65 <= _sub65_T_3; // @[Divider.scala 113:23]
      end
    end
    if (reset) begin // @[Divider.scala 45:24]
      sub33 <= 33'h0; // @[Divider.scala 45:24]
    end else if (2'h0 == state) begin // @[Divider.scala 68:18]
      if (io_div_valid & ~out_valid) begin // @[Divider.scala 76:45]
        sub33 <= _sub33_T_4; // @[Divider.scala 112:23]
      end
    end
    if (reset) begin // @[Divider.scala 49:27]
      sign_quo <= 1'h0; // @[Divider.scala 49:27]
    end else if (2'h0 == state) begin // @[Divider.scala 68:18]
      if (io_div_valid & ~out_valid) begin // @[Divider.scala 76:45]
        sign_quo <= io_div_signed & _sign_quo_T_18; // @[Divider.scala 115:26]
      end
    end
    if (reset) begin // @[Divider.scala 50:27]
      sign_rem <= 1'h0; // @[Divider.scala 50:27]
    end else if (2'h0 == state) begin // @[Divider.scala 68:18]
      if (io_div_valid & ~out_valid) begin // @[Divider.scala 76:45]
        sign_rem <= io_div_signed & _sign_rem_T_18; // @[Divider.scala 137:26]
      end
    end
    if (reset) begin // @[Divider.scala 52:24]
      state <= 2'h0; // @[Divider.scala 52:24]
    end else if (2'h0 == state) begin // @[Divider.scala 68:18]
      if (io_div_valid & ~out_valid) begin // @[Divider.scala 76:45]
        if (io_divw) begin // @[Divider.scala 79:29]
          state <= 2'h1;
        end else begin
          state <= 2'h2;
        end
      end
    end else if (2'h1 == state) begin // @[Divider.scala 68:18]
      if (shiftCounter == 7'h20) begin // @[Divider.scala 161:40]
        state <= _GEN_9;
      end
    end else if (2'h2 == state) begin // @[Divider.scala 68:18]
      state <= _GEN_25;
    end else begin
      state <= _GEN_33;
    end
    if (reset) begin // @[Divider.scala 57:31]
      shiftCounter <= 7'h0; // @[Divider.scala 57:31]
    end else if (2'h0 == state) begin // @[Divider.scala 68:18]
      shiftCounter <= 7'h0; // @[Divider.scala 74:26]
    end else if (2'h1 == state) begin // @[Divider.scala 68:18]
      if (!(shiftCounter == 7'h20)) begin // @[Divider.scala 161:40]
        shiftCounter <= _shiftCounter_T_1; // @[Divider.scala 183:30]
      end
    end else if (2'h2 == state) begin // @[Divider.scala 68:18]
      shiftCounter <= _GEN_30;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  out_valid = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  quotient = _RAND_1[63:0];
  _RAND_2 = {4{`RANDOM}};
  partial_remainder = _RAND_2[127:0];
  _RAND_3 = {3{`RANDOM}};
  sub65 = _RAND_3[64:0];
  _RAND_4 = {2{`RANDOM}};
  sub33 = _RAND_4[32:0];
  _RAND_5 = {1{`RANDOM}};
  sign_quo = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  sign_rem = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  state = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  shiftCounter = _RAND_8[6:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_22051553_Alu(
  input         clock,
  input         reset,
  input  [63:0] io_op_a,
  input  [63:0] io_op_b,
  input  [5:0]  io_alu_op,
  input  [5:0]  io_shamt,
  output [63:0] io_result,
  output        io_mul_div_outvalid
);
  wire  BM_clock; // @[Alu.scala 74:20]
  wire  BM_reset; // @[Alu.scala 74:20]
  wire  BM_io_mul_valid; // @[Alu.scala 74:20]
  wire  BM_io_mulw; // @[Alu.scala 74:20]
  wire [1:0] BM_io_mul_signed; // @[Alu.scala 74:20]
  wire [63:0] BM_io_multiplicand; // @[Alu.scala 74:20]
  wire [63:0] BM_io_multiplier; // @[Alu.scala 74:20]
  wire  BM_io_out_valid; // @[Alu.scala 74:20]
  wire [63:0] BM_io_result_hi; // @[Alu.scala 74:20]
  wire [63:0] BM_io_result_lo; // @[Alu.scala 74:20]
  wire  DIV_clock; // @[Alu.scala 75:21]
  wire  DIV_reset; // @[Alu.scala 75:21]
  wire  DIV_io_div_valid; // @[Alu.scala 75:21]
  wire  DIV_io_divw; // @[Alu.scala 75:21]
  wire  DIV_io_div_signed; // @[Alu.scala 75:21]
  wire [63:0] DIV_io_dividend; // @[Alu.scala 75:21]
  wire [63:0] DIV_io_divisor; // @[Alu.scala 75:21]
  wire  DIV_io_out_valid; // @[Alu.scala 75:21]
  wire [63:0] DIV_io_quotient; // @[Alu.scala 75:21]
  wire  _T = io_alu_op == 6'h12; // @[Alu.scala 101:20]
  wire  _T_1 = io_alu_op == 6'h13; // @[Alu.scala 101:45]
  wire  _T_2 = io_alu_op == 6'h12 | io_alu_op == 6'h13; // @[Alu.scala 101:33]
  wire  _T_3 = io_alu_op == 6'h14; // @[Alu.scala 101:71]
  wire  _T_5 = io_alu_op == 6'h15; // @[Alu.scala 102:19]
  wire  _T_6 = io_alu_op == 6'h12 | io_alu_op == 6'h13 | io_alu_op == 6'h14 | _T_5; // @[Alu.scala 101:87]
  wire  _T_7 = io_alu_op == 6'h23; // @[Alu.scala 102:46]
  wire  _BM_io_mul_signed_T_4 = _T_2 | _T_7; // @[Alu.scala 109:21]
  wire [1:0] _BM_io_mul_signed_T_8 = _T_3 ? 2'h2 : 2'h0; // @[Mux.scala 101:16]
  wire [1:0] _BM_io_mul_signed_T_9 = _BM_io_mul_signed_T_4 ? 2'h3 : _BM_io_mul_signed_T_8; // @[Mux.scala 101:16]
  wire  _bm_value_T_2 = _T | _T_7; // @[Alu.scala 121:42]
  wire  _bm_value_T_8 = _T_1 | _T_3 | _T_5; // @[Alu.scala 122:73]
  wire [63:0] _bm_value_T_10 = _bm_value_T_8 ? $signed(BM_io_result_hi) : $signed(64'sh0); // @[Mux.scala 101:16]
  wire [63:0] _bm_value_T_11 = _bm_value_T_2 ? $signed(BM_io_result_lo) : $signed(_bm_value_T_10); // @[Mux.scala 101:16]
  wire [63:0] bm_value = BM_io_out_valid ? $signed(_bm_value_T_11) : $signed(64'sh0); // @[Alu.scala 118:20]
  wire  _T_9 = io_alu_op == 6'h16; // @[Alu.scala 128:20]
  wire  _T_12 = io_alu_op == 6'h24; // @[Alu.scala 128:71]
  wire  _T_14 = io_alu_op == 6'h25; // @[Alu.scala 129:19]
  wire  _T_15 = io_alu_op == 6'h16 | io_alu_op == 6'h17 | io_alu_op == 6'h24 | _T_14; // @[Alu.scala 128:85]
  wire [63:0] div_value = DIV_io_out_valid ? $signed(DIV_io_quotient) : $signed(64'sh0); // @[Alu.scala 138:21]
  wire [63:0] _res_T_4 = $signed(io_op_a) + $signed(io_op_b); // @[Alu.scala 148:48]
  wire [63:0] _res_T_9 = $signed(io_op_a) - $signed(io_op_b); // @[Alu.scala 149:48]
  wire [1:0] _res_T_11 = {1'b0,$signed(io_op_a == io_op_b)}; // @[Alu.scala 150:54]
  wire [1:0] _res_T_13 = {1'b0,$signed(io_op_a != io_op_b)}; // @[Alu.scala 151:54]
  wire [1:0] _res_T_17 = {1'b0,$signed($signed(io_op_a) < $signed(io_op_b))}; // @[Alu.scala 152:66]
  wire [1:0] _res_T_21 = {1'b0,$signed($signed(io_op_a) >= $signed(io_op_b))}; // @[Alu.scala 153:67]
  wire [1:0] _res_T_23 = {1'b0,$signed(io_op_a < io_op_b)}; // @[Alu.scala 154:53]
  wire [1:0] _res_T_25 = {1'b0,$signed(io_op_a >= io_op_b)}; // @[Alu.scala 155:54]
  wire [63:0] _res_T_27 = io_op_a ^ io_op_b; // @[Alu.scala 156:52]
  wire [63:0] _res_T_29 = io_op_a | io_op_b; // @[Alu.scala 157:51]
  wire [126:0] _GEN_0 = {{63'd0}, io_op_a}; // @[Alu.scala 158:41]
  wire [126:0] _res_T_31 = _GEN_0 << io_op_b[5:0]; // @[Alu.scala 158:41]
  wire [126:0] _res_T_32 = _GEN_0 << io_op_b[5:0]; // @[Alu.scala 158:58]
  wire [63:0] _res_T_35 = io_op_a >> io_op_b[5:0]; // @[Alu.scala 159:58]
  wire [63:0] _res_T_38 = $signed(io_op_a) >>> io_op_b[5:0]; // @[Alu.scala 160:48]
  wire [126:0] _GEN_1 = {{63'd0}, io_op_a}; // @[Alu.scala 161:42]
  wire [126:0] _res_T_39 = _GEN_1 << io_shamt; // @[Alu.scala 161:42]
  wire [126:0] _res_T_40 = _GEN_1 << io_shamt; // @[Alu.scala 161:55]
  wire [63:0] _res_T_42 = io_op_a >> io_shamt; // @[Alu.scala 162:55]
  wire [63:0] _res_T_44 = $signed(io_op_a) >>> io_shamt; // @[Alu.scala 163:49]
  wire [63:0] _res_T_46 = io_op_a & io_op_b; // @[Alu.scala 164:52]
  wire [63:0] _res_T_50 = ~_res_T_46; // @[Alu.scala 165:33]
  wire [63:0] _res_T_53 = $signed(io_op_a) % $signed(io_op_b); // @[Alu.scala 166:48]
  wire [63:0] _res_T_54 = io_op_a % io_op_b; // @[Alu.scala 167:42]
  wire [63:0] _res_T_55 = io_op_a % io_op_b; // @[Alu.scala 167:53]
  wire [63:0] _res_T_57 = io_op_a + io_op_b; // @[Alu.scala 168:44]
  wire [31:0] _res_T_59 = _res_T_57[31:0]; // @[Alu.scala 168:62]
  wire [31:0] _res_T_62 = _res_T_39[31:0]; // @[Alu.scala 169:64]
  wire [31:0] _res_T_66 = io_op_a[31:0] >> io_shamt; // @[Alu.scala 170:70]
  wire [31:0] _res_T_68 = io_op_a[31:0]; // @[Alu.scala 171:50]
  wire [31:0] _res_T_71 = $signed(_res_T_68) >>> io_shamt; // @[Alu.scala 171:77]
  wire [63:0] _res_T_77 = io_op_a - io_op_b; // @[Alu.scala 173:43]
  wire [31:0] _res_T_79 = _res_T_77[31:0]; // @[Alu.scala 173:61]
  wire [31:0] _res_T_83 = _res_T_31[31:0]; // @[Alu.scala 174:67]
  wire [31:0] _res_T_88 = io_op_a[31:0] >> io_op_b[5:0]; // @[Alu.scala 175:73]
  wire [31:0] _res_T_94 = $signed(_res_T_68) >>> io_op_b[5:0]; // @[Alu.scala 176:80]
  wire [31:0] _res_T_99 = _res_T_53[31:0]; // @[Alu.scala 177:75]
  wire [31:0] _res_T_102 = _res_T_54[31:0]; // @[Alu.scala 178:62]
  wire [63:0] _res_T_103 = ~io_op_a; // @[Alu.scala 179:35]
  wire [63:0] _res_T_105 = _res_T_103 & io_op_b; // @[Alu.scala 179:55]
  wire [63:0] _res_T_108 = 6'h0 == io_alu_op ? $signed(_res_T_4) : $signed(64'sh0); // @[Mux.scala 81:58]
  wire [63:0] _res_T_110 = 6'h1 == io_alu_op ? $signed(_res_T_9) : $signed(_res_T_108); // @[Mux.scala 81:58]
  wire [63:0] _res_T_112 = 6'h2 == io_alu_op ? $signed({{62{_res_T_11[1]}},_res_T_11}) : $signed(_res_T_110); // @[Mux.scala 81:58]
  wire [63:0] _res_T_114 = 6'h3 == io_alu_op ? $signed({{62{_res_T_13[1]}},_res_T_13}) : $signed(_res_T_112); // @[Mux.scala 81:58]
  wire [63:0] _res_T_116 = 6'h4 == io_alu_op ? $signed({{62{_res_T_17[1]}},_res_T_17}) : $signed(_res_T_114); // @[Mux.scala 81:58]
  wire [63:0] _res_T_118 = 6'h5 == io_alu_op ? $signed({{62{_res_T_21[1]}},_res_T_21}) : $signed(_res_T_116); // @[Mux.scala 81:58]
  wire [63:0] _res_T_120 = 6'h6 == io_alu_op ? $signed({{62{_res_T_23[1]}},_res_T_23}) : $signed(_res_T_118); // @[Mux.scala 81:58]
  wire [63:0] _res_T_122 = 6'h7 == io_alu_op ? $signed({{62{_res_T_25[1]}},_res_T_25}) : $signed(_res_T_120); // @[Mux.scala 81:58]
  wire [63:0] _res_T_124 = 6'h8 == io_alu_op ? $signed(_res_T_27) : $signed(_res_T_122); // @[Mux.scala 81:58]
  wire [63:0] _res_T_126 = 6'h9 == io_alu_op ? $signed(_res_T_29) : $signed(_res_T_124); // @[Mux.scala 81:58]
  wire [126:0] _res_T_128 = 6'ha == io_alu_op ? $signed(_res_T_32) : $signed({{63{_res_T_126[63]}},_res_T_126}); // @[Mux.scala 81:58]
  wire [126:0] _res_T_130 = 6'hb == io_alu_op ? $signed({{63{_res_T_35[63]}},_res_T_35}) : $signed(_res_T_128); // @[Mux.scala 81:58]
  wire [126:0] _res_T_132 = 6'hc == io_alu_op ? $signed({{63{_res_T_38[63]}},_res_T_38}) : $signed(_res_T_130); // @[Mux.scala 81:58]
  wire [126:0] _res_T_134 = 6'hd == io_alu_op ? $signed(_res_T_40) : $signed(_res_T_132); // @[Mux.scala 81:58]
  wire [126:0] _res_T_136 = 6'he == io_alu_op ? $signed({{63{_res_T_42[63]}},_res_T_42}) : $signed(_res_T_134); // @[Mux.scala 81:58]
  wire [126:0] _res_T_138 = 6'hf == io_alu_op ? $signed({{63{_res_T_44[63]}},_res_T_44}) : $signed(_res_T_136); // @[Mux.scala 81:58]
  wire [126:0] _res_T_140 = 6'h10 == io_alu_op ? $signed({{63{_res_T_46[63]}},_res_T_46}) : $signed(_res_T_138); // @[Mux.scala 81:58]
  wire [126:0] _res_T_142 = 6'h11 == io_alu_op ? $signed({{63{_res_T_50[63]}},_res_T_50}) : $signed(_res_T_140); // @[Mux.scala 81:58]
  wire [126:0] _res_T_144 = 6'h18 == io_alu_op ? $signed({{63{_res_T_53[63]}},_res_T_53}) : $signed(_res_T_142); // @[Mux.scala 81:58]
  wire [126:0] _res_T_146 = 6'h19 == io_alu_op ? $signed({{63{_res_T_55[63]}},_res_T_55}) : $signed(_res_T_144); // @[Mux.scala 81:58]
  wire [126:0] _res_T_148 = 6'h1a == io_alu_op ? $signed({{95{_res_T_59[31]}},_res_T_59}) : $signed(_res_T_146); // @[Mux.scala 81:58]
  wire [126:0] _res_T_150 = 6'h1b == io_alu_op ? $signed({{95{_res_T_62[31]}},_res_T_62}) : $signed(_res_T_148); // @[Mux.scala 81:58]
  wire [126:0] _res_T_152 = 6'h1c == io_alu_op ? $signed({{95{_res_T_66[31]}},_res_T_66}) : $signed(_res_T_150); // @[Mux.scala 81:58]
  wire [126:0] _res_T_154 = 6'h1d == io_alu_op ? $signed({{95{_res_T_71[31]}},_res_T_71}) : $signed(_res_T_152); // @[Mux.scala 81:58]
  wire [126:0] _res_T_156 = 6'h1e == io_alu_op ? $signed({{95{_res_T_59[31]}},_res_T_59}) : $signed(_res_T_154); // @[Mux.scala 81:58]
  wire [126:0] _res_T_158 = 6'h1f == io_alu_op ? $signed({{95{_res_T_79[31]}},_res_T_79}) : $signed(_res_T_156); // @[Mux.scala 81:58]
  wire [126:0] _res_T_160 = 6'h20 == io_alu_op ? $signed({{95{_res_T_83[31]}},_res_T_83}) : $signed(_res_T_158); // @[Mux.scala 81:58]
  wire [126:0] _res_T_162 = 6'h21 == io_alu_op ? $signed({{95{_res_T_88[31]}},_res_T_88}) : $signed(_res_T_160); // @[Mux.scala 81:58]
  wire [126:0] _res_T_164 = 6'h22 == io_alu_op ? $signed({{95{_res_T_94[31]}},_res_T_94}) : $signed(_res_T_162); // @[Mux.scala 81:58]
  wire [126:0] _res_T_166 = 6'h26 == io_alu_op ? $signed({{95{_res_T_99[31]}},_res_T_99}) : $signed(_res_T_164); // @[Mux.scala 81:58]
  wire [126:0] _res_T_168 = 6'h27 == io_alu_op ? $signed({{95{_res_T_102[31]}},_res_T_102}) : $signed(_res_T_166); // @[Mux.scala 81:58]
  wire [126:0] _res_T_170 = 6'h28 == io_alu_op ? $signed({{63{_res_T_105[63]}},_res_T_105}) : $signed(_res_T_168); // @[Mux.scala 81:58]
  wire [126:0] _res_T_172 = 6'h3f == io_alu_op ? $signed(127'sh0) : $signed(_res_T_170); // @[Mux.scala 81:58]
  wire [126:0] _res_T_173 = DIV_io_out_valid ? $signed({{63{div_value[63]}},div_value}) : $signed(_res_T_172); // @[Alu.scala 143:12]
  wire [126:0] _res_T_174 = BM_io_out_valid ? $signed({{63{bm_value[63]}},bm_value}) : $signed(_res_T_173); // @[Alu.scala 142:15]
  ysyx_22051553_BoothMul BM ( // @[Alu.scala 74:20]
    .clock(BM_clock),
    .reset(BM_reset),
    .io_mul_valid(BM_io_mul_valid),
    .io_mulw(BM_io_mulw),
    .io_mul_signed(BM_io_mul_signed),
    .io_multiplicand(BM_io_multiplicand),
    .io_multiplier(BM_io_multiplier),
    .io_out_valid(BM_io_out_valid),
    .io_result_hi(BM_io_result_hi),
    .io_result_lo(BM_io_result_lo)
  );
  ysyx_22051553_Divider DIV ( // @[Alu.scala 75:21]
    .clock(DIV_clock),
    .reset(DIV_reset),
    .io_div_valid(DIV_io_div_valid),
    .io_divw(DIV_io_divw),
    .io_div_signed(DIV_io_div_signed),
    .io_dividend(DIV_io_dividend),
    .io_divisor(DIV_io_divisor),
    .io_out_valid(DIV_io_out_valid),
    .io_quotient(DIV_io_quotient)
  );
  assign io_result = _res_T_174[63:0]; // @[Alu.scala 190:22]
  assign io_mul_div_outvalid = BM_io_out_valid | DIV_io_out_valid; // @[Alu.scala 77:44]
  assign BM_clock = clock;
  assign BM_reset = reset;
  assign BM_io_mul_valid = _T_6 | io_alu_op == 6'h23; // @[Alu.scala 102:34]
  assign BM_io_mulw = (_T_6 | io_alu_op == 6'h23) & io_alu_op == 6'h23; // @[Alu.scala 102:61 105:24 88:16]
  assign BM_io_mul_signed = _T_6 | io_alu_op == 6'h23 ? _BM_io_mul_signed_T_9 : 2'h0; // @[Alu.scala 102:61 106:30 89:22]
  assign BM_io_multiplicand = _T_6 | io_alu_op == 6'h23 ? io_op_a : 64'h0; // @[Alu.scala 102:61 114:32 90:24]
  assign BM_io_multiplier = _T_6 | io_alu_op == 6'h23 ? io_op_b : 64'h0; // @[Alu.scala 102:61 115:30 91:22]
  assign DIV_clock = clock;
  assign DIV_reset = reset;
  assign DIV_io_div_valid = io_alu_op == 6'h16 | io_alu_op == 6'h17 | io_alu_op == 6'h24 | _T_14; // @[Alu.scala 128:85]
  assign DIV_io_divw = _T_15 & (_T_12 | _T_14); // @[Alu.scala 129:35 132:25 95:17]
  assign DIV_io_div_signed = _T_15 & (_T_9 | _T_12); // @[Alu.scala 129:35 133:31 96:23]
  assign DIV_io_dividend = _T_15 ? io_op_a : 64'h0; // @[Alu.scala 129:35 134:29 97:21]
  assign DIV_io_divisor = _T_15 ? io_op_b : 64'h0; // @[Alu.scala 129:35 135:28 98:20]
endmodule
module ysyx_22051553_Excute(
  input         clock,
  input         reset,
  input  [63:0] io_deio_op_a,
  input  [63:0] io_deio_op_b,
  input  [4:0]  io_deio_reg_waddr,
  input         io_deio_branch_type,
  input  [63:0] io_deio_branch_addr,
  input  [5:0]  io_deio_alu_op,
  input  [5:0]  io_deio_shamt,
  input  [1:0]  io_deio_wb_type,
  input  [2:0]  io_deio_sd_type,
  input  [63:0] io_deio_reg2_rdata,
  input  [2:0]  io_deio_ld_type,
  input  [63:0] io_deio_csr_t,
  input  [11:0] io_deio_csr_waddr,
  input         io_deio_csr_wen,
  input         io_deio_has_inst,
  output [63:0] io_emio_reg_wdata,
  output [4:0]  io_emio_reg_waddr,
  output [1:0]  io_emio_wb_type,
  output [2:0]  io_emio_ld_type,
  output [2:0]  io_emio_ld_addr_lowbit,
  output [63:0] io_emio_csr_wdata,
  output        io_emio_csr_wen,
  output [11:0] io_emio_csr_waddr,
  output        io_emio_has_inst,
  output        io_fcex_jump_flag,
  output [63:0] io_fcex_jump_pc,
  output        io_fcex_mul_div_busy,
  output        io_fcex_mul_div_valid,
  input         io_fcex_stall,
  output [63:0] io_raddr,
  output [63:0] io_waddr,
  output [63:0] io_wdata,
  output [7:0]  io_wmask,
  output [4:0]  io_fwex_reg_waddr,
  output [63:0] io_fwex_reg_wdata,
  output        io_fwex_reg_we,
  output [63:0] io_fwex_csr_wdata,
  output        io_fwex_csr_wen,
  output [11:0] io_fwex_csr_waddr,
  output        io_clex_valid,
  output [2:0]  io_clex_ld_type,
  output [63:0] io_clex_raddr,
  output [2:0]  io_clex_sd_type,
  output [63:0] io_clex_waddr,
  output [7:0]  io_clex_wmask,
  output [63:0] io_clex_wdata,
  output        io_has_inst,
  output [31:0] io_ioformem_addr,
  output [63:0] io_ioformem_data,
  output [7:0]  io_ioformem_mask,
  output [2:0]  io_ioformem_ld_type,
  output [2:0]  io_ioformem_sd_type
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  alu_clock; // @[Excute.scala 45:21]
  wire  alu_reset; // @[Excute.scala 45:21]
  wire [63:0] alu_io_op_a; // @[Excute.scala 45:21]
  wire [63:0] alu_io_op_b; // @[Excute.scala 45:21]
  wire [5:0] alu_io_alu_op; // @[Excute.scala 45:21]
  wire [5:0] alu_io_shamt; // @[Excute.scala 45:21]
  wire [63:0] alu_io_result; // @[Excute.scala 45:21]
  wire  alu_io_mul_div_outvalid; // @[Excute.scala 45:21]
  reg  aluvalid_buffer; // @[Excute.scala 53:34]
  reg [63:0] alu_buffer; // @[Excute.scala 54:29]
  wire  _GEN_0 = ~io_fcex_stall & aluvalid_buffer ? 1'h0 : aluvalid_buffer; // @[Excute.scala 62:50 63:25 53:34]
  wire  _GEN_2 = alu_io_mul_div_outvalid & io_fcex_stall & ~aluvalid_buffer | _GEN_0; // @[Excute.scala 59:71 60:25]
  wire  alu_valid = alu_io_mul_div_outvalid | aluvalid_buffer; // @[Excute.scala 67:42]
  wire [63:0] alu_value = aluvalid_buffer ? alu_buffer : alu_io_result; // @[Excute.scala 68:21]
  wire  _mul_div_type_T_5 = io_deio_alu_op == 6'h15; // @[Excute.scala 71:25]
  wire  _mul_div_type_T_6 = io_deio_alu_op == 6'h12 | io_deio_alu_op == 6'h13 | io_deio_alu_op == 6'h14 |
    _mul_div_type_T_5; // @[Excute.scala 70:129]
  wire  _mul_div_type_T_13 = io_deio_alu_op == 6'h24; // @[Excute.scala 72:25]
  wire  _mul_div_type_T_14 = _mul_div_type_T_6 | io_deio_alu_op == 6'h23 | io_deio_alu_op == 6'h16 | io_deio_alu_op == 6'h17
     | _mul_div_type_T_13; // @[Excute.scala 71:151]
  wire  mul_div_type = _mul_div_type_T_14 | io_deio_alu_op == 6'h25; // @[Excute.scala 72:43]
  wire  _CLINT_type_T = io_deio_ld_type != 3'h0; // @[Excute.scala 78:36]
  wire  _CLINT_type_T_1 = io_deio_sd_type != 3'h0; // @[Excute.scala 78:63]
  wire  _CLINT_type_T_3 = alu_io_result >= 64'h2000000; // @[Excute.scala 79:24]
  wire  _CLINT_type_T_4 = (io_deio_ld_type != 3'h0 | io_deio_sd_type != 3'h0) & _CLINT_type_T_3; // @[Excute.scala 78:72]
  wire  CLINT_type = _CLINT_type_T_4 & alu_io_result <= 64'h200ffff; // @[Excute.scala 79:42]
  wire [63:0] _io_emio_reg_wdata_T = alu_valid ? alu_value : 64'h0; // @[Excute.scala 86:32]
  wire [63:0] _io_emio_reg_wdata_T_1 = mul_div_type ? _io_emio_reg_wdata_T : alu_io_result; // @[Mux.scala 101:16]
  wire  _io_raddr_T_1 = ~CLINT_type; // @[Excute.scala 112:63]
  wire [5:0] woffset = {alu_io_result[2:0],3'h0}; // @[Cat.scala 33:92]
  wire [126:0] _GEN_4 = {{63'd0}, io_deio_reg2_rdata}; // @[Excute.scala 117:36]
  wire [126:0] _io_wdata_T = _GEN_4 << woffset; // @[Excute.scala 117:36]
  wire [7:0] _io_wmask_T_1 = 8'h1 << alu_io_result[2:0]; // @[Excute.scala 120:37]
  wire [8:0] _io_wmask_T_3 = 9'h3 << alu_io_result[2:0]; // @[Excute.scala 121:37]
  wire [10:0] _io_wmask_T_5 = 11'hf << alu_io_result[2:0]; // @[Excute.scala 122:37]
  wire [7:0] _io_wmask_T_7 = 3'h1 == io_deio_sd_type ? _io_wmask_T_1 : 8'h0; // @[Mux.scala 81:58]
  wire [8:0] _io_wmask_T_9 = 3'h2 == io_deio_sd_type ? _io_wmask_T_3 : {{1'd0}, _io_wmask_T_7}; // @[Mux.scala 81:58]
  wire [10:0] _io_wmask_T_11 = 3'h3 == io_deio_sd_type ? _io_wmask_T_5 : {{2'd0}, _io_wmask_T_9}; // @[Mux.scala 81:58]
  wire [10:0] _io_wmask_T_13 = 3'h4 == io_deio_sd_type ? 11'hff : _io_wmask_T_11; // @[Mux.scala 81:58]
  wire [63:0] _io_ioformem_addr_T = io_raddr | io_waddr; // @[Excute.scala 129:34]
  wire [1:0] _io_clex_wmask_T_3 = 3'h2 == io_deio_sd_type ? 2'h3 : {{1'd0}, 3'h1 == io_deio_sd_type}; // @[Mux.scala 81:58]
  wire [3:0] _io_clex_wmask_T_5 = 3'h3 == io_deio_sd_type ? 4'hf : {{2'd0}, _io_clex_wmask_T_3}; // @[Mux.scala 81:58]
  wire  _io_fwex_reg_we_T = io_deio_wb_type == 2'h1; // @[Excute.scala 167:40]
  wire  _io_fwex_reg_we_T_1 = io_deio_wb_type == 2'h3; // @[Excute.scala 167:70]
  wire [63:0] _io_fwex_reg_wdata_T_4 = _io_fwex_reg_we_T_1 ? io_deio_csr_t : 64'h0; // @[Mux.scala 101:16]
  ysyx_22051553_Alu alu ( // @[Excute.scala 45:21]
    .clock(alu_clock),
    .reset(alu_reset),
    .io_op_a(alu_io_op_a),
    .io_op_b(alu_io_op_b),
    .io_alu_op(alu_io_alu_op),
    .io_shamt(alu_io_shamt),
    .io_result(alu_io_result),
    .io_mul_div_outvalid(alu_io_mul_div_outvalid)
  );
  assign io_emio_reg_wdata = io_emio_csr_wen ? io_deio_csr_t : _io_emio_reg_wdata_T_1; // @[Mux.scala 101:16]
  assign io_emio_reg_waddr = io_deio_reg_waddr; // @[Excute.scala 92:23]
  assign io_emio_wb_type = io_deio_wb_type; // @[Excute.scala 91:21]
  assign io_emio_ld_type = io_deio_ld_type; // @[Excute.scala 94:21]
  assign io_emio_ld_addr_lowbit = io_raddr[2:0]; // @[Excute.scala 95:39]
  assign io_emio_csr_wdata = alu_io_result; // @[Excute.scala 97:23]
  assign io_emio_csr_wen = io_deio_csr_wen; // @[Excute.scala 98:21]
  assign io_emio_csr_waddr = io_deio_csr_waddr; // @[Excute.scala 99:23]
  assign io_emio_has_inst = io_deio_has_inst; // @[Excute.scala 101:22]
  assign io_fcex_jump_flag = io_deio_branch_type & |alu_io_result; // @[Excute.scala 105:55]
  assign io_fcex_jump_pc = io_deio_branch_addr; // @[Excute.scala 106:21]
  assign io_fcex_mul_div_busy = _mul_div_type_T_14 | io_deio_alu_op == 6'h25; // @[Excute.scala 72:43]
  assign io_fcex_mul_div_valid = alu_io_mul_div_outvalid; // @[Excute.scala 109:27]
  assign io_raddr = _CLINT_type_T & ~CLINT_type ? alu_io_result : 64'h0; // @[Excute.scala 112:20]
  assign io_waddr = _CLINT_type_T_1 & _io_raddr_T_1 ? alu_io_result : 64'h0; // @[Excute.scala 116:20]
  assign io_wdata = _io_wdata_T[63:0]; // @[Excute.scala 117:14]
  assign io_wmask = _io_wmask_T_13[7:0]; // @[Excute.scala 118:14]
  assign io_fwex_reg_waddr = io_deio_reg_waddr; // @[Excute.scala 166:23]
  assign io_fwex_reg_wdata = _io_fwex_reg_we_T ? _io_emio_reg_wdata_T_1 : _io_fwex_reg_wdata_T_4; // @[Mux.scala 101:16]
  assign io_fwex_reg_we = io_deio_wb_type == 2'h1 | io_deio_wb_type == 2'h3; // @[Excute.scala 167:51]
  assign io_fwex_csr_wdata = alu_io_result; // @[Excute.scala 179:23]
  assign io_fwex_csr_wen = io_emio_csr_wen; // @[Excute.scala 180:21]
  assign io_fwex_csr_waddr = io_emio_csr_waddr; // @[Excute.scala 181:23]
  assign io_clex_valid = _CLINT_type_T_4 & alu_io_result <= 64'h200ffff; // @[Excute.scala 79:42]
  assign io_clex_ld_type = io_deio_ld_type; // @[Excute.scala 150:21]
  assign io_clex_raddr = alu_io_result; // @[Excute.scala 151:19]
  assign io_clex_sd_type = io_deio_sd_type; // @[Excute.scala 153:21]
  assign io_clex_waddr = alu_io_result; // @[Excute.scala 154:19]
  assign io_clex_wmask = 3'h4 == io_deio_sd_type ? 8'hff : {{4'd0}, _io_clex_wmask_T_5}; // @[Mux.scala 81:58]
  assign io_clex_wdata = io_deio_reg2_rdata; // @[Excute.scala 163:19]
  assign io_has_inst = io_deio_has_inst; // @[Excute.scala 42:17]
  assign io_ioformem_addr = _io_ioformem_addr_T[31:0]; // @[Excute.scala 129:22]
  assign io_ioformem_data = _io_wdata_T[63:0]; // @[Excute.scala 130:22]
  assign io_ioformem_mask = _io_wmask_T_13[7:0]; // @[Excute.scala 131:22]
  assign io_ioformem_ld_type = io_deio_ld_type; // @[Excute.scala 139:25]
  assign io_ioformem_sd_type = io_deio_sd_type; // @[Excute.scala 140:25]
  assign alu_clock = clock;
  assign alu_reset = reset;
  assign alu_io_op_a = io_deio_op_a; // @[Excute.scala 184:17]
  assign alu_io_op_b = io_deio_op_b; // @[Excute.scala 185:17]
  assign alu_io_alu_op = io_deio_alu_op; // @[Excute.scala 186:19]
  assign alu_io_shamt = io_deio_shamt; // @[Excute.scala 187:18]
  always @(posedge clock) begin
    if (reset) begin // @[Excute.scala 53:34]
      aluvalid_buffer <= 1'h0; // @[Excute.scala 53:34]
    end else begin
      aluvalid_buffer <= _GEN_2;
    end
    if (reset) begin // @[Excute.scala 54:29]
      alu_buffer <= 64'h0; // @[Excute.scala 54:29]
    end else if (alu_io_mul_div_outvalid & io_fcex_stall & ~aluvalid_buffer) begin // @[Excute.scala 59:71]
      alu_buffer <= alu_io_result; // @[Excute.scala 61:20]
    end else if (~io_fcex_stall & aluvalid_buffer) begin // @[Excute.scala 62:50]
      alu_buffer <= 64'h0; // @[Excute.scala 64:20]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  aluvalid_buffer = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  alu_buffer = _RAND_1[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_22051553_Mem(
  input         clock,
  input         reset,
  input  [63:0] io_emio_reg_wdata,
  input  [4:0]  io_emio_reg_waddr,
  input  [1:0]  io_emio_wb_type,
  input  [2:0]  io_emio_ld_type,
  input  [2:0]  io_emio_ld_addr_lowbit,
  input  [63:0] io_emio_csr_wdata,
  input         io_emio_csr_wen,
  input  [11:0] io_emio_csr_waddr,
  input         io_emio_has_inst,
  output [63:0] io_mwio_reg_wdata,
  output [4:0]  io_mwio_reg_waddr,
  output [1:0]  io_mwio_wb_type,
  output [63:0] io_mwio_csr_wdata,
  output        io_mwio_csr_wen,
  output [11:0] io_mwio_csr_waddr,
  output        io_mwio_has_inst,
  input         io_rdata_valid,
  input  [63:0] io_rdata_bits_data,
  input         io_rdata_io_data_valid,
  input  [63:0] io_rdata_io_data_bits,
  output [4:0]  io_fwmem_reg_waddr,
  output [63:0] io_fwmem_reg_wdata,
  output        io_fwmem_reg_we,
  output [63:0] io_fwmem_csr_wdata,
  output        io_fwmem_csr_wen,
  output [11:0] io_fwmem_csr_waddr,
  input         io_clmem_Clrvalue_valid,
  input  [63:0] io_clmem_Clrvalue_bits,
  input         io_stall,
  output        io_has_inst
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  clmemvalid_buffer; // @[Mem.scala 33:36]
  reg  rdatavalid_buffer; // @[Mem.scala 34:36]
  reg  rdataiovalid_buffer; // @[Mem.scala 35:38]
  reg [63:0] clmem_buffer; // @[Mem.scala 36:31]
  reg [63:0] rdata_buffer; // @[Mem.scala 37:31]
  reg [63:0] rdataio_buffer; // @[Mem.scala 38:33]
  wire  _T_3 = ~io_stall; // @[Mem.scala 43:16]
  wire  _GEN_0 = ~io_stall & clmemvalid_buffer ? 1'h0 : clmemvalid_buffer; // @[Mem.scala 43:47 44:27 33:36]
  wire  _GEN_1 = io_clmem_Clrvalue_valid & io_stall & ~clmemvalid_buffer | _GEN_0; // @[Mem.scala 40:68 41:27]
  wire  _GEN_3 = _T_3 & rdatavalid_buffer ? 1'h0 : rdatavalid_buffer; // @[Mem.scala 50:47 51:27 34:36]
  wire  _GEN_4 = io_rdata_valid & io_stall & ~rdatavalid_buffer | _GEN_3; // @[Mem.scala 47:59 48:27]
  wire  _GEN_6 = _T_3 & rdataiovalid_buffer ? 1'h0 : rdataiovalid_buffer; // @[Mem.scala 57:49 58:29 35:38]
  wire  _GEN_7 = io_rdata_io_data_valid & io_stall & ~rdataiovalid_buffer | _GEN_6; // @[Mem.scala 54:69 55:29]
  wire [63:0] _get_value_T = io_rdata_io_data_valid ? io_rdata_io_data_bits : 64'h0; // @[Mux.scala 101:16]
  wire [63:0] _get_value_T_1 = io_rdata_valid ? io_rdata_bits_data : _get_value_T; // @[Mux.scala 101:16]
  wire [63:0] _get_value_T_2 = io_clmem_Clrvalue_valid ? io_clmem_Clrvalue_bits : _get_value_T_1; // @[Mux.scala 101:16]
  wire [63:0] _get_value_T_3 = rdataiovalid_buffer ? rdataio_buffer : _get_value_T_2; // @[Mux.scala 101:16]
  wire [63:0] _get_value_T_4 = rdatavalid_buffer ? rdata_buffer : _get_value_T_3; // @[Mux.scala 101:16]
  wire [5:0] loffset = {io_emio_ld_addr_lowbit, 3'h0}; // @[Mem.scala 86:43]
  wire [63:0] get_value = clmemvalid_buffer ? clmem_buffer : _get_value_T_4; // @[Mux.scala 101:16]
  wire [63:0] lshift = get_value >> loffset; // @[Mem.scala 87:28]
  wire [7:0] _rvalue_T_1 = lshift[7:0]; // @[Mem.scala 95:35]
  wire [15:0] _rvalue_T_3 = lshift[15:0]; // @[Mem.scala 96:36]
  wire [31:0] _rvalue_T_5 = lshift[31:0]; // @[Mem.scala 97:36]
  wire [63:0] _rvalue_T_6 = get_value >> loffset; // @[Mem.scala 98:29]
  wire [8:0] _rvalue_T_8 = {1'b0,$signed(lshift[7:0])}; // @[Mem.scala 99:35]
  wire [16:0] _rvalue_T_10 = {1'b0,$signed(lshift[15:0])}; // @[Mem.scala 100:36]
  wire [32:0] _rvalue_T_12 = {1'b0,$signed(lshift[31:0])}; // @[Mem.scala 101:36]
  wire [7:0] _rvalue_T_14 = 3'h1 == io_emio_ld_type ? $signed(_rvalue_T_1) : $signed(8'sh0); // @[Mux.scala 81:58]
  wire [15:0] _rvalue_T_16 = 3'h2 == io_emio_ld_type ? $signed(_rvalue_T_3) : $signed({{8{_rvalue_T_14[7]}},_rvalue_T_14
    }); // @[Mux.scala 81:58]
  wire [31:0] _rvalue_T_18 = 3'h3 == io_emio_ld_type ? $signed(_rvalue_T_5) : $signed({{16{_rvalue_T_16[15]}},
    _rvalue_T_16}); // @[Mux.scala 81:58]
  wire [63:0] _rvalue_T_20 = 3'h4 == io_emio_ld_type ? $signed(_rvalue_T_6) : $signed({{32{_rvalue_T_18[31]}},
    _rvalue_T_18}); // @[Mux.scala 81:58]
  wire [63:0] _rvalue_T_22 = 3'h5 == io_emio_ld_type ? $signed({{55{_rvalue_T_8[8]}},_rvalue_T_8}) : $signed(
    _rvalue_T_20); // @[Mux.scala 81:58]
  wire [63:0] _rvalue_T_24 = 3'h6 == io_emio_ld_type ? $signed({{47{_rvalue_T_10[16]}},_rvalue_T_10}) : $signed(
    _rvalue_T_22); // @[Mux.scala 81:58]
  wire  _io_mwio_reg_wdata_T_2 = io_emio_wb_type == 2'h1 | io_emio_wb_type == 2'h3; // @[Mem.scala 112:41]
  wire  _io_mwio_reg_wdata_T_3 = io_emio_wb_type == 2'h2; // @[Mem.scala 113:30]
  wire [63:0] rvalue = 3'h7 == io_emio_ld_type ? $signed({{31{_rvalue_T_12[32]}},_rvalue_T_12}) : $signed(_rvalue_T_24); // @[Mem.scala 103:7]
  wire [63:0] _io_mwio_reg_wdata_T_4 = _io_mwio_reg_wdata_T_3 ? rvalue : 64'h0; // @[Mux.scala 101:16]
  assign io_mwio_reg_wdata = _io_mwio_reg_wdata_T_2 ? io_emio_reg_wdata : _io_mwio_reg_wdata_T_4; // @[Mux.scala 101:16]
  assign io_mwio_reg_waddr = io_emio_reg_waddr; // @[Mem.scala 109:23]
  assign io_mwio_wb_type = io_emio_wb_type; // @[Mem.scala 108:21]
  assign io_mwio_csr_wdata = io_emio_csr_wdata; // @[Mem.scala 117:23]
  assign io_mwio_csr_wen = io_emio_csr_wen; // @[Mem.scala 118:21]
  assign io_mwio_csr_waddr = io_emio_csr_waddr; // @[Mem.scala 119:23]
  assign io_mwio_has_inst = io_emio_has_inst; // @[Mem.scala 121:22]
  assign io_fwmem_reg_waddr = io_emio_reg_waddr; // @[Mem.scala 123:24]
  assign io_fwmem_reg_wdata = _io_mwio_reg_wdata_T_2 ? io_emio_reg_wdata : _io_mwio_reg_wdata_T_4; // @[Mux.scala 101:16]
  assign io_fwmem_reg_we = |io_emio_wb_type; // @[Mem.scala 124:40]
  assign io_fwmem_csr_wdata = io_emio_csr_wdata; // @[Mem.scala 132:24]
  assign io_fwmem_csr_wen = io_emio_csr_wen; // @[Mem.scala 133:22]
  assign io_fwmem_csr_waddr = io_emio_csr_waddr; // @[Mem.scala 134:24]
  assign io_has_inst = io_emio_has_inst; // @[Mem.scala 31:17]
  always @(posedge clock) begin
    if (reset) begin // @[Mem.scala 33:36]
      clmemvalid_buffer <= 1'h0; // @[Mem.scala 33:36]
    end else begin
      clmemvalid_buffer <= _GEN_1;
    end
    if (reset) begin // @[Mem.scala 34:36]
      rdatavalid_buffer <= 1'h0; // @[Mem.scala 34:36]
    end else begin
      rdatavalid_buffer <= _GEN_4;
    end
    if (reset) begin // @[Mem.scala 35:38]
      rdataiovalid_buffer <= 1'h0; // @[Mem.scala 35:38]
    end else begin
      rdataiovalid_buffer <= _GEN_7;
    end
    if (reset) begin // @[Mem.scala 36:31]
      clmem_buffer <= 64'h0; // @[Mem.scala 36:31]
    end else if (io_clmem_Clrvalue_valid & io_stall & ~clmemvalid_buffer) begin // @[Mem.scala 40:68]
      clmem_buffer <= io_clmem_Clrvalue_bits; // @[Mem.scala 42:22]
    end
    if (reset) begin // @[Mem.scala 37:31]
      rdata_buffer <= 64'h0; // @[Mem.scala 37:31]
    end else if (io_rdata_valid & io_stall & ~rdatavalid_buffer) begin // @[Mem.scala 47:59]
      rdata_buffer <= io_rdata_bits_data; // @[Mem.scala 49:22]
    end
    if (reset) begin // @[Mem.scala 38:33]
      rdataio_buffer <= 64'h0; // @[Mem.scala 38:33]
    end else if (io_rdata_io_data_valid & io_stall & ~rdataiovalid_buffer) begin // @[Mem.scala 54:69]
      rdataio_buffer <= io_rdata_io_data_bits; // @[Mem.scala 56:24]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  clmemvalid_buffer = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  rdatavalid_buffer = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  rdataiovalid_buffer = _RAND_2[0:0];
  _RAND_3 = {2{`RANDOM}};
  clmem_buffer = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  rdata_buffer = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  rdataio_buffer = _RAND_5[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_22051553_Wb(
  input  [63:0] io_mwio_reg_wdata,
  input  [4:0]  io_mwio_reg_waddr,
  input  [1:0]  io_mwio_wb_type,
  input  [63:0] io_mwio_csr_wdata,
  input         io_mwio_csr_wen,
  input  [11:0] io_mwio_csr_waddr,
  input         io_mwio_has_inst,
  output [4:0]  io_rfio_rd,
  output        io_rfio_reg_wen,
  output [63:0] io_rfio_reg_wdata,
  output [4:0]  io_fwwb_reg_waddr,
  output [63:0] io_fwwb_reg_wdata,
  output        io_fwwb_reg_we,
  output [63:0] io_fwwb_csr_wdata,
  output        io_fwwb_csr_wen,
  output [11:0] io_fwwb_csr_waddr,
  output [11:0] io_csrs_rd,
  output        io_csrs_csr_wen,
  output [63:0] io_csrs_csr_wdata,
  input         io_stall,
  output        io_has_inst
);
  assign io_rfio_rd = io_mwio_reg_waddr; // @[Wb.scala 32:16]
  assign io_rfio_reg_wen = io_stall ? 1'h0 : |io_mwio_wb_type; // @[Wb.scala 33:27]
  assign io_rfio_reg_wdata = io_mwio_reg_wdata; // @[Wb.scala 34:23]
  assign io_fwwb_reg_waddr = io_mwio_reg_waddr; // @[Wb.scala 38:23]
  assign io_fwwb_reg_wdata = io_mwio_reg_wdata; // @[Wb.scala 40:23]
  assign io_fwwb_reg_we = |io_mwio_wb_type; // @[Wb.scala 39:39]
  assign io_fwwb_csr_wdata = io_mwio_csr_wdata; // @[Wb.scala 42:23]
  assign io_fwwb_csr_wen = io_mwio_csr_wen; // @[Wb.scala 43:21]
  assign io_fwwb_csr_waddr = io_mwio_csr_waddr; // @[Wb.scala 44:23]
  assign io_csrs_rd = io_mwio_csr_waddr; // @[Wb.scala 47:16]
  assign io_csrs_csr_wen = io_stall ? 1'h0 : io_mwio_csr_wen; // @[Wb.scala 48:27]
  assign io_csrs_csr_wdata = io_mwio_csr_wdata; // @[Wb.scala 49:23]
  assign io_has_inst = io_mwio_has_inst; // @[Wb.scala 30:17]
endmodule
module ysyx_22051553_CLINT(
  input         clock,
  input         reset,
  input         io_clex_valid,
  input  [2:0]  io_clex_ld_type,
  input  [63:0] io_clex_raddr,
  input  [2:0]  io_clex_sd_type,
  input  [63:0] io_clex_waddr,
  input  [7:0]  io_clex_wmask,
  input  [63:0] io_clex_wdata,
  output        io_clmem_Clrvalue_valid,
  output [63:0] io_clmem_Clrvalue_bits,
  output        io_timer_int
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] MSIP; // @[CLINT.scala 33:23]
  reg [63:0] MTIMECMP; // @[CLINT.scala 34:27]
  reg [63:0] MTIME; // @[CLINT.scala 35:24]
  reg [63:0] rvalue_buf; // @[CLINT.scala 38:29]
  reg  valid_buf; // @[CLINT.scala 39:28]
  wire [63:0] _MTIME_T_1 = MTIME + 64'h1; // @[CLINT.scala 49:20]
  wire [63:0] _GEN_1 = 64'h200bff8 == io_clex_raddr ? MTIME : 64'h0; // @[CLINT.scala 54:20 58:34 69:32]
  wire  _GEN_2 = 64'h2004000 == io_clex_raddr | 64'h200bff8 == io_clex_raddr; // @[CLINT.scala 58:34 64:31]
  wire [63:0] _GEN_3 = 64'h2004000 == io_clex_raddr ? MTIMECMP : _GEN_1; // @[CLINT.scala 58:34 65:32]
  wire  _GEN_4 = 64'h2000000 == io_clex_raddr | _GEN_2; // @[CLINT.scala 58:34 60:31]
  wire  _T_6 = 8'hff == io_clex_wmask; // @[CLINT.scala 80:42]
  wire  _T_7 = 8'hf == io_clex_wmask; // @[CLINT.scala 80:42]
  wire  _T_8 = 8'h3 == io_clex_wmask; // @[CLINT.scala 80:42]
  wire [31:0] _MSIP_T_4 = {MSIP[31:16],io_clex_wdata[15:0]}; // @[Cat.scala 33:92]
  wire  _T_9 = 8'h1 == io_clex_wmask; // @[CLINT.scala 80:42]
  wire [31:0] _MSIP_T_7 = {MSIP[31:8],io_clex_wdata[7:0]}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_6 = 8'h1 == io_clex_wmask ? _MSIP_T_7 : MSIP; // @[CLINT.scala 79:26 80:42 91:34]
  wire [31:0] _GEN_7 = 8'h3 == io_clex_wmask ? _MSIP_T_4 : _GEN_6; // @[CLINT.scala 80:42 88:34]
  wire [31:0] _GEN_8 = 8'hf == io_clex_wmask ? io_clex_wdata[31:0] : _GEN_7; // @[CLINT.scala 80:42 85:34]
  wire [31:0] _GEN_9 = 8'hff == io_clex_wmask ? io_clex_wdata[31:0] : _GEN_8; // @[CLINT.scala 80:42 82:34]
  wire [63:0] _MTIMECMP_T_2 = {MTIMECMP[63:32],io_clex_wdata[31:0]}; // @[Cat.scala 33:92]
  wire [63:0] _MTIMECMP_T_5 = {MTIMECMP[63:16],io_clex_wdata[15:0]}; // @[Cat.scala 33:92]
  wire [63:0] _MTIMECMP_T_8 = {MTIMECMP[63:8],io_clex_wdata[7:0]}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_10 = _T_9 ? _MTIMECMP_T_8 : MTIMECMP; // @[CLINT.scala 109:38 97:30 98:42]
  wire [63:0] _GEN_11 = _T_8 ? _MTIMECMP_T_5 : _GEN_10; // @[CLINT.scala 106:38 98:42]
  wire [63:0] _GEN_12 = _T_7 ? _MTIMECMP_T_2 : _GEN_11; // @[CLINT.scala 103:38 98:42]
  wire [63:0] _GEN_13 = _T_6 ? io_clex_wdata : _GEN_12; // @[CLINT.scala 100:38 98:42]
  wire [63:0] _MTIME_T_4 = {MTIME[63:32],io_clex_wdata[31:0]}; // @[Cat.scala 33:92]
  wire [63:0] _MTIME_T_7 = {MTIME[63:16],io_clex_wdata[15:0]}; // @[Cat.scala 33:92]
  wire [63:0] _MTIME_T_10 = {MTIME[63:8],io_clex_wdata[7:0]}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_14 = _T_9 ? _MTIME_T_10 : MTIME; // @[CLINT.scala 115:27 116:42 127:35]
  wire [63:0] _GEN_15 = _T_8 ? _MTIME_T_7 : _GEN_14; // @[CLINT.scala 116:42 124:35]
  wire [63:0] _GEN_16 = _T_7 ? _MTIME_T_4 : _GEN_15; // @[CLINT.scala 116:42 121:35]
  wire [63:0] _GEN_17 = _T_6 ? io_clex_wdata : _GEN_16; // @[CLINT.scala 116:42 118:35]
  wire [63:0] _GEN_18 = 64'h200bff8 == io_clex_waddr ? _GEN_17 : _MTIME_T_1; // @[CLINT.scala 49:11 76:34]
  wire [63:0] _GEN_19 = 64'h2004000 == io_clex_waddr ? _GEN_13 : MTIMECMP; // @[CLINT.scala 48:14 76:34]
  wire [63:0] _GEN_20 = 64'h2004000 == io_clex_waddr ? _MTIME_T_1 : _GEN_18; // @[CLINT.scala 49:11 76:34]
  wire [31:0] _GEN_21 = 64'h2000000 == io_clex_waddr ? _GEN_9 : MSIP; // @[CLINT.scala 47:10 76:34]
  wire [63:0] _GEN_22 = 64'h2000000 == io_clex_waddr ? MTIMECMP : _GEN_19; // @[CLINT.scala 48:14 76:34]
  wire [63:0] _GEN_23 = 64'h2000000 == io_clex_waddr ? _MTIME_T_1 : _GEN_20; // @[CLINT.scala 49:11 76:34]
  wire  _GEN_27 = |io_clex_ld_type & _GEN_4; // @[CLINT.scala 53:19 56:34]
  wire  _GEN_32 = io_clex_valid & _GEN_27; // @[CLINT.scala 44:15 51:24]
  assign io_clmem_Clrvalue_valid = valid_buf; // @[CLINT.scala 138:29]
  assign io_clmem_Clrvalue_bits = rvalue_buf; // @[CLINT.scala 137:28]
  assign io_timer_int = MTIME >= MTIMECMP; // @[CLINT.scala 140:28]
  always @(posedge clock) begin
    if (reset) begin // @[CLINT.scala 33:23]
      MSIP <= 32'h0; // @[CLINT.scala 33:23]
    end else if (io_clex_valid) begin // @[CLINT.scala 51:24]
      if (!(|io_clex_ld_type)) begin // @[CLINT.scala 56:34]
        if (|io_clex_sd_type) begin // @[CLINT.scala 72:40]
          MSIP <= _GEN_21;
        end
      end
    end
    if (reset) begin // @[CLINT.scala 34:27]
      MTIMECMP <= 64'h0; // @[CLINT.scala 34:27]
    end else if (io_clex_valid) begin // @[CLINT.scala 51:24]
      if (!(|io_clex_ld_type)) begin // @[CLINT.scala 56:34]
        if (|io_clex_sd_type) begin // @[CLINT.scala 72:40]
          MTIMECMP <= _GEN_22;
        end
      end
    end
    if (reset) begin // @[CLINT.scala 35:24]
      MTIME <= 64'h0; // @[CLINT.scala 35:24]
    end else if (io_clex_valid) begin // @[CLINT.scala 51:24]
      if (|io_clex_ld_type) begin // @[CLINT.scala 56:34]
        MTIME <= _MTIME_T_1; // @[CLINT.scala 49:11]
      end else if (|io_clex_sd_type) begin // @[CLINT.scala 72:40]
        MTIME <= _GEN_23;
      end else begin
        MTIME <= _MTIME_T_1; // @[CLINT.scala 49:11]
      end
    end else begin
      MTIME <= _MTIME_T_1; // @[CLINT.scala 49:11]
    end
    if (reset) begin // @[CLINT.scala 38:29]
      rvalue_buf <= 64'h0; // @[CLINT.scala 38:29]
    end else if (io_clex_valid) begin // @[CLINT.scala 51:24]
      if (|io_clex_ld_type) begin // @[CLINT.scala 56:34]
        if (64'h2000000 == io_clex_raddr) begin // @[CLINT.scala 58:34]
          rvalue_buf <= {{32'd0}, MSIP}; // @[CLINT.scala 61:32]
        end else begin
          rvalue_buf <= _GEN_3;
        end
      end else begin
        rvalue_buf <= 64'h0; // @[CLINT.scala 54:20]
      end
    end else begin
      rvalue_buf <= 64'h0; // @[CLINT.scala 45:16]
    end
    if (reset) begin // @[CLINT.scala 39:28]
      valid_buf <= 1'h0; // @[CLINT.scala 39:28]
    end else begin
      valid_buf <= _GEN_32;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  MSIP = _RAND_0[31:0];
  _RAND_1 = {2{`RANDOM}};
  MTIMECMP = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  MTIME = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  rvalue_buf = _RAND_3[63:0];
  _RAND_4 = {1{`RANDOM}};
  valid_buf = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_22051553_Forward(
  input  [4:0]  io_fwde_reg1_raddr,
  input  [4:0]  io_fwde_reg2_raddr,
  output        io_fwde_fw_sel1,
  output        io_fwde_fw_sel2,
  output [63:0] io_fwde_fw_data1,
  output [63:0] io_fwde_fw_data2,
  input  [11:0] io_fwde_csr_raddr,
  output        io_fwde_csr_fw_sel,
  output [63:0] io_fwde_csr_fw_data,
  input  [4:0]  io_fwex_reg_waddr,
  input  [63:0] io_fwex_reg_wdata,
  input         io_fwex_reg_we,
  input  [63:0] io_fwex_csr_wdata,
  input         io_fwex_csr_wen,
  input  [11:0] io_fwex_csr_waddr,
  input  [4:0]  io_fwmem_reg_waddr,
  input  [63:0] io_fwmem_reg_wdata,
  input         io_fwmem_reg_we,
  input  [63:0] io_fwmem_csr_wdata,
  input         io_fwmem_csr_wen,
  input  [11:0] io_fwmem_csr_waddr,
  input  [4:0]  io_fwwb_reg_waddr,
  input  [63:0] io_fwwb_reg_wdata,
  input         io_fwwb_reg_we,
  input  [63:0] io_fwwb_csr_wdata,
  input         io_fwwb_csr_wen,
  input  [11:0] io_fwwb_csr_waddr
);
  wire  _reg1_ex_hazard_T = io_fwde_reg1_raddr != 5'h0; // @[Forward.scala 46:46]
  wire  reg1_ex_hazard = io_fwde_reg1_raddr != 5'h0 & io_fwex_reg_we & io_fwex_reg_waddr == io_fwde_reg1_raddr; // @[Forward.scala 46:73]
  wire  _reg2_ex_hazard_T = io_fwde_reg2_raddr != 5'h0; // @[Forward.scala 47:46]
  wire  reg2_ex_hazard = io_fwde_reg2_raddr != 5'h0 & io_fwex_reg_we & io_fwex_reg_waddr == io_fwde_reg2_raddr; // @[Forward.scala 47:73]
  wire  reg1_mem_hazard = _reg1_ex_hazard_T & io_fwmem_reg_we & io_fwmem_reg_waddr == io_fwde_reg1_raddr; // @[Forward.scala 49:75]
  wire  reg2_mem_hazard = _reg2_ex_hazard_T & io_fwmem_reg_we & io_fwmem_reg_waddr == io_fwde_reg2_raddr; // @[Forward.scala 50:75]
  wire  reg1_wb_hazard = _reg1_ex_hazard_T & io_fwwb_reg_we & io_fwwb_reg_waddr == io_fwde_reg1_raddr; // @[Forward.scala 52:73]
  wire  reg2_wb_hazard = _reg2_ex_hazard_T & io_fwwb_reg_we & io_fwwb_reg_waddr == io_fwde_reg2_raddr; // @[Forward.scala 53:73]
  wire [63:0] _io_fwde_fw_data1_T = reg1_wb_hazard ? io_fwwb_reg_wdata : 64'h0; // @[Mux.scala 101:16]
  wire [63:0] _io_fwde_fw_data1_T_1 = reg1_mem_hazard ? io_fwmem_reg_wdata : _io_fwde_fw_data1_T; // @[Mux.scala 101:16]
  wire [63:0] _io_fwde_fw_data2_T = reg2_wb_hazard ? io_fwwb_reg_wdata : 64'h0; // @[Mux.scala 101:16]
  wire [63:0] _io_fwde_fw_data2_T_1 = reg2_mem_hazard ? io_fwmem_reg_wdata : _io_fwde_fw_data2_T; // @[Mux.scala 101:16]
  wire  csr_ex_harzard = io_fwex_csr_wen & io_fwex_csr_waddr == io_fwde_csr_raddr; // @[Forward.scala 74:42]
  wire  csr_mem_harzard = io_fwmem_csr_wen & io_fwmem_csr_waddr == io_fwde_csr_raddr; // @[Forward.scala 75:44]
  wire  csr_wb_harzard = io_fwwb_csr_wen & io_fwwb_csr_waddr == io_fwde_csr_raddr; // @[Forward.scala 76:42]
  wire [63:0] _io_fwde_csr_fw_data_T = csr_wb_harzard ? io_fwwb_csr_wdata : 64'h0; // @[Mux.scala 101:16]
  wire [63:0] _io_fwde_csr_fw_data_T_1 = csr_mem_harzard ? io_fwmem_csr_wdata : _io_fwde_csr_fw_data_T; // @[Mux.scala 101:16]
  assign io_fwde_fw_sel1 = reg1_ex_hazard | reg1_mem_hazard | reg1_wb_hazard; // @[Forward.scala 55:57]
  assign io_fwde_fw_sel2 = reg2_ex_hazard | reg2_mem_hazard | reg2_wb_hazard; // @[Forward.scala 56:57]
  assign io_fwde_fw_data1 = reg1_ex_hazard ? io_fwex_reg_wdata : _io_fwde_fw_data1_T_1; // @[Mux.scala 101:16]
  assign io_fwde_fw_data2 = reg2_ex_hazard ? io_fwex_reg_wdata : _io_fwde_fw_data2_T_1; // @[Mux.scala 101:16]
  assign io_fwde_csr_fw_sel = csr_ex_harzard | csr_mem_harzard | csr_wb_harzard; // @[Forward.scala 78:60]
  assign io_fwde_csr_fw_data = csr_ex_harzard ? io_fwex_csr_wdata : _io_fwde_csr_fw_data_T_1; // @[Mux.scala 101:16]
endmodule
module ysyx_22051553_Regfile(
  input         clock,
  input         reset,
  input  [4:0]  io_RfDe_reg1_raddr,
  input  [4:0]  io_RfDe_reg2_raddr,
  output [63:0] io_RfDe_reg1_rdata,
  output [63:0] io_RfDe_reg2_rdata,
  input  [4:0]  io_RfWb_rd,
  input         io_RfWb_reg_wen,
  input  [63:0] io_RfWb_reg_wdata
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [63:0] _RAND_12;
  reg [63:0] _RAND_13;
  reg [63:0] _RAND_14;
  reg [63:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [63:0] _RAND_17;
  reg [63:0] _RAND_18;
  reg [63:0] _RAND_19;
  reg [63:0] _RAND_20;
  reg [63:0] _RAND_21;
  reg [63:0] _RAND_22;
  reg [63:0] _RAND_23;
  reg [63:0] _RAND_24;
  reg [63:0] _RAND_25;
  reg [63:0] _RAND_26;
  reg [63:0] _RAND_27;
  reg [63:0] _RAND_28;
  reg [63:0] _RAND_29;
  reg [63:0] _RAND_30;
  reg [63:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] regs_0; // @[Regfile.scala 32:23]
  reg [63:0] regs_1; // @[Regfile.scala 32:23]
  reg [63:0] regs_2; // @[Regfile.scala 32:23]
  reg [63:0] regs_3; // @[Regfile.scala 32:23]
  reg [63:0] regs_4; // @[Regfile.scala 32:23]
  reg [63:0] regs_5; // @[Regfile.scala 32:23]
  reg [63:0] regs_6; // @[Regfile.scala 32:23]
  reg [63:0] regs_7; // @[Regfile.scala 32:23]
  reg [63:0] regs_8; // @[Regfile.scala 32:23]
  reg [63:0] regs_9; // @[Regfile.scala 32:23]
  reg [63:0] regs_10; // @[Regfile.scala 32:23]
  reg [63:0] regs_11; // @[Regfile.scala 32:23]
  reg [63:0] regs_12; // @[Regfile.scala 32:23]
  reg [63:0] regs_13; // @[Regfile.scala 32:23]
  reg [63:0] regs_14; // @[Regfile.scala 32:23]
  reg [63:0] regs_15; // @[Regfile.scala 32:23]
  reg [63:0] regs_16; // @[Regfile.scala 32:23]
  reg [63:0] regs_17; // @[Regfile.scala 32:23]
  reg [63:0] regs_18; // @[Regfile.scala 32:23]
  reg [63:0] regs_19; // @[Regfile.scala 32:23]
  reg [63:0] regs_20; // @[Regfile.scala 32:23]
  reg [63:0] regs_21; // @[Regfile.scala 32:23]
  reg [63:0] regs_22; // @[Regfile.scala 32:23]
  reg [63:0] regs_23; // @[Regfile.scala 32:23]
  reg [63:0] regs_24; // @[Regfile.scala 32:23]
  reg [63:0] regs_25; // @[Regfile.scala 32:23]
  reg [63:0] regs_26; // @[Regfile.scala 32:23]
  reg [63:0] regs_27; // @[Regfile.scala 32:23]
  reg [63:0] regs_28; // @[Regfile.scala 32:23]
  reg [63:0] regs_29; // @[Regfile.scala 32:23]
  reg [63:0] regs_30; // @[Regfile.scala 32:23]
  reg [63:0] regs_31; // @[Regfile.scala 32:23]
  wire [63:0] _GEN_1 = 5'h1 == io_RfWb_rd ? regs_1 : regs_0; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_2 = 5'h2 == io_RfWb_rd ? regs_2 : _GEN_1; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_3 = 5'h3 == io_RfWb_rd ? regs_3 : _GEN_2; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_4 = 5'h4 == io_RfWb_rd ? regs_4 : _GEN_3; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_5 = 5'h5 == io_RfWb_rd ? regs_5 : _GEN_4; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_6 = 5'h6 == io_RfWb_rd ? regs_6 : _GEN_5; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_7 = 5'h7 == io_RfWb_rd ? regs_7 : _GEN_6; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_8 = 5'h8 == io_RfWb_rd ? regs_8 : _GEN_7; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_9 = 5'h9 == io_RfWb_rd ? regs_9 : _GEN_8; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_10 = 5'ha == io_RfWb_rd ? regs_10 : _GEN_9; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_11 = 5'hb == io_RfWb_rd ? regs_11 : _GEN_10; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_12 = 5'hc == io_RfWb_rd ? regs_12 : _GEN_11; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_13 = 5'hd == io_RfWb_rd ? regs_13 : _GEN_12; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_14 = 5'he == io_RfWb_rd ? regs_14 : _GEN_13; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_15 = 5'hf == io_RfWb_rd ? regs_15 : _GEN_14; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_16 = 5'h10 == io_RfWb_rd ? regs_16 : _GEN_15; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_17 = 5'h11 == io_RfWb_rd ? regs_17 : _GEN_16; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_18 = 5'h12 == io_RfWb_rd ? regs_18 : _GEN_17; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_19 = 5'h13 == io_RfWb_rd ? regs_19 : _GEN_18; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_20 = 5'h14 == io_RfWb_rd ? regs_20 : _GEN_19; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_21 = 5'h15 == io_RfWb_rd ? regs_21 : _GEN_20; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_22 = 5'h16 == io_RfWb_rd ? regs_22 : _GEN_21; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_23 = 5'h17 == io_RfWb_rd ? regs_23 : _GEN_22; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_24 = 5'h18 == io_RfWb_rd ? regs_24 : _GEN_23; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_25 = 5'h19 == io_RfWb_rd ? regs_25 : _GEN_24; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_26 = 5'h1a == io_RfWb_rd ? regs_26 : _GEN_25; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_27 = 5'h1b == io_RfWb_rd ? regs_27 : _GEN_26; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_28 = 5'h1c == io_RfWb_rd ? regs_28 : _GEN_27; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_29 = 5'h1d == io_RfWb_rd ? regs_29 : _GEN_28; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_30 = 5'h1e == io_RfWb_rd ? regs_30 : _GEN_29; // @[Regfile.scala 39:{28,28}]
  wire [63:0] _GEN_65 = 5'h1 == io_RfDe_reg1_raddr ? regs_1 : regs_0; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_66 = 5'h2 == io_RfDe_reg1_raddr ? regs_2 : _GEN_65; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_67 = 5'h3 == io_RfDe_reg1_raddr ? regs_3 : _GEN_66; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_68 = 5'h4 == io_RfDe_reg1_raddr ? regs_4 : _GEN_67; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_69 = 5'h5 == io_RfDe_reg1_raddr ? regs_5 : _GEN_68; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_70 = 5'h6 == io_RfDe_reg1_raddr ? regs_6 : _GEN_69; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_71 = 5'h7 == io_RfDe_reg1_raddr ? regs_7 : _GEN_70; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_72 = 5'h8 == io_RfDe_reg1_raddr ? regs_8 : _GEN_71; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_73 = 5'h9 == io_RfDe_reg1_raddr ? regs_9 : _GEN_72; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_74 = 5'ha == io_RfDe_reg1_raddr ? regs_10 : _GEN_73; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_75 = 5'hb == io_RfDe_reg1_raddr ? regs_11 : _GEN_74; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_76 = 5'hc == io_RfDe_reg1_raddr ? regs_12 : _GEN_75; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_77 = 5'hd == io_RfDe_reg1_raddr ? regs_13 : _GEN_76; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_78 = 5'he == io_RfDe_reg1_raddr ? regs_14 : _GEN_77; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_79 = 5'hf == io_RfDe_reg1_raddr ? regs_15 : _GEN_78; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_80 = 5'h10 == io_RfDe_reg1_raddr ? regs_16 : _GEN_79; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_81 = 5'h11 == io_RfDe_reg1_raddr ? regs_17 : _GEN_80; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_82 = 5'h12 == io_RfDe_reg1_raddr ? regs_18 : _GEN_81; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_83 = 5'h13 == io_RfDe_reg1_raddr ? regs_19 : _GEN_82; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_84 = 5'h14 == io_RfDe_reg1_raddr ? regs_20 : _GEN_83; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_85 = 5'h15 == io_RfDe_reg1_raddr ? regs_21 : _GEN_84; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_86 = 5'h16 == io_RfDe_reg1_raddr ? regs_22 : _GEN_85; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_87 = 5'h17 == io_RfDe_reg1_raddr ? regs_23 : _GEN_86; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_88 = 5'h18 == io_RfDe_reg1_raddr ? regs_24 : _GEN_87; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_89 = 5'h19 == io_RfDe_reg1_raddr ? regs_25 : _GEN_88; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_90 = 5'h1a == io_RfDe_reg1_raddr ? regs_26 : _GEN_89; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_91 = 5'h1b == io_RfDe_reg1_raddr ? regs_27 : _GEN_90; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_92 = 5'h1c == io_RfDe_reg1_raddr ? regs_28 : _GEN_91; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_93 = 5'h1d == io_RfDe_reg1_raddr ? regs_29 : _GEN_92; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_94 = 5'h1e == io_RfDe_reg1_raddr ? regs_30 : _GEN_93; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_95 = 5'h1f == io_RfDe_reg1_raddr ? regs_31 : _GEN_94; // @[Regfile.scala 48:{30,30}]
  wire [63:0] _GEN_97 = 5'h1 == io_RfDe_reg2_raddr ? regs_1 : regs_0; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_98 = 5'h2 == io_RfDe_reg2_raddr ? regs_2 : _GEN_97; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_99 = 5'h3 == io_RfDe_reg2_raddr ? regs_3 : _GEN_98; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_100 = 5'h4 == io_RfDe_reg2_raddr ? regs_4 : _GEN_99; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_101 = 5'h5 == io_RfDe_reg2_raddr ? regs_5 : _GEN_100; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_102 = 5'h6 == io_RfDe_reg2_raddr ? regs_6 : _GEN_101; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_103 = 5'h7 == io_RfDe_reg2_raddr ? regs_7 : _GEN_102; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_104 = 5'h8 == io_RfDe_reg2_raddr ? regs_8 : _GEN_103; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_105 = 5'h9 == io_RfDe_reg2_raddr ? regs_9 : _GEN_104; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_106 = 5'ha == io_RfDe_reg2_raddr ? regs_10 : _GEN_105; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_107 = 5'hb == io_RfDe_reg2_raddr ? regs_11 : _GEN_106; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_108 = 5'hc == io_RfDe_reg2_raddr ? regs_12 : _GEN_107; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_109 = 5'hd == io_RfDe_reg2_raddr ? regs_13 : _GEN_108; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_110 = 5'he == io_RfDe_reg2_raddr ? regs_14 : _GEN_109; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_111 = 5'hf == io_RfDe_reg2_raddr ? regs_15 : _GEN_110; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_112 = 5'h10 == io_RfDe_reg2_raddr ? regs_16 : _GEN_111; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_113 = 5'h11 == io_RfDe_reg2_raddr ? regs_17 : _GEN_112; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_114 = 5'h12 == io_RfDe_reg2_raddr ? regs_18 : _GEN_113; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_115 = 5'h13 == io_RfDe_reg2_raddr ? regs_19 : _GEN_114; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_116 = 5'h14 == io_RfDe_reg2_raddr ? regs_20 : _GEN_115; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_117 = 5'h15 == io_RfDe_reg2_raddr ? regs_21 : _GEN_116; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_118 = 5'h16 == io_RfDe_reg2_raddr ? regs_22 : _GEN_117; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_119 = 5'h17 == io_RfDe_reg2_raddr ? regs_23 : _GEN_118; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_120 = 5'h18 == io_RfDe_reg2_raddr ? regs_24 : _GEN_119; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_121 = 5'h19 == io_RfDe_reg2_raddr ? regs_25 : _GEN_120; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_122 = 5'h1a == io_RfDe_reg2_raddr ? regs_26 : _GEN_121; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_123 = 5'h1b == io_RfDe_reg2_raddr ? regs_27 : _GEN_122; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_124 = 5'h1c == io_RfDe_reg2_raddr ? regs_28 : _GEN_123; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_125 = 5'h1d == io_RfDe_reg2_raddr ? regs_29 : _GEN_124; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_126 = 5'h1e == io_RfDe_reg2_raddr ? regs_30 : _GEN_125; // @[Regfile.scala 49:{30,30}]
  wire [63:0] _GEN_127 = 5'h1f == io_RfDe_reg2_raddr ? regs_31 : _GEN_126; // @[Regfile.scala 49:{30,30}]
  assign io_RfDe_reg1_rdata = |io_RfDe_reg1_raddr ? _GEN_95 : 64'h0; // @[Regfile.scala 48:30]
  assign io_RfDe_reg2_rdata = |io_RfDe_reg2_raddr ? _GEN_127 : 64'h0; // @[Regfile.scala 49:30]
  always @(posedge clock) begin
    if (reset) begin // @[Regfile.scala 32:23]
      regs_0 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h0 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_0 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_0 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_0 <= _GEN_30;
      end
    end else begin
      regs_0 <= 64'h0; // @[Regfile.scala 37:13]
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_1 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h1 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_1 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_1 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_1 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_2 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h2 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_2 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_2 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_2 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_3 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h3 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_3 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_3 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_3 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_4 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h4 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_4 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_4 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_4 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_5 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h5 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_5 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_5 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_5 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_6 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h6 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_6 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_6 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_6 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_7 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h7 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_7 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_7 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_7 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_8 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h8 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_8 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_8 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_8 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_9 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h9 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_9 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_9 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_9 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_10 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'ha == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_10 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_10 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_10 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_11 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'hb == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_11 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_11 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_11 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_12 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'hc == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_12 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_12 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_12 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_13 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'hd == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_13 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_13 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_13 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_14 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'he == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_14 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_14 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_14 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_15 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'hf == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_15 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_15 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_15 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_16 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h10 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_16 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_16 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_16 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_17 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h11 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_17 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_17 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_17 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_18 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h12 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_18 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_18 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_18 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_19 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h13 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_19 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_19 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_19 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_20 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h14 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_20 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_20 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_20 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_21 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h15 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_21 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_21 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_21 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_22 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h16 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_22 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_22 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_22 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_23 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h17 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_23 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_23 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_23 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_24 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h18 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_24 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_24 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_24 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_25 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h19 == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_25 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_25 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_25 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_26 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h1a == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_26 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_26 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_26 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_27 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h1b == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_27 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_27 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_27 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_28 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h1c == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_28 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_28 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_28 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_29 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h1d == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_29 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_29 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_29 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_30 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h1e == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_30 <= io_RfWb_reg_wdata;
      end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:28]
        regs_30 <= regs_31; // @[Regfile.scala 39:28]
      end else begin
        regs_30 <= _GEN_30;
      end
    end
    if (reset) begin // @[Regfile.scala 32:23]
      regs_31 <= 64'h0; // @[Regfile.scala 32:23]
    end else if (5'h1f == io_RfWb_rd) begin // @[Regfile.scala 39:22]
      if (io_RfWb_reg_wen & io_RfWb_rd != 5'h0) begin // @[Regfile.scala 39:28]
        regs_31 <= io_RfWb_reg_wdata;
      end else if (!(5'h1f == io_RfWb_rd)) begin // @[Regfile.scala 39:28]
        regs_31 <= _GEN_30;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  regs_0 = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  regs_1 = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  regs_2 = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  regs_3 = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  regs_4 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  regs_5 = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  regs_6 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  regs_7 = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  regs_8 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  regs_9 = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  regs_10 = _RAND_10[63:0];
  _RAND_11 = {2{`RANDOM}};
  regs_11 = _RAND_11[63:0];
  _RAND_12 = {2{`RANDOM}};
  regs_12 = _RAND_12[63:0];
  _RAND_13 = {2{`RANDOM}};
  regs_13 = _RAND_13[63:0];
  _RAND_14 = {2{`RANDOM}};
  regs_14 = _RAND_14[63:0];
  _RAND_15 = {2{`RANDOM}};
  regs_15 = _RAND_15[63:0];
  _RAND_16 = {2{`RANDOM}};
  regs_16 = _RAND_16[63:0];
  _RAND_17 = {2{`RANDOM}};
  regs_17 = _RAND_17[63:0];
  _RAND_18 = {2{`RANDOM}};
  regs_18 = _RAND_18[63:0];
  _RAND_19 = {2{`RANDOM}};
  regs_19 = _RAND_19[63:0];
  _RAND_20 = {2{`RANDOM}};
  regs_20 = _RAND_20[63:0];
  _RAND_21 = {2{`RANDOM}};
  regs_21 = _RAND_21[63:0];
  _RAND_22 = {2{`RANDOM}};
  regs_22 = _RAND_22[63:0];
  _RAND_23 = {2{`RANDOM}};
  regs_23 = _RAND_23[63:0];
  _RAND_24 = {2{`RANDOM}};
  regs_24 = _RAND_24[63:0];
  _RAND_25 = {2{`RANDOM}};
  regs_25 = _RAND_25[63:0];
  _RAND_26 = {2{`RANDOM}};
  regs_26 = _RAND_26[63:0];
  _RAND_27 = {2{`RANDOM}};
  regs_27 = _RAND_27[63:0];
  _RAND_28 = {2{`RANDOM}};
  regs_28 = _RAND_28[63:0];
  _RAND_29 = {2{`RANDOM}};
  regs_29 = _RAND_29[63:0];
  _RAND_30 = {2{`RANDOM}};
  regs_30 = _RAND_30[63:0];
  _RAND_31 = {2{`RANDOM}};
  regs_31 = _RAND_31[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_22051553_FlowControl(
  output        io_fcfe_jump_flag,
  output [63:0] io_fcfe_jump_pc,
  output        io_fcfe_flush,
  output        io_fcfe_stall,
  input         io_fcde_jump_flag,
  input  [63:0] io_fcde_jump_pc,
  input         io_fcde_load_use,
  output        io_fcde_flush,
  output        io_fcde_stall,
  input         io_fcex_jump_flag,
  input  [63:0] io_fcex_jump_pc,
  input         io_fcex_mul_div_busy,
  input         io_fcex_mul_div_valid,
  output        io_fcex_stall,
  output        io_fcmem_stall,
  output        io_fcwb_stall,
  input         io_fctr_pop_NOP,
  input  [2:0]  io_fctr_trap_state,
  input         io_fctr_jump_flag,
  input  [63:0] io_fctr_jump_pc,
  input  [2:0]  io_fcIcache_state,
  input  [2:0]  io_fcDcache_state,
  output        io_fcio_stall,
  input  [1:0]  io_fcio_state
);
  wire  _GEN_0 = io_fcio_state == 2'h1 | io_fcio_state == 2'h2; // @[FlowControl.scala 178:50]
  wire  _SFBundle_T = io_fcIcache_state != 3'h0; // @[FlowControl.scala 198:32]
  wire  _SFBundle_T_1 = io_fcDcache_state != 3'h0; // @[FlowControl.scala 199:32]
  wire  _SFBundle_T_5 = io_fctr_trap_state == 3'h4 | io_fctr_trap_state == 3'h7; // @[FlowControl.scala 201:47]
  wire  _SFBundle_T_10 = io_fctr_pop_NOP | io_fctr_trap_state == 3'h1 | io_fctr_trap_state == 3'h2; // @[FlowControl.scala 202:71]
  wire  _SFBundle_T_16 = _SFBundle_T_10 | io_fctr_trap_state == 3'h3 | io_fctr_trap_state == 3'h5 | io_fctr_trap_state
     == 3'h6; // @[FlowControl.scala 203:87]
  wire  _SFBundle_T_22_6 = io_fctr_jump_flag ? 1'h0 : io_fcex_jump_flag; // @[Mux.scala 101:16]
  wire  _SFBundle_T_23_5 = _SFBundle_T_16 ? 1'h0 : io_fctr_jump_flag | (io_fcex_jump_flag | io_fcde_jump_flag); // @[Mux.scala 101:16]
  wire  _SFBundle_T_24_0 = _SFBundle_T_5 ? 1'h0 : _SFBundle_T_16; // @[Mux.scala 101:16]
  wire  _SFBundle_T_25_5 = io_fcde_load_use ? 1'h0 : _SFBundle_T_5 | _SFBundle_T_23_5; // @[Mux.scala 101:16]
  wire  _SFBundle_T_26_5 = _SFBundle_T_1 ? 1'h0 : _SFBundle_T_25_5; // @[Mux.scala 101:16]
  wire  _SFBundle_T_26_6 = _SFBundle_T_1 ? 1'h0 : io_fcde_load_use | (_SFBundle_T_5 | (_SFBundle_T_16 | _SFBundle_T_22_6
    )); // @[Mux.scala 101:16]
  wire  _SFBundle_T_27_5 = _SFBundle_T ? 1'h0 : _SFBundle_T_26_5; // @[Mux.scala 101:16]
  wire  _SFBundle_T_27_6 = _SFBundle_T ? 1'h0 : _SFBundle_T_26_6; // @[Mux.scala 101:16]
  wire  MULDIV_stall = io_fcex_mul_div_valid ? 1'h0 : io_fcex_mul_div_busy; // @[FlowControl.scala 185:32 186:22]
  wire  _SFBundle_T_28_5 = MULDIV_stall ? 1'h0 : _SFBundle_T_27_5; // @[Mux.scala 101:16]
  wire  _SFBundle_T_28_6 = MULDIV_stall ? 1'h0 : _SFBundle_T_27_6; // @[Mux.scala 101:16]
  wire  IO_stall = io_fcio_state == 2'h1 | io_fcio_state == 2'h2; // @[FlowControl.scala 178:50]
  wire [63:0] _io_fcfe_jump_pc_T = io_fcde_jump_flag ? io_fcde_jump_pc : 64'h80000000; // @[Mux.scala 101:16]
  wire [63:0] _io_fcfe_jump_pc_T_1 = io_fcex_jump_flag ? io_fcex_jump_pc : _io_fcfe_jump_pc_T; // @[Mux.scala 101:16]
  assign io_fcfe_jump_flag = io_fcde_jump_flag | io_fcex_jump_flag | io_fctr_jump_flag; // @[FlowControl.scala 224:65]
  assign io_fcfe_jump_pc = io_fctr_jump_flag ? io_fctr_jump_pc : _io_fcfe_jump_pc_T_1; // @[Mux.scala 101:16]
  assign io_fcfe_flush = _GEN_0 ? 1'h0 : _SFBundle_T_28_5; // @[Mux.scala 101:16]
  assign io_fcfe_stall = _GEN_0 | (MULDIV_stall | (_SFBundle_T | (_SFBundle_T_1 | (io_fcde_load_use | _SFBundle_T_24_0))
    )); // @[Mux.scala 101:16]
  assign io_fcde_flush = _GEN_0 ? 1'h0 : _SFBundle_T_28_6; // @[Mux.scala 101:16]
  assign io_fcde_stall = _GEN_0 | (MULDIV_stall | (_SFBundle_T | _SFBundle_T_1)); // @[Mux.scala 101:16]
  assign io_fcex_stall = _GEN_0 | (MULDIV_stall | (_SFBundle_T | _SFBundle_T_1)); // @[Mux.scala 101:16]
  assign io_fcmem_stall = _GEN_0 | (MULDIV_stall | (_SFBundle_T | _SFBundle_T_1)); // @[Mux.scala 101:16]
  assign io_fcwb_stall = _GEN_0 | (MULDIV_stall | (_SFBundle_T | _SFBundle_T_1)); // @[Mux.scala 101:16]
  assign io_fcio_stall = io_fcex_stall; // @[FlowControl.scala 240:19]
endmodule
module ysyx_22051553_CSRs(
  input         clock,
  input         reset,
  input  [11:0] io_CSRDe_csr_raddr,
  output [63:0] io_CSRDe_csr_rdata,
  input  [11:0] io_CSRWb_rd,
  input         io_CSRWb_csr_wen,
  input  [63:0] io_CSRWb_csr_wdata,
  output [63:0] io_CSRTr_MTVEC,
  output [63:0] io_CSRTr_MCAUSE,
  output [63:0] io_CSRTr_MEPC,
  output [63:0] io_CSRTr_MIE,
  output [63:0] io_CSRTr_MIP,
  output [63:0] io_CSRTr_MSTATUS,
  input  [11:0] io_CSRTr_rd,
  input         io_CSRTr_csr_wen,
  input  [63:0] io_CSRTr_csr_wdata,
  input         io_timer_int
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] MTVEC; // @[CSRs.scala 43:24]
  reg [63:0] MCAUSE; // @[CSRs.scala 44:25]
  reg [63:0] MEPC; // @[CSRs.scala 45:23]
  reg [63:0] MIE; // @[CSRs.scala 46:22]
  reg [63:0] MIP; // @[CSRs.scala 47:22]
  reg [63:0] MSTATUS; // @[CSRs.scala 48:26]
  reg [63:0] MSCRATCH; // @[CSRs.scala 49:27]
  wire [63:0] _MIP_T_2 = {MIP[63:8],1'h1,MIP[6:0]}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_0 = io_timer_int ? _MIP_T_2 : MIP; // @[CSRs.scala 52:23 53:13 47:22]
  wire [11:0] _T = io_CSRWb_rd | io_CSRTr_rd; // @[CSRs.scala 56:24]
  wire [63:0] _MTVEC_T = io_CSRTr_csr_wen ? io_CSRTr_csr_wdata : 64'h0; // @[CSRs.scala 59:20]
  wire [63:0] _MTVEC_T_1 = io_CSRWb_csr_wen ? io_CSRWb_csr_wdata : _MTVEC_T; // @[CSRs.scala 58:25]
  wire [63:0] _GEN_1 = 12'h340 == _T ? _MTVEC_T_1 : MSCRATCH; // @[CSRs.scala 56:38 88:22 49:27]
  wire [63:0] _GEN_2 = 12'h300 == _T ? _MTVEC_T_1 : MSTATUS; // @[CSRs.scala 56:38 83:21 48:26]
  wire [63:0] _GEN_3 = 12'h300 == _T ? MSCRATCH : _GEN_1; // @[CSRs.scala 49:27 56:38]
  wire [63:0] _GEN_4 = 12'h344 == _T ? _MTVEC_T_1 : _GEN_0; // @[CSRs.scala 56:38 78:17]
  wire [63:0] _GEN_5 = 12'h344 == _T ? MSTATUS : _GEN_2; // @[CSRs.scala 48:26 56:38]
  wire [63:0] _GEN_6 = 12'h344 == _T ? MSCRATCH : _GEN_3; // @[CSRs.scala 49:27 56:38]
  wire [63:0] _GEN_7 = 12'h304 == _T ? _MTVEC_T_1 : MIE; // @[CSRs.scala 56:38 73:17 46:22]
  wire [63:0] _GEN_8 = 12'h304 == _T ? _GEN_0 : _GEN_4; // @[CSRs.scala 56:38]
  wire [63:0] _GEN_9 = 12'h304 == _T ? MSTATUS : _GEN_5; // @[CSRs.scala 48:26 56:38]
  wire [63:0] _GEN_10 = 12'h304 == _T ? MSCRATCH : _GEN_6; // @[CSRs.scala 49:27 56:38]
  wire [63:0] _io_CSRDe_csr_rdata_T_1 = 12'h305 == io_CSRDe_csr_raddr ? MTVEC : 64'h0; // @[Mux.scala 81:58]
  wire [63:0] _io_CSRDe_csr_rdata_T_3 = 12'h342 == io_CSRDe_csr_raddr ? MCAUSE : _io_CSRDe_csr_rdata_T_1; // @[Mux.scala 81:58]
  wire [63:0] _io_CSRDe_csr_rdata_T_5 = 12'h341 == io_CSRDe_csr_raddr ? MEPC : _io_CSRDe_csr_rdata_T_3; // @[Mux.scala 81:58]
  wire [63:0] _io_CSRDe_csr_rdata_T_7 = 12'h304 == io_CSRDe_csr_raddr ? MIE : _io_CSRDe_csr_rdata_T_5; // @[Mux.scala 81:58]
  wire [63:0] _io_CSRDe_csr_rdata_T_9 = 12'h344 == io_CSRDe_csr_raddr ? MIE : _io_CSRDe_csr_rdata_T_7; // @[Mux.scala 81:58]
  wire [63:0] _io_CSRDe_csr_rdata_T_11 = 12'h300 == io_CSRDe_csr_raddr ? MSTATUS : _io_CSRDe_csr_rdata_T_9; // @[Mux.scala 81:58]
  assign io_CSRDe_csr_rdata = 12'h340 == io_CSRDe_csr_raddr ? MSCRATCH : _io_CSRDe_csr_rdata_T_11; // @[Mux.scala 81:58]
  assign io_CSRTr_MTVEC = MTVEC; // @[CSRs.scala 115:20]
  assign io_CSRTr_MCAUSE = MCAUSE; // @[CSRs.scala 110:21]
  assign io_CSRTr_MEPC = MEPC; // @[CSRs.scala 111:19]
  assign io_CSRTr_MIE = MIE; // @[CSRs.scala 112:18]
  assign io_CSRTr_MIP = MIP; // @[CSRs.scala 113:18]
  assign io_CSRTr_MSTATUS = MSTATUS; // @[CSRs.scala 114:22]
  always @(posedge clock) begin
    if (reset) begin // @[CSRs.scala 43:24]
      MTVEC <= 64'h0; // @[CSRs.scala 43:24]
    end else if (12'h305 == _T) begin // @[CSRs.scala 56:38]
      if (io_CSRWb_csr_wen) begin // @[CSRs.scala 58:25]
        MTVEC <= io_CSRWb_csr_wdata;
      end else if (io_CSRTr_csr_wen) begin // @[CSRs.scala 59:20]
        MTVEC <= io_CSRTr_csr_wdata;
      end else begin
        MTVEC <= 64'h0;
      end
    end
    if (reset) begin // @[CSRs.scala 44:25]
      MCAUSE <= 64'h0; // @[CSRs.scala 44:25]
    end else if (!(12'h305 == _T)) begin // @[CSRs.scala 56:38]
      if (12'h342 == _T) begin // @[CSRs.scala 56:38]
        if (io_CSRWb_csr_wen) begin // @[CSRs.scala 58:25]
          MCAUSE <= io_CSRWb_csr_wdata;
        end else begin
          MCAUSE <= _MTVEC_T;
        end
      end
    end
    if (reset) begin // @[CSRs.scala 45:23]
      MEPC <= 64'h0; // @[CSRs.scala 45:23]
    end else if (!(12'h305 == _T)) begin // @[CSRs.scala 56:38]
      if (!(12'h342 == _T)) begin // @[CSRs.scala 56:38]
        if (12'h341 == _T) begin // @[CSRs.scala 56:38]
          MEPC <= _MTVEC_T_1; // @[CSRs.scala 68:18]
        end
      end
    end
    if (reset) begin // @[CSRs.scala 46:22]
      MIE <= 64'h0; // @[CSRs.scala 46:22]
    end else if (!(12'h305 == _T)) begin // @[CSRs.scala 56:38]
      if (!(12'h342 == _T)) begin // @[CSRs.scala 56:38]
        if (!(12'h341 == _T)) begin // @[CSRs.scala 56:38]
          MIE <= _GEN_7;
        end
      end
    end
    if (reset) begin // @[CSRs.scala 47:22]
      MIP <= 64'h0; // @[CSRs.scala 47:22]
    end else if (12'h305 == _T) begin // @[CSRs.scala 56:38]
      MIP <= _GEN_0;
    end else if (12'h342 == _T) begin // @[CSRs.scala 56:38]
      MIP <= _GEN_0;
    end else if (12'h341 == _T) begin // @[CSRs.scala 56:38]
      MIP <= _GEN_0;
    end else begin
      MIP <= _GEN_8;
    end
    if (reset) begin // @[CSRs.scala 48:26]
      MSTATUS <= 64'h0; // @[CSRs.scala 48:26]
    end else if (!(12'h305 == _T)) begin // @[CSRs.scala 56:38]
      if (!(12'h342 == _T)) begin // @[CSRs.scala 56:38]
        if (!(12'h341 == _T)) begin // @[CSRs.scala 56:38]
          MSTATUS <= _GEN_9;
        end
      end
    end
    if (reset) begin // @[CSRs.scala 49:27]
      MSCRATCH <= 64'h0; // @[CSRs.scala 49:27]
    end else if (!(12'h305 == _T)) begin // @[CSRs.scala 56:38]
      if (!(12'h342 == _T)) begin // @[CSRs.scala 56:38]
        if (!(12'h341 == _T)) begin // @[CSRs.scala 56:38]
          MSCRATCH <= _GEN_10;
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  MTVEC = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  MCAUSE = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  MEPC = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  MIE = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  MIP = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  MSTATUS = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  MSCRATCH = _RAND_6[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_22051553_Trap(
  input         clock,
  input         reset,
  input         io_ex_hasinst,
  input         io_mem_hasinst,
  input         io_wb_hasinst,
  input  [63:0] io_csrtr_MTVEC,
  input  [63:0] io_csrtr_MCAUSE,
  input  [63:0] io_csrtr_MEPC,
  input  [63:0] io_csrtr_MIE,
  input  [63:0] io_csrtr_MIP,
  input  [63:0] io_csrtr_MSTATUS,
  output [11:0] io_csrtr_rd,
  output        io_csrtr_csr_wen,
  output [63:0] io_csrtr_csr_wdata,
  input  [31:0] io_inst,
  input  [63:0] io_pc,
  output        io_fctr_pop_NOP,
  output [2:0]  io_fctr_trap_state,
  output        io_fctr_jump_flag,
  output [63:0] io_fctr_jump_pc
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] cause; // @[Trap.scala 45:24]
  reg [63:0] pc; // @[Trap.scala 46:21]
  reg [2:0] state; // @[Trap.scala 48:24]
  wire  MSTATUS_MIE = io_csrtr_MSTATUS[3]; // @[Trap.scala 52:36]
  wire  _T_7 = io_csrtr_MIP[7] & MSTATUS_MIE & io_csrtr_MIE[7]; // @[Trap.scala 85:57]
  wire [63:0] _GEN_0 = io_csrtr_MIP[7] & MSTATUS_MIE & io_csrtr_MIE[7] ? io_pc : pc; // @[Trap.scala 85:76 87:20 46:21]
  wire [63:0] _GEN_1 = io_csrtr_MIP[7] & MSTATUS_MIE & io_csrtr_MIE[7] ? 64'h8000000000000007 : cause; // @[Trap.scala 85:76 89:23 45:24]
  wire [2:0] _GEN_3 = io_csrtr_MIP[7] & MSTATUS_MIE & io_csrtr_MIE[7] ? 3'h1 : state; // @[Trap.scala 85:76 94:23 48:24]
  wire  _GEN_4 = io_inst == 32'h30200073 | _T_7; // @[Trap.scala 80:62 82:33]
  wire  _GEN_10 = io_inst == 32'h73 & MSTATUS_MIE | _GEN_4; // @[Trap.scala 71:74 78:33]
  wire  _T_13 = ~io_ex_hasinst & ~io_mem_hasinst & ~io_wb_hasinst; // @[Trap.scala 99:52]
  wire  _T_16 = 3'h4 == state; // @[Trap.scala 64:18]
  wire [63:0] _io_csrtr_csr_wdata_T_4 = {io_csrtr_MSTATUS[63:8],MSTATUS_MIE,io_csrtr_MSTATUS[6:4],1'h0,io_csrtr_MSTATUS[
    2:0]}; // @[Cat.scala 33:92]
  wire [2:0] _GEN_13 = _T_13 ? 3'h6 : state; // @[Trap.scala 126:70 127:23 48:24]
  wire  _T_24 = 64'h8000000000000007 == io_csrtr_MCAUSE; // @[Trap.scala 131:36]
  wire [63:0] _io_csrtr_csr_wdata_T_7 = {io_csrtr_MIP[63:8],1'h0,io_csrtr_MIP[6:0]}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_14 = 64'h8000000000000007 == io_csrtr_MCAUSE ? _io_csrtr_csr_wdata_T_7 : 64'h0; // @[Trap.scala 131:36 133:40 58:24]
  wire [9:0] _GEN_16 = 64'h8000000000000007 == io_csrtr_MCAUSE ? 10'h344 : 10'h0; // @[Trap.scala 131:36 135:33 61:17]
  wire  _T_25 = 3'h7 == state; // @[Trap.scala 64:18]
  wire [63:0] _io_csrtr_csr_wdata_T_11 = {io_csrtr_MSTATUS[63:4],io_csrtr_MSTATUS[7],io_csrtr_MSTATUS[2:0]}; // @[Cat.scala 33:92]
  wire [63:0] _GEN_17 = 3'h7 == state ? _io_csrtr_csr_wdata_T_11 : 64'h0; // @[Trap.scala 64:18 143:32 58:24]
  wire [9:0] _GEN_19 = 3'h7 == state ? 10'h300 : 10'h0; // @[Trap.scala 64:18 145:25 61:17]
  wire [2:0] _GEN_20 = 3'h7 == state ? 3'h0 : state; // @[Trap.scala 64:18 147:19 48:24]
  wire [63:0] _GEN_21 = 3'h6 == state ? _GEN_14 : _GEN_17; // @[Trap.scala 64:18]
  wire  _GEN_22 = 3'h6 == state ? _T_24 : 3'h7 == state; // @[Trap.scala 64:18]
  wire [9:0] _GEN_23 = 3'h6 == state ? _GEN_16 : _GEN_19; // @[Trap.scala 64:18]
  wire [2:0] _GEN_24 = 3'h6 == state ? 3'h7 : _GEN_20; // @[Trap.scala 64:18 139:19]
  wire [2:0] _GEN_25 = 3'h5 == state ? _GEN_13 : _GEN_24; // @[Trap.scala 64:18]
  wire [63:0] _GEN_26 = 3'h5 == state ? 64'h0 : _GEN_21; // @[Trap.scala 64:18 58:24]
  wire  _GEN_27 = 3'h5 == state ? 1'h0 : _GEN_22; // @[Trap.scala 64:18 59:22]
  wire [9:0] _GEN_28 = 3'h5 == state ? 10'h0 : _GEN_23; // @[Trap.scala 61:17 64:18]
  wire [63:0] _GEN_29 = 3'h4 == state ? _io_csrtr_csr_wdata_T_4 : _GEN_26; // @[Trap.scala 64:18 119:32]
  wire  _GEN_30 = 3'h4 == state | _GEN_27; // @[Trap.scala 64:18 120:30]
  wire [9:0] _GEN_31 = 3'h4 == state ? 10'h300 : _GEN_28; // @[Trap.scala 64:18 121:25]
  wire [2:0] _GEN_32 = 3'h4 == state ? 3'h0 : _GEN_25; // @[Trap.scala 64:18 123:19]
  wire [63:0] _GEN_33 = 3'h3 == state ? cause : _GEN_29; // @[Trap.scala 64:18 111:32]
  wire  _GEN_34 = 3'h3 == state | _GEN_30; // @[Trap.scala 64:18 112:30]
  wire [9:0] _GEN_35 = 3'h3 == state ? 10'h342 : _GEN_31; // @[Trap.scala 64:18 113:25]
  wire [2:0] _GEN_36 = 3'h3 == state ? 3'h4 : _GEN_32; // @[Trap.scala 64:18 115:19]
  wire [63:0] _GEN_37 = 3'h2 == state ? pc : _GEN_33; // @[Trap.scala 64:18 104:32]
  wire  _GEN_38 = 3'h2 == state | _GEN_34; // @[Trap.scala 64:18 105:30]
  wire [9:0] _GEN_39 = 3'h2 == state ? 10'h341 : _GEN_35; // @[Trap.scala 64:18 106:25]
  wire [63:0] _GEN_42 = 3'h1 == state ? 64'h0 : _GEN_37; // @[Trap.scala 64:18 58:24]
  wire  _GEN_43 = 3'h1 == state ? 1'h0 : _GEN_38; // @[Trap.scala 64:18 59:22]
  wire [9:0] _GEN_44 = 3'h1 == state ? 10'h0 : _GEN_39; // @[Trap.scala 61:17 64:18]
  wire [9:0] _GEN_47 = 3'h0 == state ? 10'h0 : _GEN_44; // @[Trap.scala 64:18 69:25]
  wire [63:0] _GEN_53 = _T_25 ? io_csrtr_MEPC : 64'h0; // @[Trap.scala 154:18 153:21 161:29]
  assign io_csrtr_rd = {{2'd0}, _GEN_47};
  assign io_csrtr_csr_wen = 3'h0 == state ? 1'h0 : _GEN_43; // @[Trap.scala 64:18 68:30]
  assign io_csrtr_csr_wdata = 3'h0 == state ? 64'h0 : _GEN_42; // @[Trap.scala 64:18 67:32]
  assign io_fctr_pop_NOP = 3'h0 == state & _GEN_10; // @[Trap.scala 64:18 62:21]
  assign io_fctr_trap_state = state; // @[Trap.scala 55:24]
  assign io_fctr_jump_flag = _T_16 | _T_25; // @[Trap.scala 154:18 156:31]
  assign io_fctr_jump_pc = _T_16 ? io_csrtr_MTVEC : _GEN_53; // @[Trap.scala 154:18 157:29]
  always @(posedge clock) begin
    if (reset) begin // @[Trap.scala 45:24]
      cause <= 64'h0; // @[Trap.scala 45:24]
    end else if (3'h0 == state) begin // @[Trap.scala 64:18]
      if (io_inst == 32'h73 & MSTATUS_MIE) begin // @[Trap.scala 71:74]
        cause <= 64'hb; // @[Trap.scala 75:23]
      end else if (!(io_inst == 32'h30200073)) begin // @[Trap.scala 80:62]
        cause <= _GEN_1;
      end
    end
    if (reset) begin // @[Trap.scala 46:21]
      pc <= 64'h0; // @[Trap.scala 46:21]
    end else if (3'h0 == state) begin // @[Trap.scala 64:18]
      if (io_inst == 32'h73 & MSTATUS_MIE) begin // @[Trap.scala 71:74]
        pc <= io_pc; // @[Trap.scala 74:20]
      end else if (!(io_inst == 32'h30200073)) begin // @[Trap.scala 80:62]
        pc <= _GEN_0;
      end
    end
    if (reset) begin // @[Trap.scala 48:24]
      state <= 3'h0; // @[Trap.scala 48:24]
    end else if (3'h0 == state) begin // @[Trap.scala 64:18]
      if (io_inst == 32'h73 & MSTATUS_MIE) begin // @[Trap.scala 71:74]
        state <= 3'h1; // @[Trap.scala 79:23]
      end else if (io_inst == 32'h30200073) begin // @[Trap.scala 80:62]
        state <= 3'h5; // @[Trap.scala 83:23]
      end else begin
        state <= _GEN_3;
      end
    end else if (3'h1 == state) begin // @[Trap.scala 64:18]
      if (~io_ex_hasinst & ~io_mem_hasinst & ~io_wb_hasinst) begin // @[Trap.scala 99:70]
        state <= 3'h2; // @[Trap.scala 100:23]
      end
    end else if (3'h2 == state) begin // @[Trap.scala 64:18]
      state <= 3'h3; // @[Trap.scala 108:19]
    end else begin
      state <= _GEN_36;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  cause = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  pc = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  state = _RAND_2[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_22051553_AXIArbitor(
  input         clock,
  input         reset,
  input         io_master0_req_valid,
  input         io_master0_req_bits_rw,
  input  [31:0] io_master0_req_bits_addr,
  input  [63:0] io_master0_req_bits_data,
  input  [7:0]  io_master0_req_bits_mask,
  input  [7:0]  io_master0_req_bits_len,
  input  [2:0]  io_master0_req_bits_size,
  output        io_master0_resp_valid,
  output [63:0] io_master0_resp_bits_data,
  input         io_master1_req_valid,
  input         io_master1_req_bits_rw,
  input  [31:0] io_master1_req_bits_addr,
  input  [63:0] io_master1_req_bits_data,
  output        io_master1_resp_valid,
  output [63:0] io_master1_resp_bits_data,
  output        io_master1_resp_bits_valid,
  output        io_master1_resp_bits_choose,
  input         io_master2_req_valid,
  input         io_master2_req_bits_rw,
  input  [31:0] io_master2_req_bits_addr,
  input  [63:0] io_master2_req_bits_data,
  output        io_master2_resp_valid,
  output [63:0] io_master2_resp_bits_data,
  output        io_master2_resp_bits_valid,
  output        io_master2_resp_bits_choose,
  input         io_AXI_O_awready,
  output        io_AXI_O_awvalid,
  output [31:0] io_AXI_O_awaddr,
  output [7:0]  io_AXI_O_awlen,
  output [2:0]  io_AXI_O_awsize,
  input         io_AXI_O_wready,
  output        io_AXI_O_wvalid,
  output [63:0] io_AXI_O_wdata,
  output [7:0]  io_AXI_O_wstrb,
  output        io_AXI_O_wlast,
  output        io_AXI_O_bready,
  input         io_AXI_O_bvalid,
  input         io_AXI_O_arready,
  output        io_AXI_O_arvalid,
  output [31:0] io_AXI_O_araddr,
  output [7:0]  io_AXI_O_arlen,
  output [2:0]  io_AXI_O_arsize,
  output        io_AXI_O_rready,
  input         io_AXI_O_rvalid,
  input  [63:0] io_AXI_O_rdata,
  input         io_AXI_O_rlast
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  wire [3:0] _master_choose_T = io_master2_req_valid ? 4'hc : 4'h0; // @[Mux.scala 101:16]
  wire [3:0] _master_choose_T_1 = io_master1_req_valid ? 4'ha : _master_choose_T; // @[Mux.scala 101:16]
  reg [3:0] choose_buffer; // @[AXIArbitor.scala 64:32]
  reg [31:0] addr; // @[AXIArbitor.scala 68:23]
  reg [7:0] burst_len; // @[AXIArbitor.scala 71:28]
  reg [2:0] size; // @[AXIArbitor.scala 72:23]
  wire [3:0] master_choose = io_master0_req_valid ? 4'h9 : _master_choose_T_1; // @[Mux.scala 101:16]
  wire  _rw_idle_T_5 = master_choose[1] ? io_master1_req_bits_rw : master_choose[2] & io_master2_req_bits_rw; // @[Mux.scala 101:16]
  wire  _rw_idle_T_6 = master_choose[0] ? io_master0_req_bits_rw : _rw_idle_T_5; // @[Mux.scala 101:16]
  wire  rw_idle = master_choose[3] & _rw_idle_T_6; // @[AXIArbitor.scala 75:19]
  wire [31:0] _addr_T_4 = master_choose[2] ? io_master2_req_bits_addr : 32'h0; // @[Mux.scala 101:16]
  wire [63:0] _data_T_4 = choose_buffer[2] ? io_master2_req_bits_data : 64'h0; // @[Mux.scala 101:16]
  wire [63:0] _data_T_5 = choose_buffer[1] ? io_master1_req_bits_data : _data_T_4; // @[Mux.scala 101:16]
  wire [63:0] _data_T_6 = choose_buffer[0] ? io_master0_req_bits_data : _data_T_5; // @[Mux.scala 101:16]
  wire [63:0] data = choose_buffer[3] ? _data_T_6 : 64'h0; // @[AXIArbitor.scala 109:16]
  wire [7:0] _mask_T_4 = choose_buffer[2] ? 8'hff : 8'h0; // @[Mux.scala 101:16]
  wire [7:0] _mask_T_5 = choose_buffer[1] ? 8'hff : _mask_T_4; // @[Mux.scala 101:16]
  wire [7:0] _mask_T_6 = choose_buffer[0] ? io_master0_req_bits_mask : _mask_T_5; // @[Mux.scala 101:16]
  wire [7:0] mask = choose_buffer[3] ? _mask_T_6 : 8'h0; // @[AXIArbitor.scala 120:16]
  wire [7:0] _burst_len_T_4 = master_choose[2] ? 8'h7 : 8'h0; // @[Mux.scala 101:16]
  wire [2:0] _size_T_4 = master_choose[2] ? 3'h3 : 3'h0; // @[Mux.scala 101:16]
  reg [1:0] state; // @[AXIArbitor.scala 154:24]
  reg  aw_comp; // @[AXIArbitor.scala 157:26]
  reg  w_comp; // @[AXIArbitor.scala 158:25]
  reg [3:0] w_count; // @[AXIArbitor.scala 160:26]
  wire [1:0] _GEN_0 = rw_idle ? 2'h2 : 2'h1; // @[AXIArbitor.scala 218:30 219:27 221:27]
  wire  _io_AXI_O_awvalid_T = aw_comp ? 1'h0 : 1'h1; // @[AXIArbitor.scala 231:36]
  wire [7:0] _GEN_160 = {{4'd0}, w_count}; // @[AXIArbitor.scala 237:45]
  wire  _io_AXI_O_wvalid_T = w_comp ? 1'h0 : 1'h1; // @[AXIArbitor.scala 239:20]
  wire  _w_comp_T = io_AXI_O_wvalid & io_AXI_O_wready; // @[AXIArbitor.scala 244:43]
  wire [3:0] _w_count_T_2 = w_count + 4'h1; // @[AXIArbitor.scala 246:72]
  wire [3:0] _w_count_T_3 = _w_comp_T ? _w_count_T_2 : w_count; // @[AXIArbitor.scala 246:27]
  wire  _GEN_4 = choose_buffer[1] ? 1'h0 : 1'h1; // @[AXIArbitor.scala 180:32 251:45 254:48]
  wire  _GEN_6 = choose_buffer[0] ? 1'h0 : choose_buffer[1]; // @[AXIArbitor.scala 176:32 249:39]
  wire  _GEN_7 = choose_buffer[0] ? 1'h0 : _GEN_4; // @[AXIArbitor.scala 180:32 249:39]
  wire  _GEN_9 = _w_comp_T & _GEN_6; // @[AXIArbitor.scala 176:32 248:53]
  wire  _GEN_10 = _w_comp_T & _GEN_7; // @[AXIArbitor.scala 180:32 248:53]
  wire  _GEN_112 = 2'h1 == state & (io_AXI_O_bvalid & io_AXI_O_bready); // @[AXIArbitor.scala 166:12 211:18 259:20]
  wire  b_comp = 2'h0 == state ? 1'h0 : _GEN_112; // @[AXIArbitor.scala 166:12 211:18]
  wire [3:0] _GEN_11 = master_choose[3] ? master_choose : choose_buffer; // @[AXIArbitor.scala 263:39 264:35 64:32]
  wire [1:0] _GEN_12 = master_choose[3] ? _GEN_0 : 2'h0; // @[AXIArbitor.scala 263:39 271:27]
  wire  _GEN_23 = aw_comp & w_comp & b_comp & choose_buffer[0]; // @[AXIArbitor.scala 170:27 261:46]
  wire  _GEN_24 = aw_comp & w_comp & b_comp & _GEN_6; // @[AXIArbitor.scala 174:27 261:46]
  wire  _GEN_25 = aw_comp & w_comp & b_comp & _GEN_7; // @[AXIArbitor.scala 178:27 261:46]
  wire  _GEN_83 = 2'h2 == state & (io_AXI_O_arvalid & io_AXI_O_arready); // @[AXIArbitor.scala 167:13 211:18 295:21]
  wire  _GEN_122 = 2'h1 == state ? 1'h0 : _GEN_83; // @[AXIArbitor.scala 167:13 211:18]
  wire  ar_comp = 2'h0 == state ? 1'h0 : _GEN_122; // @[AXIArbitor.scala 167:13 211:18]
  wire [1:0] _GEN_26 = ar_comp ? 2'h3 : state; // @[AXIArbitor.scala 297:26 298:23 154:24]
  wire  _T_13 = io_AXI_O_rvalid & io_AXI_O_rready; // @[AXIArbitor.scala 303:34]
  wire [63:0] _GEN_28 = choose_buffer[1] ? io_AXI_O_rdata : 64'h0; // @[AXIArbitor.scala 175:31 307:45 309:47]
  wire [63:0] _GEN_30 = choose_buffer[1] ? 64'h0 : io_AXI_O_rdata; // @[AXIArbitor.scala 179:31 307:45 312:47]
  wire [63:0] _GEN_32 = choose_buffer[0] ? io_AXI_O_rdata : 64'h0; // @[AXIArbitor.scala 171:31 304:39 306:47]
  wire [63:0] _GEN_34 = choose_buffer[0] ? 64'h0 : _GEN_28; // @[AXIArbitor.scala 175:31 304:39]
  wire [63:0] _GEN_36 = choose_buffer[0] ? 64'h0 : _GEN_30; // @[AXIArbitor.scala 179:31 304:39]
  wire [63:0] _GEN_38 = io_AXI_O_rvalid & io_AXI_O_rready ? _GEN_32 : 64'h0; // @[AXIArbitor.scala 171:31 303:53]
  wire  _GEN_39 = io_AXI_O_rvalid & io_AXI_O_rready & _GEN_6; // @[AXIArbitor.scala 176:32 303:53]
  wire [63:0] _GEN_40 = io_AXI_O_rvalid & io_AXI_O_rready ? _GEN_34 : 64'h0; // @[AXIArbitor.scala 175:31 303:53]
  wire  _GEN_41 = io_AXI_O_rvalid & io_AXI_O_rready & _GEN_7; // @[AXIArbitor.scala 180:32 303:53]
  wire [63:0] _GEN_42 = io_AXI_O_rvalid & io_AXI_O_rready ? _GEN_36 : 64'h0; // @[AXIArbitor.scala 179:31 303:53]
  wire [63:0] _GEN_47 = choose_buffer[1] ? io_AXI_O_rdata : _GEN_40; // @[AXIArbitor.scala 334:45 336:47]
  wire [63:0] _GEN_49 = choose_buffer[1] ? _GEN_42 : io_AXI_O_rdata; // @[AXIArbitor.scala 334:45 339:47]
  wire [63:0] _GEN_51 = choose_buffer[0] ? io_AXI_O_rdata : _GEN_38; // @[AXIArbitor.scala 331:39 333:47]
  wire [63:0] _GEN_53 = choose_buffer[0] ? _GEN_40 : _GEN_47; // @[AXIArbitor.scala 331:39]
  wire [63:0] _GEN_55 = choose_buffer[0] ? _GEN_42 : _GEN_49; // @[AXIArbitor.scala 331:39]
  wire  _GEN_73 = 2'h3 == state & (_T_13 & io_AXI_O_rlast); // @[AXIArbitor.scala 168:12 211:18 317:20]
  wire  _GEN_93 = 2'h2 == state ? 1'h0 : _GEN_73; // @[AXIArbitor.scala 168:12 211:18]
  wire  _GEN_128 = 2'h1 == state ? 1'h0 : _GEN_93; // @[AXIArbitor.scala 168:12 211:18]
  wire  r_comp = 2'h0 == state ? 1'h0 : _GEN_128; // @[AXIArbitor.scala 168:12 211:18]
  wire [3:0] _GEN_56 = r_comp ? _GEN_11 : choose_buffer; // @[AXIArbitor.scala 318:25 64:32]
  wire [1:0] _GEN_57 = r_comp ? _GEN_12 : state; // @[AXIArbitor.scala 154:24 318:25]
  wire  _GEN_59 = r_comp & choose_buffer[0]; // @[AXIArbitor.scala 318:25 170:27]
  wire [63:0] _GEN_60 = r_comp ? _GEN_51 : _GEN_38; // @[AXIArbitor.scala 318:25]
  wire  _GEN_61 = r_comp & _GEN_6; // @[AXIArbitor.scala 318:25 174:27]
  wire [63:0] _GEN_62 = r_comp ? _GEN_53 : _GEN_40; // @[AXIArbitor.scala 318:25]
  wire  _GEN_63 = r_comp & _GEN_7; // @[AXIArbitor.scala 318:25 178:27]
  wire [63:0] _GEN_64 = r_comp ? _GEN_55 : _GEN_42; // @[AXIArbitor.scala 318:25]
  wire [63:0] _GEN_67 = 2'h3 == state ? _GEN_60 : 64'h0; // @[AXIArbitor.scala 211:18 171:31]
  wire [63:0] _GEN_69 = 2'h3 == state ? _GEN_62 : 64'h0; // @[AXIArbitor.scala 211:18 175:31]
  wire [63:0] _GEN_71 = 2'h3 == state ? _GEN_64 : 64'h0; // @[AXIArbitor.scala 211:18 179:31]
  wire [3:0] _GEN_74 = 2'h3 == state ? _GEN_56 : choose_buffer; // @[AXIArbitor.scala 211:18 64:32]
  wire [1:0] _GEN_75 = 2'h3 == state ? _GEN_57 : state; // @[AXIArbitor.scala 211:18 154:24]
  wire [31:0] _GEN_80 = 2'h2 == state ? addr : 32'h0; // @[AXIArbitor.scala 211:18 200:21 292:29]
  wire [7:0] _GEN_81 = 2'h2 == state ? burst_len : 8'h0; // @[AXIArbitor.scala 211:18 201:20 293:28]
  wire [2:0] _GEN_82 = 2'h2 == state ? size : 3'h0; // @[AXIArbitor.scala 211:18 202:21 294:29]
  wire  _GEN_85 = 2'h2 == state ? 1'h0 : 2'h3 == state; // @[AXIArbitor.scala 211:18 208:21]
  wire [63:0] _GEN_87 = 2'h2 == state ? 64'h0 : _GEN_67; // @[AXIArbitor.scala 211:18 171:31]
  wire  _GEN_88 = 2'h2 == state ? 1'h0 : 2'h3 == state & _GEN_39; // @[AXIArbitor.scala 211:18 176:32]
  wire [63:0] _GEN_89 = 2'h2 == state ? 64'h0 : _GEN_69; // @[AXIArbitor.scala 211:18 175:31]
  wire  _GEN_90 = 2'h2 == state ? 1'h0 : 2'h3 == state & _GEN_41; // @[AXIArbitor.scala 211:18 180:32]
  wire [63:0] _GEN_91 = 2'h2 == state ? 64'h0 : _GEN_71; // @[AXIArbitor.scala 211:18 179:31]
  wire  _GEN_95 = 2'h2 == state ? 1'h0 : 2'h3 == state & _GEN_59; // @[AXIArbitor.scala 211:18 170:27]
  wire  _GEN_96 = 2'h2 == state ? 1'h0 : 2'h3 == state & _GEN_61; // @[AXIArbitor.scala 211:18 174:27]
  wire  _GEN_97 = 2'h2 == state ? 1'h0 : 2'h3 == state & _GEN_63; // @[AXIArbitor.scala 211:18 178:27]
  wire [31:0] _GEN_98 = 2'h1 == state ? addr : 32'h0; // @[AXIArbitor.scala 211:18 185:21 227:29]
  wire [7:0] _GEN_99 = 2'h1 == state ? burst_len : 8'h0; // @[AXIArbitor.scala 211:18 186:20 228:28]
  wire [2:0] _GEN_100 = 2'h1 == state ? size : 3'h0; // @[AXIArbitor.scala 211:18 187:21 229:29]
  wire  _GEN_101 = 2'h1 == state & _io_AXI_O_awvalid_T; // @[AXIArbitor.scala 211:18 190:22 231:30]
  wire [63:0] _GEN_103 = 2'h1 == state ? data : 64'h0; // @[AXIArbitor.scala 211:18 192:20 235:28]
  wire [7:0] _GEN_104 = 2'h1 == state ? mask : 8'h0; // @[AXIArbitor.scala 211:18 193:20 236:28]
  wire  _GEN_105 = 2'h1 == state & burst_len == _GEN_160; // @[AXIArbitor.scala 211:18 194:20 237:28]
  wire  _GEN_106 = 2'h1 == state & (aw_comp & _io_AXI_O_wvalid_T); // @[AXIArbitor.scala 211:18 195:21 238:29]
  wire  _GEN_110 = 2'h1 == state ? _GEN_9 : _GEN_88; // @[AXIArbitor.scala 211:18]
  wire  _GEN_111 = 2'h1 == state ? _GEN_10 : _GEN_90; // @[AXIArbitor.scala 211:18]
  wire  _GEN_115 = 2'h1 == state ? _GEN_23 : _GEN_95; // @[AXIArbitor.scala 211:18]
  wire  _GEN_116 = 2'h1 == state ? _GEN_24 : _GEN_96; // @[AXIArbitor.scala 211:18]
  wire  _GEN_117 = 2'h1 == state ? _GEN_25 : _GEN_97; // @[AXIArbitor.scala 211:18]
  wire  _GEN_118 = 2'h1 == state ? 1'h0 : 2'h2 == state; // @[AXIArbitor.scala 211:18 205:22]
  wire [31:0] _GEN_119 = 2'h1 == state ? 32'h0 : _GEN_80; // @[AXIArbitor.scala 211:18 200:21]
  wire [7:0] _GEN_120 = 2'h1 == state ? 8'h0 : _GEN_81; // @[AXIArbitor.scala 211:18 201:20]
  wire [2:0] _GEN_121 = 2'h1 == state ? 3'h0 : _GEN_82; // @[AXIArbitor.scala 211:18 202:21]
  wire  _GEN_123 = 2'h1 == state ? 1'h0 : _GEN_85; // @[AXIArbitor.scala 211:18 208:21]
  wire [63:0] _GEN_124 = 2'h1 == state ? 64'h0 : _GEN_87; // @[AXIArbitor.scala 211:18 171:31]
  wire [63:0] _GEN_125 = 2'h1 == state ? 64'h0 : _GEN_89; // @[AXIArbitor.scala 211:18 175:31]
  wire [63:0] _GEN_126 = 2'h1 == state ? 64'h0 : _GEN_91; // @[AXIArbitor.scala 211:18 179:31]
  assign io_master0_resp_valid = 2'h0 == state ? 1'h0 : _GEN_115; // @[AXIArbitor.scala 211:18 170:27]
  assign io_master0_resp_bits_data = 2'h0 == state ? 64'h0 : _GEN_124; // @[AXIArbitor.scala 211:18 171:31]
  assign io_master1_resp_valid = 2'h0 == state ? 1'h0 : _GEN_116; // @[AXIArbitor.scala 211:18 174:27]
  assign io_master1_resp_bits_data = 2'h0 == state ? 64'h0 : _GEN_125; // @[AXIArbitor.scala 211:18 175:31]
  assign io_master1_resp_bits_valid = 2'h0 == state ? 1'h0 : _GEN_110; // @[AXIArbitor.scala 211:18 176:32]
  assign io_master1_resp_bits_choose = choose_buffer[1]; // @[AXIArbitor.scala 177:49]
  assign io_master2_resp_valid = 2'h0 == state ? 1'h0 : _GEN_117; // @[AXIArbitor.scala 211:18 178:27]
  assign io_master2_resp_bits_data = 2'h0 == state ? 64'h0 : _GEN_126; // @[AXIArbitor.scala 211:18 179:31]
  assign io_master2_resp_bits_valid = 2'h0 == state ? 1'h0 : _GEN_111; // @[AXIArbitor.scala 211:18 180:32]
  assign io_master2_resp_bits_choose = choose_buffer[2]; // @[AXIArbitor.scala 181:49]
  assign io_AXI_O_awvalid = 2'h0 == state ? 1'h0 : _GEN_101; // @[AXIArbitor.scala 211:18 190:22]
  assign io_AXI_O_awaddr = 2'h0 == state ? 32'h0 : _GEN_98; // @[AXIArbitor.scala 211:18 185:21]
  assign io_AXI_O_awlen = 2'h0 == state ? 8'h0 : _GEN_99; // @[AXIArbitor.scala 211:18 186:20]
  assign io_AXI_O_awsize = 2'h0 == state ? 3'h0 : _GEN_100; // @[AXIArbitor.scala 211:18 187:21]
  assign io_AXI_O_wvalid = 2'h0 == state ? 1'h0 : _GEN_106; // @[AXIArbitor.scala 211:18 195:21]
  assign io_AXI_O_wdata = 2'h0 == state ? 64'h0 : _GEN_103; // @[AXIArbitor.scala 211:18 192:20]
  assign io_AXI_O_wstrb = 2'h0 == state ? 8'h0 : _GEN_104; // @[AXIArbitor.scala 211:18 193:20]
  assign io_AXI_O_wlast = 2'h0 == state ? 1'h0 : _GEN_105; // @[AXIArbitor.scala 211:18 194:20]
  assign io_AXI_O_bready = 1'h1; // @[AXIArbitor.scala 197:21]
  assign io_AXI_O_arvalid = 2'h0 == state ? 1'h0 : _GEN_118; // @[AXIArbitor.scala 211:18 205:22]
  assign io_AXI_O_araddr = 2'h0 == state ? 32'h0 : _GEN_119; // @[AXIArbitor.scala 211:18 200:21]
  assign io_AXI_O_arlen = 2'h0 == state ? 8'h0 : _GEN_120; // @[AXIArbitor.scala 211:18 201:20]
  assign io_AXI_O_arsize = 2'h0 == state ? 3'h0 : _GEN_121; // @[AXIArbitor.scala 211:18 202:21]
  assign io_AXI_O_rready = 2'h0 == state ? 1'h0 : _GEN_123; // @[AXIArbitor.scala 211:18 208:21]
  always @(posedge clock) begin
    if (reset) begin // @[AXIArbitor.scala 64:32]
      choose_buffer <= 4'h0; // @[AXIArbitor.scala 64:32]
    end else if (2'h0 == state) begin // @[AXIArbitor.scala 211:18]
      if (master_choose[3]) begin // @[AXIArbitor.scala 215:35]
        if (io_master0_req_valid) begin // @[Mux.scala 101:16]
          choose_buffer <= 4'h9;
        end else begin
          choose_buffer <= _master_choose_T_1;
        end
      end else begin
        choose_buffer <= 4'h0; // @[AXIArbitor.scala 213:27]
      end
    end else if (2'h1 == state) begin // @[AXIArbitor.scala 211:18]
      if (aw_comp & w_comp & b_comp) begin // @[AXIArbitor.scala 261:46]
        choose_buffer <= _GEN_11;
      end
    end else if (!(2'h2 == state)) begin // @[AXIArbitor.scala 211:18]
      choose_buffer <= _GEN_74;
    end
    if (reset) begin // @[AXIArbitor.scala 68:23]
      addr <= 32'h0; // @[AXIArbitor.scala 68:23]
    end else if (master_choose[3]) begin // @[AXIArbitor.scala 98:16]
      if (master_choose[0]) begin // @[Mux.scala 101:16]
        addr <= io_master0_req_bits_addr;
      end else if (master_choose[1]) begin // @[Mux.scala 101:16]
        addr <= io_master1_req_bits_addr;
      end else begin
        addr <= _addr_T_4;
      end
    end else begin
      addr <= 32'h0;
    end
    if (reset) begin // @[AXIArbitor.scala 71:28]
      burst_len <= 8'h0; // @[AXIArbitor.scala 71:28]
    end else if (master_choose[3]) begin // @[AXIArbitor.scala 131:21]
      if (master_choose[0]) begin // @[Mux.scala 101:16]
        burst_len <= io_master0_req_bits_len;
      end else if (master_choose[1]) begin // @[Mux.scala 101:16]
        burst_len <= 8'h7;
      end else begin
        burst_len <= _burst_len_T_4;
      end
    end else begin
      burst_len <= 8'h0;
    end
    if (reset) begin // @[AXIArbitor.scala 72:23]
      size <= 3'h0; // @[AXIArbitor.scala 72:23]
    end else if (master_choose[3]) begin // @[AXIArbitor.scala 142:16]
      if (master_choose[0]) begin // @[Mux.scala 101:16]
        size <= io_master0_req_bits_size;
      end else if (master_choose[1]) begin // @[Mux.scala 101:16]
        size <= 3'h3;
      end else begin
        size <= _size_T_4;
      end
    end else begin
      size <= 3'h0;
    end
    if (reset) begin // @[AXIArbitor.scala 154:24]
      state <= 2'h0; // @[AXIArbitor.scala 154:24]
    end else if (2'h0 == state) begin // @[AXIArbitor.scala 211:18]
      if (master_choose[3]) begin // @[AXIArbitor.scala 215:35]
        if (rw_idle) begin // @[AXIArbitor.scala 218:30]
          state <= 2'h2; // @[AXIArbitor.scala 219:27]
        end else begin
          state <= 2'h1; // @[AXIArbitor.scala 221:27]
        end
      end
    end else if (2'h1 == state) begin // @[AXIArbitor.scala 211:18]
      if (aw_comp & w_comp & b_comp) begin // @[AXIArbitor.scala 261:46]
        state <= _GEN_12;
      end
    end else if (2'h2 == state) begin // @[AXIArbitor.scala 211:18]
      state <= _GEN_26;
    end else begin
      state <= _GEN_75;
    end
    if (reset) begin // @[AXIArbitor.scala 157:26]
      aw_comp <= 1'h0; // @[AXIArbitor.scala 157:26]
    end else if (!(2'h0 == state)) begin // @[AXIArbitor.scala 211:18]
      if (2'h1 == state) begin // @[AXIArbitor.scala 211:18]
        if (aw_comp & w_comp & b_comp) begin // @[AXIArbitor.scala 261:46]
          aw_comp <= 1'h0; // @[AXIArbitor.scala 275:25]
        end else begin
          aw_comp <= io_AXI_O_awvalid & io_AXI_O_awready | aw_comp; // @[AXIArbitor.scala 232:21]
        end
      end
    end
    if (reset) begin // @[AXIArbitor.scala 158:25]
      w_comp <= 1'h0; // @[AXIArbitor.scala 158:25]
    end else if (!(2'h0 == state)) begin // @[AXIArbitor.scala 211:18]
      if (2'h1 == state) begin // @[AXIArbitor.scala 211:18]
        if (aw_comp & w_comp & b_comp) begin // @[AXIArbitor.scala 261:46]
          w_comp <= 1'h0; // @[AXIArbitor.scala 276:24]
        end else begin
          w_comp <= io_AXI_O_wvalid & io_AXI_O_wready & io_AXI_O_wlast | w_comp; // @[AXIArbitor.scala 244:20]
        end
      end
    end
    if (reset) begin // @[AXIArbitor.scala 160:26]
      w_count <= 4'h0; // @[AXIArbitor.scala 160:26]
    end else if (!(2'h0 == state)) begin // @[AXIArbitor.scala 211:18]
      if (2'h1 == state) begin // @[AXIArbitor.scala 211:18]
        if (aw_comp & w_comp & b_comp) begin // @[AXIArbitor.scala 261:46]
          w_count <= 4'h0; // @[AXIArbitor.scala 277:25]
        end else begin
          w_count <= _w_count_T_3; // @[AXIArbitor.scala 246:21]
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  choose_buffer = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  addr = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  burst_len = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  size = _RAND_3[2:0];
  _RAND_4 = {1{`RANDOM}};
  state = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  aw_comp = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  w_comp = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  w_count = _RAND_7[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_22051553_Cache(
  input          clock,
  input          reset,
  input          io_cpu_req_valid,
  input  [31:0]  io_cpu_req_bits_addr,
  input  [63:0]  io_cpu_req_bits_data,
  input  [7:0]   io_cpu_req_bits_mask,
  output         io_cpu_resp_valid,
  output [63:0]  io_cpu_resp_bits_data,
  output [5:0]   io_cpu_sram0_addr,
  output         io_cpu_sram0_cen,
  output         io_cpu_sram0_wen,
  output [127:0] io_cpu_sram0_wmask,
  output [127:0] io_cpu_sram0_wdata,
  input  [127:0] io_cpu_sram0_rdata,
  output [5:0]   io_cpu_sram1_addr,
  output         io_cpu_sram1_cen,
  output         io_cpu_sram1_wen,
  output [127:0] io_cpu_sram1_wmask,
  output [127:0] io_cpu_sram1_wdata,
  input  [127:0] io_cpu_sram1_rdata,
  output [5:0]   io_cpu_sram2_addr,
  output         io_cpu_sram2_cen,
  output         io_cpu_sram2_wen,
  output [127:0] io_cpu_sram2_wmask,
  output [127:0] io_cpu_sram2_wdata,
  input  [127:0] io_cpu_sram2_rdata,
  output [5:0]   io_cpu_sram3_addr,
  output         io_cpu_sram3_cen,
  output         io_cpu_sram3_wen,
  output [127:0] io_cpu_sram3_wmask,
  output [127:0] io_cpu_sram3_wdata,
  input  [127:0] io_cpu_sram3_rdata,
  output         io_axi_req_valid,
  output         io_axi_req_bits_rw,
  output [31:0]  io_axi_req_bits_addr,
  output [63:0]  io_axi_req_bits_data,
  input          io_axi_resp_valid,
  input  [63:0]  io_axi_resp_bits_data,
  input          io_axi_resp_bits_valid,
  input          io_axi_resp_bits_choose,
  output [2:0]   io_fccache_state
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [95:0] _RAND_58;
  reg [95:0] _RAND_59;
  reg [95:0] _RAND_60;
  reg [95:0] _RAND_61;
  reg [95:0] _RAND_62;
  reg [95:0] _RAND_63;
  reg [95:0] _RAND_64;
  reg [95:0] _RAND_65;
  reg [95:0] _RAND_66;
  reg [95:0] _RAND_67;
  reg [95:0] _RAND_68;
  reg [95:0] _RAND_69;
  reg [95:0] _RAND_70;
  reg [95:0] _RAND_71;
  reg [95:0] _RAND_72;
  reg [95:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [511:0] _RAND_80;
  reg [63:0] _RAND_81;
  reg [63:0] _RAND_82;
  reg [63:0] _RAND_83;
  reg [63:0] _RAND_84;
  reg [63:0] _RAND_85;
  reg [63:0] _RAND_86;
  reg [63:0] _RAND_87;
  reg [63:0] _RAND_88;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] r_count; // @[Cache.scala 98:26]
  reg [2:0] w_count; // @[Cache.scala 99:26]
  reg [2:0] state; // @[Cache.scala 102:24]
  wire  is_idle = state == 3'h0; // @[Cache.scala 104:25]
  wire  is_choose = state == 3'h1; // @[Cache.scala 105:27]
  wire  is_alloc = state == 3'h4 & r_count == 3'h7 & io_axi_resp_valid; // @[Cache.scala 106:56]
  reg  is_alloc_reg; // @[Cache.scala 107:31]
  wire  is_war = state == 3'h5; // @[Cache.scala 108:24]
  reg [31:0] addr_reg; // @[Cache.scala 112:27]
  reg [63:0] cpu_data; // @[Cache.scala 113:27]
  reg [7:0] after_alloc_mask; // @[Cache.scala 114:27]
  reg [31:0] addr_buf; // @[Cache.scala 116:27]
  reg  rw_buf; // @[Cache.scala 117:25]
  reg [3:0] valid_0; // @[Cache.scala 121:24]
  reg [3:0] valid_1; // @[Cache.scala 121:24]
  reg [3:0] valid_2; // @[Cache.scala 121:24]
  reg [3:0] valid_3; // @[Cache.scala 121:24]
  reg [3:0] valid_4; // @[Cache.scala 121:24]
  reg [3:0] valid_5; // @[Cache.scala 121:24]
  reg [3:0] valid_6; // @[Cache.scala 121:24]
  reg [3:0] valid_7; // @[Cache.scala 121:24]
  reg [3:0] valid_8; // @[Cache.scala 121:24]
  reg [3:0] valid_9; // @[Cache.scala 121:24]
  reg [3:0] valid_10; // @[Cache.scala 121:24]
  reg [3:0] valid_11; // @[Cache.scala 121:24]
  reg [3:0] valid_12; // @[Cache.scala 121:24]
  reg [3:0] valid_13; // @[Cache.scala 121:24]
  reg [3:0] valid_14; // @[Cache.scala 121:24]
  reg [3:0] valid_15; // @[Cache.scala 121:24]
  reg [3:0] dirty_0; // @[Cache.scala 122:24]
  reg [3:0] dirty_1; // @[Cache.scala 122:24]
  reg [3:0] dirty_2; // @[Cache.scala 122:24]
  reg [3:0] dirty_3; // @[Cache.scala 122:24]
  reg [3:0] dirty_4; // @[Cache.scala 122:24]
  reg [3:0] dirty_5; // @[Cache.scala 122:24]
  reg [3:0] dirty_6; // @[Cache.scala 122:24]
  reg [3:0] dirty_7; // @[Cache.scala 122:24]
  reg [3:0] dirty_8; // @[Cache.scala 122:24]
  reg [3:0] dirty_9; // @[Cache.scala 122:24]
  reg [3:0] dirty_10; // @[Cache.scala 122:24]
  reg [3:0] dirty_11; // @[Cache.scala 122:24]
  reg [3:0] dirty_12; // @[Cache.scala 122:24]
  reg [3:0] dirty_13; // @[Cache.scala 122:24]
  reg [3:0] dirty_14; // @[Cache.scala 122:24]
  reg [3:0] dirty_15; // @[Cache.scala 122:24]
  reg [2:0] replace_0; // @[Cache.scala 125:26]
  reg [2:0] replace_1; // @[Cache.scala 125:26]
  reg [2:0] replace_2; // @[Cache.scala 125:26]
  reg [2:0] replace_3; // @[Cache.scala 125:26]
  reg [2:0] replace_4; // @[Cache.scala 125:26]
  reg [2:0] replace_5; // @[Cache.scala 125:26]
  reg [2:0] replace_6; // @[Cache.scala 125:26]
  reg [2:0] replace_7; // @[Cache.scala 125:26]
  reg [2:0] replace_8; // @[Cache.scala 125:26]
  reg [2:0] replace_9; // @[Cache.scala 125:26]
  reg [2:0] replace_10; // @[Cache.scala 125:26]
  reg [2:0] replace_11; // @[Cache.scala 125:26]
  reg [2:0] replace_12; // @[Cache.scala 125:26]
  reg [2:0] replace_13; // @[Cache.scala 125:26]
  reg [2:0] replace_14; // @[Cache.scala 125:26]
  reg [2:0] replace_15; // @[Cache.scala 125:26]
  reg [1:0] victim; // @[Cache.scala 127:25]
  reg [87:0] TagArray_0; // @[Cache.scala 132:27]
  reg [87:0] TagArray_1; // @[Cache.scala 132:27]
  reg [87:0] TagArray_2; // @[Cache.scala 132:27]
  reg [87:0] TagArray_3; // @[Cache.scala 132:27]
  reg [87:0] TagArray_4; // @[Cache.scala 132:27]
  reg [87:0] TagArray_5; // @[Cache.scala 132:27]
  reg [87:0] TagArray_6; // @[Cache.scala 132:27]
  reg [87:0] TagArray_7; // @[Cache.scala 132:27]
  reg [87:0] TagArray_8; // @[Cache.scala 132:27]
  reg [87:0] TagArray_9; // @[Cache.scala 132:27]
  reg [87:0] TagArray_10; // @[Cache.scala 132:27]
  reg [87:0] TagArray_11; // @[Cache.scala 132:27]
  reg [87:0] TagArray_12; // @[Cache.scala 132:27]
  reg [87:0] TagArray_13; // @[Cache.scala 132:27]
  reg [87:0] TagArray_14; // @[Cache.scala 132:27]
  reg [87:0] TagArray_15; // @[Cache.scala 132:27]
  reg  hit_reg; // @[Cache.scala 148:26]
  wire  w_req = |io_cpu_req_bits_mask; // @[Cache.scala 154:38]
  wire [3:0] idx = io_cpu_req_bits_addr[9:6]; // @[Cache.scala 167:19]
  wire [3:0] _GEN_20 = 4'h1 == idx ? valid_1 : valid_0; // @[Cache.scala 248:{22,22}]
  wire [3:0] _GEN_21 = 4'h2 == idx ? valid_2 : _GEN_20; // @[Cache.scala 248:{22,22}]
  wire [3:0] _GEN_22 = 4'h3 == idx ? valid_3 : _GEN_21; // @[Cache.scala 248:{22,22}]
  wire [3:0] _GEN_23 = 4'h4 == idx ? valid_4 : _GEN_22; // @[Cache.scala 248:{22,22}]
  wire [3:0] _GEN_24 = 4'h5 == idx ? valid_5 : _GEN_23; // @[Cache.scala 248:{22,22}]
  wire [3:0] _GEN_25 = 4'h6 == idx ? valid_6 : _GEN_24; // @[Cache.scala 248:{22,22}]
  wire [3:0] _GEN_26 = 4'h7 == idx ? valid_7 : _GEN_25; // @[Cache.scala 248:{22,22}]
  wire [3:0] _GEN_27 = 4'h8 == idx ? valid_8 : _GEN_26; // @[Cache.scala 248:{22,22}]
  wire [3:0] _GEN_28 = 4'h9 == idx ? valid_9 : _GEN_27; // @[Cache.scala 248:{22,22}]
  wire [3:0] _GEN_29 = 4'ha == idx ? valid_10 : _GEN_28; // @[Cache.scala 248:{22,22}]
  wire [3:0] _GEN_30 = 4'hb == idx ? valid_11 : _GEN_29; // @[Cache.scala 248:{22,22}]
  wire [3:0] _GEN_31 = 4'hc == idx ? valid_12 : _GEN_30; // @[Cache.scala 248:{22,22}]
  wire [3:0] _GEN_32 = 4'hd == idx ? valid_13 : _GEN_31; // @[Cache.scala 248:{22,22}]
  wire [3:0] _GEN_33 = 4'he == idx ? valid_14 : _GEN_32; // @[Cache.scala 248:{22,22}]
  wire [3:0] _GEN_34 = 4'hf == idx ? valid_15 : _GEN_33; // @[Cache.scala 248:{22,22}]
  wire [87:0] _GEN_1 = 4'h1 == idx ? TagArray_1 : TagArray_0; // @[Cache.scala 184:{24,24}]
  wire [87:0] _GEN_2 = 4'h2 == idx ? TagArray_2 : _GEN_1; // @[Cache.scala 184:{24,24}]
  wire [87:0] _GEN_3 = 4'h3 == idx ? TagArray_3 : _GEN_2; // @[Cache.scala 184:{24,24}]
  wire [87:0] _GEN_4 = 4'h4 == idx ? TagArray_4 : _GEN_3; // @[Cache.scala 184:{24,24}]
  wire [87:0] _GEN_5 = 4'h5 == idx ? TagArray_5 : _GEN_4; // @[Cache.scala 184:{24,24}]
  wire [87:0] _GEN_6 = 4'h6 == idx ? TagArray_6 : _GEN_5; // @[Cache.scala 184:{24,24}]
  wire [87:0] _GEN_7 = 4'h7 == idx ? TagArray_7 : _GEN_6; // @[Cache.scala 184:{24,24}]
  wire [87:0] _GEN_8 = 4'h8 == idx ? TagArray_8 : _GEN_7; // @[Cache.scala 184:{24,24}]
  wire [87:0] _GEN_9 = 4'h9 == idx ? TagArray_9 : _GEN_8; // @[Cache.scala 184:{24,24}]
  wire [87:0] _GEN_10 = 4'ha == idx ? TagArray_10 : _GEN_9; // @[Cache.scala 184:{24,24}]
  wire [87:0] _GEN_11 = 4'hb == idx ? TagArray_11 : _GEN_10; // @[Cache.scala 184:{24,24}]
  wire [87:0] _GEN_12 = 4'hc == idx ? TagArray_12 : _GEN_11; // @[Cache.scala 184:{24,24}]
  wire [87:0] _GEN_13 = 4'hd == idx ? TagArray_13 : _GEN_12; // @[Cache.scala 184:{24,24}]
  wire [87:0] _GEN_14 = 4'he == idx ? TagArray_14 : _GEN_13; // @[Cache.scala 184:{24,24}]
  wire [87:0] _GEN_15 = 4'hf == idx ? TagArray_15 : _GEN_14; // @[Cache.scala 184:{24,24}]
  wire [21:0] rtag0 = _GEN_15[21:0]; // @[Cache.scala 184:24]
  wire [21:0] tag = io_cpu_req_bits_addr[31:10]; // @[Cache.scala 168:19]
  wire  hit0 = _GEN_34[0] & rtag0 == tag & is_idle; // @[Cache.scala 248:43]
  wire [21:0] rtag1 = _GEN_15[43:22]; // @[Cache.scala 185:24]
  wire  hit1 = _GEN_34[1] & rtag1 == tag & is_idle; // @[Cache.scala 249:43]
  wire [21:0] rtag2 = _GEN_15[65:44]; // @[Cache.scala 186:24]
  wire  hit2 = _GEN_34[2] & rtag2 == tag & is_idle; // @[Cache.scala 250:43]
  wire [21:0] rtag3 = _GEN_15[87:66]; // @[Cache.scala 187:24]
  wire  hit3 = _GEN_34[3] & rtag3 == tag & is_idle; // @[Cache.scala 251:43]
  wire  hit = hit0 | hit1 | hit2 | hit3; // @[Cache.scala 253:31]
  wire  _wen_T = is_idle & hit; // @[Cache.scala 155:24]
  wire  _wen_T_3 = |after_alloc_mask; // @[Cache.scala 155:84]
  wire  wen = is_idle & hit & w_req | is_alloc | is_alloc_reg & |after_alloc_mask; // @[Cache.scala 155:55]
  wire  ren = ~wen & (_wen_T & ~w_req | is_choose); // @[Cache.scala 159:20]
  reg  ren_reg; // @[Cache.scala 163:26]
  wire [2:0] off = io_cpu_req_bits_addr[5:3]; // @[Cache.scala 169:19]
  wire [21:0] tag_reg = addr_reg[31:10]; // @[Cache.scala 171:27]
  wire [3:0] idx_reg = addr_reg[9:6]; // @[Cache.scala 172:27]
  wire [2:0] off_reg = addr_reg[5:3]; // @[Cache.scala 173:27]
  reg [21:0] rtag0_buf; // @[Cache.scala 188:28]
  reg [21:0] rtag1_buf; // @[Cache.scala 189:28]
  reg [21:0] rtag2_buf; // @[Cache.scala 190:28]
  reg [21:0] rtag3_buf; // @[Cache.scala 191:28]
  wire [1:0] _addr_temp_T = hit3 ? 2'h3 : 2'h0; // @[Mux.scala 101:16]
  wire [1:0] _addr_temp_T_1 = hit2 ? 2'h2 : _addr_temp_T; // @[Mux.scala 101:16]
  wire [1:0] _addr_temp_T_2 = hit1 ? 2'h1 : _addr_temp_T_1; // @[Mux.scala 101:16]
  wire [1:0] _addr_temp_T_3 = hit0 ? 2'h0 : _addr_temp_T_2; // @[Mux.scala 101:16]
  wire [5:0] _addr_temp_T_4 = {_addr_temp_T_3,idx}; // @[Cat.scala 33:92]
  wire [5:0] _addr_temp_T_5 = {victim,idx}; // @[Cat.scala 33:92]
  wire [5:0] addr_temp = hit ? _addr_temp_T_4 : _addr_temp_T_5; // @[Cache.scala 198:28]
  wire [5:0] _GEN_16 = ren ? addr_temp : 6'h0; // @[Cache.scala 197:14 213:27 77:23]
  wire  _GEN_17 = ren ? 1'h0 : 1'h1; // @[Cache.scala 197:14 214:26 78:22]
  wire [511:0] rdata = {io_cpu_sram3_rdata,io_cpu_sram2_rdata,io_cpu_sram1_rdata,io_cpu_sram0_rdata}; // @[Cat.scala 33:92]
  reg [511:0] rdata_buf; // @[Reg.scala 35:20]
  wire [511:0] _GEN_18 = ren_reg ? rdata : rdata_buf; // @[Reg.scala 36:18 35:20 36:22]
  reg [63:0] refill_buffer_0; // @[Cache.scala 230:32]
  reg [63:0] refill_buffer_1; // @[Cache.scala 230:32]
  reg [63:0] refill_buffer_2; // @[Cache.scala 230:32]
  reg [63:0] refill_buffer_3; // @[Cache.scala 230:32]
  reg [63:0] refill_buffer_4; // @[Cache.scala 230:32]
  reg [63:0] refill_buffer_5; // @[Cache.scala 230:32]
  reg [63:0] refill_buffer_6; // @[Cache.scala 230:32]
  reg [63:0] refill_buffer_7; // @[Cache.scala 230:32]
  wire [511:0] _read_T = {refill_buffer_7,refill_buffer_6,refill_buffer_5,refill_buffer_4,refill_buffer_3,
    refill_buffer_2,refill_buffer_1,refill_buffer_0}; // @[Cache.scala 234:23]
  wire [511:0] _read_T_2 = hit_reg ? rdata : _GEN_18; // @[Cache.scala 235:12]
  wire [511:0] read = is_alloc_reg ? _read_T : _read_T_2; // @[Cache.scala 233:19]
  wire [63:0] _GEN_36 = 3'h1 == off_reg ? refill_buffer_1 : refill_buffer_0; // @[Cache.scala 255:{33,33}]
  wire [63:0] _GEN_37 = 3'h2 == off_reg ? refill_buffer_2 : _GEN_36; // @[Cache.scala 255:{33,33}]
  wire [63:0] _GEN_38 = 3'h3 == off_reg ? refill_buffer_3 : _GEN_37; // @[Cache.scala 255:{33,33}]
  wire [63:0] _GEN_39 = 3'h4 == off_reg ? refill_buffer_4 : _GEN_38; // @[Cache.scala 255:{33,33}]
  wire [63:0] _GEN_40 = 3'h5 == off_reg ? refill_buffer_5 : _GEN_39; // @[Cache.scala 255:{33,33}]
  wire [63:0] _GEN_41 = 3'h6 == off_reg ? refill_buffer_6 : _GEN_40; // @[Cache.scala 255:{33,33}]
  wire [63:0] _GEN_42 = 3'h7 == off_reg ? refill_buffer_7 : _GEN_41; // @[Cache.scala 255:{33,33}]
  wire [63:0] _GEN_44 = 3'h1 == off_reg ? read[127:64] : read[63:0]; // @[Cache.scala 255:{33,33}]
  wire [63:0] _GEN_45 = 3'h2 == off_reg ? read[191:128] : _GEN_44; // @[Cache.scala 255:{33,33}]
  wire [63:0] _GEN_46 = 3'h3 == off_reg ? read[255:192] : _GEN_45; // @[Cache.scala 255:{33,33}]
  wire [63:0] _GEN_47 = 3'h4 == off_reg ? read[319:256] : _GEN_46; // @[Cache.scala 255:{33,33}]
  wire [63:0] _GEN_48 = 3'h5 == off_reg ? read[383:320] : _GEN_47; // @[Cache.scala 255:{33,33}]
  wire [63:0] _GEN_49 = 3'h6 == off_reg ? read[447:384] : _GEN_48; // @[Cache.scala 255:{33,33}]
  wire [63:0] _GEN_50 = 3'h7 == off_reg ? read[511:448] : _GEN_49; // @[Cache.scala 255:{33,33}]
  wire [2:0] _GEN_52 = 4'h1 == idx ? replace_1 : replace_0; // @[Mux.scala 81:{61,61}]
  wire [2:0] _GEN_53 = 4'h2 == idx ? replace_2 : _GEN_52; // @[Mux.scala 81:{61,61}]
  wire [2:0] _GEN_54 = 4'h3 == idx ? replace_3 : _GEN_53; // @[Mux.scala 81:{61,61}]
  wire [2:0] _GEN_55 = 4'h4 == idx ? replace_4 : _GEN_54; // @[Mux.scala 81:{61,61}]
  wire [2:0] _GEN_56 = 4'h5 == idx ? replace_5 : _GEN_55; // @[Mux.scala 81:{61,61}]
  wire [2:0] _GEN_57 = 4'h6 == idx ? replace_6 : _GEN_56; // @[Mux.scala 81:{61,61}]
  wire [2:0] _GEN_58 = 4'h7 == idx ? replace_7 : _GEN_57; // @[Mux.scala 81:{61,61}]
  wire [2:0] _GEN_59 = 4'h8 == idx ? replace_8 : _GEN_58; // @[Mux.scala 81:{61,61}]
  wire [2:0] _GEN_60 = 4'h9 == idx ? replace_9 : _GEN_59; // @[Mux.scala 81:{61,61}]
  wire [2:0] _GEN_61 = 4'ha == idx ? replace_10 : _GEN_60; // @[Mux.scala 81:{61,61}]
  wire [2:0] _GEN_62 = 4'hb == idx ? replace_11 : _GEN_61; // @[Mux.scala 81:{61,61}]
  wire [2:0] _GEN_63 = 4'hc == idx ? replace_12 : _GEN_62; // @[Mux.scala 81:{61,61}]
  wire [2:0] _GEN_64 = 4'hd == idx ? replace_13 : _GEN_63; // @[Mux.scala 81:{61,61}]
  wire [2:0] _GEN_65 = 4'he == idx ? replace_14 : _GEN_64; // @[Mux.scala 81:{61,61}]
  wire [2:0] _GEN_66 = 4'hf == idx ? replace_15 : _GEN_65; // @[Mux.scala 81:{61,61}]
  wire  _victim_T_5 = 3'h3 == _GEN_66 | 3'h2 == _GEN_66; // @[Mux.scala 81:58]
  wire [1:0] _victim_T_7 = 3'h4 == _GEN_66 ? 2'h2 : {{1'd0}, _victim_T_5}; // @[Mux.scala 81:58]
  wire [1:0] _victim_T_9 = 3'h5 == _GEN_66 ? 2'h3 : _victim_T_7; // @[Mux.scala 81:58]
  wire [1:0] _victim_T_11 = 3'h6 == _GEN_66 ? 2'h2 : _victim_T_9; // @[Mux.scala 81:58]
  wire [1:0] _victim_T_13 = 3'h7 == _GEN_66 ? 2'h3 : _victim_T_11; // @[Mux.scala 81:58]
  wire  _victim_T_15 = ~_GEN_34[0]; // @[Cache.scala 285:18]
  wire  _victim_T_17 = ~_GEN_34[1]; // @[Cache.scala 286:18]
  wire  _victim_T_19 = ~_GEN_34[2]; // @[Cache.scala 287:18]
  wire  _victim_T_21 = ~_GEN_34[3]; // @[Cache.scala 288:18]
  wire [1:0] _victim_T_22 = _victim_T_21 ? 2'h3 : _victim_T_13; // @[Mux.scala 101:16]
  wire [1:0] _victim_T_23 = _victim_T_19 ? 2'h2 : _victim_T_22; // @[Mux.scala 101:16]
  wire [3:0] _GEN_75 = 4'h1 == idx_reg ? valid_1 : valid_0; // @[Cache.scala 301:{30,30}]
  wire [3:0] _GEN_76 = 4'h2 == idx_reg ? valid_2 : _GEN_75; // @[Cache.scala 301:{30,30}]
  wire [3:0] _GEN_77 = 4'h3 == idx_reg ? valid_3 : _GEN_76; // @[Cache.scala 301:{30,30}]
  wire [3:0] _GEN_78 = 4'h4 == idx_reg ? valid_4 : _GEN_77; // @[Cache.scala 301:{30,30}]
  wire [3:0] _GEN_79 = 4'h5 == idx_reg ? valid_5 : _GEN_78; // @[Cache.scala 301:{30,30}]
  wire [3:0] _GEN_80 = 4'h6 == idx_reg ? valid_6 : _GEN_79; // @[Cache.scala 301:{30,30}]
  wire [3:0] _GEN_81 = 4'h7 == idx_reg ? valid_7 : _GEN_80; // @[Cache.scala 301:{30,30}]
  wire [3:0] _GEN_82 = 4'h8 == idx_reg ? valid_8 : _GEN_81; // @[Cache.scala 301:{30,30}]
  wire [3:0] _GEN_83 = 4'h9 == idx_reg ? valid_9 : _GEN_82; // @[Cache.scala 301:{30,30}]
  wire [3:0] _GEN_84 = 4'ha == idx_reg ? valid_10 : _GEN_83; // @[Cache.scala 301:{30,30}]
  wire [3:0] _GEN_85 = 4'hb == idx_reg ? valid_11 : _GEN_84; // @[Cache.scala 301:{30,30}]
  wire [3:0] _GEN_86 = 4'hc == idx_reg ? valid_12 : _GEN_85; // @[Cache.scala 301:{30,30}]
  wire [3:0] _GEN_87 = 4'hd == idx_reg ? valid_13 : _GEN_86; // @[Cache.scala 301:{30,30}]
  wire [3:0] _GEN_88 = 4'he == idx_reg ? valid_14 : _GEN_87; // @[Cache.scala 301:{30,30}]
  wire [3:0] _GEN_89 = 4'hf == idx_reg ? valid_15 : _GEN_88; // @[Cache.scala 301:{30,30}]
  wire [3:0] _GEN_91 = 4'h1 == idx_reg ? dirty_1 : dirty_0; // @[Cache.scala 301:{49,49}]
  wire [3:0] _GEN_92 = 4'h2 == idx_reg ? dirty_2 : _GEN_91; // @[Cache.scala 301:{49,49}]
  wire [3:0] _GEN_93 = 4'h3 == idx_reg ? dirty_3 : _GEN_92; // @[Cache.scala 301:{49,49}]
  wire [3:0] _GEN_94 = 4'h4 == idx_reg ? dirty_4 : _GEN_93; // @[Cache.scala 301:{49,49}]
  wire [3:0] _GEN_95 = 4'h5 == idx_reg ? dirty_5 : _GEN_94; // @[Cache.scala 301:{49,49}]
  wire [3:0] _GEN_96 = 4'h6 == idx_reg ? dirty_6 : _GEN_95; // @[Cache.scala 301:{49,49}]
  wire [3:0] _GEN_97 = 4'h7 == idx_reg ? dirty_7 : _GEN_96; // @[Cache.scala 301:{49,49}]
  wire [3:0] _GEN_98 = 4'h8 == idx_reg ? dirty_8 : _GEN_97; // @[Cache.scala 301:{49,49}]
  wire [3:0] _GEN_99 = 4'h9 == idx_reg ? dirty_9 : _GEN_98; // @[Cache.scala 301:{49,49}]
  wire [3:0] _GEN_100 = 4'ha == idx_reg ? dirty_10 : _GEN_99; // @[Cache.scala 301:{49,49}]
  wire [3:0] _GEN_101 = 4'hb == idx_reg ? dirty_11 : _GEN_100; // @[Cache.scala 301:{49,49}]
  wire [3:0] _GEN_102 = 4'hc == idx_reg ? dirty_12 : _GEN_101; // @[Cache.scala 301:{49,49}]
  wire [3:0] _GEN_103 = 4'hd == idx_reg ? dirty_13 : _GEN_102; // @[Cache.scala 301:{49,49}]
  wire [3:0] _GEN_104 = 4'he == idx_reg ? dirty_14 : _GEN_103; // @[Cache.scala 301:{49,49}]
  wire [3:0] _GEN_105 = 4'hf == idx_reg ? dirty_15 : _GEN_104; // @[Cache.scala 301:{49,49}]
  wire  dirty0 = _GEN_89[0] & _GEN_105[0]; // @[Cache.scala 301:34]
  wire  dirty1 = _GEN_89[1] & _GEN_105[1]; // @[Cache.scala 302:34]
  wire  dirty2 = _GEN_89[2] & _GEN_105[2]; // @[Cache.scala 303:34]
  wire  dirty3 = _GEN_89[3] & _GEN_105[3]; // @[Cache.scala 304:34]
  wire [7:0] hit_mask_0 = ~io_cpu_req_bits_mask[0] ? 8'h0 : 8'hff; // @[Cache.scala 315:12]
  wire [7:0] hit_mask_1 = ~io_cpu_req_bits_mask[1] ? 8'h0 : 8'hff; // @[Cache.scala 315:12]
  wire [7:0] hit_mask_2 = ~io_cpu_req_bits_mask[2] ? 8'h0 : 8'hff; // @[Cache.scala 315:12]
  wire [7:0] hit_mask_3 = ~io_cpu_req_bits_mask[3] ? 8'h0 : 8'hff; // @[Cache.scala 315:12]
  wire [7:0] hit_mask_4 = ~io_cpu_req_bits_mask[4] ? 8'h0 : 8'hff; // @[Cache.scala 315:12]
  wire [7:0] hit_mask_5 = ~io_cpu_req_bits_mask[5] ? 8'h0 : 8'hff; // @[Cache.scala 315:12]
  wire [7:0] hit_mask_6 = ~io_cpu_req_bits_mask[6] ? 8'h0 : 8'hff; // @[Cache.scala 315:12]
  wire [7:0] hit_mask_7 = ~io_cpu_req_bits_mask[7] ? 8'h0 : 8'hff; // @[Cache.scala 315:12]
  wire [7:0] aa_mask_0 = ~after_alloc_mask[0] ? 8'h0 : 8'hff; // @[Cache.scala 321:12]
  wire [7:0] aa_mask_1 = ~after_alloc_mask[1] ? 8'h0 : 8'hff; // @[Cache.scala 321:12]
  wire [7:0] aa_mask_2 = ~after_alloc_mask[2] ? 8'h0 : 8'hff; // @[Cache.scala 321:12]
  wire [7:0] aa_mask_3 = ~after_alloc_mask[3] ? 8'h0 : 8'hff; // @[Cache.scala 321:12]
  wire [7:0] aa_mask_4 = ~after_alloc_mask[4] ? 8'h0 : 8'hff; // @[Cache.scala 321:12]
  wire [7:0] aa_mask_5 = ~after_alloc_mask[5] ? 8'h0 : 8'hff; // @[Cache.scala 321:12]
  wire [7:0] aa_mask_6 = ~after_alloc_mask[6] ? 8'h0 : 8'hff; // @[Cache.scala 321:12]
  wire [7:0] aa_mask_7 = ~after_alloc_mask[7] ? 8'h0 : 8'hff; // @[Cache.scala 321:12]
  wire [63:0] _wmask_T = {hit_mask_7,hit_mask_6,hit_mask_5,hit_mask_4,hit_mask_3,hit_mask_2,hit_mask_1,hit_mask_0}; // @[Cat.scala 33:92]
  wire [8:0] _wmask_T_1 = {off,6'h0}; // @[Cat.scala 33:92]
  wire [574:0] _GEN_0 = {{511'd0}, _wmask_T}; // @[Cache.scala 334:43]
  wire [574:0] _wmask_T_2 = _GEN_0 << _wmask_T_1; // @[Cache.scala 334:43]
  wire [575:0] _wmask_T_3 = {1'b0,$signed(_wmask_T_2)}; // @[Cache.scala 334:66]
  wire [575:0] _wmask_T_5 = ~_wmask_T_3; // @[Cache.scala 334:18]
  wire [63:0] _wmask_T_6 = {aa_mask_7,aa_mask_6,aa_mask_5,aa_mask_4,aa_mask_3,aa_mask_2,aa_mask_1,aa_mask_0}; // @[Cat.scala 33:92]
  wire [8:0] _wmask_T_7 = {off_reg,6'h0}; // @[Cat.scala 33:92]
  wire [574:0] _GEN_19 = {{511'd0}, _wmask_T_6}; // @[Cache.scala 337:37]
  wire [574:0] _wmask_T_8 = _GEN_19 << _wmask_T_7; // @[Cache.scala 337:37]
  wire [575:0] _wmask_T_9 = {1'b0,$signed(_wmask_T_8)}; // @[Cache.scala 337:64]
  wire [575:0] _wmask_T_11 = ~_wmask_T_9; // @[Cache.scala 337:13]
  wire [575:0] _wmask_T_12 = is_alloc ? $signed(576'sh0) : $signed(_wmask_T_11); // @[Cache.scala 335:12]
  wire [575:0] wmask = is_idle ? $signed(_wmask_T_5) : $signed(_wmask_T_12); // @[Cache.scala 333:20]
  wire [511:0] _wdata_T_2 = {io_cpu_req_bits_data,io_cpu_req_bits_data,io_cpu_req_bits_data,io_cpu_req_bits_data,
    io_cpu_req_bits_data,io_cpu_req_bits_data,io_cpu_req_bits_data,io_cpu_req_bits_data}; // @[Cat.scala 33:92]
  wire [511:0] _wdata_T_4 = {io_axi_resp_bits_data,refill_buffer_6,refill_buffer_5,refill_buffer_4,refill_buffer_3,
    refill_buffer_2,refill_buffer_1,refill_buffer_0}; // @[Cat.scala 33:92]
  wire [511:0] _wdata_T_7 = {cpu_data,cpu_data,cpu_data,cpu_data,cpu_data,cpu_data,cpu_data,cpu_data}; // @[Cat.scala 33:92]
  wire [511:0] _wdata_T_8 = is_alloc ? _wdata_T_4 : _wdata_T_7; // @[Cache.scala 345:12]
  wire [511:0] wdata = is_idle ? _wdata_T_2 : _wdata_T_8; // @[Cache.scala 343:20]
  wire [2:0] _replace_T_1 = {2'h3,_GEN_66[0]}; // @[Cat.scala 33:92]
  wire [2:0] _replace_T_3 = {2'h2,_GEN_66[0]}; // @[Cat.scala 33:92]
  wire [2:0] _replace_T_5 = {1'h0,_GEN_66[1],1'h1}; // @[Cat.scala 33:92]
  wire [2:0] _replace_T_7 = {1'h0,_GEN_66[1],1'h0}; // @[Cat.scala 33:92]
  wire [2:0] _replace_T_8 = hit3 ? _replace_T_7 : 3'h0; // @[Mux.scala 101:16]
  wire [2:0] _replace_T_9 = hit2 ? _replace_T_5 : _replace_T_8; // @[Mux.scala 101:16]
  wire [2:0] _replace_T_10 = hit1 ? _replace_T_3 : _replace_T_9; // @[Mux.scala 101:16]
  wire [2:0] _replace_T_11 = hit0 ? _replace_T_1 : _replace_T_10; // @[Mux.scala 101:16]
  wire [2:0] _GEN_106 = 4'h0 == idx ? _replace_T_11 : replace_0; // @[Cache.scala 354:{22,22} 125:26]
  wire [2:0] _GEN_107 = 4'h1 == idx ? _replace_T_11 : replace_1; // @[Cache.scala 354:{22,22} 125:26]
  wire [2:0] _GEN_108 = 4'h2 == idx ? _replace_T_11 : replace_2; // @[Cache.scala 354:{22,22} 125:26]
  wire [2:0] _GEN_109 = 4'h3 == idx ? _replace_T_11 : replace_3; // @[Cache.scala 354:{22,22} 125:26]
  wire [2:0] _GEN_110 = 4'h4 == idx ? _replace_T_11 : replace_4; // @[Cache.scala 354:{22,22} 125:26]
  wire [2:0] _GEN_111 = 4'h5 == idx ? _replace_T_11 : replace_5; // @[Cache.scala 354:{22,22} 125:26]
  wire [2:0] _GEN_112 = 4'h6 == idx ? _replace_T_11 : replace_6; // @[Cache.scala 354:{22,22} 125:26]
  wire [2:0] _GEN_113 = 4'h7 == idx ? _replace_T_11 : replace_7; // @[Cache.scala 354:{22,22} 125:26]
  wire [2:0] _GEN_114 = 4'h8 == idx ? _replace_T_11 : replace_8; // @[Cache.scala 354:{22,22} 125:26]
  wire [2:0] _GEN_115 = 4'h9 == idx ? _replace_T_11 : replace_9; // @[Cache.scala 354:{22,22} 125:26]
  wire [2:0] _GEN_116 = 4'ha == idx ? _replace_T_11 : replace_10; // @[Cache.scala 354:{22,22} 125:26]
  wire [2:0] _GEN_117 = 4'hb == idx ? _replace_T_11 : replace_11; // @[Cache.scala 354:{22,22} 125:26]
  wire [2:0] _GEN_118 = 4'hc == idx ? _replace_T_11 : replace_12; // @[Cache.scala 354:{22,22} 125:26]
  wire [2:0] _GEN_119 = 4'hd == idx ? _replace_T_11 : replace_13; // @[Cache.scala 354:{22,22} 125:26]
  wire [2:0] _GEN_120 = 4'he == idx ? _replace_T_11 : replace_14; // @[Cache.scala 354:{22,22} 125:26]
  wire [2:0] _GEN_121 = 4'hf == idx ? _replace_T_11 : replace_15; // @[Cache.scala 354:{22,22} 125:26]
  wire [2:0] _GEN_122 = hit ? _GEN_106 : replace_0; // @[Cache.scala 353:14 125:26]
  wire [2:0] _GEN_123 = hit ? _GEN_107 : replace_1; // @[Cache.scala 353:14 125:26]
  wire [2:0] _GEN_124 = hit ? _GEN_108 : replace_2; // @[Cache.scala 353:14 125:26]
  wire [2:0] _GEN_125 = hit ? _GEN_109 : replace_3; // @[Cache.scala 353:14 125:26]
  wire [2:0] _GEN_126 = hit ? _GEN_110 : replace_4; // @[Cache.scala 353:14 125:26]
  wire [2:0] _GEN_127 = hit ? _GEN_111 : replace_5; // @[Cache.scala 353:14 125:26]
  wire [2:0] _GEN_128 = hit ? _GEN_112 : replace_6; // @[Cache.scala 353:14 125:26]
  wire [2:0] _GEN_129 = hit ? _GEN_113 : replace_7; // @[Cache.scala 353:14 125:26]
  wire [2:0] _GEN_130 = hit ? _GEN_114 : replace_8; // @[Cache.scala 353:14 125:26]
  wire [2:0] _GEN_131 = hit ? _GEN_115 : replace_9; // @[Cache.scala 353:14 125:26]
  wire [2:0] _GEN_132 = hit ? _GEN_116 : replace_10; // @[Cache.scala 353:14 125:26]
  wire [2:0] _GEN_133 = hit ? _GEN_117 : replace_11; // @[Cache.scala 353:14 125:26]
  wire [2:0] _GEN_134 = hit ? _GEN_118 : replace_12; // @[Cache.scala 353:14 125:26]
  wire [2:0] _GEN_135 = hit ? _GEN_119 : replace_13; // @[Cache.scala 353:14 125:26]
  wire [2:0] _GEN_136 = hit ? _GEN_120 : replace_14; // @[Cache.scala 353:14 125:26]
  wire [2:0] _GEN_137 = hit ? _GEN_121 : replace_15; // @[Cache.scala 353:14 125:26]
  wire [3:0] _GEN_139 = 4'h1 == idx ? dirty_1 : dirty_0; // @[Cache.scala 408:{46,46}]
  wire [3:0] _GEN_140 = 4'h2 == idx ? dirty_2 : _GEN_139; // @[Cache.scala 408:{46,46}]
  wire [3:0] _GEN_141 = 4'h3 == idx ? dirty_3 : _GEN_140; // @[Cache.scala 408:{46,46}]
  wire [3:0] _GEN_142 = 4'h4 == idx ? dirty_4 : _GEN_141; // @[Cache.scala 408:{46,46}]
  wire [3:0] _GEN_143 = 4'h5 == idx ? dirty_5 : _GEN_142; // @[Cache.scala 408:{46,46}]
  wire [3:0] _GEN_144 = 4'h6 == idx ? dirty_6 : _GEN_143; // @[Cache.scala 408:{46,46}]
  wire [3:0] _GEN_145 = 4'h7 == idx ? dirty_7 : _GEN_144; // @[Cache.scala 408:{46,46}]
  wire [3:0] _GEN_146 = 4'h8 == idx ? dirty_8 : _GEN_145; // @[Cache.scala 408:{46,46}]
  wire [3:0] _GEN_147 = 4'h9 == idx ? dirty_9 : _GEN_146; // @[Cache.scala 408:{46,46}]
  wire [3:0] _GEN_148 = 4'ha == idx ? dirty_10 : _GEN_147; // @[Cache.scala 408:{46,46}]
  wire [3:0] _GEN_149 = 4'hb == idx ? dirty_11 : _GEN_148; // @[Cache.scala 408:{46,46}]
  wire [3:0] _GEN_150 = 4'hc == idx ? dirty_12 : _GEN_149; // @[Cache.scala 408:{46,46}]
  wire [3:0] _GEN_151 = 4'hd == idx ? dirty_13 : _GEN_150; // @[Cache.scala 408:{46,46}]
  wire [3:0] _GEN_152 = 4'he == idx ? dirty_14 : _GEN_151; // @[Cache.scala 408:{46,46}]
  wire [3:0] _GEN_153 = 4'hf == idx ? dirty_15 : _GEN_152; // @[Cache.scala 408:{46,46}]
  wire [3:0] _dirty_T_1 = _GEN_153 | 4'h1; // @[Cache.scala 408:46]
  wire [3:0] _dirty_T_7 = _GEN_153 | 4'h2; // @[Cache.scala 409:46]
  wire [3:0] _dirty_T_13 = _GEN_153 | 4'h4; // @[Cache.scala 410:46]
  wire [3:0] _dirty_T_19 = _GEN_153 | 4'h8; // @[Cache.scala 411:46]
  wire [3:0] _dirty_T_24 = hit3 ? _dirty_T_19 : _GEN_153; // @[Mux.scala 101:16]
  wire [3:0] _dirty_T_25 = hit2 ? _dirty_T_13 : _dirty_T_24; // @[Mux.scala 101:16]
  wire [3:0] _dirty_T_26 = hit1 ? _dirty_T_7 : _dirty_T_25; // @[Mux.scala 101:16]
  wire [3:0] _dirty_T_27 = hit0 ? _dirty_T_1 : _dirty_T_26; // @[Mux.scala 101:16]
  wire [3:0] _dirty_T_29 = _GEN_105 | 4'h1; // @[Cache.scala 417:49]
  wire [3:0] _dirty_T_35 = _GEN_105 | 4'h2; // @[Cache.scala 418:49]
  wire [3:0] _dirty_T_41 = _GEN_105 | 4'h4; // @[Cache.scala 419:49]
  wire [3:0] _dirty_T_47 = _GEN_105 | 4'h8; // @[Cache.scala 420:49]
  wire  _dirty_T_52 = 2'h1 == victim; // @[Mux.scala 81:61]
  wire [3:0] _dirty_T_53 = 2'h1 == victim ? _dirty_T_35 : _dirty_T_29; // @[Mux.scala 81:58]
  wire  _dirty_T_54 = 2'h2 == victim; // @[Mux.scala 81:61]
  wire [3:0] _dirty_T_55 = 2'h2 == victim ? _dirty_T_41 : _dirty_T_53; // @[Mux.scala 81:58]
  wire  _dirty_T_56 = 2'h3 == victim; // @[Mux.scala 81:61]
  wire [3:0] _dirty_T_57 = 2'h3 == victim ? _dirty_T_47 : _dirty_T_55; // @[Mux.scala 81:58]
  wire [3:0] _GEN_170 = 4'h0 == idx_reg ? _dirty_T_57 : dirty_0; // @[Cache.scala 122:24 415:{28,28}]
  wire [3:0] _GEN_171 = 4'h1 == idx_reg ? _dirty_T_57 : dirty_1; // @[Cache.scala 122:24 415:{28,28}]
  wire [3:0] _GEN_172 = 4'h2 == idx_reg ? _dirty_T_57 : dirty_2; // @[Cache.scala 122:24 415:{28,28}]
  wire [3:0] _GEN_173 = 4'h3 == idx_reg ? _dirty_T_57 : dirty_3; // @[Cache.scala 122:24 415:{28,28}]
  wire [3:0] _GEN_174 = 4'h4 == idx_reg ? _dirty_T_57 : dirty_4; // @[Cache.scala 122:24 415:{28,28}]
  wire [3:0] _GEN_175 = 4'h5 == idx_reg ? _dirty_T_57 : dirty_5; // @[Cache.scala 122:24 415:{28,28}]
  wire [3:0] _GEN_176 = 4'h6 == idx_reg ? _dirty_T_57 : dirty_6; // @[Cache.scala 122:24 415:{28,28}]
  wire [3:0] _GEN_177 = 4'h7 == idx_reg ? _dirty_T_57 : dirty_7; // @[Cache.scala 122:24 415:{28,28}]
  wire [3:0] _GEN_178 = 4'h8 == idx_reg ? _dirty_T_57 : dirty_8; // @[Cache.scala 122:24 415:{28,28}]
  wire [3:0] _GEN_179 = 4'h9 == idx_reg ? _dirty_T_57 : dirty_9; // @[Cache.scala 122:24 415:{28,28}]
  wire [3:0] _GEN_180 = 4'ha == idx_reg ? _dirty_T_57 : dirty_10; // @[Cache.scala 122:24 415:{28,28}]
  wire [3:0] _GEN_181 = 4'hb == idx_reg ? _dirty_T_57 : dirty_11; // @[Cache.scala 122:24 415:{28,28}]
  wire [3:0] _GEN_182 = 4'hc == idx_reg ? _dirty_T_57 : dirty_12; // @[Cache.scala 122:24 415:{28,28}]
  wire [3:0] _GEN_183 = 4'hd == idx_reg ? _dirty_T_57 : dirty_13; // @[Cache.scala 122:24 415:{28,28}]
  wire [3:0] _GEN_184 = 4'he == idx_reg ? _dirty_T_57 : dirty_14; // @[Cache.scala 122:24 415:{28,28}]
  wire [3:0] _GEN_185 = 4'hf == idx_reg ? _dirty_T_57 : dirty_15; // @[Cache.scala 122:24 415:{28,28}]
  wire [3:0] _valid_T_1 = _GEN_89 | 4'h1; // @[Cache.scala 427:49]
  wire [3:0] _valid_T_7 = _GEN_89 | 4'h2; // @[Cache.scala 428:49]
  wire [3:0] _valid_T_13 = _GEN_89 | 4'h4; // @[Cache.scala 429:49]
  wire [3:0] _valid_T_19 = _GEN_89 | 4'h8; // @[Cache.scala 430:49]
  wire [3:0] _valid_T_25 = 2'h1 == victim ? _valid_T_7 : _valid_T_1; // @[Mux.scala 81:58]
  wire [3:0] _valid_T_27 = 2'h2 == victim ? _valid_T_13 : _valid_T_25; // @[Mux.scala 81:58]
  wire [3:0] _valid_T_29 = 2'h3 == victim ? _valid_T_19 : _valid_T_27; // @[Mux.scala 81:58]
  wire [3:0] _GEN_186 = 4'h0 == idx_reg ? _valid_T_29 : valid_0; // @[Cache.scala 121:24 425:{28,28}]
  wire [3:0] _GEN_187 = 4'h1 == idx_reg ? _valid_T_29 : valid_1; // @[Cache.scala 121:24 425:{28,28}]
  wire [3:0] _GEN_188 = 4'h2 == idx_reg ? _valid_T_29 : valid_2; // @[Cache.scala 121:24 425:{28,28}]
  wire [3:0] _GEN_189 = 4'h3 == idx_reg ? _valid_T_29 : valid_3; // @[Cache.scala 121:24 425:{28,28}]
  wire [3:0] _GEN_190 = 4'h4 == idx_reg ? _valid_T_29 : valid_4; // @[Cache.scala 121:24 425:{28,28}]
  wire [3:0] _GEN_191 = 4'h5 == idx_reg ? _valid_T_29 : valid_5; // @[Cache.scala 121:24 425:{28,28}]
  wire [3:0] _GEN_192 = 4'h6 == idx_reg ? _valid_T_29 : valid_6; // @[Cache.scala 121:24 425:{28,28}]
  wire [3:0] _GEN_193 = 4'h7 == idx_reg ? _valid_T_29 : valid_7; // @[Cache.scala 121:24 425:{28,28}]
  wire [3:0] _GEN_194 = 4'h8 == idx_reg ? _valid_T_29 : valid_8; // @[Cache.scala 121:24 425:{28,28}]
  wire [3:0] _GEN_195 = 4'h9 == idx_reg ? _valid_T_29 : valid_9; // @[Cache.scala 121:24 425:{28,28}]
  wire [3:0] _GEN_196 = 4'ha == idx_reg ? _valid_T_29 : valid_10; // @[Cache.scala 121:24 425:{28,28}]
  wire [3:0] _GEN_197 = 4'hb == idx_reg ? _valid_T_29 : valid_11; // @[Cache.scala 121:24 425:{28,28}]
  wire [3:0] _GEN_198 = 4'hc == idx_reg ? _valid_T_29 : valid_12; // @[Cache.scala 121:24 425:{28,28}]
  wire [3:0] _GEN_199 = 4'hd == idx_reg ? _valid_T_29 : valid_13; // @[Cache.scala 121:24 425:{28,28}]
  wire [3:0] _GEN_200 = 4'he == idx_reg ? _valid_T_29 : valid_14; // @[Cache.scala 121:24 425:{28,28}]
  wire [3:0] _GEN_201 = 4'hf == idx_reg ? _valid_T_29 : valid_15; // @[Cache.scala 121:24 425:{28,28}]
  wire [2:0] _GEN_219 = 4'h1 == idx_reg ? replace_1 : replace_0; // @[Cache.scala 445:{58,58}]
  wire [2:0] _GEN_220 = 4'h2 == idx_reg ? replace_2 : _GEN_219; // @[Cache.scala 445:{58,58}]
  wire [2:0] _GEN_221 = 4'h3 == idx_reg ? replace_3 : _GEN_220; // @[Cache.scala 445:{58,58}]
  wire [2:0] _GEN_222 = 4'h4 == idx_reg ? replace_4 : _GEN_221; // @[Cache.scala 445:{58,58}]
  wire [2:0] _GEN_223 = 4'h5 == idx_reg ? replace_5 : _GEN_222; // @[Cache.scala 445:{58,58}]
  wire [2:0] _GEN_224 = 4'h6 == idx_reg ? replace_6 : _GEN_223; // @[Cache.scala 445:{58,58}]
  wire [2:0] _GEN_225 = 4'h7 == idx_reg ? replace_7 : _GEN_224; // @[Cache.scala 445:{58,58}]
  wire [2:0] _GEN_226 = 4'h8 == idx_reg ? replace_8 : _GEN_225; // @[Cache.scala 445:{58,58}]
  wire [2:0] _GEN_227 = 4'h9 == idx_reg ? replace_9 : _GEN_226; // @[Cache.scala 445:{58,58}]
  wire [2:0] _GEN_228 = 4'ha == idx_reg ? replace_10 : _GEN_227; // @[Cache.scala 445:{58,58}]
  wire [2:0] _GEN_229 = 4'hb == idx_reg ? replace_11 : _GEN_228; // @[Cache.scala 445:{58,58}]
  wire [2:0] _GEN_230 = 4'hc == idx_reg ? replace_12 : _GEN_229; // @[Cache.scala 445:{58,58}]
  wire [2:0] _GEN_231 = 4'hd == idx_reg ? replace_13 : _GEN_230; // @[Cache.scala 445:{58,58}]
  wire [2:0] _GEN_232 = 4'he == idx_reg ? replace_14 : _GEN_231; // @[Cache.scala 445:{58,58}]
  wire [2:0] _GEN_233 = 4'hf == idx_reg ? replace_15 : _GEN_232; // @[Cache.scala 445:{58,58}]
  wire [2:0] _replace_T_13 = {2'h3,_GEN_233[0]}; // @[Cat.scala 33:92]
  wire [2:0] _replace_T_15 = {2'h2,_GEN_233[0]}; // @[Cat.scala 33:92]
  wire [2:0] _replace_T_17 = {1'h0,_GEN_233[1],1'h1}; // @[Cat.scala 33:92]
  wire [2:0] _replace_T_19 = {1'h0,_GEN_233[1],1'h0}; // @[Cat.scala 33:92]
  wire [2:0] _replace_T_21 = 2'h1 == victim ? _replace_T_15 : _replace_T_13; // @[Mux.scala 81:58]
  wire [2:0] _replace_T_23 = 2'h2 == victim ? _replace_T_17 : _replace_T_21; // @[Mux.scala 81:58]
  wire [2:0] _replace_T_25 = 2'h3 == victim ? _replace_T_19 : _replace_T_23; // @[Mux.scala 81:58]
  wire [2:0] _GEN_234 = 4'h0 == idx_reg ? _replace_T_25 : _GEN_122; // @[Cache.scala 443:{30,30}]
  wire [2:0] _GEN_235 = 4'h1 == idx_reg ? _replace_T_25 : _GEN_123; // @[Cache.scala 443:{30,30}]
  wire [2:0] _GEN_236 = 4'h2 == idx_reg ? _replace_T_25 : _GEN_124; // @[Cache.scala 443:{30,30}]
  wire [2:0] _GEN_237 = 4'h3 == idx_reg ? _replace_T_25 : _GEN_125; // @[Cache.scala 443:{30,30}]
  wire [2:0] _GEN_238 = 4'h4 == idx_reg ? _replace_T_25 : _GEN_126; // @[Cache.scala 443:{30,30}]
  wire [2:0] _GEN_239 = 4'h5 == idx_reg ? _replace_T_25 : _GEN_127; // @[Cache.scala 443:{30,30}]
  wire [2:0] _GEN_240 = 4'h6 == idx_reg ? _replace_T_25 : _GEN_128; // @[Cache.scala 443:{30,30}]
  wire [2:0] _GEN_241 = 4'h7 == idx_reg ? _replace_T_25 : _GEN_129; // @[Cache.scala 443:{30,30}]
  wire [2:0] _GEN_242 = 4'h8 == idx_reg ? _replace_T_25 : _GEN_130; // @[Cache.scala 443:{30,30}]
  wire [2:0] _GEN_243 = 4'h9 == idx_reg ? _replace_T_25 : _GEN_131; // @[Cache.scala 443:{30,30}]
  wire [2:0] _GEN_244 = 4'ha == idx_reg ? _replace_T_25 : _GEN_132; // @[Cache.scala 443:{30,30}]
  wire [2:0] _GEN_245 = 4'hb == idx_reg ? _replace_T_25 : _GEN_133; // @[Cache.scala 443:{30,30}]
  wire [2:0] _GEN_246 = 4'hc == idx_reg ? _replace_T_25 : _GEN_134; // @[Cache.scala 443:{30,30}]
  wire [2:0] _GEN_247 = 4'hd == idx_reg ? _replace_T_25 : _GEN_135; // @[Cache.scala 443:{30,30}]
  wire [2:0] _GEN_248 = 4'he == idx_reg ? _replace_T_25 : _GEN_136; // @[Cache.scala 443:{30,30}]
  wire [2:0] _GEN_249 = 4'hf == idx_reg ? _replace_T_25 : _GEN_137; // @[Cache.scala 443:{30,30}]
  wire [87:0] _GEN_251 = 4'h1 == idx_reg ? TagArray_1 : TagArray_0; // @[Cache.scala 455:{49,49}]
  wire [87:0] _GEN_252 = 4'h2 == idx_reg ? TagArray_2 : _GEN_251; // @[Cache.scala 455:{49,49}]
  wire [87:0] _GEN_253 = 4'h3 == idx_reg ? TagArray_3 : _GEN_252; // @[Cache.scala 455:{49,49}]
  wire [87:0] _GEN_254 = 4'h4 == idx_reg ? TagArray_4 : _GEN_253; // @[Cache.scala 455:{49,49}]
  wire [87:0] _GEN_255 = 4'h5 == idx_reg ? TagArray_5 : _GEN_254; // @[Cache.scala 455:{49,49}]
  wire [87:0] _GEN_256 = 4'h6 == idx_reg ? TagArray_6 : _GEN_255; // @[Cache.scala 455:{49,49}]
  wire [87:0] _GEN_257 = 4'h7 == idx_reg ? TagArray_7 : _GEN_256; // @[Cache.scala 455:{49,49}]
  wire [87:0] _GEN_258 = 4'h8 == idx_reg ? TagArray_8 : _GEN_257; // @[Cache.scala 455:{49,49}]
  wire [87:0] _GEN_259 = 4'h9 == idx_reg ? TagArray_9 : _GEN_258; // @[Cache.scala 455:{49,49}]
  wire [87:0] _GEN_260 = 4'ha == idx_reg ? TagArray_10 : _GEN_259; // @[Cache.scala 455:{49,49}]
  wire [87:0] _GEN_261 = 4'hb == idx_reg ? TagArray_11 : _GEN_260; // @[Cache.scala 455:{49,49}]
  wire [87:0] _GEN_262 = 4'hc == idx_reg ? TagArray_12 : _GEN_261; // @[Cache.scala 455:{49,49}]
  wire [87:0] _GEN_263 = 4'hd == idx_reg ? TagArray_13 : _GEN_262; // @[Cache.scala 455:{49,49}]
  wire [87:0] _GEN_264 = 4'he == idx_reg ? TagArray_14 : _GEN_263; // @[Cache.scala 455:{49,49}]
  wire [87:0] _GEN_265 = 4'hf == idx_reg ? TagArray_15 : _GEN_264; // @[Cache.scala 455:{49,49}]
  wire [87:0] _TagArray_T_1 = {_GEN_265[87:22],tag_reg}; // @[Cat.scala 33:92]
  wire [87:0] _GEN_266 = 4'h0 == idx_reg ? _TagArray_T_1 : TagArray_0; // @[Cache.scala 132:27 455:{32,32}]
  wire [87:0] _GEN_267 = 4'h1 == idx_reg ? _TagArray_T_1 : TagArray_1; // @[Cache.scala 132:27 455:{32,32}]
  wire [87:0] _GEN_268 = 4'h2 == idx_reg ? _TagArray_T_1 : TagArray_2; // @[Cache.scala 132:27 455:{32,32}]
  wire [87:0] _GEN_269 = 4'h3 == idx_reg ? _TagArray_T_1 : TagArray_3; // @[Cache.scala 132:27 455:{32,32}]
  wire [87:0] _GEN_270 = 4'h4 == idx_reg ? _TagArray_T_1 : TagArray_4; // @[Cache.scala 132:27 455:{32,32}]
  wire [87:0] _GEN_271 = 4'h5 == idx_reg ? _TagArray_T_1 : TagArray_5; // @[Cache.scala 132:27 455:{32,32}]
  wire [87:0] _GEN_272 = 4'h6 == idx_reg ? _TagArray_T_1 : TagArray_6; // @[Cache.scala 132:27 455:{32,32}]
  wire [87:0] _GEN_273 = 4'h7 == idx_reg ? _TagArray_T_1 : TagArray_7; // @[Cache.scala 132:27 455:{32,32}]
  wire [87:0] _GEN_274 = 4'h8 == idx_reg ? _TagArray_T_1 : TagArray_8; // @[Cache.scala 132:27 455:{32,32}]
  wire [87:0] _GEN_275 = 4'h9 == idx_reg ? _TagArray_T_1 : TagArray_9; // @[Cache.scala 132:27 455:{32,32}]
  wire [87:0] _GEN_276 = 4'ha == idx_reg ? _TagArray_T_1 : TagArray_10; // @[Cache.scala 132:27 455:{32,32}]
  wire [87:0] _GEN_277 = 4'hb == idx_reg ? _TagArray_T_1 : TagArray_11; // @[Cache.scala 132:27 455:{32,32}]
  wire [87:0] _GEN_278 = 4'hc == idx_reg ? _TagArray_T_1 : TagArray_12; // @[Cache.scala 132:27 455:{32,32}]
  wire [87:0] _GEN_279 = 4'hd == idx_reg ? _TagArray_T_1 : TagArray_13; // @[Cache.scala 132:27 455:{32,32}]
  wire [87:0] _GEN_280 = 4'he == idx_reg ? _TagArray_T_1 : TagArray_14; // @[Cache.scala 132:27 455:{32,32}]
  wire [87:0] _GEN_281 = 4'hf == idx_reg ? _TagArray_T_1 : TagArray_15; // @[Cache.scala 132:27 455:{32,32}]
  wire [87:0] _TagArray_T_4 = {_GEN_265[87:44],tag_reg,_GEN_265[21:0]}; // @[Cat.scala 33:92]
  wire [87:0] _GEN_282 = 4'h0 == idx_reg ? _TagArray_T_4 : TagArray_0; // @[Cache.scala 132:27 458:{32,32}]
  wire [87:0] _GEN_283 = 4'h1 == idx_reg ? _TagArray_T_4 : TagArray_1; // @[Cache.scala 132:27 458:{32,32}]
  wire [87:0] _GEN_284 = 4'h2 == idx_reg ? _TagArray_T_4 : TagArray_2; // @[Cache.scala 132:27 458:{32,32}]
  wire [87:0] _GEN_285 = 4'h3 == idx_reg ? _TagArray_T_4 : TagArray_3; // @[Cache.scala 132:27 458:{32,32}]
  wire [87:0] _GEN_286 = 4'h4 == idx_reg ? _TagArray_T_4 : TagArray_4; // @[Cache.scala 132:27 458:{32,32}]
  wire [87:0] _GEN_287 = 4'h5 == idx_reg ? _TagArray_T_4 : TagArray_5; // @[Cache.scala 132:27 458:{32,32}]
  wire [87:0] _GEN_288 = 4'h6 == idx_reg ? _TagArray_T_4 : TagArray_6; // @[Cache.scala 132:27 458:{32,32}]
  wire [87:0] _GEN_289 = 4'h7 == idx_reg ? _TagArray_T_4 : TagArray_7; // @[Cache.scala 132:27 458:{32,32}]
  wire [87:0] _GEN_290 = 4'h8 == idx_reg ? _TagArray_T_4 : TagArray_8; // @[Cache.scala 132:27 458:{32,32}]
  wire [87:0] _GEN_291 = 4'h9 == idx_reg ? _TagArray_T_4 : TagArray_9; // @[Cache.scala 132:27 458:{32,32}]
  wire [87:0] _GEN_292 = 4'ha == idx_reg ? _TagArray_T_4 : TagArray_10; // @[Cache.scala 132:27 458:{32,32}]
  wire [87:0] _GEN_293 = 4'hb == idx_reg ? _TagArray_T_4 : TagArray_11; // @[Cache.scala 132:27 458:{32,32}]
  wire [87:0] _GEN_294 = 4'hc == idx_reg ? _TagArray_T_4 : TagArray_12; // @[Cache.scala 132:27 458:{32,32}]
  wire [87:0] _GEN_295 = 4'hd == idx_reg ? _TagArray_T_4 : TagArray_13; // @[Cache.scala 132:27 458:{32,32}]
  wire [87:0] _GEN_296 = 4'he == idx_reg ? _TagArray_T_4 : TagArray_14; // @[Cache.scala 132:27 458:{32,32}]
  wire [87:0] _GEN_297 = 4'hf == idx_reg ? _TagArray_T_4 : TagArray_15; // @[Cache.scala 132:27 458:{32,32}]
  wire [87:0] _TagArray_T_7 = {_GEN_265[87:66],tag_reg,_GEN_265[43:0]}; // @[Cat.scala 33:92]
  wire [87:0] _GEN_298 = 4'h0 == idx_reg ? _TagArray_T_7 : TagArray_0; // @[Cache.scala 132:27 461:{32,32}]
  wire [87:0] _GEN_299 = 4'h1 == idx_reg ? _TagArray_T_7 : TagArray_1; // @[Cache.scala 132:27 461:{32,32}]
  wire [87:0] _GEN_300 = 4'h2 == idx_reg ? _TagArray_T_7 : TagArray_2; // @[Cache.scala 132:27 461:{32,32}]
  wire [87:0] _GEN_301 = 4'h3 == idx_reg ? _TagArray_T_7 : TagArray_3; // @[Cache.scala 132:27 461:{32,32}]
  wire [87:0] _GEN_302 = 4'h4 == idx_reg ? _TagArray_T_7 : TagArray_4; // @[Cache.scala 132:27 461:{32,32}]
  wire [87:0] _GEN_303 = 4'h5 == idx_reg ? _TagArray_T_7 : TagArray_5; // @[Cache.scala 132:27 461:{32,32}]
  wire [87:0] _GEN_304 = 4'h6 == idx_reg ? _TagArray_T_7 : TagArray_6; // @[Cache.scala 132:27 461:{32,32}]
  wire [87:0] _GEN_305 = 4'h7 == idx_reg ? _TagArray_T_7 : TagArray_7; // @[Cache.scala 132:27 461:{32,32}]
  wire [87:0] _GEN_306 = 4'h8 == idx_reg ? _TagArray_T_7 : TagArray_8; // @[Cache.scala 132:27 461:{32,32}]
  wire [87:0] _GEN_307 = 4'h9 == idx_reg ? _TagArray_T_7 : TagArray_9; // @[Cache.scala 132:27 461:{32,32}]
  wire [87:0] _GEN_308 = 4'ha == idx_reg ? _TagArray_T_7 : TagArray_10; // @[Cache.scala 132:27 461:{32,32}]
  wire [87:0] _GEN_309 = 4'hb == idx_reg ? _TagArray_T_7 : TagArray_11; // @[Cache.scala 132:27 461:{32,32}]
  wire [87:0] _GEN_310 = 4'hc == idx_reg ? _TagArray_T_7 : TagArray_12; // @[Cache.scala 132:27 461:{32,32}]
  wire [87:0] _GEN_311 = 4'hd == idx_reg ? _TagArray_T_7 : TagArray_13; // @[Cache.scala 132:27 461:{32,32}]
  wire [87:0] _GEN_312 = 4'he == idx_reg ? _TagArray_T_7 : TagArray_14; // @[Cache.scala 132:27 461:{32,32}]
  wire [87:0] _GEN_313 = 4'hf == idx_reg ? _TagArray_T_7 : TagArray_15; // @[Cache.scala 132:27 461:{32,32}]
  wire [87:0] _TagArray_T_9 = {tag_reg,_GEN_265[65:0]}; // @[Cat.scala 33:92]
  wire [87:0] _GEN_314 = 4'h0 == idx_reg ? _TagArray_T_9 : TagArray_0; // @[Cache.scala 132:27 464:{32,32}]
  wire [87:0] _GEN_315 = 4'h1 == idx_reg ? _TagArray_T_9 : TagArray_1; // @[Cache.scala 132:27 464:{32,32}]
  wire [87:0] _GEN_316 = 4'h2 == idx_reg ? _TagArray_T_9 : TagArray_2; // @[Cache.scala 132:27 464:{32,32}]
  wire [87:0] _GEN_317 = 4'h3 == idx_reg ? _TagArray_T_9 : TagArray_3; // @[Cache.scala 132:27 464:{32,32}]
  wire [87:0] _GEN_318 = 4'h4 == idx_reg ? _TagArray_T_9 : TagArray_4; // @[Cache.scala 132:27 464:{32,32}]
  wire [87:0] _GEN_319 = 4'h5 == idx_reg ? _TagArray_T_9 : TagArray_5; // @[Cache.scala 132:27 464:{32,32}]
  wire [87:0] _GEN_320 = 4'h6 == idx_reg ? _TagArray_T_9 : TagArray_6; // @[Cache.scala 132:27 464:{32,32}]
  wire [87:0] _GEN_321 = 4'h7 == idx_reg ? _TagArray_T_9 : TagArray_7; // @[Cache.scala 132:27 464:{32,32}]
  wire [87:0] _GEN_322 = 4'h8 == idx_reg ? _TagArray_T_9 : TagArray_8; // @[Cache.scala 132:27 464:{32,32}]
  wire [87:0] _GEN_323 = 4'h9 == idx_reg ? _TagArray_T_9 : TagArray_9; // @[Cache.scala 132:27 464:{32,32}]
  wire [87:0] _GEN_324 = 4'ha == idx_reg ? _TagArray_T_9 : TagArray_10; // @[Cache.scala 132:27 464:{32,32}]
  wire [87:0] _GEN_325 = 4'hb == idx_reg ? _TagArray_T_9 : TagArray_11; // @[Cache.scala 132:27 464:{32,32}]
  wire [87:0] _GEN_326 = 4'hc == idx_reg ? _TagArray_T_9 : TagArray_12; // @[Cache.scala 132:27 464:{32,32}]
  wire [87:0] _GEN_327 = 4'hd == idx_reg ? _TagArray_T_9 : TagArray_13; // @[Cache.scala 132:27 464:{32,32}]
  wire [87:0] _GEN_328 = 4'he == idx_reg ? _TagArray_T_9 : TagArray_14; // @[Cache.scala 132:27 464:{32,32}]
  wire [87:0] _GEN_329 = 4'hf == idx_reg ? _TagArray_T_9 : TagArray_15; // @[Cache.scala 132:27 464:{32,32}]
  wire [87:0] _GEN_330 = _dirty_T_56 ? _GEN_314 : TagArray_0; // @[Cache.scala 132:27 453:27]
  wire [87:0] _GEN_331 = _dirty_T_56 ? _GEN_315 : TagArray_1; // @[Cache.scala 132:27 453:27]
  wire [87:0] _GEN_332 = _dirty_T_56 ? _GEN_316 : TagArray_2; // @[Cache.scala 132:27 453:27]
  wire [87:0] _GEN_333 = _dirty_T_56 ? _GEN_317 : TagArray_3; // @[Cache.scala 132:27 453:27]
  wire [87:0] _GEN_334 = _dirty_T_56 ? _GEN_318 : TagArray_4; // @[Cache.scala 132:27 453:27]
  wire [87:0] _GEN_335 = _dirty_T_56 ? _GEN_319 : TagArray_5; // @[Cache.scala 132:27 453:27]
  wire [87:0] _GEN_336 = _dirty_T_56 ? _GEN_320 : TagArray_6; // @[Cache.scala 132:27 453:27]
  wire [87:0] _GEN_337 = _dirty_T_56 ? _GEN_321 : TagArray_7; // @[Cache.scala 132:27 453:27]
  wire [87:0] _GEN_338 = _dirty_T_56 ? _GEN_322 : TagArray_8; // @[Cache.scala 132:27 453:27]
  wire [87:0] _GEN_339 = _dirty_T_56 ? _GEN_323 : TagArray_9; // @[Cache.scala 132:27 453:27]
  wire [87:0] _GEN_340 = _dirty_T_56 ? _GEN_324 : TagArray_10; // @[Cache.scala 132:27 453:27]
  wire [87:0] _GEN_341 = _dirty_T_56 ? _GEN_325 : TagArray_11; // @[Cache.scala 132:27 453:27]
  wire [87:0] _GEN_342 = _dirty_T_56 ? _GEN_326 : TagArray_12; // @[Cache.scala 132:27 453:27]
  wire [87:0] _GEN_343 = _dirty_T_56 ? _GEN_327 : TagArray_13; // @[Cache.scala 132:27 453:27]
  wire [87:0] _GEN_344 = _dirty_T_56 ? _GEN_328 : TagArray_14; // @[Cache.scala 132:27 453:27]
  wire [87:0] _GEN_345 = _dirty_T_56 ? _GEN_329 : TagArray_15; // @[Cache.scala 132:27 453:27]
  wire [87:0] _GEN_346 = _dirty_T_54 ? _GEN_298 : _GEN_330; // @[Cache.scala 453:27]
  wire [87:0] _GEN_347 = _dirty_T_54 ? _GEN_299 : _GEN_331; // @[Cache.scala 453:27]
  wire [87:0] _GEN_348 = _dirty_T_54 ? _GEN_300 : _GEN_332; // @[Cache.scala 453:27]
  wire [87:0] _GEN_349 = _dirty_T_54 ? _GEN_301 : _GEN_333; // @[Cache.scala 453:27]
  wire [87:0] _GEN_350 = _dirty_T_54 ? _GEN_302 : _GEN_334; // @[Cache.scala 453:27]
  wire [87:0] _GEN_351 = _dirty_T_54 ? _GEN_303 : _GEN_335; // @[Cache.scala 453:27]
  wire [87:0] _GEN_352 = _dirty_T_54 ? _GEN_304 : _GEN_336; // @[Cache.scala 453:27]
  wire [87:0] _GEN_353 = _dirty_T_54 ? _GEN_305 : _GEN_337; // @[Cache.scala 453:27]
  wire [87:0] _GEN_354 = _dirty_T_54 ? _GEN_306 : _GEN_338; // @[Cache.scala 453:27]
  wire [87:0] _GEN_355 = _dirty_T_54 ? _GEN_307 : _GEN_339; // @[Cache.scala 453:27]
  wire [87:0] _GEN_356 = _dirty_T_54 ? _GEN_308 : _GEN_340; // @[Cache.scala 453:27]
  wire [87:0] _GEN_357 = _dirty_T_54 ? _GEN_309 : _GEN_341; // @[Cache.scala 453:27]
  wire [87:0] _GEN_358 = _dirty_T_54 ? _GEN_310 : _GEN_342; // @[Cache.scala 453:27]
  wire [87:0] _GEN_359 = _dirty_T_54 ? _GEN_311 : _GEN_343; // @[Cache.scala 453:27]
  wire [87:0] _GEN_360 = _dirty_T_54 ? _GEN_312 : _GEN_344; // @[Cache.scala 453:27]
  wire [87:0] _GEN_361 = _dirty_T_54 ? _GEN_313 : _GEN_345; // @[Cache.scala 453:27]
  wire [87:0] _GEN_362 = _dirty_T_52 ? _GEN_282 : _GEN_346; // @[Cache.scala 453:27]
  wire [87:0] _GEN_363 = _dirty_T_52 ? _GEN_283 : _GEN_347; // @[Cache.scala 453:27]
  wire [87:0] _GEN_364 = _dirty_T_52 ? _GEN_284 : _GEN_348; // @[Cache.scala 453:27]
  wire [87:0] _GEN_365 = _dirty_T_52 ? _GEN_285 : _GEN_349; // @[Cache.scala 453:27]
  wire [87:0] _GEN_366 = _dirty_T_52 ? _GEN_286 : _GEN_350; // @[Cache.scala 453:27]
  wire [87:0] _GEN_367 = _dirty_T_52 ? _GEN_287 : _GEN_351; // @[Cache.scala 453:27]
  wire [87:0] _GEN_368 = _dirty_T_52 ? _GEN_288 : _GEN_352; // @[Cache.scala 453:27]
  wire [87:0] _GEN_369 = _dirty_T_52 ? _GEN_289 : _GEN_353; // @[Cache.scala 453:27]
  wire [87:0] _GEN_370 = _dirty_T_52 ? _GEN_290 : _GEN_354; // @[Cache.scala 453:27]
  wire [87:0] _GEN_371 = _dirty_T_52 ? _GEN_291 : _GEN_355; // @[Cache.scala 453:27]
  wire [87:0] _GEN_372 = _dirty_T_52 ? _GEN_292 : _GEN_356; // @[Cache.scala 453:27]
  wire [87:0] _GEN_373 = _dirty_T_52 ? _GEN_293 : _GEN_357; // @[Cache.scala 453:27]
  wire [87:0] _GEN_374 = _dirty_T_52 ? _GEN_294 : _GEN_358; // @[Cache.scala 453:27]
  wire [87:0] _GEN_375 = _dirty_T_52 ? _GEN_295 : _GEN_359; // @[Cache.scala 453:27]
  wire [87:0] _GEN_376 = _dirty_T_52 ? _GEN_296 : _GEN_360; // @[Cache.scala 453:27]
  wire [87:0] _GEN_377 = _dirty_T_52 ? _GEN_297 : _GEN_361; // @[Cache.scala 453:27]
  wire [87:0] _GEN_378 = 2'h0 == victim ? _GEN_266 : _GEN_362; // @[Cache.scala 453:27]
  wire [87:0] _GEN_379 = 2'h0 == victim ? _GEN_267 : _GEN_363; // @[Cache.scala 453:27]
  wire [87:0] _GEN_380 = 2'h0 == victim ? _GEN_268 : _GEN_364; // @[Cache.scala 453:27]
  wire [87:0] _GEN_381 = 2'h0 == victim ? _GEN_269 : _GEN_365; // @[Cache.scala 453:27]
  wire [87:0] _GEN_382 = 2'h0 == victim ? _GEN_270 : _GEN_366; // @[Cache.scala 453:27]
  wire [87:0] _GEN_383 = 2'h0 == victim ? _GEN_271 : _GEN_367; // @[Cache.scala 453:27]
  wire [87:0] _GEN_384 = 2'h0 == victim ? _GEN_272 : _GEN_368; // @[Cache.scala 453:27]
  wire [87:0] _GEN_385 = 2'h0 == victim ? _GEN_273 : _GEN_369; // @[Cache.scala 453:27]
  wire [87:0] _GEN_386 = 2'h0 == victim ? _GEN_274 : _GEN_370; // @[Cache.scala 453:27]
  wire [87:0] _GEN_387 = 2'h0 == victim ? _GEN_275 : _GEN_371; // @[Cache.scala 453:27]
  wire [87:0] _GEN_388 = 2'h0 == victim ? _GEN_276 : _GEN_372; // @[Cache.scala 453:27]
  wire [87:0] _GEN_389 = 2'h0 == victim ? _GEN_277 : _GEN_373; // @[Cache.scala 453:27]
  wire [87:0] _GEN_390 = 2'h0 == victim ? _GEN_278 : _GEN_374; // @[Cache.scala 453:27]
  wire [87:0] _GEN_391 = 2'h0 == victim ? _GEN_279 : _GEN_375; // @[Cache.scala 453:27]
  wire [87:0] _GEN_392 = 2'h0 == victim ? _GEN_280 : _GEN_376; // @[Cache.scala 453:27]
  wire [87:0] _GEN_393 = 2'h0 == victim ? _GEN_281 : _GEN_377; // @[Cache.scala 453:27]
  wire [63:0] _GEN_598 = 3'h1 == w_count ? read[127:64] : read[63:0]; // @[Cache.scala 477:{26,26}]
  wire [63:0] _GEN_599 = 3'h2 == w_count ? read[191:128] : _GEN_598; // @[Cache.scala 477:{26,26}]
  wire [63:0] _GEN_600 = 3'h3 == w_count ? read[255:192] : _GEN_599; // @[Cache.scala 477:{26,26}]
  wire [63:0] _GEN_601 = 3'h4 == w_count ? read[319:256] : _GEN_600; // @[Cache.scala 477:{26,26}]
  wire [63:0] _GEN_602 = 3'h5 == w_count ? read[383:320] : _GEN_601; // @[Cache.scala 477:{26,26}]
  wire [63:0] _GEN_603 = 3'h6 == w_count ? read[447:384] : _GEN_602; // @[Cache.scala 477:{26,26}]
  wire [2:0] _state_T = dirty0 ? 3'h2 : 3'h3; // @[Cache.scala 510:31]
  wire [2:0] _state_T_1 = dirty1 ? 3'h2 : 3'h3; // @[Cache.scala 511:31]
  wire [2:0] _state_T_2 = dirty2 ? 3'h2 : 3'h3; // @[Cache.scala 512:31]
  wire [2:0] _state_T_3 = dirty3 ? 3'h2 : 3'h3; // @[Cache.scala 513:31]
  wire [2:0] _state_T_5 = 2'h1 == victim ? _state_T_1 : _state_T; // @[Mux.scala 81:58]
  wire [2:0] _state_T_7 = 2'h2 == victim ? _state_T_2 : _state_T_5; // @[Mux.scala 81:58]
  wire  _io_axi_req_bits_rw_T = dirty0 ? 1'h0 : 1'h1; // @[Cache.scala 519:31]
  wire  _io_axi_req_bits_rw_T_1 = dirty1 ? 1'h0 : 1'h1; // @[Cache.scala 520:31]
  wire  _io_axi_req_bits_rw_T_2 = dirty2 ? 1'h0 : 1'h1; // @[Cache.scala 521:31]
  wire  _io_axi_req_bits_rw_T_3 = dirty3 ? 1'h0 : 1'h1; // @[Cache.scala 522:31]
  wire  _io_axi_req_bits_rw_T_5 = 2'h1 == victim ? _io_axi_req_bits_rw_T_1 : _io_axi_req_bits_rw_T; // @[Mux.scala 81:58]
  wire  _io_axi_req_bits_rw_T_7 = 2'h2 == victim ? _io_axi_req_bits_rw_T_2 : _io_axi_req_bits_rw_T_5; // @[Mux.scala 81:58]
  wire  _io_axi_req_bits_rw_T_9 = 2'h3 == victim ? _io_axi_req_bits_rw_T_3 : _io_axi_req_bits_rw_T_7; // @[Mux.scala 81:58]
  wire [25:0] _io_axi_req_bits_addr_T = {rtag0_buf,idx_reg}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_737 = {_io_axi_req_bits_addr_T, 6'h0}; // @[Cache.scala 528:64]
  wire [32:0] _io_axi_req_bits_addr_T_1 = {{1'd0}, _GEN_737}; // @[Cache.scala 528:64]
  wire [25:0] _io_axi_req_bits_addr_T_2 = {tag_reg,idx_reg}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_738 = {_io_axi_req_bits_addr_T_2, 6'h0}; // @[Cache.scala 528:99]
  wire [32:0] _io_axi_req_bits_addr_T_3 = {{1'd0}, _GEN_738}; // @[Cache.scala 528:99]
  wire [32:0] _io_axi_req_bits_addr_T_4 = dirty0 ? _io_axi_req_bits_addr_T_1 : _io_axi_req_bits_addr_T_3; // @[Cache.scala 528:31]
  wire [25:0] _io_axi_req_bits_addr_T_5 = {rtag1_buf,idx_reg}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_739 = {_io_axi_req_bits_addr_T_5, 6'h0}; // @[Cache.scala 529:64]
  wire [32:0] _io_axi_req_bits_addr_T_6 = {{1'd0}, _GEN_739}; // @[Cache.scala 529:64]
  wire [32:0] _io_axi_req_bits_addr_T_9 = dirty1 ? _io_axi_req_bits_addr_T_6 : _io_axi_req_bits_addr_T_3; // @[Cache.scala 529:31]
  wire [25:0] _io_axi_req_bits_addr_T_10 = {rtag2_buf,idx_reg}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_741 = {_io_axi_req_bits_addr_T_10, 6'h0}; // @[Cache.scala 530:64]
  wire [32:0] _io_axi_req_bits_addr_T_11 = {{1'd0}, _GEN_741}; // @[Cache.scala 530:64]
  wire [32:0] _io_axi_req_bits_addr_T_14 = dirty2 ? _io_axi_req_bits_addr_T_11 : _io_axi_req_bits_addr_T_3; // @[Cache.scala 530:31]
  wire [25:0] _io_axi_req_bits_addr_T_15 = {rtag3_buf,idx_reg}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_743 = {_io_axi_req_bits_addr_T_15, 6'h0}; // @[Cache.scala 531:64]
  wire [32:0] _io_axi_req_bits_addr_T_16 = {{1'd0}, _GEN_743}; // @[Cache.scala 531:64]
  wire [32:0] _io_axi_req_bits_addr_T_19 = dirty3 ? _io_axi_req_bits_addr_T_16 : _io_axi_req_bits_addr_T_3; // @[Cache.scala 531:31]
  wire [32:0] _io_axi_req_bits_addr_T_21 = 2'h1 == victim ? _io_axi_req_bits_addr_T_9 : _io_axi_req_bits_addr_T_4; // @[Mux.scala 81:58]
  wire [32:0] _io_axi_req_bits_addr_T_23 = 2'h2 == victim ? _io_axi_req_bits_addr_T_14 : _io_axi_req_bits_addr_T_21; // @[Mux.scala 81:58]
  wire [32:0] _io_axi_req_bits_addr_T_25 = 2'h3 == victim ? _io_axi_req_bits_addr_T_19 : _io_axi_req_bits_addr_T_23; // @[Mux.scala 81:58]
  wire [3:0] _GEN_746 = {{1'd0}, w_count}; // @[Cache.scala 551:34]
  wire [2:0] _w_count_T_1 = w_count + 3'h1; // @[Cache.scala 555:48]
  wire [2:0] _GEN_607 = io_axi_resp_bits_valid ? _w_count_T_1 : w_count; // @[Cache.scala 554:53 555:37 99:26]
  wire [2:0] _GEN_608 = _GEN_746 == 4'hf ? w_count : _GEN_607; // @[Cache.scala 551:43 552:33]
  wire [2:0] _GEN_609 = io_axi_resp_valid ? 3'h0 : _GEN_608; // @[Cache.scala 542:40 543:29]
  wire [2:0] _GEN_610 = io_axi_resp_valid ? 3'h3 : state; // @[Cache.scala 102:24 542:40 544:27]
  wire [32:0] _GEN_611 = io_axi_resp_valid ? _io_axi_req_bits_addr_T_3 : 33'h0; // @[Cache.scala 478:26 542:40 545:42]
  wire [31:0] _GEN_613 = io_axi_resp_valid ? io_axi_req_bits_addr : addr_buf; // @[Cache.scala 116:27 542:40 548:30]
  wire  _GEN_614 = io_axi_resp_valid ? io_axi_req_bits_rw : rw_buf; // @[Cache.scala 117:25 542:40 549:28]
  wire [2:0] _GEN_615 = io_axi_resp_bits_choose ? _GEN_609 : w_count; // @[Cache.scala 541:42 99:26]
  wire [2:0] _GEN_616 = io_axi_resp_bits_choose ? _GEN_610 : state; // @[Cache.scala 102:24 541:42]
  wire [32:0] _GEN_617 = io_axi_resp_bits_choose ? _GEN_611 : {{1'd0}, addr_buf}; // @[Cache.scala 541:42 560:38]
  wire  _GEN_618 = io_axi_resp_bits_choose ? io_axi_resp_valid : rw_buf; // @[Cache.scala 541:42 561:36]
  wire [31:0] _GEN_619 = io_axi_resp_bits_choose ? _GEN_613 : addr_buf; // @[Cache.scala 116:27 541:42]
  wire  _GEN_620 = io_axi_resp_bits_choose ? _GEN_614 : rw_buf; // @[Cache.scala 117:25 541:42]
  wire [2:0] _GEN_621 = io_axi_resp_bits_choose ? 3'h4 : state; // @[Cache.scala 565:42 566:23 102:24]
  wire  _GEN_622 = io_axi_resp_bits_choose ? 1'h0 : 1'h1; // @[Cache.scala 475:22 565:42 568:34]
  wire [31:0] _GEN_623 = io_axi_resp_bits_choose ? 32'h0 : addr_buf; // @[Cache.scala 478:26 565:42 569:38]
  wire  _GEN_624 = io_axi_resp_bits_choose ? 1'h0 : rw_buf; // @[Cache.scala 476:24 565:42 570:36]
  wire [2:0] _state_T_11 = _wen_T_3 ? 3'h5 : 3'h0; // @[Cache.scala 580:33]
  wire [2:0] _r_count_T_1 = r_count + 3'h1; // @[Cache.scala 583:44]
  wire [63:0] _GEN_625 = 3'h0 == r_count ? io_axi_resp_bits_data : refill_buffer_0; // @[Cache.scala 230:32 584:{48,48}]
  wire [63:0] _GEN_626 = 3'h1 == r_count ? io_axi_resp_bits_data : refill_buffer_1; // @[Cache.scala 230:32 584:{48,48}]
  wire [63:0] _GEN_627 = 3'h2 == r_count ? io_axi_resp_bits_data : refill_buffer_2; // @[Cache.scala 230:32 584:{48,48}]
  wire [63:0] _GEN_628 = 3'h3 == r_count ? io_axi_resp_bits_data : refill_buffer_3; // @[Cache.scala 230:32 584:{48,48}]
  wire [63:0] _GEN_629 = 3'h4 == r_count ? io_axi_resp_bits_data : refill_buffer_4; // @[Cache.scala 230:32 584:{48,48}]
  wire [63:0] _GEN_630 = 3'h5 == r_count ? io_axi_resp_bits_data : refill_buffer_5; // @[Cache.scala 230:32 584:{48,48}]
  wire [63:0] _GEN_631 = 3'h6 == r_count ? io_axi_resp_bits_data : refill_buffer_6; // @[Cache.scala 230:32 584:{48,48}]
  wire [63:0] _GEN_632 = 3'h7 == r_count ? io_axi_resp_bits_data : refill_buffer_7; // @[Cache.scala 230:32 584:{48,48}]
  wire [2:0] _GEN_633 = io_axi_resp_bits_valid ? _r_count_T_1 : r_count; // @[Cache.scala 582:49 583:33 98:26]
  wire [63:0] _GEN_634 = io_axi_resp_bits_valid ? _GEN_625 : refill_buffer_0; // @[Cache.scala 230:32 582:49]
  wire [63:0] _GEN_635 = io_axi_resp_bits_valid ? _GEN_626 : refill_buffer_1; // @[Cache.scala 230:32 582:49]
  wire [63:0] _GEN_636 = io_axi_resp_bits_valid ? _GEN_627 : refill_buffer_2; // @[Cache.scala 230:32 582:49]
  wire [63:0] _GEN_637 = io_axi_resp_bits_valid ? _GEN_628 : refill_buffer_3; // @[Cache.scala 230:32 582:49]
  wire [63:0] _GEN_638 = io_axi_resp_bits_valid ? _GEN_629 : refill_buffer_4; // @[Cache.scala 230:32 582:49]
  wire [63:0] _GEN_639 = io_axi_resp_bits_valid ? _GEN_630 : refill_buffer_5; // @[Cache.scala 230:32 582:49]
  wire [63:0] _GEN_640 = io_axi_resp_bits_valid ? _GEN_631 : refill_buffer_6; // @[Cache.scala 230:32 582:49]
  wire [63:0] _GEN_641 = io_axi_resp_bits_valid ? _GEN_632 : refill_buffer_7; // @[Cache.scala 230:32 582:49]
  wire [2:0] _GEN_643 = io_axi_resp_valid ? 3'h0 : _GEN_633; // @[Cache.scala 576:40 578:29]
  wire [63:0] _GEN_644 = io_axi_resp_valid ? io_axi_resp_bits_data : _GEN_641; // @[Cache.scala 576:40 579:38]
  wire [2:0] _GEN_645 = io_axi_resp_valid ? _state_T_11 : state; // @[Cache.scala 102:24 576:40 580:27]
  wire [63:0] _GEN_646 = io_axi_resp_valid ? refill_buffer_0 : _GEN_634; // @[Cache.scala 230:32 576:40]
  wire [63:0] _GEN_647 = io_axi_resp_valid ? refill_buffer_1 : _GEN_635; // @[Cache.scala 230:32 576:40]
  wire [63:0] _GEN_648 = io_axi_resp_valid ? refill_buffer_2 : _GEN_636; // @[Cache.scala 230:32 576:40]
  wire [63:0] _GEN_649 = io_axi_resp_valid ? refill_buffer_3 : _GEN_637; // @[Cache.scala 230:32 576:40]
  wire [63:0] _GEN_650 = io_axi_resp_valid ? refill_buffer_4 : _GEN_638; // @[Cache.scala 230:32 576:40]
  wire [63:0] _GEN_651 = io_axi_resp_valid ? refill_buffer_5 : _GEN_639; // @[Cache.scala 230:32 576:40]
  wire [63:0] _GEN_652 = io_axi_resp_valid ? refill_buffer_6 : _GEN_640; // @[Cache.scala 230:32 576:40]
  wire [2:0] _GEN_654 = io_axi_resp_bits_choose ? _GEN_643 : r_count; // @[Cache.scala 575:42 590:25]
  wire [63:0] _GEN_655 = io_axi_resp_bits_choose ? _GEN_644 : refill_buffer_7; // @[Cache.scala 230:32 575:42]
  wire [2:0] _GEN_656 = io_axi_resp_bits_choose ? _GEN_645 : state; // @[Cache.scala 575:42 589:23]
  wire [63:0] _GEN_657 = io_axi_resp_bits_choose ? _GEN_646 : refill_buffer_0; // @[Cache.scala 230:32 575:42]
  wire [63:0] _GEN_658 = io_axi_resp_bits_choose ? _GEN_647 : refill_buffer_1; // @[Cache.scala 230:32 575:42]
  wire [63:0] _GEN_659 = io_axi_resp_bits_choose ? _GEN_648 : refill_buffer_2; // @[Cache.scala 230:32 575:42]
  wire [63:0] _GEN_660 = io_axi_resp_bits_choose ? _GEN_649 : refill_buffer_3; // @[Cache.scala 230:32 575:42]
  wire [63:0] _GEN_661 = io_axi_resp_bits_choose ? _GEN_650 : refill_buffer_4; // @[Cache.scala 230:32 575:42]
  wire [63:0] _GEN_662 = io_axi_resp_bits_choose ? _GEN_651 : refill_buffer_5; // @[Cache.scala 230:32 575:42]
  wire [63:0] _GEN_663 = io_axi_resp_bits_choose ? _GEN_652 : refill_buffer_6; // @[Cache.scala 230:32 575:42]
  wire [2:0] _GEN_664 = 3'h5 == state ? 3'h0 : state; // @[Cache.scala 494:18 594:19 102:24]
  wire [2:0] _GEN_666 = 3'h4 == state ? _GEN_654 : r_count; // @[Cache.scala 494:18 98:26]
  wire [63:0] _GEN_667 = 3'h4 == state ? _GEN_655 : refill_buffer_7; // @[Cache.scala 494:18 230:32]
  wire [2:0] _GEN_668 = 3'h4 == state ? _GEN_656 : _GEN_664; // @[Cache.scala 494:18]
  wire [63:0] _GEN_669 = 3'h4 == state ? _GEN_657 : refill_buffer_0; // @[Cache.scala 494:18 230:32]
  wire [63:0] _GEN_670 = 3'h4 == state ? _GEN_658 : refill_buffer_1; // @[Cache.scala 494:18 230:32]
  wire [63:0] _GEN_671 = 3'h4 == state ? _GEN_659 : refill_buffer_2; // @[Cache.scala 494:18 230:32]
  wire [63:0] _GEN_672 = 3'h4 == state ? _GEN_660 : refill_buffer_3; // @[Cache.scala 494:18 230:32]
  wire [63:0] _GEN_673 = 3'h4 == state ? _GEN_661 : refill_buffer_4; // @[Cache.scala 494:18 230:32]
  wire [63:0] _GEN_674 = 3'h4 == state ? _GEN_662 : refill_buffer_5; // @[Cache.scala 494:18 230:32]
  wire [63:0] _GEN_675 = 3'h4 == state ? _GEN_663 : refill_buffer_6; // @[Cache.scala 494:18 230:32]
  wire [2:0] _GEN_676 = 3'h3 == state ? _GEN_621 : _GEN_668; // @[Cache.scala 494:18]
  wire [31:0] _GEN_678 = 3'h3 == state ? _GEN_623 : 32'h0; // @[Cache.scala 494:18 478:26]
  wire  _GEN_679 = 3'h3 == state & _GEN_624; // @[Cache.scala 494:18 476:24]
  wire [2:0] _GEN_680 = 3'h3 == state ? r_count : _GEN_666; // @[Cache.scala 494:18 98:26]
  wire [63:0] _GEN_681 = 3'h3 == state ? refill_buffer_7 : _GEN_667; // @[Cache.scala 494:18 230:32]
  wire [63:0] _GEN_682 = 3'h3 == state ? refill_buffer_0 : _GEN_669; // @[Cache.scala 494:18 230:32]
  wire [63:0] _GEN_683 = 3'h3 == state ? refill_buffer_1 : _GEN_670; // @[Cache.scala 494:18 230:32]
  wire [63:0] _GEN_684 = 3'h3 == state ? refill_buffer_2 : _GEN_671; // @[Cache.scala 494:18 230:32]
  wire [63:0] _GEN_685 = 3'h3 == state ? refill_buffer_3 : _GEN_672; // @[Cache.scala 494:18 230:32]
  wire [63:0] _GEN_686 = 3'h3 == state ? refill_buffer_4 : _GEN_673; // @[Cache.scala 494:18 230:32]
  wire [63:0] _GEN_687 = 3'h3 == state ? refill_buffer_5 : _GEN_674; // @[Cache.scala 494:18 230:32]
  wire [63:0] _GEN_688 = 3'h3 == state ? refill_buffer_6 : _GEN_675; // @[Cache.scala 494:18 230:32]
  wire  _GEN_689 = 3'h2 == state | 3'h3 == state & _GEN_622; // @[Cache.scala 494:18 539:30]
  wire [32:0] _GEN_692 = 3'h2 == state ? _GEN_617 : {{1'd0}, _GEN_678}; // @[Cache.scala 494:18]
  wire  _GEN_693 = 3'h2 == state ? _GEN_618 : _GEN_679; // @[Cache.scala 494:18]
  wire  _GEN_705 = 3'h1 == state | _GEN_689; // @[Cache.scala 494:18 506:30]
  wire  _GEN_707 = 3'h1 == state ? _io_axi_req_bits_rw_T_9 : _GEN_693; // @[Cache.scala 494:18 517:32]
  wire [32:0] _GEN_708 = 3'h1 == state ? _io_axi_req_bits_addr_T_25 : _GEN_692; // @[Cache.scala 494:18 526:34]
  wire [32:0] _GEN_724 = 3'h0 == state ? 33'h0 : _GEN_708; // @[Cache.scala 494:18 478:26]
  assign io_cpu_resp_valid = hit_reg & is_idle | is_alloc_reg & ~_wen_T_3 | is_idle & _wen_T_3; // @[Cache.scala 260:82]
  assign io_cpu_resp_bits_data = is_alloc_reg ? _GEN_42 : _GEN_50; // @[Cache.scala 255:33]
  assign io_cpu_sram0_addr = wen ? addr_temp : _GEN_16; // @[Cache.scala 365:14 381:27]
  assign io_cpu_sram0_cen = wen ? 1'h0 : _GEN_17; // @[Cache.scala 365:14 382:26]
  assign io_cpu_sram0_wen = wen ? 1'h0 : 1'h1; // @[Cache.scala 365:14 383:26 79:22]
  assign io_cpu_sram0_wmask = wen ? wmask[127:0] : 128'h0; // @[Cache.scala 365:14 384:28 80:24]
  assign io_cpu_sram0_wdata = wen ? wdata[127:0] : 128'h0; // @[Cache.scala 365:14 385:28 81:24]
  assign io_cpu_sram1_addr = wen ? addr_temp : _GEN_16; // @[Cache.scala 365:14 381:27]
  assign io_cpu_sram1_cen = wen ? 1'h0 : _GEN_17; // @[Cache.scala 365:14 382:26]
  assign io_cpu_sram1_wen = wen ? 1'h0 : 1'h1; // @[Cache.scala 365:14 383:26 79:22]
  assign io_cpu_sram1_wmask = wen ? wmask[255:128] : 128'h0; // @[Cache.scala 365:14 389:28 85:24]
  assign io_cpu_sram1_wdata = wen ? wdata[255:128] : 128'h0; // @[Cache.scala 365:14 390:28 86:24]
  assign io_cpu_sram2_addr = wen ? addr_temp : _GEN_16; // @[Cache.scala 365:14 381:27]
  assign io_cpu_sram2_cen = wen ? 1'h0 : _GEN_17; // @[Cache.scala 365:14 382:26]
  assign io_cpu_sram2_wen = wen ? 1'h0 : 1'h1; // @[Cache.scala 365:14 383:26 79:22]
  assign io_cpu_sram2_wmask = wen ? wmask[383:256] : 128'h0; // @[Cache.scala 365:14 394:28 90:24]
  assign io_cpu_sram2_wdata = wen ? wdata[383:256] : 128'h0; // @[Cache.scala 365:14 395:28 91:24]
  assign io_cpu_sram3_addr = wen ? addr_temp : _GEN_16; // @[Cache.scala 365:14 381:27]
  assign io_cpu_sram3_cen = wen ? 1'h0 : _GEN_17; // @[Cache.scala 365:14 382:26]
  assign io_cpu_sram3_wen = wen ? 1'h0 : 1'h1; // @[Cache.scala 365:14 383:26 79:22]
  assign io_cpu_sram3_wmask = wen ? wmask[511:384] : 128'h0; // @[Cache.scala 365:14 399:28 95:24]
  assign io_cpu_sram3_wdata = wen ? wdata[511:384] : 128'h0; // @[Cache.scala 365:14 400:28 96:24]
  assign io_axi_req_valid = 3'h0 == state ? 1'h0 : _GEN_705; // @[Cache.scala 494:18 475:22]
  assign io_axi_req_bits_rw = 3'h0 == state ? 1'h0 : _GEN_707; // @[Cache.scala 494:18 476:24]
  assign io_axi_req_bits_addr = _GEN_724[31:0];
  assign io_axi_req_bits_data = 3'h7 == w_count ? read[511:448] : _GEN_603; // @[Cache.scala 477:{26,26}]
  assign io_fccache_state = state; // @[Cache.scala 488:22]
  always @(posedge clock) begin
    if (reset) begin // @[Cache.scala 98:26]
      r_count <= 3'h0; // @[Cache.scala 98:26]
    end else if (!(3'h0 == state)) begin // @[Cache.scala 494:18]
      if (!(3'h1 == state)) begin // @[Cache.scala 494:18]
        if (!(3'h2 == state)) begin // @[Cache.scala 494:18]
          r_count <= _GEN_680;
        end
      end
    end
    if (reset) begin // @[Cache.scala 99:26]
      w_count <= 3'h0; // @[Cache.scala 99:26]
    end else if (!(3'h0 == state)) begin // @[Cache.scala 494:18]
      if (!(3'h1 == state)) begin // @[Cache.scala 494:18]
        if (3'h2 == state) begin // @[Cache.scala 494:18]
          w_count <= _GEN_615;
        end
      end
    end
    if (reset) begin // @[Cache.scala 102:24]
      state <= 3'h0; // @[Cache.scala 102:24]
    end else if (3'h0 == state) begin // @[Cache.scala 494:18]
      if (io_cpu_req_valid) begin // @[Cache.scala 496:35]
        if (hit) begin // @[Cache.scala 497:26]
          state <= 3'h0; // @[Cache.scala 498:27]
        end else begin
          state <= 3'h1; // @[Cache.scala 500:27]
        end
      end
    end else if (3'h1 == state) begin // @[Cache.scala 494:18]
      if (2'h3 == victim) begin // @[Mux.scala 81:58]
        state <= _state_T_3;
      end else begin
        state <= _state_T_7;
      end
    end else if (3'h2 == state) begin // @[Cache.scala 494:18]
      state <= _GEN_616;
    end else begin
      state <= _GEN_676;
    end
    if (reset) begin // @[Cache.scala 107:31]
      is_alloc_reg <= 1'h0; // @[Cache.scala 107:31]
    end else begin
      is_alloc_reg <= is_alloc; // @[Cache.scala 107:31]
    end
    if (reset) begin // @[Cache.scala 112:27]
      addr_reg <= 32'h0; // @[Cache.scala 112:27]
    end else if (is_idle & io_cpu_req_valid) begin // @[Cache.scala 266:37]
      addr_reg <= io_cpu_req_bits_addr; // @[Cache.scala 267:18]
    end else if (~io_cpu_req_valid & is_idle) begin // @[Cache.scala 291:44]
      addr_reg <= 32'h0; // @[Cache.scala 292:18]
    end
    if (reset) begin // @[Cache.scala 113:27]
      cpu_data <= 64'h0; // @[Cache.scala 113:27]
    end else if (is_idle & io_cpu_req_valid) begin // @[Cache.scala 266:37]
      cpu_data <= io_cpu_req_bits_data; // @[Cache.scala 268:18]
    end else if (~io_cpu_req_valid & is_idle) begin // @[Cache.scala 291:44]
      cpu_data <= 64'h0; // @[Cache.scala 293:18]
    end
    if (reset) begin // @[Cache.scala 114:27]
      after_alloc_mask <= 8'h0; // @[Cache.scala 114:27]
    end else if (is_idle & io_cpu_req_valid) begin // @[Cache.scala 266:37]
      after_alloc_mask <= io_cpu_req_bits_mask; // @[Cache.scala 269:18]
    end else if (~io_cpu_req_valid & is_idle) begin // @[Cache.scala 291:44]
      after_alloc_mask <= 8'h0; // @[Cache.scala 294:18]
    end
    if (reset) begin // @[Cache.scala 116:27]
      addr_buf <= 32'h0; // @[Cache.scala 116:27]
    end else if (!(3'h0 == state)) begin // @[Cache.scala 494:18]
      if (3'h1 == state) begin // @[Cache.scala 494:18]
        addr_buf <= io_axi_req_bits_addr; // @[Cache.scala 535:22]
      end else if (3'h2 == state) begin // @[Cache.scala 494:18]
        addr_buf <= _GEN_619;
      end
    end
    if (reset) begin // @[Cache.scala 117:25]
      rw_buf <= 1'h0; // @[Cache.scala 117:25]
    end else if (!(3'h0 == state)) begin // @[Cache.scala 494:18]
      if (3'h1 == state) begin // @[Cache.scala 494:18]
        rw_buf <= io_axi_req_bits_rw; // @[Cache.scala 536:20]
      end else if (3'h2 == state) begin // @[Cache.scala 494:18]
        rw_buf <= _GEN_620;
      end
    end
    if (reset) begin // @[Cache.scala 121:24]
      valid_0 <= 4'h0; // @[Cache.scala 121:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          valid_0 <= _GEN_186;
        end
      end
    end
    if (reset) begin // @[Cache.scala 121:24]
      valid_1 <= 4'h0; // @[Cache.scala 121:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          valid_1 <= _GEN_187;
        end
      end
    end
    if (reset) begin // @[Cache.scala 121:24]
      valid_2 <= 4'h0; // @[Cache.scala 121:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          valid_2 <= _GEN_188;
        end
      end
    end
    if (reset) begin // @[Cache.scala 121:24]
      valid_3 <= 4'h0; // @[Cache.scala 121:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          valid_3 <= _GEN_189;
        end
      end
    end
    if (reset) begin // @[Cache.scala 121:24]
      valid_4 <= 4'h0; // @[Cache.scala 121:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          valid_4 <= _GEN_190;
        end
      end
    end
    if (reset) begin // @[Cache.scala 121:24]
      valid_5 <= 4'h0; // @[Cache.scala 121:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          valid_5 <= _GEN_191;
        end
      end
    end
    if (reset) begin // @[Cache.scala 121:24]
      valid_6 <= 4'h0; // @[Cache.scala 121:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          valid_6 <= _GEN_192;
        end
      end
    end
    if (reset) begin // @[Cache.scala 121:24]
      valid_7 <= 4'h0; // @[Cache.scala 121:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          valid_7 <= _GEN_193;
        end
      end
    end
    if (reset) begin // @[Cache.scala 121:24]
      valid_8 <= 4'h0; // @[Cache.scala 121:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          valid_8 <= _GEN_194;
        end
      end
    end
    if (reset) begin // @[Cache.scala 121:24]
      valid_9 <= 4'h0; // @[Cache.scala 121:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          valid_9 <= _GEN_195;
        end
      end
    end
    if (reset) begin // @[Cache.scala 121:24]
      valid_10 <= 4'h0; // @[Cache.scala 121:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          valid_10 <= _GEN_196;
        end
      end
    end
    if (reset) begin // @[Cache.scala 121:24]
      valid_11 <= 4'h0; // @[Cache.scala 121:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          valid_11 <= _GEN_197;
        end
      end
    end
    if (reset) begin // @[Cache.scala 121:24]
      valid_12 <= 4'h0; // @[Cache.scala 121:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          valid_12 <= _GEN_198;
        end
      end
    end
    if (reset) begin // @[Cache.scala 121:24]
      valid_13 <= 4'h0; // @[Cache.scala 121:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          valid_13 <= _GEN_199;
        end
      end
    end
    if (reset) begin // @[Cache.scala 121:24]
      valid_14 <= 4'h0; // @[Cache.scala 121:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          valid_14 <= _GEN_200;
        end
      end
    end
    if (reset) begin // @[Cache.scala 121:24]
      valid_15 <= 4'h0; // @[Cache.scala 121:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          valid_15 <= _GEN_201;
        end
      end
    end
    if (reset) begin // @[Cache.scala 122:24]
      dirty_0 <= 4'h0; // @[Cache.scala 122:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        if (4'h0 == idx) begin // @[Cache.scala 406:24]
          dirty_0 <= _dirty_T_27; // @[Cache.scala 406:24]
        end
      end else if (is_war) begin // @[Cache.scala 414:27]
        dirty_0 <= _GEN_170;
      end else begin
        dirty_0 <= _GEN_170;
      end
    end
    if (reset) begin // @[Cache.scala 122:24]
      dirty_1 <= 4'h0; // @[Cache.scala 122:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        if (4'h1 == idx) begin // @[Cache.scala 406:24]
          dirty_1 <= _dirty_T_27; // @[Cache.scala 406:24]
        end
      end else if (is_war) begin // @[Cache.scala 414:27]
        dirty_1 <= _GEN_171;
      end else begin
        dirty_1 <= _GEN_171;
      end
    end
    if (reset) begin // @[Cache.scala 122:24]
      dirty_2 <= 4'h0; // @[Cache.scala 122:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        if (4'h2 == idx) begin // @[Cache.scala 406:24]
          dirty_2 <= _dirty_T_27; // @[Cache.scala 406:24]
        end
      end else if (is_war) begin // @[Cache.scala 414:27]
        dirty_2 <= _GEN_172;
      end else begin
        dirty_2 <= _GEN_172;
      end
    end
    if (reset) begin // @[Cache.scala 122:24]
      dirty_3 <= 4'h0; // @[Cache.scala 122:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        if (4'h3 == idx) begin // @[Cache.scala 406:24]
          dirty_3 <= _dirty_T_27; // @[Cache.scala 406:24]
        end
      end else if (is_war) begin // @[Cache.scala 414:27]
        dirty_3 <= _GEN_173;
      end else begin
        dirty_3 <= _GEN_173;
      end
    end
    if (reset) begin // @[Cache.scala 122:24]
      dirty_4 <= 4'h0; // @[Cache.scala 122:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        if (4'h4 == idx) begin // @[Cache.scala 406:24]
          dirty_4 <= _dirty_T_27; // @[Cache.scala 406:24]
        end
      end else if (is_war) begin // @[Cache.scala 414:27]
        dirty_4 <= _GEN_174;
      end else begin
        dirty_4 <= _GEN_174;
      end
    end
    if (reset) begin // @[Cache.scala 122:24]
      dirty_5 <= 4'h0; // @[Cache.scala 122:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        if (4'h5 == idx) begin // @[Cache.scala 406:24]
          dirty_5 <= _dirty_T_27; // @[Cache.scala 406:24]
        end
      end else if (is_war) begin // @[Cache.scala 414:27]
        dirty_5 <= _GEN_175;
      end else begin
        dirty_5 <= _GEN_175;
      end
    end
    if (reset) begin // @[Cache.scala 122:24]
      dirty_6 <= 4'h0; // @[Cache.scala 122:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        if (4'h6 == idx) begin // @[Cache.scala 406:24]
          dirty_6 <= _dirty_T_27; // @[Cache.scala 406:24]
        end
      end else if (is_war) begin // @[Cache.scala 414:27]
        dirty_6 <= _GEN_176;
      end else begin
        dirty_6 <= _GEN_176;
      end
    end
    if (reset) begin // @[Cache.scala 122:24]
      dirty_7 <= 4'h0; // @[Cache.scala 122:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        if (4'h7 == idx) begin // @[Cache.scala 406:24]
          dirty_7 <= _dirty_T_27; // @[Cache.scala 406:24]
        end
      end else if (is_war) begin // @[Cache.scala 414:27]
        dirty_7 <= _GEN_177;
      end else begin
        dirty_7 <= _GEN_177;
      end
    end
    if (reset) begin // @[Cache.scala 122:24]
      dirty_8 <= 4'h0; // @[Cache.scala 122:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        if (4'h8 == idx) begin // @[Cache.scala 406:24]
          dirty_8 <= _dirty_T_27; // @[Cache.scala 406:24]
        end
      end else if (is_war) begin // @[Cache.scala 414:27]
        dirty_8 <= _GEN_178;
      end else begin
        dirty_8 <= _GEN_178;
      end
    end
    if (reset) begin // @[Cache.scala 122:24]
      dirty_9 <= 4'h0; // @[Cache.scala 122:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        if (4'h9 == idx) begin // @[Cache.scala 406:24]
          dirty_9 <= _dirty_T_27; // @[Cache.scala 406:24]
        end
      end else if (is_war) begin // @[Cache.scala 414:27]
        dirty_9 <= _GEN_179;
      end else begin
        dirty_9 <= _GEN_179;
      end
    end
    if (reset) begin // @[Cache.scala 122:24]
      dirty_10 <= 4'h0; // @[Cache.scala 122:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        if (4'ha == idx) begin // @[Cache.scala 406:24]
          dirty_10 <= _dirty_T_27; // @[Cache.scala 406:24]
        end
      end else if (is_war) begin // @[Cache.scala 414:27]
        dirty_10 <= _GEN_180;
      end else begin
        dirty_10 <= _GEN_180;
      end
    end
    if (reset) begin // @[Cache.scala 122:24]
      dirty_11 <= 4'h0; // @[Cache.scala 122:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        if (4'hb == idx) begin // @[Cache.scala 406:24]
          dirty_11 <= _dirty_T_27; // @[Cache.scala 406:24]
        end
      end else if (is_war) begin // @[Cache.scala 414:27]
        dirty_11 <= _GEN_181;
      end else begin
        dirty_11 <= _GEN_181;
      end
    end
    if (reset) begin // @[Cache.scala 122:24]
      dirty_12 <= 4'h0; // @[Cache.scala 122:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        if (4'hc == idx) begin // @[Cache.scala 406:24]
          dirty_12 <= _dirty_T_27; // @[Cache.scala 406:24]
        end
      end else if (is_war) begin // @[Cache.scala 414:27]
        dirty_12 <= _GEN_182;
      end else begin
        dirty_12 <= _GEN_182;
      end
    end
    if (reset) begin // @[Cache.scala 122:24]
      dirty_13 <= 4'h0; // @[Cache.scala 122:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        if (4'hd == idx) begin // @[Cache.scala 406:24]
          dirty_13 <= _dirty_T_27; // @[Cache.scala 406:24]
        end
      end else if (is_war) begin // @[Cache.scala 414:27]
        dirty_13 <= _GEN_183;
      end else begin
        dirty_13 <= _GEN_183;
      end
    end
    if (reset) begin // @[Cache.scala 122:24]
      dirty_14 <= 4'h0; // @[Cache.scala 122:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        if (4'he == idx) begin // @[Cache.scala 406:24]
          dirty_14 <= _dirty_T_27; // @[Cache.scala 406:24]
        end
      end else if (is_war) begin // @[Cache.scala 414:27]
        dirty_14 <= _GEN_184;
      end else begin
        dirty_14 <= _GEN_184;
      end
    end
    if (reset) begin // @[Cache.scala 122:24]
      dirty_15 <= 4'h0; // @[Cache.scala 122:24]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        if (4'hf == idx) begin // @[Cache.scala 406:24]
          dirty_15 <= _dirty_T_27; // @[Cache.scala 406:24]
        end
      end else if (is_war) begin // @[Cache.scala 414:27]
        dirty_15 <= _GEN_185;
      end else begin
        dirty_15 <= _GEN_185;
      end
    end
    if (reset) begin // @[Cache.scala 125:26]
      replace_0 <= 3'h0; // @[Cache.scala 125:26]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        replace_0 <= _GEN_122;
      end else if (is_war) begin // @[Cache.scala 414:27]
        replace_0 <= _GEN_122;
      end else begin
        replace_0 <= _GEN_234;
      end
    end else begin
      replace_0 <= _GEN_122;
    end
    if (reset) begin // @[Cache.scala 125:26]
      replace_1 <= 3'h0; // @[Cache.scala 125:26]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        replace_1 <= _GEN_123;
      end else if (is_war) begin // @[Cache.scala 414:27]
        replace_1 <= _GEN_123;
      end else begin
        replace_1 <= _GEN_235;
      end
    end else begin
      replace_1 <= _GEN_123;
    end
    if (reset) begin // @[Cache.scala 125:26]
      replace_2 <= 3'h0; // @[Cache.scala 125:26]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        replace_2 <= _GEN_124;
      end else if (is_war) begin // @[Cache.scala 414:27]
        replace_2 <= _GEN_124;
      end else begin
        replace_2 <= _GEN_236;
      end
    end else begin
      replace_2 <= _GEN_124;
    end
    if (reset) begin // @[Cache.scala 125:26]
      replace_3 <= 3'h0; // @[Cache.scala 125:26]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        replace_3 <= _GEN_125;
      end else if (is_war) begin // @[Cache.scala 414:27]
        replace_3 <= _GEN_125;
      end else begin
        replace_3 <= _GEN_237;
      end
    end else begin
      replace_3 <= _GEN_125;
    end
    if (reset) begin // @[Cache.scala 125:26]
      replace_4 <= 3'h0; // @[Cache.scala 125:26]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        replace_4 <= _GEN_126;
      end else if (is_war) begin // @[Cache.scala 414:27]
        replace_4 <= _GEN_126;
      end else begin
        replace_4 <= _GEN_238;
      end
    end else begin
      replace_4 <= _GEN_126;
    end
    if (reset) begin // @[Cache.scala 125:26]
      replace_5 <= 3'h0; // @[Cache.scala 125:26]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        replace_5 <= _GEN_127;
      end else if (is_war) begin // @[Cache.scala 414:27]
        replace_5 <= _GEN_127;
      end else begin
        replace_5 <= _GEN_239;
      end
    end else begin
      replace_5 <= _GEN_127;
    end
    if (reset) begin // @[Cache.scala 125:26]
      replace_6 <= 3'h0; // @[Cache.scala 125:26]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        replace_6 <= _GEN_128;
      end else if (is_war) begin // @[Cache.scala 414:27]
        replace_6 <= _GEN_128;
      end else begin
        replace_6 <= _GEN_240;
      end
    end else begin
      replace_6 <= _GEN_128;
    end
    if (reset) begin // @[Cache.scala 125:26]
      replace_7 <= 3'h0; // @[Cache.scala 125:26]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        replace_7 <= _GEN_129;
      end else if (is_war) begin // @[Cache.scala 414:27]
        replace_7 <= _GEN_129;
      end else begin
        replace_7 <= _GEN_241;
      end
    end else begin
      replace_7 <= _GEN_129;
    end
    if (reset) begin // @[Cache.scala 125:26]
      replace_8 <= 3'h0; // @[Cache.scala 125:26]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        replace_8 <= _GEN_130;
      end else if (is_war) begin // @[Cache.scala 414:27]
        replace_8 <= _GEN_130;
      end else begin
        replace_8 <= _GEN_242;
      end
    end else begin
      replace_8 <= _GEN_130;
    end
    if (reset) begin // @[Cache.scala 125:26]
      replace_9 <= 3'h0; // @[Cache.scala 125:26]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        replace_9 <= _GEN_131;
      end else if (is_war) begin // @[Cache.scala 414:27]
        replace_9 <= _GEN_131;
      end else begin
        replace_9 <= _GEN_243;
      end
    end else begin
      replace_9 <= _GEN_131;
    end
    if (reset) begin // @[Cache.scala 125:26]
      replace_10 <= 3'h0; // @[Cache.scala 125:26]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        replace_10 <= _GEN_132;
      end else if (is_war) begin // @[Cache.scala 414:27]
        replace_10 <= _GEN_132;
      end else begin
        replace_10 <= _GEN_244;
      end
    end else begin
      replace_10 <= _GEN_132;
    end
    if (reset) begin // @[Cache.scala 125:26]
      replace_11 <= 3'h0; // @[Cache.scala 125:26]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        replace_11 <= _GEN_133;
      end else if (is_war) begin // @[Cache.scala 414:27]
        replace_11 <= _GEN_133;
      end else begin
        replace_11 <= _GEN_245;
      end
    end else begin
      replace_11 <= _GEN_133;
    end
    if (reset) begin // @[Cache.scala 125:26]
      replace_12 <= 3'h0; // @[Cache.scala 125:26]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        replace_12 <= _GEN_134;
      end else if (is_war) begin // @[Cache.scala 414:27]
        replace_12 <= _GEN_134;
      end else begin
        replace_12 <= _GEN_246;
      end
    end else begin
      replace_12 <= _GEN_134;
    end
    if (reset) begin // @[Cache.scala 125:26]
      replace_13 <= 3'h0; // @[Cache.scala 125:26]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        replace_13 <= _GEN_135;
      end else if (is_war) begin // @[Cache.scala 414:27]
        replace_13 <= _GEN_135;
      end else begin
        replace_13 <= _GEN_247;
      end
    end else begin
      replace_13 <= _GEN_135;
    end
    if (reset) begin // @[Cache.scala 125:26]
      replace_14 <= 3'h0; // @[Cache.scala 125:26]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        replace_14 <= _GEN_136;
      end else if (is_war) begin // @[Cache.scala 414:27]
        replace_14 <= _GEN_136;
      end else begin
        replace_14 <= _GEN_248;
      end
    end else begin
      replace_14 <= _GEN_136;
    end
    if (reset) begin // @[Cache.scala 125:26]
      replace_15 <= 3'h0; // @[Cache.scala 125:26]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (hit) begin // @[Cache.scala 403:18]
        replace_15 <= _GEN_137;
      end else if (is_war) begin // @[Cache.scala 414:27]
        replace_15 <= _GEN_137;
      end else begin
        replace_15 <= _GEN_249;
      end
    end else begin
      replace_15 <= _GEN_137;
    end
    if (reset) begin // @[Cache.scala 127:25]
      victim <= 2'h0; // @[Cache.scala 127:25]
    end else if (is_idle & io_cpu_req_valid) begin // @[Cache.scala 266:37]
      if (_victim_T_15) begin // @[Mux.scala 101:16]
        victim <= 2'h0;
      end else if (_victim_T_17) begin // @[Mux.scala 101:16]
        victim <= 2'h1;
      end else begin
        victim <= _victim_T_23;
      end
    end
    if (reset) begin // @[Cache.scala 132:27]
      TagArray_0 <= 88'h0; // @[Cache.scala 132:27]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          TagArray_0 <= _GEN_378;
        end
      end
    end
    if (reset) begin // @[Cache.scala 132:27]
      TagArray_1 <= 88'h0; // @[Cache.scala 132:27]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          TagArray_1 <= _GEN_379;
        end
      end
    end
    if (reset) begin // @[Cache.scala 132:27]
      TagArray_2 <= 88'h0; // @[Cache.scala 132:27]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          TagArray_2 <= _GEN_380;
        end
      end
    end
    if (reset) begin // @[Cache.scala 132:27]
      TagArray_3 <= 88'h0; // @[Cache.scala 132:27]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          TagArray_3 <= _GEN_381;
        end
      end
    end
    if (reset) begin // @[Cache.scala 132:27]
      TagArray_4 <= 88'h0; // @[Cache.scala 132:27]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          TagArray_4 <= _GEN_382;
        end
      end
    end
    if (reset) begin // @[Cache.scala 132:27]
      TagArray_5 <= 88'h0; // @[Cache.scala 132:27]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          TagArray_5 <= _GEN_383;
        end
      end
    end
    if (reset) begin // @[Cache.scala 132:27]
      TagArray_6 <= 88'h0; // @[Cache.scala 132:27]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          TagArray_6 <= _GEN_384;
        end
      end
    end
    if (reset) begin // @[Cache.scala 132:27]
      TagArray_7 <= 88'h0; // @[Cache.scala 132:27]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          TagArray_7 <= _GEN_385;
        end
      end
    end
    if (reset) begin // @[Cache.scala 132:27]
      TagArray_8 <= 88'h0; // @[Cache.scala 132:27]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          TagArray_8 <= _GEN_386;
        end
      end
    end
    if (reset) begin // @[Cache.scala 132:27]
      TagArray_9 <= 88'h0; // @[Cache.scala 132:27]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          TagArray_9 <= _GEN_387;
        end
      end
    end
    if (reset) begin // @[Cache.scala 132:27]
      TagArray_10 <= 88'h0; // @[Cache.scala 132:27]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          TagArray_10 <= _GEN_388;
        end
      end
    end
    if (reset) begin // @[Cache.scala 132:27]
      TagArray_11 <= 88'h0; // @[Cache.scala 132:27]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          TagArray_11 <= _GEN_389;
        end
      end
    end
    if (reset) begin // @[Cache.scala 132:27]
      TagArray_12 <= 88'h0; // @[Cache.scala 132:27]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          TagArray_12 <= _GEN_390;
        end
      end
    end
    if (reset) begin // @[Cache.scala 132:27]
      TagArray_13 <= 88'h0; // @[Cache.scala 132:27]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          TagArray_13 <= _GEN_391;
        end
      end
    end
    if (reset) begin // @[Cache.scala 132:27]
      TagArray_14 <= 88'h0; // @[Cache.scala 132:27]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          TagArray_14 <= _GEN_392;
        end
      end
    end
    if (reset) begin // @[Cache.scala 132:27]
      TagArray_15 <= 88'h0; // @[Cache.scala 132:27]
    end else if (wen) begin // @[Cache.scala 365:14]
      if (!(hit)) begin // @[Cache.scala 403:18]
        if (!(is_war)) begin // @[Cache.scala 414:27]
          TagArray_15 <= _GEN_393;
        end
      end
    end
    if (reset) begin // @[Cache.scala 148:26]
      hit_reg <= 1'h0; // @[Cache.scala 148:26]
    end else begin
      hit_reg <= hit; // @[Cache.scala 148:26]
    end
    if (reset) begin // @[Cache.scala 163:26]
      ren_reg <= 1'h0; // @[Cache.scala 163:26]
    end else begin
      ren_reg <= ren; // @[Cache.scala 163:26]
    end
    if (reset) begin // @[Cache.scala 188:28]
      rtag0_buf <= 22'h0; // @[Cache.scala 188:28]
    end else begin
      rtag0_buf <= rtag0; // @[Cache.scala 188:28]
    end
    if (reset) begin // @[Cache.scala 189:28]
      rtag1_buf <= 22'h0; // @[Cache.scala 189:28]
    end else begin
      rtag1_buf <= rtag1; // @[Cache.scala 189:28]
    end
    if (reset) begin // @[Cache.scala 190:28]
      rtag2_buf <= 22'h0; // @[Cache.scala 190:28]
    end else begin
      rtag2_buf <= rtag2; // @[Cache.scala 190:28]
    end
    if (reset) begin // @[Cache.scala 191:28]
      rtag3_buf <= 22'h0; // @[Cache.scala 191:28]
    end else begin
      rtag3_buf <= rtag3; // @[Cache.scala 191:28]
    end
    if (reset) begin // @[Reg.scala 35:20]
      rdata_buf <= 512'h0; // @[Reg.scala 35:20]
    end else if (ren_reg) begin // @[Reg.scala 36:18]
      rdata_buf <= rdata; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Cache.scala 230:32]
      refill_buffer_0 <= 64'h0; // @[Cache.scala 230:32]
    end else if (!(3'h0 == state)) begin // @[Cache.scala 494:18]
      if (!(3'h1 == state)) begin // @[Cache.scala 494:18]
        if (!(3'h2 == state)) begin // @[Cache.scala 494:18]
          refill_buffer_0 <= _GEN_682;
        end
      end
    end
    if (reset) begin // @[Cache.scala 230:32]
      refill_buffer_1 <= 64'h0; // @[Cache.scala 230:32]
    end else if (!(3'h0 == state)) begin // @[Cache.scala 494:18]
      if (!(3'h1 == state)) begin // @[Cache.scala 494:18]
        if (!(3'h2 == state)) begin // @[Cache.scala 494:18]
          refill_buffer_1 <= _GEN_683;
        end
      end
    end
    if (reset) begin // @[Cache.scala 230:32]
      refill_buffer_2 <= 64'h0; // @[Cache.scala 230:32]
    end else if (!(3'h0 == state)) begin // @[Cache.scala 494:18]
      if (!(3'h1 == state)) begin // @[Cache.scala 494:18]
        if (!(3'h2 == state)) begin // @[Cache.scala 494:18]
          refill_buffer_2 <= _GEN_684;
        end
      end
    end
    if (reset) begin // @[Cache.scala 230:32]
      refill_buffer_3 <= 64'h0; // @[Cache.scala 230:32]
    end else if (!(3'h0 == state)) begin // @[Cache.scala 494:18]
      if (!(3'h1 == state)) begin // @[Cache.scala 494:18]
        if (!(3'h2 == state)) begin // @[Cache.scala 494:18]
          refill_buffer_3 <= _GEN_685;
        end
      end
    end
    if (reset) begin // @[Cache.scala 230:32]
      refill_buffer_4 <= 64'h0; // @[Cache.scala 230:32]
    end else if (!(3'h0 == state)) begin // @[Cache.scala 494:18]
      if (!(3'h1 == state)) begin // @[Cache.scala 494:18]
        if (!(3'h2 == state)) begin // @[Cache.scala 494:18]
          refill_buffer_4 <= _GEN_686;
        end
      end
    end
    if (reset) begin // @[Cache.scala 230:32]
      refill_buffer_5 <= 64'h0; // @[Cache.scala 230:32]
    end else if (!(3'h0 == state)) begin // @[Cache.scala 494:18]
      if (!(3'h1 == state)) begin // @[Cache.scala 494:18]
        if (!(3'h2 == state)) begin // @[Cache.scala 494:18]
          refill_buffer_5 <= _GEN_687;
        end
      end
    end
    if (reset) begin // @[Cache.scala 230:32]
      refill_buffer_6 <= 64'h0; // @[Cache.scala 230:32]
    end else if (!(3'h0 == state)) begin // @[Cache.scala 494:18]
      if (!(3'h1 == state)) begin // @[Cache.scala 494:18]
        if (!(3'h2 == state)) begin // @[Cache.scala 494:18]
          refill_buffer_6 <= _GEN_688;
        end
      end
    end
    if (reset) begin // @[Cache.scala 230:32]
      refill_buffer_7 <= 64'h0; // @[Cache.scala 230:32]
    end else if (!(3'h0 == state)) begin // @[Cache.scala 494:18]
      if (!(3'h1 == state)) begin // @[Cache.scala 494:18]
        if (!(3'h2 == state)) begin // @[Cache.scala 494:18]
          refill_buffer_7 <= _GEN_681;
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  r_count = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  w_count = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  state = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  is_alloc_reg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  addr_reg = _RAND_4[31:0];
  _RAND_5 = {2{`RANDOM}};
  cpu_data = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  after_alloc_mask = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  addr_buf = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  rw_buf = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  valid_0 = _RAND_9[3:0];
  _RAND_10 = {1{`RANDOM}};
  valid_1 = _RAND_10[3:0];
  _RAND_11 = {1{`RANDOM}};
  valid_2 = _RAND_11[3:0];
  _RAND_12 = {1{`RANDOM}};
  valid_3 = _RAND_12[3:0];
  _RAND_13 = {1{`RANDOM}};
  valid_4 = _RAND_13[3:0];
  _RAND_14 = {1{`RANDOM}};
  valid_5 = _RAND_14[3:0];
  _RAND_15 = {1{`RANDOM}};
  valid_6 = _RAND_15[3:0];
  _RAND_16 = {1{`RANDOM}};
  valid_7 = _RAND_16[3:0];
  _RAND_17 = {1{`RANDOM}};
  valid_8 = _RAND_17[3:0];
  _RAND_18 = {1{`RANDOM}};
  valid_9 = _RAND_18[3:0];
  _RAND_19 = {1{`RANDOM}};
  valid_10 = _RAND_19[3:0];
  _RAND_20 = {1{`RANDOM}};
  valid_11 = _RAND_20[3:0];
  _RAND_21 = {1{`RANDOM}};
  valid_12 = _RAND_21[3:0];
  _RAND_22 = {1{`RANDOM}};
  valid_13 = _RAND_22[3:0];
  _RAND_23 = {1{`RANDOM}};
  valid_14 = _RAND_23[3:0];
  _RAND_24 = {1{`RANDOM}};
  valid_15 = _RAND_24[3:0];
  _RAND_25 = {1{`RANDOM}};
  dirty_0 = _RAND_25[3:0];
  _RAND_26 = {1{`RANDOM}};
  dirty_1 = _RAND_26[3:0];
  _RAND_27 = {1{`RANDOM}};
  dirty_2 = _RAND_27[3:0];
  _RAND_28 = {1{`RANDOM}};
  dirty_3 = _RAND_28[3:0];
  _RAND_29 = {1{`RANDOM}};
  dirty_4 = _RAND_29[3:0];
  _RAND_30 = {1{`RANDOM}};
  dirty_5 = _RAND_30[3:0];
  _RAND_31 = {1{`RANDOM}};
  dirty_6 = _RAND_31[3:0];
  _RAND_32 = {1{`RANDOM}};
  dirty_7 = _RAND_32[3:0];
  _RAND_33 = {1{`RANDOM}};
  dirty_8 = _RAND_33[3:0];
  _RAND_34 = {1{`RANDOM}};
  dirty_9 = _RAND_34[3:0];
  _RAND_35 = {1{`RANDOM}};
  dirty_10 = _RAND_35[3:0];
  _RAND_36 = {1{`RANDOM}};
  dirty_11 = _RAND_36[3:0];
  _RAND_37 = {1{`RANDOM}};
  dirty_12 = _RAND_37[3:0];
  _RAND_38 = {1{`RANDOM}};
  dirty_13 = _RAND_38[3:0];
  _RAND_39 = {1{`RANDOM}};
  dirty_14 = _RAND_39[3:0];
  _RAND_40 = {1{`RANDOM}};
  dirty_15 = _RAND_40[3:0];
  _RAND_41 = {1{`RANDOM}};
  replace_0 = _RAND_41[2:0];
  _RAND_42 = {1{`RANDOM}};
  replace_1 = _RAND_42[2:0];
  _RAND_43 = {1{`RANDOM}};
  replace_2 = _RAND_43[2:0];
  _RAND_44 = {1{`RANDOM}};
  replace_3 = _RAND_44[2:0];
  _RAND_45 = {1{`RANDOM}};
  replace_4 = _RAND_45[2:0];
  _RAND_46 = {1{`RANDOM}};
  replace_5 = _RAND_46[2:0];
  _RAND_47 = {1{`RANDOM}};
  replace_6 = _RAND_47[2:0];
  _RAND_48 = {1{`RANDOM}};
  replace_7 = _RAND_48[2:0];
  _RAND_49 = {1{`RANDOM}};
  replace_8 = _RAND_49[2:0];
  _RAND_50 = {1{`RANDOM}};
  replace_9 = _RAND_50[2:0];
  _RAND_51 = {1{`RANDOM}};
  replace_10 = _RAND_51[2:0];
  _RAND_52 = {1{`RANDOM}};
  replace_11 = _RAND_52[2:0];
  _RAND_53 = {1{`RANDOM}};
  replace_12 = _RAND_53[2:0];
  _RAND_54 = {1{`RANDOM}};
  replace_13 = _RAND_54[2:0];
  _RAND_55 = {1{`RANDOM}};
  replace_14 = _RAND_55[2:0];
  _RAND_56 = {1{`RANDOM}};
  replace_15 = _RAND_56[2:0];
  _RAND_57 = {1{`RANDOM}};
  victim = _RAND_57[1:0];
  _RAND_58 = {3{`RANDOM}};
  TagArray_0 = _RAND_58[87:0];
  _RAND_59 = {3{`RANDOM}};
  TagArray_1 = _RAND_59[87:0];
  _RAND_60 = {3{`RANDOM}};
  TagArray_2 = _RAND_60[87:0];
  _RAND_61 = {3{`RANDOM}};
  TagArray_3 = _RAND_61[87:0];
  _RAND_62 = {3{`RANDOM}};
  TagArray_4 = _RAND_62[87:0];
  _RAND_63 = {3{`RANDOM}};
  TagArray_5 = _RAND_63[87:0];
  _RAND_64 = {3{`RANDOM}};
  TagArray_6 = _RAND_64[87:0];
  _RAND_65 = {3{`RANDOM}};
  TagArray_7 = _RAND_65[87:0];
  _RAND_66 = {3{`RANDOM}};
  TagArray_8 = _RAND_66[87:0];
  _RAND_67 = {3{`RANDOM}};
  TagArray_9 = _RAND_67[87:0];
  _RAND_68 = {3{`RANDOM}};
  TagArray_10 = _RAND_68[87:0];
  _RAND_69 = {3{`RANDOM}};
  TagArray_11 = _RAND_69[87:0];
  _RAND_70 = {3{`RANDOM}};
  TagArray_12 = _RAND_70[87:0];
  _RAND_71 = {3{`RANDOM}};
  TagArray_13 = _RAND_71[87:0];
  _RAND_72 = {3{`RANDOM}};
  TagArray_14 = _RAND_72[87:0];
  _RAND_73 = {3{`RANDOM}};
  TagArray_15 = _RAND_73[87:0];
  _RAND_74 = {1{`RANDOM}};
  hit_reg = _RAND_74[0:0];
  _RAND_75 = {1{`RANDOM}};
  ren_reg = _RAND_75[0:0];
  _RAND_76 = {1{`RANDOM}};
  rtag0_buf = _RAND_76[21:0];
  _RAND_77 = {1{`RANDOM}};
  rtag1_buf = _RAND_77[21:0];
  _RAND_78 = {1{`RANDOM}};
  rtag2_buf = _RAND_78[21:0];
  _RAND_79 = {1{`RANDOM}};
  rtag3_buf = _RAND_79[21:0];
  _RAND_80 = {16{`RANDOM}};
  rdata_buf = _RAND_80[511:0];
  _RAND_81 = {2{`RANDOM}};
  refill_buffer_0 = _RAND_81[63:0];
  _RAND_82 = {2{`RANDOM}};
  refill_buffer_1 = _RAND_82[63:0];
  _RAND_83 = {2{`RANDOM}};
  refill_buffer_2 = _RAND_83[63:0];
  _RAND_84 = {2{`RANDOM}};
  refill_buffer_3 = _RAND_84[63:0];
  _RAND_85 = {2{`RANDOM}};
  refill_buffer_4 = _RAND_85[63:0];
  _RAND_86 = {2{`RANDOM}};
  refill_buffer_5 = _RAND_86[63:0];
  _RAND_87 = {2{`RANDOM}};
  refill_buffer_6 = _RAND_87[63:0];
  _RAND_88 = {2{`RANDOM}};
  refill_buffer_7 = _RAND_88[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_22051553_IoforMem(
  input         clock,
  input         reset,
  output        io_axi_req_valid,
  output        io_axi_req_bits_rw,
  output [31:0] io_axi_req_bits_addr,
  output [63:0] io_axi_req_bits_data,
  output [7:0]  io_axi_req_bits_mask,
  output [7:0]  io_axi_req_bits_len,
  output [2:0]  io_axi_req_bits_size,
  input         io_axi_resp_valid,
  input  [63:0] io_axi_resp_bits_data,
  input         io_ex_req,
  input  [31:0] io_excute_addr,
  input  [63:0] io_excute_data,
  input  [7:0]  io_excute_mask,
  input  [2:0]  io_excute_ld_type,
  input  [2:0]  io_excute_sd_type,
  input         io_fetch_req,
  input  [31:0] io_fetch_addr,
  output        io_decode_inst_valid,
  output [63:0] io_decode_inst_bits,
  input         io_decode_load_use,
  output        io_mem_data_valid,
  output [63:0] io_mem_data_bits,
  input         io_fc_stall,
  output [1:0]  io_fc_state
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [63:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [63:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [63:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [63:0] _RAND_43;
  reg [31:0] _RAND_44;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] VmemBuffer_0 [0:15]; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_read_MPORT_en; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_0_read_MPORT_addr; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_0_read_MPORT_data; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_0_MPORT_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_0_MPORT_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_0_MPORT_1_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_0_MPORT_1_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_1_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_1_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_0_MPORT_2_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_0_MPORT_2_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_2_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_2_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_0_MPORT_3_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_0_MPORT_3_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_3_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_3_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_0_MPORT_4_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_0_MPORT_4_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_4_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_4_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_0_MPORT_5_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_0_MPORT_5_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_5_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_5_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_0_MPORT_6_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_0_MPORT_6_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_6_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_6_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_0_MPORT_7_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_0_MPORT_7_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_7_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_7_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_0_MPORT_8_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_0_MPORT_8_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_8_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_8_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_0_MPORT_9_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_0_MPORT_9_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_9_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_9_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_0_MPORT_10_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_0_MPORT_10_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_10_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_10_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_0_MPORT_11_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_0_MPORT_11_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_11_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_11_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_0_MPORT_12_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_0_MPORT_12_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_12_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_12_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_0_MPORT_13_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_0_MPORT_13_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_13_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_13_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_0_MPORT_14_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_0_MPORT_14_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_14_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_14_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_0_MPORT_15_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_0_MPORT_15_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_15_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_15_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_0_MPORT_16_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_0_MPORT_16_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_16_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_16_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_0_MPORT_17_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_0_MPORT_17_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_17_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_0_MPORT_17_en; // @[IoforMem.scala 146:25]
  reg [7:0] VmemBuffer_1 [0:15]; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_read_MPORT_en; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_1_read_MPORT_addr; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_1_read_MPORT_data; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_1_MPORT_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_1_MPORT_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_1_MPORT_1_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_1_MPORT_1_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_1_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_1_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_1_MPORT_2_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_1_MPORT_2_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_2_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_2_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_1_MPORT_3_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_1_MPORT_3_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_3_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_3_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_1_MPORT_4_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_1_MPORT_4_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_4_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_4_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_1_MPORT_5_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_1_MPORT_5_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_5_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_5_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_1_MPORT_6_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_1_MPORT_6_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_6_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_6_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_1_MPORT_7_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_1_MPORT_7_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_7_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_7_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_1_MPORT_8_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_1_MPORT_8_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_8_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_8_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_1_MPORT_9_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_1_MPORT_9_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_9_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_9_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_1_MPORT_10_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_1_MPORT_10_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_10_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_10_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_1_MPORT_11_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_1_MPORT_11_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_11_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_11_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_1_MPORT_12_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_1_MPORT_12_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_12_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_12_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_1_MPORT_13_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_1_MPORT_13_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_13_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_13_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_1_MPORT_14_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_1_MPORT_14_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_14_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_14_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_1_MPORT_15_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_1_MPORT_15_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_15_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_15_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_1_MPORT_16_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_1_MPORT_16_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_16_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_16_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_1_MPORT_17_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_1_MPORT_17_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_17_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_1_MPORT_17_en; // @[IoforMem.scala 146:25]
  reg [7:0] VmemBuffer_2 [0:15]; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_read_MPORT_en; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_2_read_MPORT_addr; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_2_read_MPORT_data; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_2_MPORT_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_2_MPORT_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_2_MPORT_1_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_2_MPORT_1_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_1_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_1_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_2_MPORT_2_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_2_MPORT_2_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_2_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_2_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_2_MPORT_3_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_2_MPORT_3_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_3_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_3_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_2_MPORT_4_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_2_MPORT_4_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_4_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_4_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_2_MPORT_5_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_2_MPORT_5_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_5_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_5_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_2_MPORT_6_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_2_MPORT_6_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_6_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_6_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_2_MPORT_7_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_2_MPORT_7_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_7_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_7_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_2_MPORT_8_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_2_MPORT_8_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_8_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_8_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_2_MPORT_9_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_2_MPORT_9_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_9_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_9_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_2_MPORT_10_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_2_MPORT_10_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_10_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_10_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_2_MPORT_11_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_2_MPORT_11_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_11_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_11_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_2_MPORT_12_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_2_MPORT_12_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_12_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_12_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_2_MPORT_13_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_2_MPORT_13_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_13_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_13_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_2_MPORT_14_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_2_MPORT_14_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_14_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_14_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_2_MPORT_15_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_2_MPORT_15_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_15_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_15_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_2_MPORT_16_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_2_MPORT_16_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_16_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_16_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_2_MPORT_17_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_2_MPORT_17_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_17_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_2_MPORT_17_en; // @[IoforMem.scala 146:25]
  reg [7:0] VmemBuffer_3 [0:15]; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_read_MPORT_en; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_3_read_MPORT_addr; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_3_read_MPORT_data; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_3_MPORT_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_3_MPORT_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_3_MPORT_1_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_3_MPORT_1_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_1_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_1_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_3_MPORT_2_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_3_MPORT_2_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_2_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_2_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_3_MPORT_3_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_3_MPORT_3_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_3_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_3_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_3_MPORT_4_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_3_MPORT_4_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_4_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_4_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_3_MPORT_5_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_3_MPORT_5_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_5_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_5_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_3_MPORT_6_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_3_MPORT_6_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_6_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_6_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_3_MPORT_7_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_3_MPORT_7_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_7_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_7_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_3_MPORT_8_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_3_MPORT_8_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_8_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_8_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_3_MPORT_9_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_3_MPORT_9_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_9_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_9_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_3_MPORT_10_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_3_MPORT_10_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_10_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_10_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_3_MPORT_11_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_3_MPORT_11_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_11_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_11_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_3_MPORT_12_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_3_MPORT_12_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_12_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_12_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_3_MPORT_13_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_3_MPORT_13_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_13_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_13_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_3_MPORT_14_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_3_MPORT_14_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_14_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_14_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_3_MPORT_15_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_3_MPORT_15_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_15_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_15_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_3_MPORT_16_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_3_MPORT_16_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_16_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_16_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_3_MPORT_17_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_3_MPORT_17_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_17_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_3_MPORT_17_en; // @[IoforMem.scala 146:25]
  reg [7:0] VmemBuffer_4 [0:15]; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_read_MPORT_en; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_4_read_MPORT_addr; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_4_read_MPORT_data; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_4_MPORT_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_4_MPORT_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_4_MPORT_1_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_4_MPORT_1_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_1_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_1_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_4_MPORT_2_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_4_MPORT_2_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_2_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_2_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_4_MPORT_3_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_4_MPORT_3_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_3_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_3_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_4_MPORT_4_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_4_MPORT_4_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_4_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_4_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_4_MPORT_5_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_4_MPORT_5_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_5_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_5_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_4_MPORT_6_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_4_MPORT_6_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_6_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_6_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_4_MPORT_7_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_4_MPORT_7_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_7_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_7_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_4_MPORT_8_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_4_MPORT_8_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_8_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_8_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_4_MPORT_9_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_4_MPORT_9_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_9_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_9_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_4_MPORT_10_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_4_MPORT_10_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_10_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_10_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_4_MPORT_11_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_4_MPORT_11_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_11_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_11_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_4_MPORT_12_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_4_MPORT_12_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_12_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_12_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_4_MPORT_13_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_4_MPORT_13_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_13_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_13_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_4_MPORT_14_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_4_MPORT_14_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_14_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_14_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_4_MPORT_15_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_4_MPORT_15_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_15_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_15_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_4_MPORT_16_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_4_MPORT_16_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_16_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_16_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_4_MPORT_17_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_4_MPORT_17_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_17_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_4_MPORT_17_en; // @[IoforMem.scala 146:25]
  reg [7:0] VmemBuffer_5 [0:15]; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_read_MPORT_en; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_5_read_MPORT_addr; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_5_read_MPORT_data; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_5_MPORT_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_5_MPORT_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_5_MPORT_1_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_5_MPORT_1_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_1_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_1_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_5_MPORT_2_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_5_MPORT_2_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_2_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_2_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_5_MPORT_3_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_5_MPORT_3_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_3_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_3_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_5_MPORT_4_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_5_MPORT_4_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_4_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_4_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_5_MPORT_5_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_5_MPORT_5_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_5_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_5_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_5_MPORT_6_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_5_MPORT_6_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_6_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_6_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_5_MPORT_7_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_5_MPORT_7_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_7_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_7_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_5_MPORT_8_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_5_MPORT_8_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_8_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_8_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_5_MPORT_9_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_5_MPORT_9_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_9_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_9_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_5_MPORT_10_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_5_MPORT_10_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_10_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_10_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_5_MPORT_11_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_5_MPORT_11_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_11_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_11_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_5_MPORT_12_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_5_MPORT_12_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_12_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_12_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_5_MPORT_13_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_5_MPORT_13_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_13_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_13_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_5_MPORT_14_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_5_MPORT_14_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_14_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_14_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_5_MPORT_15_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_5_MPORT_15_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_15_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_15_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_5_MPORT_16_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_5_MPORT_16_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_16_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_16_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_5_MPORT_17_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_5_MPORT_17_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_17_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_5_MPORT_17_en; // @[IoforMem.scala 146:25]
  reg [7:0] VmemBuffer_6 [0:15]; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_read_MPORT_en; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_6_read_MPORT_addr; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_6_read_MPORT_data; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_6_MPORT_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_6_MPORT_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_6_MPORT_1_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_6_MPORT_1_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_1_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_1_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_6_MPORT_2_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_6_MPORT_2_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_2_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_2_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_6_MPORT_3_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_6_MPORT_3_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_3_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_3_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_6_MPORT_4_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_6_MPORT_4_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_4_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_4_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_6_MPORT_5_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_6_MPORT_5_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_5_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_5_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_6_MPORT_6_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_6_MPORT_6_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_6_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_6_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_6_MPORT_7_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_6_MPORT_7_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_7_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_7_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_6_MPORT_8_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_6_MPORT_8_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_8_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_8_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_6_MPORT_9_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_6_MPORT_9_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_9_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_9_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_6_MPORT_10_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_6_MPORT_10_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_10_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_10_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_6_MPORT_11_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_6_MPORT_11_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_11_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_11_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_6_MPORT_12_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_6_MPORT_12_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_12_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_12_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_6_MPORT_13_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_6_MPORT_13_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_13_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_13_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_6_MPORT_14_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_6_MPORT_14_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_14_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_14_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_6_MPORT_15_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_6_MPORT_15_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_15_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_15_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_6_MPORT_16_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_6_MPORT_16_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_16_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_16_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_6_MPORT_17_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_6_MPORT_17_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_17_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_6_MPORT_17_en; // @[IoforMem.scala 146:25]
  reg [7:0] VmemBuffer_7 [0:15]; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_read_MPORT_en; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_7_read_MPORT_addr; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_7_read_MPORT_data; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_7_MPORT_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_7_MPORT_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_7_MPORT_1_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_7_MPORT_1_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_1_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_1_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_7_MPORT_2_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_7_MPORT_2_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_2_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_2_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_7_MPORT_3_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_7_MPORT_3_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_3_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_3_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_7_MPORT_4_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_7_MPORT_4_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_4_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_4_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_7_MPORT_5_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_7_MPORT_5_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_5_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_5_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_7_MPORT_6_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_7_MPORT_6_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_6_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_6_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_7_MPORT_7_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_7_MPORT_7_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_7_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_7_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_7_MPORT_8_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_7_MPORT_8_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_8_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_8_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_7_MPORT_9_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_7_MPORT_9_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_9_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_9_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_7_MPORT_10_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_7_MPORT_10_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_10_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_10_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_7_MPORT_11_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_7_MPORT_11_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_11_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_11_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_7_MPORT_12_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_7_MPORT_12_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_12_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_12_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_7_MPORT_13_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_7_MPORT_13_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_13_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_13_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_7_MPORT_14_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_7_MPORT_14_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_14_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_14_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_7_MPORT_15_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_7_MPORT_15_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_15_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_15_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_7_MPORT_16_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_7_MPORT_16_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_16_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_16_en; // @[IoforMem.scala 146:25]
  wire [7:0] VmemBuffer_7_MPORT_17_data; // @[IoforMem.scala 146:25]
  wire [3:0] VmemBuffer_7_MPORT_17_addr; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_17_mask; // @[IoforMem.scala 146:25]
  wire  VmemBuffer_7_MPORT_17_en; // @[IoforMem.scala 146:25]
  reg [1:0] state; // @[IoforMem.scala 71:24]
  reg  fetch_buffer; // @[IoforMem.scala 73:31]
  wire  excute_rw = ~(|io_excute_mask); // @[IoforMem.scala 77:21]
  reg [1:0] choose_buffer; // @[IoforMem.scala 87:32]
  reg  load_use_local; // @[IoforMem.scala 89:33]
  wire [1:0] _master_choose_T = io_fetch_req ? 2'h3 : 2'h0; // @[Mux.scala 101:16]
  wire [1:0] master_choose = io_ex_req ? 2'h2 : _master_choose_T; // @[Mux.scala 101:16]
  wire [7:0] _mask_T_2 = master_choose[0] ? 8'h0 : io_excute_mask; // @[IoforMem.scala 131:12]
  reg  mem_data_valid; // @[IoforMem.scala 139:33]
  reg [63:0] mem_data_bits; // @[IoforMem.scala 140:32]
  reg  decode_inst_valid; // @[IoforMem.scala 142:36]
  reg [63:0] decode_inst; // @[IoforMem.scala 143:30]
  reg [7:0] maskbuffer_0; // @[IoforMem.scala 148:29]
  reg [7:0] maskbuffer_1; // @[IoforMem.scala 148:29]
  reg [7:0] maskbuffer_2; // @[IoforMem.scala 148:29]
  reg [7:0] maskbuffer_3; // @[IoforMem.scala 148:29]
  reg [7:0] maskbuffer_4; // @[IoforMem.scala 148:29]
  reg [7:0] maskbuffer_5; // @[IoforMem.scala 148:29]
  reg [7:0] maskbuffer_6; // @[IoforMem.scala 148:29]
  reg [7:0] maskbuffer_7; // @[IoforMem.scala 148:29]
  reg [7:0] maskbuffer_8; // @[IoforMem.scala 148:29]
  reg [7:0] maskbuffer_9; // @[IoforMem.scala 148:29]
  reg [7:0] maskbuffer_10; // @[IoforMem.scala 148:29]
  reg [7:0] maskbuffer_11; // @[IoforMem.scala 148:29]
  reg [7:0] maskbuffer_12; // @[IoforMem.scala 148:29]
  reg [7:0] maskbuffer_13; // @[IoforMem.scala 148:29]
  reg [7:0] maskbuffer_14; // @[IoforMem.scala 148:29]
  reg [7:0] maskbuffer_15; // @[IoforMem.scala 148:29]
  reg [3:0] r_count; // @[IoforMem.scala 150:26]
  reg [31:0] last_addr; // @[IoforMem.scala 156:28]
  reg  begin_flag; // @[IoforMem.scala 157:29]
  reg [31:0] begin_waddr; // @[IoforMem.scala 158:30]
  reg [3:0] data_count; // @[IoforMem.scala 160:29]
  reg [3:0] wait_cycle; // @[IoforMem.scala 161:29]
  reg [63:0] jump_data; // @[IoforMem.scala 164:28]
  reg [7:0] jump_mask; // @[IoforMem.scala 165:28]
  reg [31:0] jump_addr; // @[IoforMem.scala 166:28]
  wire [7:0] _GEN_2 = 4'h1 == r_count ? maskbuffer_1 : maskbuffer_0; // @[IoforMem.scala 170:{18,18}]
  wire [7:0] _GEN_3 = 4'h2 == r_count ? maskbuffer_2 : _GEN_2; // @[IoforMem.scala 170:{18,18}]
  wire [7:0] _GEN_4 = 4'h3 == r_count ? maskbuffer_3 : _GEN_3; // @[IoforMem.scala 170:{18,18}]
  wire [7:0] _GEN_5 = 4'h4 == r_count ? maskbuffer_4 : _GEN_4; // @[IoforMem.scala 170:{18,18}]
  wire [7:0] _GEN_6 = 4'h5 == r_count ? maskbuffer_5 : _GEN_5; // @[IoforMem.scala 170:{18,18}]
  wire [7:0] _GEN_7 = 4'h6 == r_count ? maskbuffer_6 : _GEN_6; // @[IoforMem.scala 170:{18,18}]
  wire [7:0] _GEN_8 = 4'h7 == r_count ? maskbuffer_7 : _GEN_7; // @[IoforMem.scala 170:{18,18}]
  wire [7:0] _GEN_9 = 4'h8 == r_count ? maskbuffer_8 : _GEN_8; // @[IoforMem.scala 170:{18,18}]
  wire [7:0] _GEN_10 = 4'h9 == r_count ? maskbuffer_9 : _GEN_9; // @[IoforMem.scala 170:{18,18}]
  wire [7:0] _GEN_11 = 4'ha == r_count ? maskbuffer_10 : _GEN_10; // @[IoforMem.scala 170:{18,18}]
  wire [7:0] _GEN_12 = 4'hb == r_count ? maskbuffer_11 : _GEN_11; // @[IoforMem.scala 170:{18,18}]
  wire [7:0] _GEN_13 = 4'hc == r_count ? maskbuffer_12 : _GEN_12; // @[IoforMem.scala 170:{18,18}]
  wire [7:0] _GEN_14 = 4'hd == r_count ? maskbuffer_13 : _GEN_13; // @[IoforMem.scala 170:{18,18}]
  wire [7:0] _GEN_15 = 4'he == r_count ? maskbuffer_14 : _GEN_14; // @[IoforMem.scala 170:{18,18}]
  wire [7:0] mask_forVmem = 4'hf == r_count ? maskbuffer_15 : _GEN_15; // @[IoforMem.scala 170:{18,18}]
  reg [31:0] addr_buf; // @[IoforMem.scala 197:27]
  reg  rw_buf; // @[IoforMem.scala 198:25]
  reg [63:0] data_buf; // @[IoforMem.scala 200:27]
  reg [7:0] mask_buf; // @[IoforMem.scala 201:27]
  wire  _T = 2'h0 == state; // @[IoforMem.scala 204:18]
  wire  _T_1 = ~io_fc_stall; // @[IoforMem.scala 207:22]
  wire [3:0] _wait_cycle_T_1 = wait_cycle + 4'h1; // @[IoforMem.scala 221:50]
  wire [3:0] _GEN_19 = begin_flag ? _wait_cycle_T_1 : wait_cycle; // @[IoforMem.scala 161:29 220:37 221:36]
  wire  _T_4 = wait_cycle == 4'hf; // @[IoforMem.scala 224:51]
  wire [31:0] _io_axi_req_bits_addr_T_1 = {begin_waddr[31:3],3'h0}; // @[Cat.scala 33:92]
  wire [3:0] _data_count_T_1 = data_count - 4'h1; // @[IoforMem.scala 233:54]
  wire [3:0] _GEN_20 = io_fc_stall ? 4'hf : 4'h0; // @[IoforMem.scala 225:50 226:40 234:40]
  wire [1:0] _GEN_21 = io_fc_stall ? state : 2'h2; // @[IoforMem.scala 225:50 71:24 228:35]
  wire  _GEN_22 = io_fc_stall ? 1'h0 : 1'h1; // @[IoforMem.scala 173:22 225:50 229:46]
  wire [31:0] _GEN_23 = io_fc_stall ? 32'h0 : _io_axi_req_bits_addr_T_1; // @[IoforMem.scala 175:26 225:50 230:50]
  wire [3:0] _GEN_25 = io_fc_stall ? 4'h0 : 4'hf; // @[IoforMem.scala 178:25 225:50 232:49]
  wire [3:0] _GEN_26 = io_fc_stall ? data_count : _data_count_T_1; // @[IoforMem.scala 160:29 225:50 233:40]
  wire [3:0] _GEN_27 = begin_flag & wait_cycle == 4'hf ? _GEN_20 : _GEN_19; // @[IoforMem.scala 224:60]
  wire [1:0] _GEN_28 = begin_flag & wait_cycle == 4'hf ? _GEN_21 : state; // @[IoforMem.scala 224:60 71:24]
  wire  _GEN_29 = begin_flag & wait_cycle == 4'hf & _GEN_22; // @[IoforMem.scala 173:22 224:60]
  wire [31:0] _GEN_30 = begin_flag & wait_cycle == 4'hf ? _GEN_23 : 32'h0; // @[IoforMem.scala 175:26 224:60]
  wire [3:0] _GEN_32 = begin_flag & wait_cycle == 4'hf ? _GEN_25 : 4'h0; // @[IoforMem.scala 178:25 224:60]
  wire [3:0] _GEN_33 = begin_flag & wait_cycle == 4'hf ? _GEN_26 : data_count; // @[IoforMem.scala 160:29 224:60]
  wire [31:0] _GEN_34 = ~begin_flag ? io_excute_addr : begin_waddr; // @[IoforMem.scala 158:30 257:53 258:45]
  wire  _GEN_35 = ~begin_flag | begin_flag; // @[IoforMem.scala 157:29 257:53 259:44]
  wire [7:0] _GEN_52 = 4'h0 == data_count ? io_excute_mask : maskbuffer_0; // @[IoforMem.scala 148:29 264:{52,52}]
  wire [7:0] _GEN_53 = 4'h1 == data_count ? io_excute_mask : maskbuffer_1; // @[IoforMem.scala 148:29 264:{52,52}]
  wire [7:0] _GEN_54 = 4'h2 == data_count ? io_excute_mask : maskbuffer_2; // @[IoforMem.scala 148:29 264:{52,52}]
  wire [7:0] _GEN_55 = 4'h3 == data_count ? io_excute_mask : maskbuffer_3; // @[IoforMem.scala 148:29 264:{52,52}]
  wire [7:0] _GEN_56 = 4'h4 == data_count ? io_excute_mask : maskbuffer_4; // @[IoforMem.scala 148:29 264:{52,52}]
  wire [7:0] _GEN_57 = 4'h5 == data_count ? io_excute_mask : maskbuffer_5; // @[IoforMem.scala 148:29 264:{52,52}]
  wire [7:0] _GEN_58 = 4'h6 == data_count ? io_excute_mask : maskbuffer_6; // @[IoforMem.scala 148:29 264:{52,52}]
  wire [7:0] _GEN_59 = 4'h7 == data_count ? io_excute_mask : maskbuffer_7; // @[IoforMem.scala 148:29 264:{52,52}]
  wire [7:0] _GEN_60 = 4'h8 == data_count ? io_excute_mask : maskbuffer_8; // @[IoforMem.scala 148:29 264:{52,52}]
  wire [7:0] _GEN_61 = 4'h9 == data_count ? io_excute_mask : maskbuffer_9; // @[IoforMem.scala 148:29 264:{52,52}]
  wire [7:0] _GEN_62 = 4'ha == data_count ? io_excute_mask : maskbuffer_10; // @[IoforMem.scala 148:29 264:{52,52}]
  wire [7:0] _GEN_63 = 4'hb == data_count ? io_excute_mask : maskbuffer_11; // @[IoforMem.scala 148:29 264:{52,52}]
  wire [7:0] _GEN_64 = 4'hc == data_count ? io_excute_mask : maskbuffer_12; // @[IoforMem.scala 148:29 264:{52,52}]
  wire [7:0] _GEN_65 = 4'hd == data_count ? io_excute_mask : maskbuffer_13; // @[IoforMem.scala 148:29 264:{52,52}]
  wire [7:0] _GEN_66 = 4'he == data_count ? io_excute_mask : maskbuffer_14; // @[IoforMem.scala 148:29 264:{52,52}]
  wire [7:0] _GEN_67 = 4'hf == data_count ? io_excute_mask : maskbuffer_15; // @[IoforMem.scala 148:29 264:{52,52}]
  wire [31:0] _last_addr_T_1 = io_excute_addr + 32'h8; // @[IoforMem.scala 265:54]
  wire [3:0] _data_count_T_5 = data_count + 4'h1; // @[IoforMem.scala 266:54]
  wire [1:0] _GEN_68 = _T_4 | data_count == 4'hf ? 2'h2 : _GEN_28; // @[IoforMem.scala 269:77 270:39]
  wire  _GEN_69 = _T_4 | data_count == 4'hf | _GEN_29; // @[IoforMem.scala 269:77 271:50]
  wire [31:0] _GEN_70 = _T_4 | data_count == 4'hf ? _io_axi_req_bits_addr_T_1 : _GEN_30; // @[IoforMem.scala 269:77 272:54]
  wire [3:0] _GEN_72 = _T_4 | data_count == 4'hf ? 4'hf : _GEN_32; // @[IoforMem.scala 269:77 274:53]
  wire [3:0] _GEN_73 = _T_4 | data_count == 4'hf ? data_count : _data_count_T_5; // @[IoforMem.scala 266:40 269:77 275:44]
  wire [1:0] _GEN_74 = begin_flag & last_addr != io_excute_addr ? 2'h2 : _GEN_68; // @[IoforMem.scala 244:72 245:35]
  wire  _GEN_75 = begin_flag & last_addr != io_excute_addr | _GEN_69; // @[IoforMem.scala 244:72 246:46]
  wire [31:0] _GEN_76 = begin_flag & last_addr != io_excute_addr ? _io_axi_req_bits_addr_T_1 : _GEN_70; // @[IoforMem.scala 244:72 247:50]
  wire [3:0] _GEN_78 = begin_flag & last_addr != io_excute_addr ? 4'hf : _GEN_72; // @[IoforMem.scala 244:72 249:49]
  wire [3:0] _GEN_79 = begin_flag & last_addr != io_excute_addr ? _data_count_T_1 : _GEN_73; // @[IoforMem.scala 244:72 250:40]
  wire [63:0] _GEN_80 = begin_flag & last_addr != io_excute_addr ? io_excute_data : jump_data; // @[IoforMem.scala 164:28 244:72 252:39]
  wire [31:0] _GEN_81 = begin_flag & last_addr != io_excute_addr ? io_excute_addr : jump_addr; // @[IoforMem.scala 166:28 244:72 253:39]
  wire [7:0] _GEN_82 = begin_flag & last_addr != io_excute_addr ? io_excute_mask : jump_mask; // @[IoforMem.scala 165:28 244:72 254:39]
  wire [31:0] _GEN_83 = begin_flag & last_addr != io_excute_addr ? begin_waddr : _GEN_34; // @[IoforMem.scala 158:30 244:72]
  wire  _GEN_84 = begin_flag & last_addr != io_excute_addr ? begin_flag : _GEN_35; // @[IoforMem.scala 157:29 244:72]
  wire  _GEN_87 = begin_flag & last_addr != io_excute_addr ? 1'h0 : 1'h1; // @[IoforMem.scala 146:25 244:72]
  wire [7:0] _GEN_104 = begin_flag & last_addr != io_excute_addr ? maskbuffer_0 : _GEN_52; // @[IoforMem.scala 148:29 244:72]
  wire [7:0] _GEN_105 = begin_flag & last_addr != io_excute_addr ? maskbuffer_1 : _GEN_53; // @[IoforMem.scala 148:29 244:72]
  wire [7:0] _GEN_106 = begin_flag & last_addr != io_excute_addr ? maskbuffer_2 : _GEN_54; // @[IoforMem.scala 148:29 244:72]
  wire [7:0] _GEN_107 = begin_flag & last_addr != io_excute_addr ? maskbuffer_3 : _GEN_55; // @[IoforMem.scala 148:29 244:72]
  wire [7:0] _GEN_108 = begin_flag & last_addr != io_excute_addr ? maskbuffer_4 : _GEN_56; // @[IoforMem.scala 148:29 244:72]
  wire [7:0] _GEN_109 = begin_flag & last_addr != io_excute_addr ? maskbuffer_5 : _GEN_57; // @[IoforMem.scala 148:29 244:72]
  wire [7:0] _GEN_110 = begin_flag & last_addr != io_excute_addr ? maskbuffer_6 : _GEN_58; // @[IoforMem.scala 148:29 244:72]
  wire [7:0] _GEN_111 = begin_flag & last_addr != io_excute_addr ? maskbuffer_7 : _GEN_59; // @[IoforMem.scala 148:29 244:72]
  wire [7:0] _GEN_112 = begin_flag & last_addr != io_excute_addr ? maskbuffer_8 : _GEN_60; // @[IoforMem.scala 148:29 244:72]
  wire [7:0] _GEN_113 = begin_flag & last_addr != io_excute_addr ? maskbuffer_9 : _GEN_61; // @[IoforMem.scala 148:29 244:72]
  wire [7:0] _GEN_114 = begin_flag & last_addr != io_excute_addr ? maskbuffer_10 : _GEN_62; // @[IoforMem.scala 148:29 244:72]
  wire [7:0] _GEN_115 = begin_flag & last_addr != io_excute_addr ? maskbuffer_11 : _GEN_63; // @[IoforMem.scala 148:29 244:72]
  wire [7:0] _GEN_116 = begin_flag & last_addr != io_excute_addr ? maskbuffer_12 : _GEN_64; // @[IoforMem.scala 148:29 244:72]
  wire [7:0] _GEN_117 = begin_flag & last_addr != io_excute_addr ? maskbuffer_13 : _GEN_65; // @[IoforMem.scala 148:29 244:72]
  wire [7:0] _GEN_118 = begin_flag & last_addr != io_excute_addr ? maskbuffer_14 : _GEN_66; // @[IoforMem.scala 148:29 244:72]
  wire [7:0] _GEN_119 = begin_flag & last_addr != io_excute_addr ? maskbuffer_15 : _GEN_67; // @[IoforMem.scala 148:29 244:72]
  wire [31:0] _GEN_120 = begin_flag & last_addr != io_excute_addr ? last_addr : _last_addr_T_1; // @[IoforMem.scala 156:28 244:72 265:39]
  wire [3:0] _GEN_121 = begin_flag & last_addr != io_excute_addr ? _GEN_27 : 4'h0; // @[IoforMem.scala 244:72 267:40]
  wire [1:0] _io_axi_req_bits_size_T_5 = 3'h3 == io_excute_sd_type ? 2'h2 : {{1'd0}, 3'h2 == io_excute_sd_type}; // @[Mux.scala 81:58]
  wire [1:0] _io_axi_req_bits_size_T_7 = 3'h4 == io_excute_sd_type ? 2'h3 : _io_axi_req_bits_size_T_5; // @[Mux.scala 81:58]
  wire [1:0] _io_axi_req_bits_size_T_13 = 3'h3 == io_excute_ld_type ? 2'h2 : {{1'd0}, 3'h2 == io_excute_ld_type}; // @[Mux.scala 81:58]
  wire [1:0] _io_axi_req_bits_size_T_15 = 3'h4 == io_excute_ld_type ? 2'h3 : _io_axi_req_bits_size_T_13; // @[Mux.scala 81:58]
  wire [1:0] _io_axi_req_bits_size_T_16 = excute_rw ? _io_axi_req_bits_size_T_7 : _io_axi_req_bits_size_T_15; // @[IoforMem.scala 288:52]
  wire  _GEN_124 = ~excute_rw & io_excute_addr == 32'h0 ? _GEN_75 : 1'h1; // @[IoforMem.scala 241:70 282:42]
  wire [31:0] _GEN_125 = ~excute_rw & io_excute_addr == 32'h0 ? _GEN_76 : io_excute_addr; // @[IoforMem.scala 241:70 284:46]
  wire  _GEN_126 = ~excute_rw & io_excute_addr == 32'h0 ? 1'h0 : excute_rw; // @[IoforMem.scala 241:70 283:44]
  wire [3:0] _GEN_127 = ~excute_rw & io_excute_addr == 32'h0 ? _GEN_78 : 4'h0; // @[IoforMem.scala 241:70 287:45]
  wire  _GEN_136 = ~excute_rw & io_excute_addr == 32'h0 & _GEN_87; // @[IoforMem.scala 146:25 241:70]
  wire [63:0] _GEN_171 = ~excute_rw & io_excute_addr == 32'h0 ? 64'h0 : io_excute_data; // @[IoforMem.scala 176:26 241:70 285:46]
  wire [7:0] _GEN_172 = ~excute_rw & io_excute_addr == 32'h0 ? 8'h0 : io_excute_mask; // @[IoforMem.scala 177:26 241:70 286:46]
  wire [1:0] _GEN_173 = ~excute_rw & io_excute_addr == 32'h0 ? 2'h0 : _io_axi_req_bits_size_T_16; // @[IoforMem.scala 179:26 241:70 288:46]
  wire  _T_25 = io_fetch_req & _T_1; // @[IoforMem.scala 311:39]
  wire [31:0] _io_axi_req_bits_addr_T_7 = {io_fetch_addr[31:2],2'h0}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_179 = io_fetch_req & _T_1 ? _io_axi_req_bits_addr_T_7 : 32'h0; // @[IoforMem.scala 175:26 311:55 317:42]
  wire [1:0] _GEN_181 = io_fetch_req & _T_1 ? 2'h2 : 2'h0; // @[IoforMem.scala 179:26 311:55 319:42]
  wire  _GEN_183 = io_fetch_req & _T_1 | rw_buf; // @[IoforMem.scala 198:25 311:55 322:28]
  wire  _GEN_184 = io_fetch_req & _T_1 | fetch_buffer; // @[IoforMem.scala 311:55 324:34 73:31]
  wire  _GEN_190 = io_ex_req & _T_1 ? _GEN_124 : _T_25; // @[IoforMem.scala 214:49]
  wire [31:0] _GEN_191 = io_ex_req & _T_1 ? _GEN_125 : _GEN_179; // @[IoforMem.scala 214:49]
  wire  _GEN_192 = io_ex_req & _T_1 ? _GEN_126 : _T_25; // @[IoforMem.scala 214:49]
  wire [3:0] _GEN_193 = io_ex_req & _T_1 ? _GEN_127 : 4'h0; // @[IoforMem.scala 214:49]
  wire  _GEN_203 = io_ex_req & _T_1 & _GEN_136; // @[IoforMem.scala 146:25 214:49]
  wire [63:0] _GEN_237 = io_ex_req & _T_1 ? _GEN_171 : 64'h0; // @[IoforMem.scala 176:26 214:49]
  wire [7:0] _GEN_238 = io_ex_req & _T_1 ? _GEN_172 : 8'h0; // @[IoforMem.scala 177:26 214:49]
  wire [1:0] _GEN_239 = io_ex_req & _T_1 ? _GEN_173 : _GEN_181; // @[IoforMem.scala 214:49]
  wire  _T_29 = io_fetch_req & ~fetch_buffer; // @[IoforMem.scala 342:36]
  wire  _GEN_243 = io_ex_req ? 1'h0 : fetch_buffer; // @[IoforMem.scala 356:42 357:38 73:31]
  wire [1:0] _GEN_244 = io_ex_req ? 2'h0 : state; // @[IoforMem.scala 356:42 358:31 71:24]
  wire [1:0] _GEN_245 = io_fetch_req & ~fetch_buffer ? 2'h1 : _GEN_244; // @[IoforMem.scala 342:53 343:31]
  wire [1:0] _GEN_246 = io_fetch_req & ~fetch_buffer ? 2'h3 : choose_buffer; // @[IoforMem.scala 342:53 345:39 87:32]
  wire [31:0] _GEN_248 = io_fetch_req & ~fetch_buffer ? _io_axi_req_bits_addr_T_7 : 32'h0; // @[IoforMem.scala 175:26 342:53 348:46]
  wire [1:0] _GEN_250 = io_fetch_req & ~fetch_buffer ? 2'h2 : 2'h0; // @[IoforMem.scala 179:26 342:53 350:46]
  wire [31:0] _GEN_251 = io_fetch_req & ~fetch_buffer ? io_axi_req_bits_addr : addr_buf; // @[IoforMem.scala 197:27 342:53 352:34]
  wire  _GEN_252 = io_fetch_req & ~fetch_buffer | rw_buf; // @[IoforMem.scala 198:25 342:53 353:32]
  wire  _GEN_253 = io_fetch_req & ~fetch_buffer ? fetch_buffer : _GEN_243; // @[IoforMem.scala 342:53 73:31]
  wire  _GEN_254 = choose_buffer[0] | decode_inst_valid; // @[IoforMem.scala 142:36 331:39 332:39]
  wire [63:0] _GEN_255 = choose_buffer[0] ? io_axi_resp_bits_data : decode_inst; // @[IoforMem.scala 143:30 331:39 333:33]
  wire [1:0] _GEN_256 = choose_buffer[0] ? 2'h0 : _GEN_245; // @[IoforMem.scala 331:39 335:27]
  wire  _GEN_257 = choose_buffer[0] ? 1'h0 : _GEN_253; // @[IoforMem.scala 331:39 337:34]
  wire  _GEN_258 = choose_buffer[0] ? mem_data_valid : 1'h1; // @[IoforMem.scala 139:33 331:39 339:36]
  wire [63:0] _GEN_259 = choose_buffer[0] ? mem_data_bits : io_axi_resp_bits_data; // @[IoforMem.scala 140:32 331:39 340:35]
  wire [1:0] _GEN_260 = choose_buffer[0] ? choose_buffer : _GEN_246; // @[IoforMem.scala 331:39 87:32]
  wire  _GEN_261 = choose_buffer[0] ? 1'h0 : _T_29; // @[IoforMem.scala 173:22 331:39]
  wire [31:0] _GEN_262 = choose_buffer[0] ? 32'h0 : _GEN_248; // @[IoforMem.scala 175:26 331:39]
  wire [1:0] _GEN_264 = choose_buffer[0] ? 2'h0 : _GEN_250; // @[IoforMem.scala 179:26 331:39]
  wire [31:0] _GEN_265 = choose_buffer[0] ? addr_buf : _GEN_251; // @[IoforMem.scala 197:27 331:39]
  wire  _GEN_266 = choose_buffer[0] ? rw_buf : _GEN_252; // @[IoforMem.scala 198:25 331:39]
  wire  _GEN_274 = io_axi_resp_valid ? _GEN_261 : 1'h1; // @[IoforMem.scala 330:36 366:34]
  wire  _GEN_275 = io_axi_resp_valid ? _GEN_261 : rw_buf; // @[IoforMem.scala 330:36 370:36]
  wire [31:0] _GEN_276 = io_axi_resp_valid ? _GEN_262 : addr_buf; // @[IoforMem.scala 330:36 367:38]
  wire [1:0] _GEN_278 = io_axi_resp_valid ? _GEN_264 : 2'h0; // @[IoforMem.scala 179:26 330:36]
  wire [63:0] _GEN_281 = io_axi_resp_valid ? 64'h0 : data_buf; // @[IoforMem.scala 176:26 330:36 368:38]
  wire [7:0] _GEN_282 = io_axi_resp_valid ? 8'h0 : mask_buf; // @[IoforMem.scala 177:26 330:36 369:38]
  wire  _T_31 = jump_addr != 32'h0; // @[IoforMem.scala 385:32]
  wire [31:0] _last_addr_T_3 = jump_addr + 32'h8; // @[IoforMem.scala 389:44]
  wire [7:0] _GEN_318 = jump_addr != 32'h0 ? jump_mask : maskbuffer_0; // @[IoforMem.scala 148:29 385:40 388:35]
  wire [31:0] _GEN_319 = jump_addr != 32'h0 ? _last_addr_T_3 : last_addr; // @[IoforMem.scala 156:28 385:40 389:31]
  wire [31:0] _GEN_320 = jump_addr != 32'h0 ? jump_addr : begin_waddr; // @[IoforMem.scala 158:30 385:40 393:33]
  wire  _GEN_323 = jump_addr != 32'h0 ? 1'h0 : 1'h1; // @[IoforMem.scala 146:25 385:40]
  wire [7:0] _io_axi_req_bits_mask_T_1 = r_count <= data_count ? mask_forVmem : 8'h0; // @[IoforMem.scala 404:44]
  wire [3:0] _r_count_T_1 = r_count + 4'h1; // @[IoforMem.scala 407:36]
  wire [1:0] _GEN_467 = io_axi_resp_valid ? 2'h0 : state; // @[IoforMem.scala 374:36 375:23 71:24]
  wire  _GEN_468 = io_axi_resp_valid ? 1'h0 : 1'h1; // @[IoforMem.scala 374:36 377:34 402:34]
  wire [3:0] _GEN_469 = io_axi_resp_valid ? 4'h0 : _r_count_T_1; // @[IoforMem.scala 374:36 379:25 407:25]
  wire  _GEN_470 = io_axi_resp_valid ? _T_31 : begin_flag; // @[IoforMem.scala 157:29 374:36]
  wire [3:0] _GEN_471 = io_axi_resp_valid ? {{3'd0}, _T_31} : data_count; // @[IoforMem.scala 160:29 374:36]
  wire [3:0] _GEN_472 = io_axi_resp_valid ? 4'h0 : wait_cycle; // @[IoforMem.scala 374:36 382:28 161:29]
  wire [31:0] _GEN_473 = io_axi_resp_valid ? 32'h0 : jump_addr; // @[IoforMem.scala 374:36 383:27 166:28]
  wire  _GEN_476 = io_axi_resp_valid & _T_31; // @[IoforMem.scala 146:25 374:36]
  wire [7:0] _GEN_493 = io_axi_resp_valid ? _GEN_318 : maskbuffer_0; // @[IoforMem.scala 148:29 374:36]
  wire [31:0] _GEN_494 = io_axi_resp_valid ? _GEN_319 : last_addr; // @[IoforMem.scala 156:28 374:36]
  wire [31:0] _GEN_495 = io_axi_resp_valid ? _GEN_320 : begin_waddr; // @[IoforMem.scala 158:30 374:36]
  wire  _GEN_498 = io_axi_resp_valid & _GEN_323; // @[IoforMem.scala 146:25 374:36]
  wire [63:0] read = {VmemBuffer_7_read_MPORT_data,VmemBuffer_6_read_MPORT_data,VmemBuffer_5_read_MPORT_data,
    VmemBuffer_4_read_MPORT_data,VmemBuffer_3_read_MPORT_data,VmemBuffer_2_read_MPORT_data,VmemBuffer_1_read_MPORT_data,
    VmemBuffer_0_read_MPORT_data}; // @[IoforMem.scala 169:38]
  wire [63:0] _GEN_642 = io_axi_resp_valid ? 64'h0 : read; // @[IoforMem.scala 176:26 374:36 403:38]
  wire [7:0] _GEN_643 = io_axi_resp_valid ? 8'h0 : _io_axi_req_bits_mask_T_1; // @[IoforMem.scala 177:26 374:36 404:38]
  wire [3:0] _GEN_644 = io_axi_resp_valid ? 4'h0 : 4'hf; // @[IoforMem.scala 178:25 374:36 406:37]
  wire  _GEN_646 = 2'h2 == state & _GEN_468; // @[IoforMem.scala 204:18 173:22]
  wire [63:0] _GEN_820 = 2'h2 == state ? _GEN_642 : 64'h0; // @[IoforMem.scala 204:18 176:26]
  wire [7:0] _GEN_821 = 2'h2 == state ? _GEN_643 : 8'h0; // @[IoforMem.scala 204:18 177:26]
  wire [3:0] _GEN_822 = 2'h2 == state ? _GEN_644 : 4'h0; // @[IoforMem.scala 204:18 178:25]
  wire  _GEN_830 = 2'h1 == state ? _GEN_274 : _GEN_646; // @[IoforMem.scala 204:18]
  wire  _GEN_831 = 2'h1 == state & _GEN_275; // @[IoforMem.scala 204:18 174:24]
  wire [31:0] _GEN_832 = 2'h1 == state ? _GEN_276 : 32'h0; // @[IoforMem.scala 204:18 175:26]
  wire [3:0] _GEN_833 = 2'h1 == state ? 4'h0 : _GEN_822; // @[IoforMem.scala 204:18]
  wire [1:0] _GEN_834 = 2'h1 == state ? _GEN_278 : 2'h0; // @[IoforMem.scala 204:18 179:26]
  wire [63:0] _GEN_837 = 2'h1 == state ? _GEN_281 : _GEN_820; // @[IoforMem.scala 204:18]
  wire [7:0] _GEN_838 = 2'h1 == state ? _GEN_282 : _GEN_821; // @[IoforMem.scala 204:18]
  wire  _GEN_846 = 2'h1 == state ? 1'h0 : 2'h2 == state & _GEN_476; // @[IoforMem.scala 204:18 146:25]
  wire  _GEN_868 = 2'h1 == state ? 1'h0 : 2'h2 == state & _GEN_498; // @[IoforMem.scala 204:18 146:25]
  wire [3:0] _GEN_1022 = 2'h0 == state ? _GEN_193 : _GEN_833; // @[IoforMem.scala 204:18]
  wire [1:0] _GEN_1068 = 2'h0 == state ? _GEN_239 : _GEN_834; // @[IoforMem.scala 204:18]
  wire [7:0] mask = master_choose[1] ? _mask_T_2 : 8'h0; // @[IoforMem.scala 130:16]
  assign VmemBuffer_0_read_MPORT_en = 1'h1;
  assign VmemBuffer_0_read_MPORT_addr = r_count;
  assign VmemBuffer_0_read_MPORT_data = VmemBuffer_0[VmemBuffer_0_read_MPORT_addr]; // @[IoforMem.scala 146:25]
  assign VmemBuffer_0_MPORT_data = io_excute_data[7:0];
  assign VmemBuffer_0_MPORT_addr = data_count;
  assign VmemBuffer_0_MPORT_mask = io_excute_mask[0];
  assign VmemBuffer_0_MPORT_en = _T & _GEN_203;
  assign VmemBuffer_0_MPORT_1_data = jump_data[7:0];
  assign VmemBuffer_0_MPORT_1_addr = 4'h0;
  assign VmemBuffer_0_MPORT_1_mask = jump_mask[0];
  assign VmemBuffer_0_MPORT_1_en = _T ? 1'h0 : _GEN_846;
  assign VmemBuffer_0_MPORT_2_data = 8'h0;
  assign VmemBuffer_0_MPORT_2_addr = 4'h0;
  assign VmemBuffer_0_MPORT_2_mask = 1'h1;
  assign VmemBuffer_0_MPORT_2_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_0_MPORT_3_data = 8'h0;
  assign VmemBuffer_0_MPORT_3_addr = 4'h1;
  assign VmemBuffer_0_MPORT_3_mask = 1'h1;
  assign VmemBuffer_0_MPORT_3_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_0_MPORT_4_data = 8'h0;
  assign VmemBuffer_0_MPORT_4_addr = 4'h2;
  assign VmemBuffer_0_MPORT_4_mask = 1'h1;
  assign VmemBuffer_0_MPORT_4_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_0_MPORT_5_data = 8'h0;
  assign VmemBuffer_0_MPORT_5_addr = 4'h3;
  assign VmemBuffer_0_MPORT_5_mask = 1'h1;
  assign VmemBuffer_0_MPORT_5_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_0_MPORT_6_data = 8'h0;
  assign VmemBuffer_0_MPORT_6_addr = 4'h4;
  assign VmemBuffer_0_MPORT_6_mask = 1'h1;
  assign VmemBuffer_0_MPORT_6_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_0_MPORT_7_data = 8'h0;
  assign VmemBuffer_0_MPORT_7_addr = 4'h5;
  assign VmemBuffer_0_MPORT_7_mask = 1'h1;
  assign VmemBuffer_0_MPORT_7_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_0_MPORT_8_data = 8'h0;
  assign VmemBuffer_0_MPORT_8_addr = 4'h6;
  assign VmemBuffer_0_MPORT_8_mask = 1'h1;
  assign VmemBuffer_0_MPORT_8_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_0_MPORT_9_data = 8'h0;
  assign VmemBuffer_0_MPORT_9_addr = 4'h7;
  assign VmemBuffer_0_MPORT_9_mask = 1'h1;
  assign VmemBuffer_0_MPORT_9_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_0_MPORT_10_data = 8'h0;
  assign VmemBuffer_0_MPORT_10_addr = 4'h8;
  assign VmemBuffer_0_MPORT_10_mask = 1'h1;
  assign VmemBuffer_0_MPORT_10_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_0_MPORT_11_data = 8'h0;
  assign VmemBuffer_0_MPORT_11_addr = 4'h9;
  assign VmemBuffer_0_MPORT_11_mask = 1'h1;
  assign VmemBuffer_0_MPORT_11_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_0_MPORT_12_data = 8'h0;
  assign VmemBuffer_0_MPORT_12_addr = 4'ha;
  assign VmemBuffer_0_MPORT_12_mask = 1'h1;
  assign VmemBuffer_0_MPORT_12_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_0_MPORT_13_data = 8'h0;
  assign VmemBuffer_0_MPORT_13_addr = 4'hb;
  assign VmemBuffer_0_MPORT_13_mask = 1'h1;
  assign VmemBuffer_0_MPORT_13_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_0_MPORT_14_data = 8'h0;
  assign VmemBuffer_0_MPORT_14_addr = 4'hc;
  assign VmemBuffer_0_MPORT_14_mask = 1'h1;
  assign VmemBuffer_0_MPORT_14_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_0_MPORT_15_data = 8'h0;
  assign VmemBuffer_0_MPORT_15_addr = 4'hd;
  assign VmemBuffer_0_MPORT_15_mask = 1'h1;
  assign VmemBuffer_0_MPORT_15_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_0_MPORT_16_data = 8'h0;
  assign VmemBuffer_0_MPORT_16_addr = 4'he;
  assign VmemBuffer_0_MPORT_16_mask = 1'h1;
  assign VmemBuffer_0_MPORT_16_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_0_MPORT_17_data = 8'h0;
  assign VmemBuffer_0_MPORT_17_addr = 4'hf;
  assign VmemBuffer_0_MPORT_17_mask = 1'h1;
  assign VmemBuffer_0_MPORT_17_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_1_read_MPORT_en = 1'h1;
  assign VmemBuffer_1_read_MPORT_addr = r_count;
  assign VmemBuffer_1_read_MPORT_data = VmemBuffer_1[VmemBuffer_1_read_MPORT_addr]; // @[IoforMem.scala 146:25]
  assign VmemBuffer_1_MPORT_data = io_excute_data[15:8];
  assign VmemBuffer_1_MPORT_addr = data_count;
  assign VmemBuffer_1_MPORT_mask = io_excute_mask[1];
  assign VmemBuffer_1_MPORT_en = _T & _GEN_203;
  assign VmemBuffer_1_MPORT_1_data = jump_data[15:8];
  assign VmemBuffer_1_MPORT_1_addr = 4'h0;
  assign VmemBuffer_1_MPORT_1_mask = jump_mask[1];
  assign VmemBuffer_1_MPORT_1_en = _T ? 1'h0 : _GEN_846;
  assign VmemBuffer_1_MPORT_2_data = 8'h0;
  assign VmemBuffer_1_MPORT_2_addr = 4'h0;
  assign VmemBuffer_1_MPORT_2_mask = 1'h1;
  assign VmemBuffer_1_MPORT_2_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_1_MPORT_3_data = 8'h0;
  assign VmemBuffer_1_MPORT_3_addr = 4'h1;
  assign VmemBuffer_1_MPORT_3_mask = 1'h1;
  assign VmemBuffer_1_MPORT_3_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_1_MPORT_4_data = 8'h0;
  assign VmemBuffer_1_MPORT_4_addr = 4'h2;
  assign VmemBuffer_1_MPORT_4_mask = 1'h1;
  assign VmemBuffer_1_MPORT_4_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_1_MPORT_5_data = 8'h0;
  assign VmemBuffer_1_MPORT_5_addr = 4'h3;
  assign VmemBuffer_1_MPORT_5_mask = 1'h1;
  assign VmemBuffer_1_MPORT_5_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_1_MPORT_6_data = 8'h0;
  assign VmemBuffer_1_MPORT_6_addr = 4'h4;
  assign VmemBuffer_1_MPORT_6_mask = 1'h1;
  assign VmemBuffer_1_MPORT_6_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_1_MPORT_7_data = 8'h0;
  assign VmemBuffer_1_MPORT_7_addr = 4'h5;
  assign VmemBuffer_1_MPORT_7_mask = 1'h1;
  assign VmemBuffer_1_MPORT_7_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_1_MPORT_8_data = 8'h0;
  assign VmemBuffer_1_MPORT_8_addr = 4'h6;
  assign VmemBuffer_1_MPORT_8_mask = 1'h1;
  assign VmemBuffer_1_MPORT_8_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_1_MPORT_9_data = 8'h0;
  assign VmemBuffer_1_MPORT_9_addr = 4'h7;
  assign VmemBuffer_1_MPORT_9_mask = 1'h1;
  assign VmemBuffer_1_MPORT_9_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_1_MPORT_10_data = 8'h0;
  assign VmemBuffer_1_MPORT_10_addr = 4'h8;
  assign VmemBuffer_1_MPORT_10_mask = 1'h1;
  assign VmemBuffer_1_MPORT_10_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_1_MPORT_11_data = 8'h0;
  assign VmemBuffer_1_MPORT_11_addr = 4'h9;
  assign VmemBuffer_1_MPORT_11_mask = 1'h1;
  assign VmemBuffer_1_MPORT_11_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_1_MPORT_12_data = 8'h0;
  assign VmemBuffer_1_MPORT_12_addr = 4'ha;
  assign VmemBuffer_1_MPORT_12_mask = 1'h1;
  assign VmemBuffer_1_MPORT_12_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_1_MPORT_13_data = 8'h0;
  assign VmemBuffer_1_MPORT_13_addr = 4'hb;
  assign VmemBuffer_1_MPORT_13_mask = 1'h1;
  assign VmemBuffer_1_MPORT_13_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_1_MPORT_14_data = 8'h0;
  assign VmemBuffer_1_MPORT_14_addr = 4'hc;
  assign VmemBuffer_1_MPORT_14_mask = 1'h1;
  assign VmemBuffer_1_MPORT_14_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_1_MPORT_15_data = 8'h0;
  assign VmemBuffer_1_MPORT_15_addr = 4'hd;
  assign VmemBuffer_1_MPORT_15_mask = 1'h1;
  assign VmemBuffer_1_MPORT_15_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_1_MPORT_16_data = 8'h0;
  assign VmemBuffer_1_MPORT_16_addr = 4'he;
  assign VmemBuffer_1_MPORT_16_mask = 1'h1;
  assign VmemBuffer_1_MPORT_16_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_1_MPORT_17_data = 8'h0;
  assign VmemBuffer_1_MPORT_17_addr = 4'hf;
  assign VmemBuffer_1_MPORT_17_mask = 1'h1;
  assign VmemBuffer_1_MPORT_17_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_2_read_MPORT_en = 1'h1;
  assign VmemBuffer_2_read_MPORT_addr = r_count;
  assign VmemBuffer_2_read_MPORT_data = VmemBuffer_2[VmemBuffer_2_read_MPORT_addr]; // @[IoforMem.scala 146:25]
  assign VmemBuffer_2_MPORT_data = io_excute_data[23:16];
  assign VmemBuffer_2_MPORT_addr = data_count;
  assign VmemBuffer_2_MPORT_mask = io_excute_mask[2];
  assign VmemBuffer_2_MPORT_en = _T & _GEN_203;
  assign VmemBuffer_2_MPORT_1_data = jump_data[23:16];
  assign VmemBuffer_2_MPORT_1_addr = 4'h0;
  assign VmemBuffer_2_MPORT_1_mask = jump_mask[2];
  assign VmemBuffer_2_MPORT_1_en = _T ? 1'h0 : _GEN_846;
  assign VmemBuffer_2_MPORT_2_data = 8'h0;
  assign VmemBuffer_2_MPORT_2_addr = 4'h0;
  assign VmemBuffer_2_MPORT_2_mask = 1'h1;
  assign VmemBuffer_2_MPORT_2_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_2_MPORT_3_data = 8'h0;
  assign VmemBuffer_2_MPORT_3_addr = 4'h1;
  assign VmemBuffer_2_MPORT_3_mask = 1'h1;
  assign VmemBuffer_2_MPORT_3_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_2_MPORT_4_data = 8'h0;
  assign VmemBuffer_2_MPORT_4_addr = 4'h2;
  assign VmemBuffer_2_MPORT_4_mask = 1'h1;
  assign VmemBuffer_2_MPORT_4_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_2_MPORT_5_data = 8'h0;
  assign VmemBuffer_2_MPORT_5_addr = 4'h3;
  assign VmemBuffer_2_MPORT_5_mask = 1'h1;
  assign VmemBuffer_2_MPORT_5_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_2_MPORT_6_data = 8'h0;
  assign VmemBuffer_2_MPORT_6_addr = 4'h4;
  assign VmemBuffer_2_MPORT_6_mask = 1'h1;
  assign VmemBuffer_2_MPORT_6_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_2_MPORT_7_data = 8'h0;
  assign VmemBuffer_2_MPORT_7_addr = 4'h5;
  assign VmemBuffer_2_MPORT_7_mask = 1'h1;
  assign VmemBuffer_2_MPORT_7_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_2_MPORT_8_data = 8'h0;
  assign VmemBuffer_2_MPORT_8_addr = 4'h6;
  assign VmemBuffer_2_MPORT_8_mask = 1'h1;
  assign VmemBuffer_2_MPORT_8_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_2_MPORT_9_data = 8'h0;
  assign VmemBuffer_2_MPORT_9_addr = 4'h7;
  assign VmemBuffer_2_MPORT_9_mask = 1'h1;
  assign VmemBuffer_2_MPORT_9_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_2_MPORT_10_data = 8'h0;
  assign VmemBuffer_2_MPORT_10_addr = 4'h8;
  assign VmemBuffer_2_MPORT_10_mask = 1'h1;
  assign VmemBuffer_2_MPORT_10_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_2_MPORT_11_data = 8'h0;
  assign VmemBuffer_2_MPORT_11_addr = 4'h9;
  assign VmemBuffer_2_MPORT_11_mask = 1'h1;
  assign VmemBuffer_2_MPORT_11_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_2_MPORT_12_data = 8'h0;
  assign VmemBuffer_2_MPORT_12_addr = 4'ha;
  assign VmemBuffer_2_MPORT_12_mask = 1'h1;
  assign VmemBuffer_2_MPORT_12_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_2_MPORT_13_data = 8'h0;
  assign VmemBuffer_2_MPORT_13_addr = 4'hb;
  assign VmemBuffer_2_MPORT_13_mask = 1'h1;
  assign VmemBuffer_2_MPORT_13_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_2_MPORT_14_data = 8'h0;
  assign VmemBuffer_2_MPORT_14_addr = 4'hc;
  assign VmemBuffer_2_MPORT_14_mask = 1'h1;
  assign VmemBuffer_2_MPORT_14_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_2_MPORT_15_data = 8'h0;
  assign VmemBuffer_2_MPORT_15_addr = 4'hd;
  assign VmemBuffer_2_MPORT_15_mask = 1'h1;
  assign VmemBuffer_2_MPORT_15_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_2_MPORT_16_data = 8'h0;
  assign VmemBuffer_2_MPORT_16_addr = 4'he;
  assign VmemBuffer_2_MPORT_16_mask = 1'h1;
  assign VmemBuffer_2_MPORT_16_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_2_MPORT_17_data = 8'h0;
  assign VmemBuffer_2_MPORT_17_addr = 4'hf;
  assign VmemBuffer_2_MPORT_17_mask = 1'h1;
  assign VmemBuffer_2_MPORT_17_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_3_read_MPORT_en = 1'h1;
  assign VmemBuffer_3_read_MPORT_addr = r_count;
  assign VmemBuffer_3_read_MPORT_data = VmemBuffer_3[VmemBuffer_3_read_MPORT_addr]; // @[IoforMem.scala 146:25]
  assign VmemBuffer_3_MPORT_data = io_excute_data[31:24];
  assign VmemBuffer_3_MPORT_addr = data_count;
  assign VmemBuffer_3_MPORT_mask = io_excute_mask[3];
  assign VmemBuffer_3_MPORT_en = _T & _GEN_203;
  assign VmemBuffer_3_MPORT_1_data = jump_data[31:24];
  assign VmemBuffer_3_MPORT_1_addr = 4'h0;
  assign VmemBuffer_3_MPORT_1_mask = jump_mask[3];
  assign VmemBuffer_3_MPORT_1_en = _T ? 1'h0 : _GEN_846;
  assign VmemBuffer_3_MPORT_2_data = 8'h0;
  assign VmemBuffer_3_MPORT_2_addr = 4'h0;
  assign VmemBuffer_3_MPORT_2_mask = 1'h1;
  assign VmemBuffer_3_MPORT_2_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_3_MPORT_3_data = 8'h0;
  assign VmemBuffer_3_MPORT_3_addr = 4'h1;
  assign VmemBuffer_3_MPORT_3_mask = 1'h1;
  assign VmemBuffer_3_MPORT_3_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_3_MPORT_4_data = 8'h0;
  assign VmemBuffer_3_MPORT_4_addr = 4'h2;
  assign VmemBuffer_3_MPORT_4_mask = 1'h1;
  assign VmemBuffer_3_MPORT_4_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_3_MPORT_5_data = 8'h0;
  assign VmemBuffer_3_MPORT_5_addr = 4'h3;
  assign VmemBuffer_3_MPORT_5_mask = 1'h1;
  assign VmemBuffer_3_MPORT_5_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_3_MPORT_6_data = 8'h0;
  assign VmemBuffer_3_MPORT_6_addr = 4'h4;
  assign VmemBuffer_3_MPORT_6_mask = 1'h1;
  assign VmemBuffer_3_MPORT_6_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_3_MPORT_7_data = 8'h0;
  assign VmemBuffer_3_MPORT_7_addr = 4'h5;
  assign VmemBuffer_3_MPORT_7_mask = 1'h1;
  assign VmemBuffer_3_MPORT_7_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_3_MPORT_8_data = 8'h0;
  assign VmemBuffer_3_MPORT_8_addr = 4'h6;
  assign VmemBuffer_3_MPORT_8_mask = 1'h1;
  assign VmemBuffer_3_MPORT_8_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_3_MPORT_9_data = 8'h0;
  assign VmemBuffer_3_MPORT_9_addr = 4'h7;
  assign VmemBuffer_3_MPORT_9_mask = 1'h1;
  assign VmemBuffer_3_MPORT_9_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_3_MPORT_10_data = 8'h0;
  assign VmemBuffer_3_MPORT_10_addr = 4'h8;
  assign VmemBuffer_3_MPORT_10_mask = 1'h1;
  assign VmemBuffer_3_MPORT_10_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_3_MPORT_11_data = 8'h0;
  assign VmemBuffer_3_MPORT_11_addr = 4'h9;
  assign VmemBuffer_3_MPORT_11_mask = 1'h1;
  assign VmemBuffer_3_MPORT_11_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_3_MPORT_12_data = 8'h0;
  assign VmemBuffer_3_MPORT_12_addr = 4'ha;
  assign VmemBuffer_3_MPORT_12_mask = 1'h1;
  assign VmemBuffer_3_MPORT_12_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_3_MPORT_13_data = 8'h0;
  assign VmemBuffer_3_MPORT_13_addr = 4'hb;
  assign VmemBuffer_3_MPORT_13_mask = 1'h1;
  assign VmemBuffer_3_MPORT_13_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_3_MPORT_14_data = 8'h0;
  assign VmemBuffer_3_MPORT_14_addr = 4'hc;
  assign VmemBuffer_3_MPORT_14_mask = 1'h1;
  assign VmemBuffer_3_MPORT_14_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_3_MPORT_15_data = 8'h0;
  assign VmemBuffer_3_MPORT_15_addr = 4'hd;
  assign VmemBuffer_3_MPORT_15_mask = 1'h1;
  assign VmemBuffer_3_MPORT_15_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_3_MPORT_16_data = 8'h0;
  assign VmemBuffer_3_MPORT_16_addr = 4'he;
  assign VmemBuffer_3_MPORT_16_mask = 1'h1;
  assign VmemBuffer_3_MPORT_16_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_3_MPORT_17_data = 8'h0;
  assign VmemBuffer_3_MPORT_17_addr = 4'hf;
  assign VmemBuffer_3_MPORT_17_mask = 1'h1;
  assign VmemBuffer_3_MPORT_17_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_4_read_MPORT_en = 1'h1;
  assign VmemBuffer_4_read_MPORT_addr = r_count;
  assign VmemBuffer_4_read_MPORT_data = VmemBuffer_4[VmemBuffer_4_read_MPORT_addr]; // @[IoforMem.scala 146:25]
  assign VmemBuffer_4_MPORT_data = io_excute_data[39:32];
  assign VmemBuffer_4_MPORT_addr = data_count;
  assign VmemBuffer_4_MPORT_mask = io_excute_mask[4];
  assign VmemBuffer_4_MPORT_en = _T & _GEN_203;
  assign VmemBuffer_4_MPORT_1_data = jump_data[39:32];
  assign VmemBuffer_4_MPORT_1_addr = 4'h0;
  assign VmemBuffer_4_MPORT_1_mask = jump_mask[4];
  assign VmemBuffer_4_MPORT_1_en = _T ? 1'h0 : _GEN_846;
  assign VmemBuffer_4_MPORT_2_data = 8'h0;
  assign VmemBuffer_4_MPORT_2_addr = 4'h0;
  assign VmemBuffer_4_MPORT_2_mask = 1'h1;
  assign VmemBuffer_4_MPORT_2_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_4_MPORT_3_data = 8'h0;
  assign VmemBuffer_4_MPORT_3_addr = 4'h1;
  assign VmemBuffer_4_MPORT_3_mask = 1'h1;
  assign VmemBuffer_4_MPORT_3_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_4_MPORT_4_data = 8'h0;
  assign VmemBuffer_4_MPORT_4_addr = 4'h2;
  assign VmemBuffer_4_MPORT_4_mask = 1'h1;
  assign VmemBuffer_4_MPORT_4_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_4_MPORT_5_data = 8'h0;
  assign VmemBuffer_4_MPORT_5_addr = 4'h3;
  assign VmemBuffer_4_MPORT_5_mask = 1'h1;
  assign VmemBuffer_4_MPORT_5_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_4_MPORT_6_data = 8'h0;
  assign VmemBuffer_4_MPORT_6_addr = 4'h4;
  assign VmemBuffer_4_MPORT_6_mask = 1'h1;
  assign VmemBuffer_4_MPORT_6_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_4_MPORT_7_data = 8'h0;
  assign VmemBuffer_4_MPORT_7_addr = 4'h5;
  assign VmemBuffer_4_MPORT_7_mask = 1'h1;
  assign VmemBuffer_4_MPORT_7_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_4_MPORT_8_data = 8'h0;
  assign VmemBuffer_4_MPORT_8_addr = 4'h6;
  assign VmemBuffer_4_MPORT_8_mask = 1'h1;
  assign VmemBuffer_4_MPORT_8_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_4_MPORT_9_data = 8'h0;
  assign VmemBuffer_4_MPORT_9_addr = 4'h7;
  assign VmemBuffer_4_MPORT_9_mask = 1'h1;
  assign VmemBuffer_4_MPORT_9_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_4_MPORT_10_data = 8'h0;
  assign VmemBuffer_4_MPORT_10_addr = 4'h8;
  assign VmemBuffer_4_MPORT_10_mask = 1'h1;
  assign VmemBuffer_4_MPORT_10_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_4_MPORT_11_data = 8'h0;
  assign VmemBuffer_4_MPORT_11_addr = 4'h9;
  assign VmemBuffer_4_MPORT_11_mask = 1'h1;
  assign VmemBuffer_4_MPORT_11_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_4_MPORT_12_data = 8'h0;
  assign VmemBuffer_4_MPORT_12_addr = 4'ha;
  assign VmemBuffer_4_MPORT_12_mask = 1'h1;
  assign VmemBuffer_4_MPORT_12_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_4_MPORT_13_data = 8'h0;
  assign VmemBuffer_4_MPORT_13_addr = 4'hb;
  assign VmemBuffer_4_MPORT_13_mask = 1'h1;
  assign VmemBuffer_4_MPORT_13_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_4_MPORT_14_data = 8'h0;
  assign VmemBuffer_4_MPORT_14_addr = 4'hc;
  assign VmemBuffer_4_MPORT_14_mask = 1'h1;
  assign VmemBuffer_4_MPORT_14_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_4_MPORT_15_data = 8'h0;
  assign VmemBuffer_4_MPORT_15_addr = 4'hd;
  assign VmemBuffer_4_MPORT_15_mask = 1'h1;
  assign VmemBuffer_4_MPORT_15_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_4_MPORT_16_data = 8'h0;
  assign VmemBuffer_4_MPORT_16_addr = 4'he;
  assign VmemBuffer_4_MPORT_16_mask = 1'h1;
  assign VmemBuffer_4_MPORT_16_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_4_MPORT_17_data = 8'h0;
  assign VmemBuffer_4_MPORT_17_addr = 4'hf;
  assign VmemBuffer_4_MPORT_17_mask = 1'h1;
  assign VmemBuffer_4_MPORT_17_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_5_read_MPORT_en = 1'h1;
  assign VmemBuffer_5_read_MPORT_addr = r_count;
  assign VmemBuffer_5_read_MPORT_data = VmemBuffer_5[VmemBuffer_5_read_MPORT_addr]; // @[IoforMem.scala 146:25]
  assign VmemBuffer_5_MPORT_data = io_excute_data[47:40];
  assign VmemBuffer_5_MPORT_addr = data_count;
  assign VmemBuffer_5_MPORT_mask = io_excute_mask[5];
  assign VmemBuffer_5_MPORT_en = _T & _GEN_203;
  assign VmemBuffer_5_MPORT_1_data = jump_data[47:40];
  assign VmemBuffer_5_MPORT_1_addr = 4'h0;
  assign VmemBuffer_5_MPORT_1_mask = jump_mask[5];
  assign VmemBuffer_5_MPORT_1_en = _T ? 1'h0 : _GEN_846;
  assign VmemBuffer_5_MPORT_2_data = 8'h0;
  assign VmemBuffer_5_MPORT_2_addr = 4'h0;
  assign VmemBuffer_5_MPORT_2_mask = 1'h1;
  assign VmemBuffer_5_MPORT_2_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_5_MPORT_3_data = 8'h0;
  assign VmemBuffer_5_MPORT_3_addr = 4'h1;
  assign VmemBuffer_5_MPORT_3_mask = 1'h1;
  assign VmemBuffer_5_MPORT_3_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_5_MPORT_4_data = 8'h0;
  assign VmemBuffer_5_MPORT_4_addr = 4'h2;
  assign VmemBuffer_5_MPORT_4_mask = 1'h1;
  assign VmemBuffer_5_MPORT_4_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_5_MPORT_5_data = 8'h0;
  assign VmemBuffer_5_MPORT_5_addr = 4'h3;
  assign VmemBuffer_5_MPORT_5_mask = 1'h1;
  assign VmemBuffer_5_MPORT_5_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_5_MPORT_6_data = 8'h0;
  assign VmemBuffer_5_MPORT_6_addr = 4'h4;
  assign VmemBuffer_5_MPORT_6_mask = 1'h1;
  assign VmemBuffer_5_MPORT_6_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_5_MPORT_7_data = 8'h0;
  assign VmemBuffer_5_MPORT_7_addr = 4'h5;
  assign VmemBuffer_5_MPORT_7_mask = 1'h1;
  assign VmemBuffer_5_MPORT_7_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_5_MPORT_8_data = 8'h0;
  assign VmemBuffer_5_MPORT_8_addr = 4'h6;
  assign VmemBuffer_5_MPORT_8_mask = 1'h1;
  assign VmemBuffer_5_MPORT_8_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_5_MPORT_9_data = 8'h0;
  assign VmemBuffer_5_MPORT_9_addr = 4'h7;
  assign VmemBuffer_5_MPORT_9_mask = 1'h1;
  assign VmemBuffer_5_MPORT_9_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_5_MPORT_10_data = 8'h0;
  assign VmemBuffer_5_MPORT_10_addr = 4'h8;
  assign VmemBuffer_5_MPORT_10_mask = 1'h1;
  assign VmemBuffer_5_MPORT_10_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_5_MPORT_11_data = 8'h0;
  assign VmemBuffer_5_MPORT_11_addr = 4'h9;
  assign VmemBuffer_5_MPORT_11_mask = 1'h1;
  assign VmemBuffer_5_MPORT_11_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_5_MPORT_12_data = 8'h0;
  assign VmemBuffer_5_MPORT_12_addr = 4'ha;
  assign VmemBuffer_5_MPORT_12_mask = 1'h1;
  assign VmemBuffer_5_MPORT_12_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_5_MPORT_13_data = 8'h0;
  assign VmemBuffer_5_MPORT_13_addr = 4'hb;
  assign VmemBuffer_5_MPORT_13_mask = 1'h1;
  assign VmemBuffer_5_MPORT_13_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_5_MPORT_14_data = 8'h0;
  assign VmemBuffer_5_MPORT_14_addr = 4'hc;
  assign VmemBuffer_5_MPORT_14_mask = 1'h1;
  assign VmemBuffer_5_MPORT_14_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_5_MPORT_15_data = 8'h0;
  assign VmemBuffer_5_MPORT_15_addr = 4'hd;
  assign VmemBuffer_5_MPORT_15_mask = 1'h1;
  assign VmemBuffer_5_MPORT_15_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_5_MPORT_16_data = 8'h0;
  assign VmemBuffer_5_MPORT_16_addr = 4'he;
  assign VmemBuffer_5_MPORT_16_mask = 1'h1;
  assign VmemBuffer_5_MPORT_16_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_5_MPORT_17_data = 8'h0;
  assign VmemBuffer_5_MPORT_17_addr = 4'hf;
  assign VmemBuffer_5_MPORT_17_mask = 1'h1;
  assign VmemBuffer_5_MPORT_17_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_6_read_MPORT_en = 1'h1;
  assign VmemBuffer_6_read_MPORT_addr = r_count;
  assign VmemBuffer_6_read_MPORT_data = VmemBuffer_6[VmemBuffer_6_read_MPORT_addr]; // @[IoforMem.scala 146:25]
  assign VmemBuffer_6_MPORT_data = io_excute_data[55:48];
  assign VmemBuffer_6_MPORT_addr = data_count;
  assign VmemBuffer_6_MPORT_mask = io_excute_mask[6];
  assign VmemBuffer_6_MPORT_en = _T & _GEN_203;
  assign VmemBuffer_6_MPORT_1_data = jump_data[55:48];
  assign VmemBuffer_6_MPORT_1_addr = 4'h0;
  assign VmemBuffer_6_MPORT_1_mask = jump_mask[6];
  assign VmemBuffer_6_MPORT_1_en = _T ? 1'h0 : _GEN_846;
  assign VmemBuffer_6_MPORT_2_data = 8'h0;
  assign VmemBuffer_6_MPORT_2_addr = 4'h0;
  assign VmemBuffer_6_MPORT_2_mask = 1'h1;
  assign VmemBuffer_6_MPORT_2_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_6_MPORT_3_data = 8'h0;
  assign VmemBuffer_6_MPORT_3_addr = 4'h1;
  assign VmemBuffer_6_MPORT_3_mask = 1'h1;
  assign VmemBuffer_6_MPORT_3_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_6_MPORT_4_data = 8'h0;
  assign VmemBuffer_6_MPORT_4_addr = 4'h2;
  assign VmemBuffer_6_MPORT_4_mask = 1'h1;
  assign VmemBuffer_6_MPORT_4_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_6_MPORT_5_data = 8'h0;
  assign VmemBuffer_6_MPORT_5_addr = 4'h3;
  assign VmemBuffer_6_MPORT_5_mask = 1'h1;
  assign VmemBuffer_6_MPORT_5_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_6_MPORT_6_data = 8'h0;
  assign VmemBuffer_6_MPORT_6_addr = 4'h4;
  assign VmemBuffer_6_MPORT_6_mask = 1'h1;
  assign VmemBuffer_6_MPORT_6_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_6_MPORT_7_data = 8'h0;
  assign VmemBuffer_6_MPORT_7_addr = 4'h5;
  assign VmemBuffer_6_MPORT_7_mask = 1'h1;
  assign VmemBuffer_6_MPORT_7_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_6_MPORT_8_data = 8'h0;
  assign VmemBuffer_6_MPORT_8_addr = 4'h6;
  assign VmemBuffer_6_MPORT_8_mask = 1'h1;
  assign VmemBuffer_6_MPORT_8_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_6_MPORT_9_data = 8'h0;
  assign VmemBuffer_6_MPORT_9_addr = 4'h7;
  assign VmemBuffer_6_MPORT_9_mask = 1'h1;
  assign VmemBuffer_6_MPORT_9_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_6_MPORT_10_data = 8'h0;
  assign VmemBuffer_6_MPORT_10_addr = 4'h8;
  assign VmemBuffer_6_MPORT_10_mask = 1'h1;
  assign VmemBuffer_6_MPORT_10_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_6_MPORT_11_data = 8'h0;
  assign VmemBuffer_6_MPORT_11_addr = 4'h9;
  assign VmemBuffer_6_MPORT_11_mask = 1'h1;
  assign VmemBuffer_6_MPORT_11_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_6_MPORT_12_data = 8'h0;
  assign VmemBuffer_6_MPORT_12_addr = 4'ha;
  assign VmemBuffer_6_MPORT_12_mask = 1'h1;
  assign VmemBuffer_6_MPORT_12_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_6_MPORT_13_data = 8'h0;
  assign VmemBuffer_6_MPORT_13_addr = 4'hb;
  assign VmemBuffer_6_MPORT_13_mask = 1'h1;
  assign VmemBuffer_6_MPORT_13_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_6_MPORT_14_data = 8'h0;
  assign VmemBuffer_6_MPORT_14_addr = 4'hc;
  assign VmemBuffer_6_MPORT_14_mask = 1'h1;
  assign VmemBuffer_6_MPORT_14_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_6_MPORT_15_data = 8'h0;
  assign VmemBuffer_6_MPORT_15_addr = 4'hd;
  assign VmemBuffer_6_MPORT_15_mask = 1'h1;
  assign VmemBuffer_6_MPORT_15_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_6_MPORT_16_data = 8'h0;
  assign VmemBuffer_6_MPORT_16_addr = 4'he;
  assign VmemBuffer_6_MPORT_16_mask = 1'h1;
  assign VmemBuffer_6_MPORT_16_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_6_MPORT_17_data = 8'h0;
  assign VmemBuffer_6_MPORT_17_addr = 4'hf;
  assign VmemBuffer_6_MPORT_17_mask = 1'h1;
  assign VmemBuffer_6_MPORT_17_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_7_read_MPORT_en = 1'h1;
  assign VmemBuffer_7_read_MPORT_addr = r_count;
  assign VmemBuffer_7_read_MPORT_data = VmemBuffer_7[VmemBuffer_7_read_MPORT_addr]; // @[IoforMem.scala 146:25]
  assign VmemBuffer_7_MPORT_data = io_excute_data[63:56];
  assign VmemBuffer_7_MPORT_addr = data_count;
  assign VmemBuffer_7_MPORT_mask = io_excute_mask[7];
  assign VmemBuffer_7_MPORT_en = _T & _GEN_203;
  assign VmemBuffer_7_MPORT_1_data = jump_data[63:56];
  assign VmemBuffer_7_MPORT_1_addr = 4'h0;
  assign VmemBuffer_7_MPORT_1_mask = jump_mask[7];
  assign VmemBuffer_7_MPORT_1_en = _T ? 1'h0 : _GEN_846;
  assign VmemBuffer_7_MPORT_2_data = 8'h0;
  assign VmemBuffer_7_MPORT_2_addr = 4'h0;
  assign VmemBuffer_7_MPORT_2_mask = 1'h1;
  assign VmemBuffer_7_MPORT_2_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_7_MPORT_3_data = 8'h0;
  assign VmemBuffer_7_MPORT_3_addr = 4'h1;
  assign VmemBuffer_7_MPORT_3_mask = 1'h1;
  assign VmemBuffer_7_MPORT_3_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_7_MPORT_4_data = 8'h0;
  assign VmemBuffer_7_MPORT_4_addr = 4'h2;
  assign VmemBuffer_7_MPORT_4_mask = 1'h1;
  assign VmemBuffer_7_MPORT_4_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_7_MPORT_5_data = 8'h0;
  assign VmemBuffer_7_MPORT_5_addr = 4'h3;
  assign VmemBuffer_7_MPORT_5_mask = 1'h1;
  assign VmemBuffer_7_MPORT_5_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_7_MPORT_6_data = 8'h0;
  assign VmemBuffer_7_MPORT_6_addr = 4'h4;
  assign VmemBuffer_7_MPORT_6_mask = 1'h1;
  assign VmemBuffer_7_MPORT_6_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_7_MPORT_7_data = 8'h0;
  assign VmemBuffer_7_MPORT_7_addr = 4'h5;
  assign VmemBuffer_7_MPORT_7_mask = 1'h1;
  assign VmemBuffer_7_MPORT_7_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_7_MPORT_8_data = 8'h0;
  assign VmemBuffer_7_MPORT_8_addr = 4'h6;
  assign VmemBuffer_7_MPORT_8_mask = 1'h1;
  assign VmemBuffer_7_MPORT_8_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_7_MPORT_9_data = 8'h0;
  assign VmemBuffer_7_MPORT_9_addr = 4'h7;
  assign VmemBuffer_7_MPORT_9_mask = 1'h1;
  assign VmemBuffer_7_MPORT_9_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_7_MPORT_10_data = 8'h0;
  assign VmemBuffer_7_MPORT_10_addr = 4'h8;
  assign VmemBuffer_7_MPORT_10_mask = 1'h1;
  assign VmemBuffer_7_MPORT_10_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_7_MPORT_11_data = 8'h0;
  assign VmemBuffer_7_MPORT_11_addr = 4'h9;
  assign VmemBuffer_7_MPORT_11_mask = 1'h1;
  assign VmemBuffer_7_MPORT_11_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_7_MPORT_12_data = 8'h0;
  assign VmemBuffer_7_MPORT_12_addr = 4'ha;
  assign VmemBuffer_7_MPORT_12_mask = 1'h1;
  assign VmemBuffer_7_MPORT_12_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_7_MPORT_13_data = 8'h0;
  assign VmemBuffer_7_MPORT_13_addr = 4'hb;
  assign VmemBuffer_7_MPORT_13_mask = 1'h1;
  assign VmemBuffer_7_MPORT_13_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_7_MPORT_14_data = 8'h0;
  assign VmemBuffer_7_MPORT_14_addr = 4'hc;
  assign VmemBuffer_7_MPORT_14_mask = 1'h1;
  assign VmemBuffer_7_MPORT_14_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_7_MPORT_15_data = 8'h0;
  assign VmemBuffer_7_MPORT_15_addr = 4'hd;
  assign VmemBuffer_7_MPORT_15_mask = 1'h1;
  assign VmemBuffer_7_MPORT_15_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_7_MPORT_16_data = 8'h0;
  assign VmemBuffer_7_MPORT_16_addr = 4'he;
  assign VmemBuffer_7_MPORT_16_mask = 1'h1;
  assign VmemBuffer_7_MPORT_16_en = _T ? 1'h0 : _GEN_868;
  assign VmemBuffer_7_MPORT_17_data = 8'h0;
  assign VmemBuffer_7_MPORT_17_addr = 4'hf;
  assign VmemBuffer_7_MPORT_17_mask = 1'h1;
  assign VmemBuffer_7_MPORT_17_en = _T ? 1'h0 : _GEN_868;
  assign io_axi_req_valid = 2'h0 == state ? _GEN_190 : _GEN_830; // @[IoforMem.scala 204:18]
  assign io_axi_req_bits_rw = 2'h0 == state ? _GEN_192 : _GEN_831; // @[IoforMem.scala 204:18]
  assign io_axi_req_bits_addr = 2'h0 == state ? _GEN_191 : _GEN_832; // @[IoforMem.scala 204:18]
  assign io_axi_req_bits_data = 2'h0 == state ? _GEN_237 : _GEN_837; // @[IoforMem.scala 204:18]
  assign io_axi_req_bits_mask = 2'h0 == state ? _GEN_238 : _GEN_838; // @[IoforMem.scala 204:18]
  assign io_axi_req_bits_len = {{4'd0}, _GEN_1022};
  assign io_axi_req_bits_size = {{1'd0}, _GEN_1068};
  assign io_decode_inst_valid = load_use_local | decode_inst_valid; // @[IoforMem.scala 186:32]
  assign io_decode_inst_bits = decode_inst; // @[IoforMem.scala 187:25]
  assign io_mem_data_valid = mem_data_valid; // @[IoforMem.scala 183:23]
  assign io_mem_data_bits = mem_data_bits; // @[IoforMem.scala 184:22]
  assign io_fc_state = state; // @[IoforMem.scala 191:17]
  always @(posedge clock) begin
    if (VmemBuffer_0_MPORT_en & VmemBuffer_0_MPORT_mask) begin
      VmemBuffer_0[VmemBuffer_0_MPORT_addr] <= VmemBuffer_0_MPORT_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_0_MPORT_1_en & VmemBuffer_0_MPORT_1_mask) begin
      VmemBuffer_0[VmemBuffer_0_MPORT_1_addr] <= VmemBuffer_0_MPORT_1_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_0_MPORT_2_en & VmemBuffer_0_MPORT_2_mask) begin
      VmemBuffer_0[VmemBuffer_0_MPORT_2_addr] <= VmemBuffer_0_MPORT_2_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_0_MPORT_3_en & VmemBuffer_0_MPORT_3_mask) begin
      VmemBuffer_0[VmemBuffer_0_MPORT_3_addr] <= VmemBuffer_0_MPORT_3_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_0_MPORT_4_en & VmemBuffer_0_MPORT_4_mask) begin
      VmemBuffer_0[VmemBuffer_0_MPORT_4_addr] <= VmemBuffer_0_MPORT_4_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_0_MPORT_5_en & VmemBuffer_0_MPORT_5_mask) begin
      VmemBuffer_0[VmemBuffer_0_MPORT_5_addr] <= VmemBuffer_0_MPORT_5_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_0_MPORT_6_en & VmemBuffer_0_MPORT_6_mask) begin
      VmemBuffer_0[VmemBuffer_0_MPORT_6_addr] <= VmemBuffer_0_MPORT_6_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_0_MPORT_7_en & VmemBuffer_0_MPORT_7_mask) begin
      VmemBuffer_0[VmemBuffer_0_MPORT_7_addr] <= VmemBuffer_0_MPORT_7_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_0_MPORT_8_en & VmemBuffer_0_MPORT_8_mask) begin
      VmemBuffer_0[VmemBuffer_0_MPORT_8_addr] <= VmemBuffer_0_MPORT_8_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_0_MPORT_9_en & VmemBuffer_0_MPORT_9_mask) begin
      VmemBuffer_0[VmemBuffer_0_MPORT_9_addr] <= VmemBuffer_0_MPORT_9_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_0_MPORT_10_en & VmemBuffer_0_MPORT_10_mask) begin
      VmemBuffer_0[VmemBuffer_0_MPORT_10_addr] <= VmemBuffer_0_MPORT_10_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_0_MPORT_11_en & VmemBuffer_0_MPORT_11_mask) begin
      VmemBuffer_0[VmemBuffer_0_MPORT_11_addr] <= VmemBuffer_0_MPORT_11_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_0_MPORT_12_en & VmemBuffer_0_MPORT_12_mask) begin
      VmemBuffer_0[VmemBuffer_0_MPORT_12_addr] <= VmemBuffer_0_MPORT_12_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_0_MPORT_13_en & VmemBuffer_0_MPORT_13_mask) begin
      VmemBuffer_0[VmemBuffer_0_MPORT_13_addr] <= VmemBuffer_0_MPORT_13_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_0_MPORT_14_en & VmemBuffer_0_MPORT_14_mask) begin
      VmemBuffer_0[VmemBuffer_0_MPORT_14_addr] <= VmemBuffer_0_MPORT_14_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_0_MPORT_15_en & VmemBuffer_0_MPORT_15_mask) begin
      VmemBuffer_0[VmemBuffer_0_MPORT_15_addr] <= VmemBuffer_0_MPORT_15_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_0_MPORT_16_en & VmemBuffer_0_MPORT_16_mask) begin
      VmemBuffer_0[VmemBuffer_0_MPORT_16_addr] <= VmemBuffer_0_MPORT_16_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_0_MPORT_17_en & VmemBuffer_0_MPORT_17_mask) begin
      VmemBuffer_0[VmemBuffer_0_MPORT_17_addr] <= VmemBuffer_0_MPORT_17_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_1_MPORT_en & VmemBuffer_1_MPORT_mask) begin
      VmemBuffer_1[VmemBuffer_1_MPORT_addr] <= VmemBuffer_1_MPORT_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_1_MPORT_1_en & VmemBuffer_1_MPORT_1_mask) begin
      VmemBuffer_1[VmemBuffer_1_MPORT_1_addr] <= VmemBuffer_1_MPORT_1_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_1_MPORT_2_en & VmemBuffer_1_MPORT_2_mask) begin
      VmemBuffer_1[VmemBuffer_1_MPORT_2_addr] <= VmemBuffer_1_MPORT_2_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_1_MPORT_3_en & VmemBuffer_1_MPORT_3_mask) begin
      VmemBuffer_1[VmemBuffer_1_MPORT_3_addr] <= VmemBuffer_1_MPORT_3_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_1_MPORT_4_en & VmemBuffer_1_MPORT_4_mask) begin
      VmemBuffer_1[VmemBuffer_1_MPORT_4_addr] <= VmemBuffer_1_MPORT_4_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_1_MPORT_5_en & VmemBuffer_1_MPORT_5_mask) begin
      VmemBuffer_1[VmemBuffer_1_MPORT_5_addr] <= VmemBuffer_1_MPORT_5_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_1_MPORT_6_en & VmemBuffer_1_MPORT_6_mask) begin
      VmemBuffer_1[VmemBuffer_1_MPORT_6_addr] <= VmemBuffer_1_MPORT_6_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_1_MPORT_7_en & VmemBuffer_1_MPORT_7_mask) begin
      VmemBuffer_1[VmemBuffer_1_MPORT_7_addr] <= VmemBuffer_1_MPORT_7_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_1_MPORT_8_en & VmemBuffer_1_MPORT_8_mask) begin
      VmemBuffer_1[VmemBuffer_1_MPORT_8_addr] <= VmemBuffer_1_MPORT_8_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_1_MPORT_9_en & VmemBuffer_1_MPORT_9_mask) begin
      VmemBuffer_1[VmemBuffer_1_MPORT_9_addr] <= VmemBuffer_1_MPORT_9_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_1_MPORT_10_en & VmemBuffer_1_MPORT_10_mask) begin
      VmemBuffer_1[VmemBuffer_1_MPORT_10_addr] <= VmemBuffer_1_MPORT_10_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_1_MPORT_11_en & VmemBuffer_1_MPORT_11_mask) begin
      VmemBuffer_1[VmemBuffer_1_MPORT_11_addr] <= VmemBuffer_1_MPORT_11_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_1_MPORT_12_en & VmemBuffer_1_MPORT_12_mask) begin
      VmemBuffer_1[VmemBuffer_1_MPORT_12_addr] <= VmemBuffer_1_MPORT_12_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_1_MPORT_13_en & VmemBuffer_1_MPORT_13_mask) begin
      VmemBuffer_1[VmemBuffer_1_MPORT_13_addr] <= VmemBuffer_1_MPORT_13_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_1_MPORT_14_en & VmemBuffer_1_MPORT_14_mask) begin
      VmemBuffer_1[VmemBuffer_1_MPORT_14_addr] <= VmemBuffer_1_MPORT_14_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_1_MPORT_15_en & VmemBuffer_1_MPORT_15_mask) begin
      VmemBuffer_1[VmemBuffer_1_MPORT_15_addr] <= VmemBuffer_1_MPORT_15_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_1_MPORT_16_en & VmemBuffer_1_MPORT_16_mask) begin
      VmemBuffer_1[VmemBuffer_1_MPORT_16_addr] <= VmemBuffer_1_MPORT_16_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_1_MPORT_17_en & VmemBuffer_1_MPORT_17_mask) begin
      VmemBuffer_1[VmemBuffer_1_MPORT_17_addr] <= VmemBuffer_1_MPORT_17_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_2_MPORT_en & VmemBuffer_2_MPORT_mask) begin
      VmemBuffer_2[VmemBuffer_2_MPORT_addr] <= VmemBuffer_2_MPORT_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_2_MPORT_1_en & VmemBuffer_2_MPORT_1_mask) begin
      VmemBuffer_2[VmemBuffer_2_MPORT_1_addr] <= VmemBuffer_2_MPORT_1_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_2_MPORT_2_en & VmemBuffer_2_MPORT_2_mask) begin
      VmemBuffer_2[VmemBuffer_2_MPORT_2_addr] <= VmemBuffer_2_MPORT_2_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_2_MPORT_3_en & VmemBuffer_2_MPORT_3_mask) begin
      VmemBuffer_2[VmemBuffer_2_MPORT_3_addr] <= VmemBuffer_2_MPORT_3_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_2_MPORT_4_en & VmemBuffer_2_MPORT_4_mask) begin
      VmemBuffer_2[VmemBuffer_2_MPORT_4_addr] <= VmemBuffer_2_MPORT_4_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_2_MPORT_5_en & VmemBuffer_2_MPORT_5_mask) begin
      VmemBuffer_2[VmemBuffer_2_MPORT_5_addr] <= VmemBuffer_2_MPORT_5_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_2_MPORT_6_en & VmemBuffer_2_MPORT_6_mask) begin
      VmemBuffer_2[VmemBuffer_2_MPORT_6_addr] <= VmemBuffer_2_MPORT_6_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_2_MPORT_7_en & VmemBuffer_2_MPORT_7_mask) begin
      VmemBuffer_2[VmemBuffer_2_MPORT_7_addr] <= VmemBuffer_2_MPORT_7_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_2_MPORT_8_en & VmemBuffer_2_MPORT_8_mask) begin
      VmemBuffer_2[VmemBuffer_2_MPORT_8_addr] <= VmemBuffer_2_MPORT_8_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_2_MPORT_9_en & VmemBuffer_2_MPORT_9_mask) begin
      VmemBuffer_2[VmemBuffer_2_MPORT_9_addr] <= VmemBuffer_2_MPORT_9_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_2_MPORT_10_en & VmemBuffer_2_MPORT_10_mask) begin
      VmemBuffer_2[VmemBuffer_2_MPORT_10_addr] <= VmemBuffer_2_MPORT_10_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_2_MPORT_11_en & VmemBuffer_2_MPORT_11_mask) begin
      VmemBuffer_2[VmemBuffer_2_MPORT_11_addr] <= VmemBuffer_2_MPORT_11_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_2_MPORT_12_en & VmemBuffer_2_MPORT_12_mask) begin
      VmemBuffer_2[VmemBuffer_2_MPORT_12_addr] <= VmemBuffer_2_MPORT_12_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_2_MPORT_13_en & VmemBuffer_2_MPORT_13_mask) begin
      VmemBuffer_2[VmemBuffer_2_MPORT_13_addr] <= VmemBuffer_2_MPORT_13_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_2_MPORT_14_en & VmemBuffer_2_MPORT_14_mask) begin
      VmemBuffer_2[VmemBuffer_2_MPORT_14_addr] <= VmemBuffer_2_MPORT_14_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_2_MPORT_15_en & VmemBuffer_2_MPORT_15_mask) begin
      VmemBuffer_2[VmemBuffer_2_MPORT_15_addr] <= VmemBuffer_2_MPORT_15_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_2_MPORT_16_en & VmemBuffer_2_MPORT_16_mask) begin
      VmemBuffer_2[VmemBuffer_2_MPORT_16_addr] <= VmemBuffer_2_MPORT_16_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_2_MPORT_17_en & VmemBuffer_2_MPORT_17_mask) begin
      VmemBuffer_2[VmemBuffer_2_MPORT_17_addr] <= VmemBuffer_2_MPORT_17_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_3_MPORT_en & VmemBuffer_3_MPORT_mask) begin
      VmemBuffer_3[VmemBuffer_3_MPORT_addr] <= VmemBuffer_3_MPORT_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_3_MPORT_1_en & VmemBuffer_3_MPORT_1_mask) begin
      VmemBuffer_3[VmemBuffer_3_MPORT_1_addr] <= VmemBuffer_3_MPORT_1_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_3_MPORT_2_en & VmemBuffer_3_MPORT_2_mask) begin
      VmemBuffer_3[VmemBuffer_3_MPORT_2_addr] <= VmemBuffer_3_MPORT_2_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_3_MPORT_3_en & VmemBuffer_3_MPORT_3_mask) begin
      VmemBuffer_3[VmemBuffer_3_MPORT_3_addr] <= VmemBuffer_3_MPORT_3_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_3_MPORT_4_en & VmemBuffer_3_MPORT_4_mask) begin
      VmemBuffer_3[VmemBuffer_3_MPORT_4_addr] <= VmemBuffer_3_MPORT_4_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_3_MPORT_5_en & VmemBuffer_3_MPORT_5_mask) begin
      VmemBuffer_3[VmemBuffer_3_MPORT_5_addr] <= VmemBuffer_3_MPORT_5_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_3_MPORT_6_en & VmemBuffer_3_MPORT_6_mask) begin
      VmemBuffer_3[VmemBuffer_3_MPORT_6_addr] <= VmemBuffer_3_MPORT_6_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_3_MPORT_7_en & VmemBuffer_3_MPORT_7_mask) begin
      VmemBuffer_3[VmemBuffer_3_MPORT_7_addr] <= VmemBuffer_3_MPORT_7_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_3_MPORT_8_en & VmemBuffer_3_MPORT_8_mask) begin
      VmemBuffer_3[VmemBuffer_3_MPORT_8_addr] <= VmemBuffer_3_MPORT_8_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_3_MPORT_9_en & VmemBuffer_3_MPORT_9_mask) begin
      VmemBuffer_3[VmemBuffer_3_MPORT_9_addr] <= VmemBuffer_3_MPORT_9_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_3_MPORT_10_en & VmemBuffer_3_MPORT_10_mask) begin
      VmemBuffer_3[VmemBuffer_3_MPORT_10_addr] <= VmemBuffer_3_MPORT_10_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_3_MPORT_11_en & VmemBuffer_3_MPORT_11_mask) begin
      VmemBuffer_3[VmemBuffer_3_MPORT_11_addr] <= VmemBuffer_3_MPORT_11_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_3_MPORT_12_en & VmemBuffer_3_MPORT_12_mask) begin
      VmemBuffer_3[VmemBuffer_3_MPORT_12_addr] <= VmemBuffer_3_MPORT_12_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_3_MPORT_13_en & VmemBuffer_3_MPORT_13_mask) begin
      VmemBuffer_3[VmemBuffer_3_MPORT_13_addr] <= VmemBuffer_3_MPORT_13_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_3_MPORT_14_en & VmemBuffer_3_MPORT_14_mask) begin
      VmemBuffer_3[VmemBuffer_3_MPORT_14_addr] <= VmemBuffer_3_MPORT_14_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_3_MPORT_15_en & VmemBuffer_3_MPORT_15_mask) begin
      VmemBuffer_3[VmemBuffer_3_MPORT_15_addr] <= VmemBuffer_3_MPORT_15_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_3_MPORT_16_en & VmemBuffer_3_MPORT_16_mask) begin
      VmemBuffer_3[VmemBuffer_3_MPORT_16_addr] <= VmemBuffer_3_MPORT_16_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_3_MPORT_17_en & VmemBuffer_3_MPORT_17_mask) begin
      VmemBuffer_3[VmemBuffer_3_MPORT_17_addr] <= VmemBuffer_3_MPORT_17_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_4_MPORT_en & VmemBuffer_4_MPORT_mask) begin
      VmemBuffer_4[VmemBuffer_4_MPORT_addr] <= VmemBuffer_4_MPORT_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_4_MPORT_1_en & VmemBuffer_4_MPORT_1_mask) begin
      VmemBuffer_4[VmemBuffer_4_MPORT_1_addr] <= VmemBuffer_4_MPORT_1_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_4_MPORT_2_en & VmemBuffer_4_MPORT_2_mask) begin
      VmemBuffer_4[VmemBuffer_4_MPORT_2_addr] <= VmemBuffer_4_MPORT_2_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_4_MPORT_3_en & VmemBuffer_4_MPORT_3_mask) begin
      VmemBuffer_4[VmemBuffer_4_MPORT_3_addr] <= VmemBuffer_4_MPORT_3_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_4_MPORT_4_en & VmemBuffer_4_MPORT_4_mask) begin
      VmemBuffer_4[VmemBuffer_4_MPORT_4_addr] <= VmemBuffer_4_MPORT_4_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_4_MPORT_5_en & VmemBuffer_4_MPORT_5_mask) begin
      VmemBuffer_4[VmemBuffer_4_MPORT_5_addr] <= VmemBuffer_4_MPORT_5_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_4_MPORT_6_en & VmemBuffer_4_MPORT_6_mask) begin
      VmemBuffer_4[VmemBuffer_4_MPORT_6_addr] <= VmemBuffer_4_MPORT_6_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_4_MPORT_7_en & VmemBuffer_4_MPORT_7_mask) begin
      VmemBuffer_4[VmemBuffer_4_MPORT_7_addr] <= VmemBuffer_4_MPORT_7_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_4_MPORT_8_en & VmemBuffer_4_MPORT_8_mask) begin
      VmemBuffer_4[VmemBuffer_4_MPORT_8_addr] <= VmemBuffer_4_MPORT_8_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_4_MPORT_9_en & VmemBuffer_4_MPORT_9_mask) begin
      VmemBuffer_4[VmemBuffer_4_MPORT_9_addr] <= VmemBuffer_4_MPORT_9_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_4_MPORT_10_en & VmemBuffer_4_MPORT_10_mask) begin
      VmemBuffer_4[VmemBuffer_4_MPORT_10_addr] <= VmemBuffer_4_MPORT_10_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_4_MPORT_11_en & VmemBuffer_4_MPORT_11_mask) begin
      VmemBuffer_4[VmemBuffer_4_MPORT_11_addr] <= VmemBuffer_4_MPORT_11_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_4_MPORT_12_en & VmemBuffer_4_MPORT_12_mask) begin
      VmemBuffer_4[VmemBuffer_4_MPORT_12_addr] <= VmemBuffer_4_MPORT_12_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_4_MPORT_13_en & VmemBuffer_4_MPORT_13_mask) begin
      VmemBuffer_4[VmemBuffer_4_MPORT_13_addr] <= VmemBuffer_4_MPORT_13_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_4_MPORT_14_en & VmemBuffer_4_MPORT_14_mask) begin
      VmemBuffer_4[VmemBuffer_4_MPORT_14_addr] <= VmemBuffer_4_MPORT_14_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_4_MPORT_15_en & VmemBuffer_4_MPORT_15_mask) begin
      VmemBuffer_4[VmemBuffer_4_MPORT_15_addr] <= VmemBuffer_4_MPORT_15_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_4_MPORT_16_en & VmemBuffer_4_MPORT_16_mask) begin
      VmemBuffer_4[VmemBuffer_4_MPORT_16_addr] <= VmemBuffer_4_MPORT_16_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_4_MPORT_17_en & VmemBuffer_4_MPORT_17_mask) begin
      VmemBuffer_4[VmemBuffer_4_MPORT_17_addr] <= VmemBuffer_4_MPORT_17_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_5_MPORT_en & VmemBuffer_5_MPORT_mask) begin
      VmemBuffer_5[VmemBuffer_5_MPORT_addr] <= VmemBuffer_5_MPORT_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_5_MPORT_1_en & VmemBuffer_5_MPORT_1_mask) begin
      VmemBuffer_5[VmemBuffer_5_MPORT_1_addr] <= VmemBuffer_5_MPORT_1_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_5_MPORT_2_en & VmemBuffer_5_MPORT_2_mask) begin
      VmemBuffer_5[VmemBuffer_5_MPORT_2_addr] <= VmemBuffer_5_MPORT_2_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_5_MPORT_3_en & VmemBuffer_5_MPORT_3_mask) begin
      VmemBuffer_5[VmemBuffer_5_MPORT_3_addr] <= VmemBuffer_5_MPORT_3_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_5_MPORT_4_en & VmemBuffer_5_MPORT_4_mask) begin
      VmemBuffer_5[VmemBuffer_5_MPORT_4_addr] <= VmemBuffer_5_MPORT_4_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_5_MPORT_5_en & VmemBuffer_5_MPORT_5_mask) begin
      VmemBuffer_5[VmemBuffer_5_MPORT_5_addr] <= VmemBuffer_5_MPORT_5_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_5_MPORT_6_en & VmemBuffer_5_MPORT_6_mask) begin
      VmemBuffer_5[VmemBuffer_5_MPORT_6_addr] <= VmemBuffer_5_MPORT_6_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_5_MPORT_7_en & VmemBuffer_5_MPORT_7_mask) begin
      VmemBuffer_5[VmemBuffer_5_MPORT_7_addr] <= VmemBuffer_5_MPORT_7_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_5_MPORT_8_en & VmemBuffer_5_MPORT_8_mask) begin
      VmemBuffer_5[VmemBuffer_5_MPORT_8_addr] <= VmemBuffer_5_MPORT_8_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_5_MPORT_9_en & VmemBuffer_5_MPORT_9_mask) begin
      VmemBuffer_5[VmemBuffer_5_MPORT_9_addr] <= VmemBuffer_5_MPORT_9_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_5_MPORT_10_en & VmemBuffer_5_MPORT_10_mask) begin
      VmemBuffer_5[VmemBuffer_5_MPORT_10_addr] <= VmemBuffer_5_MPORT_10_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_5_MPORT_11_en & VmemBuffer_5_MPORT_11_mask) begin
      VmemBuffer_5[VmemBuffer_5_MPORT_11_addr] <= VmemBuffer_5_MPORT_11_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_5_MPORT_12_en & VmemBuffer_5_MPORT_12_mask) begin
      VmemBuffer_5[VmemBuffer_5_MPORT_12_addr] <= VmemBuffer_5_MPORT_12_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_5_MPORT_13_en & VmemBuffer_5_MPORT_13_mask) begin
      VmemBuffer_5[VmemBuffer_5_MPORT_13_addr] <= VmemBuffer_5_MPORT_13_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_5_MPORT_14_en & VmemBuffer_5_MPORT_14_mask) begin
      VmemBuffer_5[VmemBuffer_5_MPORT_14_addr] <= VmemBuffer_5_MPORT_14_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_5_MPORT_15_en & VmemBuffer_5_MPORT_15_mask) begin
      VmemBuffer_5[VmemBuffer_5_MPORT_15_addr] <= VmemBuffer_5_MPORT_15_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_5_MPORT_16_en & VmemBuffer_5_MPORT_16_mask) begin
      VmemBuffer_5[VmemBuffer_5_MPORT_16_addr] <= VmemBuffer_5_MPORT_16_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_5_MPORT_17_en & VmemBuffer_5_MPORT_17_mask) begin
      VmemBuffer_5[VmemBuffer_5_MPORT_17_addr] <= VmemBuffer_5_MPORT_17_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_6_MPORT_en & VmemBuffer_6_MPORT_mask) begin
      VmemBuffer_6[VmemBuffer_6_MPORT_addr] <= VmemBuffer_6_MPORT_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_6_MPORT_1_en & VmemBuffer_6_MPORT_1_mask) begin
      VmemBuffer_6[VmemBuffer_6_MPORT_1_addr] <= VmemBuffer_6_MPORT_1_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_6_MPORT_2_en & VmemBuffer_6_MPORT_2_mask) begin
      VmemBuffer_6[VmemBuffer_6_MPORT_2_addr] <= VmemBuffer_6_MPORT_2_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_6_MPORT_3_en & VmemBuffer_6_MPORT_3_mask) begin
      VmemBuffer_6[VmemBuffer_6_MPORT_3_addr] <= VmemBuffer_6_MPORT_3_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_6_MPORT_4_en & VmemBuffer_6_MPORT_4_mask) begin
      VmemBuffer_6[VmemBuffer_6_MPORT_4_addr] <= VmemBuffer_6_MPORT_4_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_6_MPORT_5_en & VmemBuffer_6_MPORT_5_mask) begin
      VmemBuffer_6[VmemBuffer_6_MPORT_5_addr] <= VmemBuffer_6_MPORT_5_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_6_MPORT_6_en & VmemBuffer_6_MPORT_6_mask) begin
      VmemBuffer_6[VmemBuffer_6_MPORT_6_addr] <= VmemBuffer_6_MPORT_6_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_6_MPORT_7_en & VmemBuffer_6_MPORT_7_mask) begin
      VmemBuffer_6[VmemBuffer_6_MPORT_7_addr] <= VmemBuffer_6_MPORT_7_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_6_MPORT_8_en & VmemBuffer_6_MPORT_8_mask) begin
      VmemBuffer_6[VmemBuffer_6_MPORT_8_addr] <= VmemBuffer_6_MPORT_8_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_6_MPORT_9_en & VmemBuffer_6_MPORT_9_mask) begin
      VmemBuffer_6[VmemBuffer_6_MPORT_9_addr] <= VmemBuffer_6_MPORT_9_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_6_MPORT_10_en & VmemBuffer_6_MPORT_10_mask) begin
      VmemBuffer_6[VmemBuffer_6_MPORT_10_addr] <= VmemBuffer_6_MPORT_10_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_6_MPORT_11_en & VmemBuffer_6_MPORT_11_mask) begin
      VmemBuffer_6[VmemBuffer_6_MPORT_11_addr] <= VmemBuffer_6_MPORT_11_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_6_MPORT_12_en & VmemBuffer_6_MPORT_12_mask) begin
      VmemBuffer_6[VmemBuffer_6_MPORT_12_addr] <= VmemBuffer_6_MPORT_12_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_6_MPORT_13_en & VmemBuffer_6_MPORT_13_mask) begin
      VmemBuffer_6[VmemBuffer_6_MPORT_13_addr] <= VmemBuffer_6_MPORT_13_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_6_MPORT_14_en & VmemBuffer_6_MPORT_14_mask) begin
      VmemBuffer_6[VmemBuffer_6_MPORT_14_addr] <= VmemBuffer_6_MPORT_14_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_6_MPORT_15_en & VmemBuffer_6_MPORT_15_mask) begin
      VmemBuffer_6[VmemBuffer_6_MPORT_15_addr] <= VmemBuffer_6_MPORT_15_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_6_MPORT_16_en & VmemBuffer_6_MPORT_16_mask) begin
      VmemBuffer_6[VmemBuffer_6_MPORT_16_addr] <= VmemBuffer_6_MPORT_16_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_6_MPORT_17_en & VmemBuffer_6_MPORT_17_mask) begin
      VmemBuffer_6[VmemBuffer_6_MPORT_17_addr] <= VmemBuffer_6_MPORT_17_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_7_MPORT_en & VmemBuffer_7_MPORT_mask) begin
      VmemBuffer_7[VmemBuffer_7_MPORT_addr] <= VmemBuffer_7_MPORT_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_7_MPORT_1_en & VmemBuffer_7_MPORT_1_mask) begin
      VmemBuffer_7[VmemBuffer_7_MPORT_1_addr] <= VmemBuffer_7_MPORT_1_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_7_MPORT_2_en & VmemBuffer_7_MPORT_2_mask) begin
      VmemBuffer_7[VmemBuffer_7_MPORT_2_addr] <= VmemBuffer_7_MPORT_2_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_7_MPORT_3_en & VmemBuffer_7_MPORT_3_mask) begin
      VmemBuffer_7[VmemBuffer_7_MPORT_3_addr] <= VmemBuffer_7_MPORT_3_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_7_MPORT_4_en & VmemBuffer_7_MPORT_4_mask) begin
      VmemBuffer_7[VmemBuffer_7_MPORT_4_addr] <= VmemBuffer_7_MPORT_4_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_7_MPORT_5_en & VmemBuffer_7_MPORT_5_mask) begin
      VmemBuffer_7[VmemBuffer_7_MPORT_5_addr] <= VmemBuffer_7_MPORT_5_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_7_MPORT_6_en & VmemBuffer_7_MPORT_6_mask) begin
      VmemBuffer_7[VmemBuffer_7_MPORT_6_addr] <= VmemBuffer_7_MPORT_6_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_7_MPORT_7_en & VmemBuffer_7_MPORT_7_mask) begin
      VmemBuffer_7[VmemBuffer_7_MPORT_7_addr] <= VmemBuffer_7_MPORT_7_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_7_MPORT_8_en & VmemBuffer_7_MPORT_8_mask) begin
      VmemBuffer_7[VmemBuffer_7_MPORT_8_addr] <= VmemBuffer_7_MPORT_8_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_7_MPORT_9_en & VmemBuffer_7_MPORT_9_mask) begin
      VmemBuffer_7[VmemBuffer_7_MPORT_9_addr] <= VmemBuffer_7_MPORT_9_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_7_MPORT_10_en & VmemBuffer_7_MPORT_10_mask) begin
      VmemBuffer_7[VmemBuffer_7_MPORT_10_addr] <= VmemBuffer_7_MPORT_10_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_7_MPORT_11_en & VmemBuffer_7_MPORT_11_mask) begin
      VmemBuffer_7[VmemBuffer_7_MPORT_11_addr] <= VmemBuffer_7_MPORT_11_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_7_MPORT_12_en & VmemBuffer_7_MPORT_12_mask) begin
      VmemBuffer_7[VmemBuffer_7_MPORT_12_addr] <= VmemBuffer_7_MPORT_12_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_7_MPORT_13_en & VmemBuffer_7_MPORT_13_mask) begin
      VmemBuffer_7[VmemBuffer_7_MPORT_13_addr] <= VmemBuffer_7_MPORT_13_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_7_MPORT_14_en & VmemBuffer_7_MPORT_14_mask) begin
      VmemBuffer_7[VmemBuffer_7_MPORT_14_addr] <= VmemBuffer_7_MPORT_14_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_7_MPORT_15_en & VmemBuffer_7_MPORT_15_mask) begin
      VmemBuffer_7[VmemBuffer_7_MPORT_15_addr] <= VmemBuffer_7_MPORT_15_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_7_MPORT_16_en & VmemBuffer_7_MPORT_16_mask) begin
      VmemBuffer_7[VmemBuffer_7_MPORT_16_addr] <= VmemBuffer_7_MPORT_16_data; // @[IoforMem.scala 146:25]
    end
    if (VmemBuffer_7_MPORT_17_en & VmemBuffer_7_MPORT_17_mask) begin
      VmemBuffer_7[VmemBuffer_7_MPORT_17_addr] <= VmemBuffer_7_MPORT_17_data; // @[IoforMem.scala 146:25]
    end
    if (reset) begin // @[IoforMem.scala 71:24]
      state <= 2'h0; // @[IoforMem.scala 71:24]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          state <= _GEN_74;
        end else begin
          state <= 2'h1; // @[IoforMem.scala 281:31]
        end
      end else if (io_fetch_req & _T_1) begin // @[IoforMem.scala 311:55]
        state <= 2'h1; // @[IoforMem.scala 314:27]
      end
    end else if (2'h1 == state) begin // @[IoforMem.scala 204:18]
      if (io_axi_resp_valid) begin // @[IoforMem.scala 330:36]
        state <= _GEN_256;
      end
    end else if (2'h2 == state) begin // @[IoforMem.scala 204:18]
      state <= _GEN_467;
    end
    if (reset) begin // @[IoforMem.scala 73:31]
      fetch_buffer <= 1'h0; // @[IoforMem.scala 73:31]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (!(io_ex_req & _T_1)) begin // @[IoforMem.scala 214:49]
        fetch_buffer <= _GEN_184;
      end
    end else if (2'h1 == state) begin // @[IoforMem.scala 204:18]
      if (io_axi_resp_valid) begin // @[IoforMem.scala 330:36]
        fetch_buffer <= _GEN_257;
      end
    end
    if (reset) begin // @[IoforMem.scala 87:32]
      choose_buffer <= 2'h0; // @[IoforMem.scala 87:32]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        choose_buffer <= master_choose; // @[IoforMem.scala 215:35]
      end else if (io_fetch_req & _T_1) begin // @[IoforMem.scala 311:55]
        choose_buffer <= master_choose; // @[IoforMem.scala 312:35]
      end
    end else if (2'h1 == state) begin // @[IoforMem.scala 204:18]
      if (io_axi_resp_valid) begin // @[IoforMem.scala 330:36]
        choose_buffer <= _GEN_260;
      end
    end
    if (reset) begin // @[IoforMem.scala 89:33]
      load_use_local <= 1'h0; // @[IoforMem.scala 89:33]
    end else if (!(io_fc_stall)) begin // @[IoforMem.scala 90:22]
      load_use_local <= io_decode_load_use; // @[IoforMem.scala 93:24]
    end
    if (reset) begin // @[IoforMem.scala 139:33]
      mem_data_valid <= 1'h0; // @[IoforMem.scala 139:33]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (~io_fc_stall) begin // @[IoforMem.scala 207:35]
        mem_data_valid <= 1'h0; // @[IoforMem.scala 208:36]
      end
    end else if (2'h1 == state) begin // @[IoforMem.scala 204:18]
      if (io_axi_resp_valid) begin // @[IoforMem.scala 330:36]
        mem_data_valid <= _GEN_258;
      end
    end
    if (reset) begin // @[IoforMem.scala 140:32]
      mem_data_bits <= 64'h0; // @[IoforMem.scala 140:32]
    end else if (!(2'h0 == state)) begin // @[IoforMem.scala 204:18]
      if (2'h1 == state) begin // @[IoforMem.scala 204:18]
        if (io_axi_resp_valid) begin // @[IoforMem.scala 330:36]
          mem_data_bits <= _GEN_259;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 142:36]
      decode_inst_valid <= 1'h0; // @[IoforMem.scala 142:36]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (~io_fc_stall) begin // @[IoforMem.scala 207:35]
        decode_inst_valid <= 1'h0; // @[IoforMem.scala 209:39]
      end
    end else if (2'h1 == state) begin // @[IoforMem.scala 204:18]
      if (io_axi_resp_valid) begin // @[IoforMem.scala 330:36]
        decode_inst_valid <= _GEN_254;
      end
    end
    if (reset) begin // @[IoforMem.scala 143:30]
      decode_inst <= 64'h0; // @[IoforMem.scala 143:30]
    end else if (!(2'h0 == state)) begin // @[IoforMem.scala 204:18]
      if (2'h1 == state) begin // @[IoforMem.scala 204:18]
        if (io_axi_resp_valid) begin // @[IoforMem.scala 330:36]
          decode_inst <= _GEN_255;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 148:29]
      maskbuffer_0 <= 8'h0; // @[IoforMem.scala 148:29]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          maskbuffer_0 <= _GEN_104;
        end
      end
    end else if (!(2'h1 == state)) begin // @[IoforMem.scala 204:18]
      if (2'h2 == state) begin // @[IoforMem.scala 204:18]
        maskbuffer_0 <= _GEN_493;
      end
    end
    if (reset) begin // @[IoforMem.scala 148:29]
      maskbuffer_1 <= 8'h0; // @[IoforMem.scala 148:29]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          maskbuffer_1 <= _GEN_105;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 148:29]
      maskbuffer_2 <= 8'h0; // @[IoforMem.scala 148:29]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          maskbuffer_2 <= _GEN_106;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 148:29]
      maskbuffer_3 <= 8'h0; // @[IoforMem.scala 148:29]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          maskbuffer_3 <= _GEN_107;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 148:29]
      maskbuffer_4 <= 8'h0; // @[IoforMem.scala 148:29]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          maskbuffer_4 <= _GEN_108;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 148:29]
      maskbuffer_5 <= 8'h0; // @[IoforMem.scala 148:29]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          maskbuffer_5 <= _GEN_109;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 148:29]
      maskbuffer_6 <= 8'h0; // @[IoforMem.scala 148:29]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          maskbuffer_6 <= _GEN_110;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 148:29]
      maskbuffer_7 <= 8'h0; // @[IoforMem.scala 148:29]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          maskbuffer_7 <= _GEN_111;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 148:29]
      maskbuffer_8 <= 8'h0; // @[IoforMem.scala 148:29]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          maskbuffer_8 <= _GEN_112;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 148:29]
      maskbuffer_9 <= 8'h0; // @[IoforMem.scala 148:29]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          maskbuffer_9 <= _GEN_113;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 148:29]
      maskbuffer_10 <= 8'h0; // @[IoforMem.scala 148:29]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          maskbuffer_10 <= _GEN_114;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 148:29]
      maskbuffer_11 <= 8'h0; // @[IoforMem.scala 148:29]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          maskbuffer_11 <= _GEN_115;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 148:29]
      maskbuffer_12 <= 8'h0; // @[IoforMem.scala 148:29]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          maskbuffer_12 <= _GEN_116;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 148:29]
      maskbuffer_13 <= 8'h0; // @[IoforMem.scala 148:29]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          maskbuffer_13 <= _GEN_117;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 148:29]
      maskbuffer_14 <= 8'h0; // @[IoforMem.scala 148:29]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          maskbuffer_14 <= _GEN_118;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 148:29]
      maskbuffer_15 <= 8'h0; // @[IoforMem.scala 148:29]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          maskbuffer_15 <= _GEN_119;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 150:26]
      r_count <= 4'h0; // @[IoforMem.scala 150:26]
    end else if (!(2'h0 == state)) begin // @[IoforMem.scala 204:18]
      if (!(2'h1 == state)) begin // @[IoforMem.scala 204:18]
        if (2'h2 == state) begin // @[IoforMem.scala 204:18]
          r_count <= _GEN_469;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 156:28]
      last_addr <= 32'h0; // @[IoforMem.scala 156:28]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          last_addr <= _GEN_120;
        end
      end
    end else if (!(2'h1 == state)) begin // @[IoforMem.scala 204:18]
      if (2'h2 == state) begin // @[IoforMem.scala 204:18]
        last_addr <= _GEN_494;
      end
    end
    if (reset) begin // @[IoforMem.scala 157:29]
      begin_flag <= 1'h0; // @[IoforMem.scala 157:29]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          begin_flag <= _GEN_84;
        end
      end
    end else if (!(2'h1 == state)) begin // @[IoforMem.scala 204:18]
      if (2'h2 == state) begin // @[IoforMem.scala 204:18]
        begin_flag <= _GEN_470;
      end
    end
    if (reset) begin // @[IoforMem.scala 158:30]
      begin_waddr <= 32'h0; // @[IoforMem.scala 158:30]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          begin_waddr <= _GEN_83;
        end
      end
    end else if (!(2'h1 == state)) begin // @[IoforMem.scala 204:18]
      if (2'h2 == state) begin // @[IoforMem.scala 204:18]
        begin_waddr <= _GEN_495;
      end
    end
    if (reset) begin // @[IoforMem.scala 160:29]
      data_count <= 4'h0; // @[IoforMem.scala 160:29]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          data_count <= _GEN_79;
        end else begin
          data_count <= _GEN_33;
        end
      end
    end else if (!(2'h1 == state)) begin // @[IoforMem.scala 204:18]
      if (2'h2 == state) begin // @[IoforMem.scala 204:18]
        data_count <= _GEN_471;
      end
    end
    if (reset) begin // @[IoforMem.scala 161:29]
      wait_cycle <= 4'h0; // @[IoforMem.scala 161:29]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          wait_cycle <= _GEN_121;
        end else begin
          wait_cycle <= _GEN_27;
        end
      end
    end else if (!(2'h1 == state)) begin // @[IoforMem.scala 204:18]
      if (2'h2 == state) begin // @[IoforMem.scala 204:18]
        wait_cycle <= _GEN_472;
      end
    end
    if (reset) begin // @[IoforMem.scala 164:28]
      jump_data <= 64'h0; // @[IoforMem.scala 164:28]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          jump_data <= _GEN_80;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 165:28]
      jump_mask <= 8'h0; // @[IoforMem.scala 165:28]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          jump_mask <= _GEN_82;
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 166:28]
      jump_addr <= 32'h0; // @[IoforMem.scala 166:28]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (~excute_rw & io_excute_addr == 32'h0) begin // @[IoforMem.scala 241:70]
          jump_addr <= _GEN_81;
        end
      end
    end else if (!(2'h1 == state)) begin // @[IoforMem.scala 204:18]
      if (2'h2 == state) begin // @[IoforMem.scala 204:18]
        jump_addr <= _GEN_473;
      end
    end
    if (reset) begin // @[IoforMem.scala 197:27]
      addr_buf <= 32'h0; // @[IoforMem.scala 197:27]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        addr_buf <= io_axi_req_bits_addr; // @[IoforMem.scala 217:30]
      end else if (io_fetch_req & _T_1) begin // @[IoforMem.scala 311:55]
        addr_buf <= io_axi_req_bits_addr; // @[IoforMem.scala 321:30]
      end
    end else if (2'h1 == state) begin // @[IoforMem.scala 204:18]
      if (io_axi_resp_valid) begin // @[IoforMem.scala 330:36]
        addr_buf <= _GEN_265;
      end
    end
    if (reset) begin // @[IoforMem.scala 198:25]
      rw_buf <= 1'h0; // @[IoforMem.scala 198:25]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        rw_buf <= io_axi_req_bits_rw; // @[IoforMem.scala 218:28]
      end else begin
        rw_buf <= _GEN_183;
      end
    end else if (2'h1 == state) begin // @[IoforMem.scala 204:18]
      if (io_axi_resp_valid) begin // @[IoforMem.scala 330:36]
        rw_buf <= _GEN_266;
      end
    end
    if (reset) begin // @[IoforMem.scala 200:27]
      data_buf <= 64'h0; // @[IoforMem.scala 200:27]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (!(~excute_rw & io_excute_addr == 32'h0)) begin // @[IoforMem.scala 241:70]
          data_buf <= io_excute_data; // @[IoforMem.scala 307:34]
        end
      end
    end
    if (reset) begin // @[IoforMem.scala 201:27]
      mask_buf <= 8'h0; // @[IoforMem.scala 201:27]
    end else if (2'h0 == state) begin // @[IoforMem.scala 204:18]
      if (io_ex_req & _T_1) begin // @[IoforMem.scala 214:49]
        if (!(~excute_rw & io_excute_addr == 32'h0)) begin // @[IoforMem.scala 241:70]
          mask_buf <= io_excute_mask; // @[IoforMem.scala 308:34]
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    VmemBuffer_0[initvar] = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    VmemBuffer_1[initvar] = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    VmemBuffer_2[initvar] = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    VmemBuffer_3[initvar] = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    VmemBuffer_4[initvar] = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    VmemBuffer_5[initvar] = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    VmemBuffer_6[initvar] = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    VmemBuffer_7[initvar] = _RAND_7[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  state = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  fetch_buffer = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  choose_buffer = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  load_use_local = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  mem_data_valid = _RAND_12[0:0];
  _RAND_13 = {2{`RANDOM}};
  mem_data_bits = _RAND_13[63:0];
  _RAND_14 = {1{`RANDOM}};
  decode_inst_valid = _RAND_14[0:0];
  _RAND_15 = {2{`RANDOM}};
  decode_inst = _RAND_15[63:0];
  _RAND_16 = {1{`RANDOM}};
  maskbuffer_0 = _RAND_16[7:0];
  _RAND_17 = {1{`RANDOM}};
  maskbuffer_1 = _RAND_17[7:0];
  _RAND_18 = {1{`RANDOM}};
  maskbuffer_2 = _RAND_18[7:0];
  _RAND_19 = {1{`RANDOM}};
  maskbuffer_3 = _RAND_19[7:0];
  _RAND_20 = {1{`RANDOM}};
  maskbuffer_4 = _RAND_20[7:0];
  _RAND_21 = {1{`RANDOM}};
  maskbuffer_5 = _RAND_21[7:0];
  _RAND_22 = {1{`RANDOM}};
  maskbuffer_6 = _RAND_22[7:0];
  _RAND_23 = {1{`RANDOM}};
  maskbuffer_7 = _RAND_23[7:0];
  _RAND_24 = {1{`RANDOM}};
  maskbuffer_8 = _RAND_24[7:0];
  _RAND_25 = {1{`RANDOM}};
  maskbuffer_9 = _RAND_25[7:0];
  _RAND_26 = {1{`RANDOM}};
  maskbuffer_10 = _RAND_26[7:0];
  _RAND_27 = {1{`RANDOM}};
  maskbuffer_11 = _RAND_27[7:0];
  _RAND_28 = {1{`RANDOM}};
  maskbuffer_12 = _RAND_28[7:0];
  _RAND_29 = {1{`RANDOM}};
  maskbuffer_13 = _RAND_29[7:0];
  _RAND_30 = {1{`RANDOM}};
  maskbuffer_14 = _RAND_30[7:0];
  _RAND_31 = {1{`RANDOM}};
  maskbuffer_15 = _RAND_31[7:0];
  _RAND_32 = {1{`RANDOM}};
  r_count = _RAND_32[3:0];
  _RAND_33 = {1{`RANDOM}};
  last_addr = _RAND_33[31:0];
  _RAND_34 = {1{`RANDOM}};
  begin_flag = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  begin_waddr = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  data_count = _RAND_36[3:0];
  _RAND_37 = {1{`RANDOM}};
  wait_cycle = _RAND_37[3:0];
  _RAND_38 = {2{`RANDOM}};
  jump_data = _RAND_38[63:0];
  _RAND_39 = {1{`RANDOM}};
  jump_mask = _RAND_39[7:0];
  _RAND_40 = {1{`RANDOM}};
  jump_addr = _RAND_40[31:0];
  _RAND_41 = {1{`RANDOM}};
  addr_buf = _RAND_41[31:0];
  _RAND_42 = {1{`RANDOM}};
  rw_buf = _RAND_42[0:0];
  _RAND_43 = {2{`RANDOM}};
  data_buf = _RAND_43[63:0];
  _RAND_44 = {1{`RANDOM}};
  mask_buf = _RAND_44[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_22051553_ysyx_22051553(
  input          clock,
  input          reset,
  input          io_interrupt,
  input          io_master_awready,
  output         io_master_awvalid,
  output [3:0]   io_master_awid,
  output [31:0]  io_master_awaddr,
  output [7:0]   io_master_awlen,
  output [2:0]   io_master_awsize,
  output [1:0]   io_master_awburst,
  input          io_master_wready,
  output         io_master_wvalid,
  output [63:0]  io_master_wdata,
  output [7:0]   io_master_wstrb,
  output         io_master_wlast,
  output         io_master_bready,
  input          io_master_bvalid,
  input  [3:0]   io_master_bid,
  input  [1:0]   io_master_bresp,
  input          io_master_arready,
  output         io_master_arvalid,
  output [3:0]   io_master_arid,
  output [31:0]  io_master_araddr,
  output [7:0]   io_master_arlen,
  output [2:0]   io_master_arsize,
  output [1:0]   io_master_arburst,
  output         io_master_rready,
  input          io_master_rvalid,
  input  [3:0]   io_master_rid,
  input  [1:0]   io_master_rresp,
  input  [63:0]  io_master_rdata,
  input          io_master_rlast,
  output         io_slave_awready,
  input          io_slave_awvalid,
  input  [3:0]   io_slave_awid,
  input  [31:0]  io_slave_awaddr,
  input  [7:0]   io_slave_awlen,
  input  [2:0]   io_slave_awsize,
  input  [1:0]   io_slave_awburst,
  output         io_slave_wready,
  input          io_slave_wvalid,
  input  [63:0]  io_slave_wdata,
  input  [7:0]   io_slave_wstrb,
  input          io_slave_wlast,
  input          io_slave_bready,
  output         io_slave_bvalid,
  output [3:0]   io_slave_bid,
  output [1:0]   io_slave_bresp,
  output         io_slave_arready,
  input          io_slave_arvalid,
  input  [3:0]   io_slave_arid,
  input  [31:0]  io_slave_araddr,
  input  [7:0]   io_slave_arlen,
  input  [2:0]   io_slave_arsize,
  input  [1:0]   io_slave_arburst,
  input          io_slave_rready,
  output         io_slave_rvalid,
  output [3:0]   io_slave_rid,
  output [1:0]   io_slave_rresp,
  output [63:0]  io_slave_rdata,
  output         io_slave_rlast,
  output [5:0]   io_sram0_addr,
  output         io_sram0_cen,
  output         io_sram0_wen,
  output [127:0] io_sram0_wmask,
  output [127:0] io_sram0_wdata,
  input  [127:0] io_sram0_rdata,
  output [5:0]   io_sram1_addr,
  output         io_sram1_cen,
  output         io_sram1_wen,
  output [127:0] io_sram1_wmask,
  output [127:0] io_sram1_wdata,
  input  [127:0] io_sram1_rdata,
  output [5:0]   io_sram2_addr,
  output         io_sram2_cen,
  output         io_sram2_wen,
  output [127:0] io_sram2_wmask,
  output [127:0] io_sram2_wdata,
  input  [127:0] io_sram2_rdata,
  output [5:0]   io_sram3_addr,
  output         io_sram3_cen,
  output         io_sram3_wen,
  output [127:0] io_sram3_wmask,
  output [127:0] io_sram3_wdata,
  input  [127:0] io_sram3_rdata,
  output [5:0]   io_sram4_addr,
  output         io_sram4_cen,
  output         io_sram4_wen,
  output [127:0] io_sram4_wmask,
  output [127:0] io_sram4_wdata,
  input  [127:0] io_sram4_rdata,
  output [5:0]   io_sram5_addr,
  output         io_sram5_cen,
  output         io_sram5_wen,
  output [127:0] io_sram5_wmask,
  output [127:0] io_sram5_wdata,
  input  [127:0] io_sram5_rdata,
  output [5:0]   io_sram6_addr,
  output         io_sram6_cen,
  output         io_sram6_wen,
  output [127:0] io_sram6_wmask,
  output [127:0] io_sram6_wdata,
  input  [127:0] io_sram6_rdata,
  output [5:0]   io_sram7_addr,
  output         io_sram7_cen,
  output         io_sram7_wen,
  output [127:0] io_sram7_wmask,
  output [127:0] io_sram7_wdata,
  input  [127:0] io_sram7_rdata
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [63:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [63:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [63:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [63:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  wire  fetch_clock; // @[ysyx_22051553.scala 40:23]
  wire  fetch_reset; // @[ysyx_22051553.scala 40:23]
  wire [63:0] fetch_io_fdio_pc; // @[ysyx_22051553.scala 40:23]
  wire  fetch_io_pc_valid; // @[ysyx_22051553.scala 40:23]
  wire [63:0] fetch_io_pc_bits; // @[ysyx_22051553.scala 40:23]
  wire  fetch_io_fcfe_jump_flag; // @[ysyx_22051553.scala 40:23]
  wire [63:0] fetch_io_fcfe_jump_pc; // @[ysyx_22051553.scala 40:23]
  wire  fetch_io_fcfe_flush; // @[ysyx_22051553.scala 40:23]
  wire  fetch_io_fcfe_stall; // @[ysyx_22051553.scala 40:23]
  wire  decode_clock; // @[ysyx_22051553.scala 41:24]
  wire  decode_reset; // @[ysyx_22051553.scala 41:24]
  wire  decode_io_inst_valid; // @[ysyx_22051553.scala 41:24]
  wire [63:0] decode_io_inst_bits_data; // @[ysyx_22051553.scala 41:24]
  wire  decode_io_inst_io_inst_valid; // @[ysyx_22051553.scala 41:24]
  wire [63:0] decode_io_inst_io_inst_bits; // @[ysyx_22051553.scala 41:24]
  wire  decode_io_inst_io_load_use; // @[ysyx_22051553.scala 41:24]
  wire [63:0] decode_io_fdio_pc; // @[ysyx_22051553.scala 41:24]
  wire [4:0] decode_io_rfio_reg1_raddr; // @[ysyx_22051553.scala 41:24]
  wire [4:0] decode_io_rfio_reg2_raddr; // @[ysyx_22051553.scala 41:24]
  wire [63:0] decode_io_rfio_reg1_rdata; // @[ysyx_22051553.scala 41:24]
  wire [63:0] decode_io_rfio_reg2_rdata; // @[ysyx_22051553.scala 41:24]
  wire [63:0] decode_io_deio_op_a; // @[ysyx_22051553.scala 41:24]
  wire [63:0] decode_io_deio_op_b; // @[ysyx_22051553.scala 41:24]
  wire [4:0] decode_io_deio_reg_waddr; // @[ysyx_22051553.scala 41:24]
  wire  decode_io_deio_branch_type; // @[ysyx_22051553.scala 41:24]
  wire [63:0] decode_io_deio_branch_addr; // @[ysyx_22051553.scala 41:24]
  wire [5:0] decode_io_deio_alu_op; // @[ysyx_22051553.scala 41:24]
  wire [5:0] decode_io_deio_shamt; // @[ysyx_22051553.scala 41:24]
  wire [1:0] decode_io_deio_wb_type; // @[ysyx_22051553.scala 41:24]
  wire [2:0] decode_io_deio_sd_type; // @[ysyx_22051553.scala 41:24]
  wire [63:0] decode_io_deio_reg2_rdata; // @[ysyx_22051553.scala 41:24]
  wire [2:0] decode_io_deio_ld_type; // @[ysyx_22051553.scala 41:24]
  wire [63:0] decode_io_deio_csr_t; // @[ysyx_22051553.scala 41:24]
  wire [11:0] decode_io_deio_csr_waddr; // @[ysyx_22051553.scala 41:24]
  wire  decode_io_deio_csr_wen; // @[ysyx_22051553.scala 41:24]
  wire  decode_io_deio_has_inst; // @[ysyx_22051553.scala 41:24]
  wire  decode_io_jump_flag; // @[ysyx_22051553.scala 41:24]
  wire [63:0] decode_io_jump_pc; // @[ysyx_22051553.scala 41:24]
  wire  decode_io_load_use; // @[ysyx_22051553.scala 41:24]
  wire  decode_io_branch; // @[ysyx_22051553.scala 41:24]
  wire  decode_io_stall; // @[ysyx_22051553.scala 41:24]
  wire  decode_io_flush; // @[ysyx_22051553.scala 41:24]
  wire [4:0] decode_io_fwde_reg1_raddr; // @[ysyx_22051553.scala 41:24]
  wire [4:0] decode_io_fwde_reg2_raddr; // @[ysyx_22051553.scala 41:24]
  wire  decode_io_fwde_fw_sel1; // @[ysyx_22051553.scala 41:24]
  wire  decode_io_fwde_fw_sel2; // @[ysyx_22051553.scala 41:24]
  wire [63:0] decode_io_fwde_fw_data1; // @[ysyx_22051553.scala 41:24]
  wire [63:0] decode_io_fwde_fw_data2; // @[ysyx_22051553.scala 41:24]
  wire [11:0] decode_io_fwde_csr_raddr; // @[ysyx_22051553.scala 41:24]
  wire  decode_io_fwde_csr_fw_sel; // @[ysyx_22051553.scala 41:24]
  wire [63:0] decode_io_fwde_csr_fw_data; // @[ysyx_22051553.scala 41:24]
  wire [11:0] decode_io_csrs_csr_raddr; // @[ysyx_22051553.scala 41:24]
  wire [63:0] decode_io_csrs_csr_rdata; // @[ysyx_22051553.scala 41:24]
  wire  excute_clock; // @[ysyx_22051553.scala 42:24]
  wire  excute_reset; // @[ysyx_22051553.scala 42:24]
  wire [63:0] excute_io_deio_op_a; // @[ysyx_22051553.scala 42:24]
  wire [63:0] excute_io_deio_op_b; // @[ysyx_22051553.scala 42:24]
  wire [4:0] excute_io_deio_reg_waddr; // @[ysyx_22051553.scala 42:24]
  wire  excute_io_deio_branch_type; // @[ysyx_22051553.scala 42:24]
  wire [63:0] excute_io_deio_branch_addr; // @[ysyx_22051553.scala 42:24]
  wire [5:0] excute_io_deio_alu_op; // @[ysyx_22051553.scala 42:24]
  wire [5:0] excute_io_deio_shamt; // @[ysyx_22051553.scala 42:24]
  wire [1:0] excute_io_deio_wb_type; // @[ysyx_22051553.scala 42:24]
  wire [2:0] excute_io_deio_sd_type; // @[ysyx_22051553.scala 42:24]
  wire [63:0] excute_io_deio_reg2_rdata; // @[ysyx_22051553.scala 42:24]
  wire [2:0] excute_io_deio_ld_type; // @[ysyx_22051553.scala 42:24]
  wire [63:0] excute_io_deio_csr_t; // @[ysyx_22051553.scala 42:24]
  wire [11:0] excute_io_deio_csr_waddr; // @[ysyx_22051553.scala 42:24]
  wire  excute_io_deio_csr_wen; // @[ysyx_22051553.scala 42:24]
  wire  excute_io_deio_has_inst; // @[ysyx_22051553.scala 42:24]
  wire [63:0] excute_io_emio_reg_wdata; // @[ysyx_22051553.scala 42:24]
  wire [4:0] excute_io_emio_reg_waddr; // @[ysyx_22051553.scala 42:24]
  wire [1:0] excute_io_emio_wb_type; // @[ysyx_22051553.scala 42:24]
  wire [2:0] excute_io_emio_ld_type; // @[ysyx_22051553.scala 42:24]
  wire [2:0] excute_io_emio_ld_addr_lowbit; // @[ysyx_22051553.scala 42:24]
  wire [63:0] excute_io_emio_csr_wdata; // @[ysyx_22051553.scala 42:24]
  wire  excute_io_emio_csr_wen; // @[ysyx_22051553.scala 42:24]
  wire [11:0] excute_io_emio_csr_waddr; // @[ysyx_22051553.scala 42:24]
  wire  excute_io_emio_has_inst; // @[ysyx_22051553.scala 42:24]
  wire  excute_io_fcex_jump_flag; // @[ysyx_22051553.scala 42:24]
  wire [63:0] excute_io_fcex_jump_pc; // @[ysyx_22051553.scala 42:24]
  wire  excute_io_fcex_mul_div_busy; // @[ysyx_22051553.scala 42:24]
  wire  excute_io_fcex_mul_div_valid; // @[ysyx_22051553.scala 42:24]
  wire  excute_io_fcex_stall; // @[ysyx_22051553.scala 42:24]
  wire [63:0] excute_io_raddr; // @[ysyx_22051553.scala 42:24]
  wire [63:0] excute_io_waddr; // @[ysyx_22051553.scala 42:24]
  wire [63:0] excute_io_wdata; // @[ysyx_22051553.scala 42:24]
  wire [7:0] excute_io_wmask; // @[ysyx_22051553.scala 42:24]
  wire [4:0] excute_io_fwex_reg_waddr; // @[ysyx_22051553.scala 42:24]
  wire [63:0] excute_io_fwex_reg_wdata; // @[ysyx_22051553.scala 42:24]
  wire  excute_io_fwex_reg_we; // @[ysyx_22051553.scala 42:24]
  wire [63:0] excute_io_fwex_csr_wdata; // @[ysyx_22051553.scala 42:24]
  wire  excute_io_fwex_csr_wen; // @[ysyx_22051553.scala 42:24]
  wire [11:0] excute_io_fwex_csr_waddr; // @[ysyx_22051553.scala 42:24]
  wire  excute_io_clex_valid; // @[ysyx_22051553.scala 42:24]
  wire [2:0] excute_io_clex_ld_type; // @[ysyx_22051553.scala 42:24]
  wire [63:0] excute_io_clex_raddr; // @[ysyx_22051553.scala 42:24]
  wire [2:0] excute_io_clex_sd_type; // @[ysyx_22051553.scala 42:24]
  wire [63:0] excute_io_clex_waddr; // @[ysyx_22051553.scala 42:24]
  wire [7:0] excute_io_clex_wmask; // @[ysyx_22051553.scala 42:24]
  wire [63:0] excute_io_clex_wdata; // @[ysyx_22051553.scala 42:24]
  wire  excute_io_has_inst; // @[ysyx_22051553.scala 42:24]
  wire [31:0] excute_io_ioformem_addr; // @[ysyx_22051553.scala 42:24]
  wire [63:0] excute_io_ioformem_data; // @[ysyx_22051553.scala 42:24]
  wire [7:0] excute_io_ioformem_mask; // @[ysyx_22051553.scala 42:24]
  wire [2:0] excute_io_ioformem_ld_type; // @[ysyx_22051553.scala 42:24]
  wire [2:0] excute_io_ioformem_sd_type; // @[ysyx_22051553.scala 42:24]
  wire  mem_clock; // @[ysyx_22051553.scala 44:21]
  wire  mem_reset; // @[ysyx_22051553.scala 44:21]
  wire [63:0] mem_io_emio_reg_wdata; // @[ysyx_22051553.scala 44:21]
  wire [4:0] mem_io_emio_reg_waddr; // @[ysyx_22051553.scala 44:21]
  wire [1:0] mem_io_emio_wb_type; // @[ysyx_22051553.scala 44:21]
  wire [2:0] mem_io_emio_ld_type; // @[ysyx_22051553.scala 44:21]
  wire [2:0] mem_io_emio_ld_addr_lowbit; // @[ysyx_22051553.scala 44:21]
  wire [63:0] mem_io_emio_csr_wdata; // @[ysyx_22051553.scala 44:21]
  wire  mem_io_emio_csr_wen; // @[ysyx_22051553.scala 44:21]
  wire [11:0] mem_io_emio_csr_waddr; // @[ysyx_22051553.scala 44:21]
  wire  mem_io_emio_has_inst; // @[ysyx_22051553.scala 44:21]
  wire [63:0] mem_io_mwio_reg_wdata; // @[ysyx_22051553.scala 44:21]
  wire [4:0] mem_io_mwio_reg_waddr; // @[ysyx_22051553.scala 44:21]
  wire [1:0] mem_io_mwio_wb_type; // @[ysyx_22051553.scala 44:21]
  wire [63:0] mem_io_mwio_csr_wdata; // @[ysyx_22051553.scala 44:21]
  wire  mem_io_mwio_csr_wen; // @[ysyx_22051553.scala 44:21]
  wire [11:0] mem_io_mwio_csr_waddr; // @[ysyx_22051553.scala 44:21]
  wire  mem_io_mwio_has_inst; // @[ysyx_22051553.scala 44:21]
  wire  mem_io_rdata_valid; // @[ysyx_22051553.scala 44:21]
  wire [63:0] mem_io_rdata_bits_data; // @[ysyx_22051553.scala 44:21]
  wire  mem_io_rdata_io_data_valid; // @[ysyx_22051553.scala 44:21]
  wire [63:0] mem_io_rdata_io_data_bits; // @[ysyx_22051553.scala 44:21]
  wire [4:0] mem_io_fwmem_reg_waddr; // @[ysyx_22051553.scala 44:21]
  wire [63:0] mem_io_fwmem_reg_wdata; // @[ysyx_22051553.scala 44:21]
  wire  mem_io_fwmem_reg_we; // @[ysyx_22051553.scala 44:21]
  wire [63:0] mem_io_fwmem_csr_wdata; // @[ysyx_22051553.scala 44:21]
  wire  mem_io_fwmem_csr_wen; // @[ysyx_22051553.scala 44:21]
  wire [11:0] mem_io_fwmem_csr_waddr; // @[ysyx_22051553.scala 44:21]
  wire  mem_io_clmem_Clrvalue_valid; // @[ysyx_22051553.scala 44:21]
  wire [63:0] mem_io_clmem_Clrvalue_bits; // @[ysyx_22051553.scala 44:21]
  wire  mem_io_stall; // @[ysyx_22051553.scala 44:21]
  wire  mem_io_has_inst; // @[ysyx_22051553.scala 44:21]
  wire [63:0] wb_io_mwio_reg_wdata; // @[ysyx_22051553.scala 45:20]
  wire [4:0] wb_io_mwio_reg_waddr; // @[ysyx_22051553.scala 45:20]
  wire [1:0] wb_io_mwio_wb_type; // @[ysyx_22051553.scala 45:20]
  wire [63:0] wb_io_mwio_csr_wdata; // @[ysyx_22051553.scala 45:20]
  wire  wb_io_mwio_csr_wen; // @[ysyx_22051553.scala 45:20]
  wire [11:0] wb_io_mwio_csr_waddr; // @[ysyx_22051553.scala 45:20]
  wire  wb_io_mwio_has_inst; // @[ysyx_22051553.scala 45:20]
  wire [4:0] wb_io_rfio_rd; // @[ysyx_22051553.scala 45:20]
  wire  wb_io_rfio_reg_wen; // @[ysyx_22051553.scala 45:20]
  wire [63:0] wb_io_rfio_reg_wdata; // @[ysyx_22051553.scala 45:20]
  wire [4:0] wb_io_fwwb_reg_waddr; // @[ysyx_22051553.scala 45:20]
  wire [63:0] wb_io_fwwb_reg_wdata; // @[ysyx_22051553.scala 45:20]
  wire  wb_io_fwwb_reg_we; // @[ysyx_22051553.scala 45:20]
  wire [63:0] wb_io_fwwb_csr_wdata; // @[ysyx_22051553.scala 45:20]
  wire  wb_io_fwwb_csr_wen; // @[ysyx_22051553.scala 45:20]
  wire [11:0] wb_io_fwwb_csr_waddr; // @[ysyx_22051553.scala 45:20]
  wire [11:0] wb_io_csrs_rd; // @[ysyx_22051553.scala 45:20]
  wire  wb_io_csrs_csr_wen; // @[ysyx_22051553.scala 45:20]
  wire [63:0] wb_io_csrs_csr_wdata; // @[ysyx_22051553.scala 45:20]
  wire  wb_io_stall; // @[ysyx_22051553.scala 45:20]
  wire  wb_io_has_inst; // @[ysyx_22051553.scala 45:20]
  wire  clint_clock; // @[ysyx_22051553.scala 98:23]
  wire  clint_reset; // @[ysyx_22051553.scala 98:23]
  wire  clint_io_clex_valid; // @[ysyx_22051553.scala 98:23]
  wire [2:0] clint_io_clex_ld_type; // @[ysyx_22051553.scala 98:23]
  wire [63:0] clint_io_clex_raddr; // @[ysyx_22051553.scala 98:23]
  wire [2:0] clint_io_clex_sd_type; // @[ysyx_22051553.scala 98:23]
  wire [63:0] clint_io_clex_waddr; // @[ysyx_22051553.scala 98:23]
  wire [7:0] clint_io_clex_wmask; // @[ysyx_22051553.scala 98:23]
  wire [63:0] clint_io_clex_wdata; // @[ysyx_22051553.scala 98:23]
  wire  clint_io_clmem_Clrvalue_valid; // @[ysyx_22051553.scala 98:23]
  wire [63:0] clint_io_clmem_Clrvalue_bits; // @[ysyx_22051553.scala 98:23]
  wire  clint_io_timer_int; // @[ysyx_22051553.scala 98:23]
  wire [4:0] fw_io_fwde_reg1_raddr; // @[ysyx_22051553.scala 101:20]
  wire [4:0] fw_io_fwde_reg2_raddr; // @[ysyx_22051553.scala 101:20]
  wire  fw_io_fwde_fw_sel1; // @[ysyx_22051553.scala 101:20]
  wire  fw_io_fwde_fw_sel2; // @[ysyx_22051553.scala 101:20]
  wire [63:0] fw_io_fwde_fw_data1; // @[ysyx_22051553.scala 101:20]
  wire [63:0] fw_io_fwde_fw_data2; // @[ysyx_22051553.scala 101:20]
  wire [11:0] fw_io_fwde_csr_raddr; // @[ysyx_22051553.scala 101:20]
  wire  fw_io_fwde_csr_fw_sel; // @[ysyx_22051553.scala 101:20]
  wire [63:0] fw_io_fwde_csr_fw_data; // @[ysyx_22051553.scala 101:20]
  wire [4:0] fw_io_fwex_reg_waddr; // @[ysyx_22051553.scala 101:20]
  wire [63:0] fw_io_fwex_reg_wdata; // @[ysyx_22051553.scala 101:20]
  wire  fw_io_fwex_reg_we; // @[ysyx_22051553.scala 101:20]
  wire [63:0] fw_io_fwex_csr_wdata; // @[ysyx_22051553.scala 101:20]
  wire  fw_io_fwex_csr_wen; // @[ysyx_22051553.scala 101:20]
  wire [11:0] fw_io_fwex_csr_waddr; // @[ysyx_22051553.scala 101:20]
  wire [4:0] fw_io_fwmem_reg_waddr; // @[ysyx_22051553.scala 101:20]
  wire [63:0] fw_io_fwmem_reg_wdata; // @[ysyx_22051553.scala 101:20]
  wire  fw_io_fwmem_reg_we; // @[ysyx_22051553.scala 101:20]
  wire [63:0] fw_io_fwmem_csr_wdata; // @[ysyx_22051553.scala 101:20]
  wire  fw_io_fwmem_csr_wen; // @[ysyx_22051553.scala 101:20]
  wire [11:0] fw_io_fwmem_csr_waddr; // @[ysyx_22051553.scala 101:20]
  wire [4:0] fw_io_fwwb_reg_waddr; // @[ysyx_22051553.scala 101:20]
  wire [63:0] fw_io_fwwb_reg_wdata; // @[ysyx_22051553.scala 101:20]
  wire  fw_io_fwwb_reg_we; // @[ysyx_22051553.scala 101:20]
  wire [63:0] fw_io_fwwb_csr_wdata; // @[ysyx_22051553.scala 101:20]
  wire  fw_io_fwwb_csr_wen; // @[ysyx_22051553.scala 101:20]
  wire [11:0] fw_io_fwwb_csr_waddr; // @[ysyx_22051553.scala 101:20]
  wire  regfile_clock; // @[ysyx_22051553.scala 104:25]
  wire  regfile_reset; // @[ysyx_22051553.scala 104:25]
  wire [4:0] regfile_io_RfDe_reg1_raddr; // @[ysyx_22051553.scala 104:25]
  wire [4:0] regfile_io_RfDe_reg2_raddr; // @[ysyx_22051553.scala 104:25]
  wire [63:0] regfile_io_RfDe_reg1_rdata; // @[ysyx_22051553.scala 104:25]
  wire [63:0] regfile_io_RfDe_reg2_rdata; // @[ysyx_22051553.scala 104:25]
  wire [4:0] regfile_io_RfWb_rd; // @[ysyx_22051553.scala 104:25]
  wire  regfile_io_RfWb_reg_wen; // @[ysyx_22051553.scala 104:25]
  wire [63:0] regfile_io_RfWb_reg_wdata; // @[ysyx_22051553.scala 104:25]
  wire  fc_io_fcfe_jump_flag; // @[ysyx_22051553.scala 107:20]
  wire [63:0] fc_io_fcfe_jump_pc; // @[ysyx_22051553.scala 107:20]
  wire  fc_io_fcfe_flush; // @[ysyx_22051553.scala 107:20]
  wire  fc_io_fcfe_stall; // @[ysyx_22051553.scala 107:20]
  wire  fc_io_fcde_jump_flag; // @[ysyx_22051553.scala 107:20]
  wire [63:0] fc_io_fcde_jump_pc; // @[ysyx_22051553.scala 107:20]
  wire  fc_io_fcde_load_use; // @[ysyx_22051553.scala 107:20]
  wire  fc_io_fcde_flush; // @[ysyx_22051553.scala 107:20]
  wire  fc_io_fcde_stall; // @[ysyx_22051553.scala 107:20]
  wire  fc_io_fcex_jump_flag; // @[ysyx_22051553.scala 107:20]
  wire [63:0] fc_io_fcex_jump_pc; // @[ysyx_22051553.scala 107:20]
  wire  fc_io_fcex_mul_div_busy; // @[ysyx_22051553.scala 107:20]
  wire  fc_io_fcex_mul_div_valid; // @[ysyx_22051553.scala 107:20]
  wire  fc_io_fcex_stall; // @[ysyx_22051553.scala 107:20]
  wire  fc_io_fcmem_stall; // @[ysyx_22051553.scala 107:20]
  wire  fc_io_fcwb_stall; // @[ysyx_22051553.scala 107:20]
  wire  fc_io_fctr_pop_NOP; // @[ysyx_22051553.scala 107:20]
  wire [2:0] fc_io_fctr_trap_state; // @[ysyx_22051553.scala 107:20]
  wire  fc_io_fctr_jump_flag; // @[ysyx_22051553.scala 107:20]
  wire [63:0] fc_io_fctr_jump_pc; // @[ysyx_22051553.scala 107:20]
  wire [2:0] fc_io_fcIcache_state; // @[ysyx_22051553.scala 107:20]
  wire [2:0] fc_io_fcDcache_state; // @[ysyx_22051553.scala 107:20]
  wire  fc_io_fcio_stall; // @[ysyx_22051553.scala 107:20]
  wire [1:0] fc_io_fcio_state; // @[ysyx_22051553.scala 107:20]
  wire  csrs_clock; // @[ysyx_22051553.scala 110:22]
  wire  csrs_reset; // @[ysyx_22051553.scala 110:22]
  wire [11:0] csrs_io_CSRDe_csr_raddr; // @[ysyx_22051553.scala 110:22]
  wire [63:0] csrs_io_CSRDe_csr_rdata; // @[ysyx_22051553.scala 110:22]
  wire [11:0] csrs_io_CSRWb_rd; // @[ysyx_22051553.scala 110:22]
  wire  csrs_io_CSRWb_csr_wen; // @[ysyx_22051553.scala 110:22]
  wire [63:0] csrs_io_CSRWb_csr_wdata; // @[ysyx_22051553.scala 110:22]
  wire [63:0] csrs_io_CSRTr_MTVEC; // @[ysyx_22051553.scala 110:22]
  wire [63:0] csrs_io_CSRTr_MCAUSE; // @[ysyx_22051553.scala 110:22]
  wire [63:0] csrs_io_CSRTr_MEPC; // @[ysyx_22051553.scala 110:22]
  wire [63:0] csrs_io_CSRTr_MIE; // @[ysyx_22051553.scala 110:22]
  wire [63:0] csrs_io_CSRTr_MIP; // @[ysyx_22051553.scala 110:22]
  wire [63:0] csrs_io_CSRTr_MSTATUS; // @[ysyx_22051553.scala 110:22]
  wire [11:0] csrs_io_CSRTr_rd; // @[ysyx_22051553.scala 110:22]
  wire  csrs_io_CSRTr_csr_wen; // @[ysyx_22051553.scala 110:22]
  wire [63:0] csrs_io_CSRTr_csr_wdata; // @[ysyx_22051553.scala 110:22]
  wire  csrs_io_timer_int; // @[ysyx_22051553.scala 110:22]
  wire  trap_clock; // @[ysyx_22051553.scala 113:22]
  wire  trap_reset; // @[ysyx_22051553.scala 113:22]
  wire  trap_io_ex_hasinst; // @[ysyx_22051553.scala 113:22]
  wire  trap_io_mem_hasinst; // @[ysyx_22051553.scala 113:22]
  wire  trap_io_wb_hasinst; // @[ysyx_22051553.scala 113:22]
  wire [63:0] trap_io_csrtr_MTVEC; // @[ysyx_22051553.scala 113:22]
  wire [63:0] trap_io_csrtr_MCAUSE; // @[ysyx_22051553.scala 113:22]
  wire [63:0] trap_io_csrtr_MEPC; // @[ysyx_22051553.scala 113:22]
  wire [63:0] trap_io_csrtr_MIE; // @[ysyx_22051553.scala 113:22]
  wire [63:0] trap_io_csrtr_MIP; // @[ysyx_22051553.scala 113:22]
  wire [63:0] trap_io_csrtr_MSTATUS; // @[ysyx_22051553.scala 113:22]
  wire [11:0] trap_io_csrtr_rd; // @[ysyx_22051553.scala 113:22]
  wire  trap_io_csrtr_csr_wen; // @[ysyx_22051553.scala 113:22]
  wire [63:0] trap_io_csrtr_csr_wdata; // @[ysyx_22051553.scala 113:22]
  wire [31:0] trap_io_inst; // @[ysyx_22051553.scala 113:22]
  wire [63:0] trap_io_pc; // @[ysyx_22051553.scala 113:22]
  wire  trap_io_fctr_pop_NOP; // @[ysyx_22051553.scala 113:22]
  wire [2:0] trap_io_fctr_trap_state; // @[ysyx_22051553.scala 113:22]
  wire  trap_io_fctr_jump_flag; // @[ysyx_22051553.scala 113:22]
  wire [63:0] trap_io_fctr_jump_pc; // @[ysyx_22051553.scala 113:22]
  wire  arbitor_clock; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_reset; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_master0_req_valid; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_master0_req_bits_rw; // @[ysyx_22051553.scala 116:25]
  wire [31:0] arbitor_io_master0_req_bits_addr; // @[ysyx_22051553.scala 116:25]
  wire [63:0] arbitor_io_master0_req_bits_data; // @[ysyx_22051553.scala 116:25]
  wire [7:0] arbitor_io_master0_req_bits_mask; // @[ysyx_22051553.scala 116:25]
  wire [7:0] arbitor_io_master0_req_bits_len; // @[ysyx_22051553.scala 116:25]
  wire [2:0] arbitor_io_master0_req_bits_size; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_master0_resp_valid; // @[ysyx_22051553.scala 116:25]
  wire [63:0] arbitor_io_master0_resp_bits_data; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_master1_req_valid; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_master1_req_bits_rw; // @[ysyx_22051553.scala 116:25]
  wire [31:0] arbitor_io_master1_req_bits_addr; // @[ysyx_22051553.scala 116:25]
  wire [63:0] arbitor_io_master1_req_bits_data; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_master1_resp_valid; // @[ysyx_22051553.scala 116:25]
  wire [63:0] arbitor_io_master1_resp_bits_data; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_master1_resp_bits_valid; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_master1_resp_bits_choose; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_master2_req_valid; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_master2_req_bits_rw; // @[ysyx_22051553.scala 116:25]
  wire [31:0] arbitor_io_master2_req_bits_addr; // @[ysyx_22051553.scala 116:25]
  wire [63:0] arbitor_io_master2_req_bits_data; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_master2_resp_valid; // @[ysyx_22051553.scala 116:25]
  wire [63:0] arbitor_io_master2_resp_bits_data; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_master2_resp_bits_valid; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_master2_resp_bits_choose; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_AXI_O_awready; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_AXI_O_awvalid; // @[ysyx_22051553.scala 116:25]
  wire [31:0] arbitor_io_AXI_O_awaddr; // @[ysyx_22051553.scala 116:25]
  wire [7:0] arbitor_io_AXI_O_awlen; // @[ysyx_22051553.scala 116:25]
  wire [2:0] arbitor_io_AXI_O_awsize; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_AXI_O_wready; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_AXI_O_wvalid; // @[ysyx_22051553.scala 116:25]
  wire [63:0] arbitor_io_AXI_O_wdata; // @[ysyx_22051553.scala 116:25]
  wire [7:0] arbitor_io_AXI_O_wstrb; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_AXI_O_wlast; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_AXI_O_bready; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_AXI_O_bvalid; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_AXI_O_arready; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_AXI_O_arvalid; // @[ysyx_22051553.scala 116:25]
  wire [31:0] arbitor_io_AXI_O_araddr; // @[ysyx_22051553.scala 116:25]
  wire [7:0] arbitor_io_AXI_O_arlen; // @[ysyx_22051553.scala 116:25]
  wire [2:0] arbitor_io_AXI_O_arsize; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_AXI_O_rready; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_AXI_O_rvalid; // @[ysyx_22051553.scala 116:25]
  wire [63:0] arbitor_io_AXI_O_rdata; // @[ysyx_22051553.scala 116:25]
  wire  arbitor_io_AXI_O_rlast; // @[ysyx_22051553.scala 116:25]
  wire  Icache_clock; // @[ysyx_22051553.scala 119:24]
  wire  Icache_reset; // @[ysyx_22051553.scala 119:24]
  wire  Icache_io_cpu_req_valid; // @[ysyx_22051553.scala 119:24]
  wire [31:0] Icache_io_cpu_req_bits_addr; // @[ysyx_22051553.scala 119:24]
  wire [63:0] Icache_io_cpu_req_bits_data; // @[ysyx_22051553.scala 119:24]
  wire [7:0] Icache_io_cpu_req_bits_mask; // @[ysyx_22051553.scala 119:24]
  wire  Icache_io_cpu_resp_valid; // @[ysyx_22051553.scala 119:24]
  wire [63:0] Icache_io_cpu_resp_bits_data; // @[ysyx_22051553.scala 119:24]
  wire [5:0] Icache_io_cpu_sram0_addr; // @[ysyx_22051553.scala 119:24]
  wire  Icache_io_cpu_sram0_cen; // @[ysyx_22051553.scala 119:24]
  wire  Icache_io_cpu_sram0_wen; // @[ysyx_22051553.scala 119:24]
  wire [127:0] Icache_io_cpu_sram0_wmask; // @[ysyx_22051553.scala 119:24]
  wire [127:0] Icache_io_cpu_sram0_wdata; // @[ysyx_22051553.scala 119:24]
  wire [127:0] Icache_io_cpu_sram0_rdata; // @[ysyx_22051553.scala 119:24]
  wire [5:0] Icache_io_cpu_sram1_addr; // @[ysyx_22051553.scala 119:24]
  wire  Icache_io_cpu_sram1_cen; // @[ysyx_22051553.scala 119:24]
  wire  Icache_io_cpu_sram1_wen; // @[ysyx_22051553.scala 119:24]
  wire [127:0] Icache_io_cpu_sram1_wmask; // @[ysyx_22051553.scala 119:24]
  wire [127:0] Icache_io_cpu_sram1_wdata; // @[ysyx_22051553.scala 119:24]
  wire [127:0] Icache_io_cpu_sram1_rdata; // @[ysyx_22051553.scala 119:24]
  wire [5:0] Icache_io_cpu_sram2_addr; // @[ysyx_22051553.scala 119:24]
  wire  Icache_io_cpu_sram2_cen; // @[ysyx_22051553.scala 119:24]
  wire  Icache_io_cpu_sram2_wen; // @[ysyx_22051553.scala 119:24]
  wire [127:0] Icache_io_cpu_sram2_wmask; // @[ysyx_22051553.scala 119:24]
  wire [127:0] Icache_io_cpu_sram2_wdata; // @[ysyx_22051553.scala 119:24]
  wire [127:0] Icache_io_cpu_sram2_rdata; // @[ysyx_22051553.scala 119:24]
  wire [5:0] Icache_io_cpu_sram3_addr; // @[ysyx_22051553.scala 119:24]
  wire  Icache_io_cpu_sram3_cen; // @[ysyx_22051553.scala 119:24]
  wire  Icache_io_cpu_sram3_wen; // @[ysyx_22051553.scala 119:24]
  wire [127:0] Icache_io_cpu_sram3_wmask; // @[ysyx_22051553.scala 119:24]
  wire [127:0] Icache_io_cpu_sram3_wdata; // @[ysyx_22051553.scala 119:24]
  wire [127:0] Icache_io_cpu_sram3_rdata; // @[ysyx_22051553.scala 119:24]
  wire  Icache_io_axi_req_valid; // @[ysyx_22051553.scala 119:24]
  wire  Icache_io_axi_req_bits_rw; // @[ysyx_22051553.scala 119:24]
  wire [31:0] Icache_io_axi_req_bits_addr; // @[ysyx_22051553.scala 119:24]
  wire [63:0] Icache_io_axi_req_bits_data; // @[ysyx_22051553.scala 119:24]
  wire  Icache_io_axi_resp_valid; // @[ysyx_22051553.scala 119:24]
  wire [63:0] Icache_io_axi_resp_bits_data; // @[ysyx_22051553.scala 119:24]
  wire  Icache_io_axi_resp_bits_valid; // @[ysyx_22051553.scala 119:24]
  wire  Icache_io_axi_resp_bits_choose; // @[ysyx_22051553.scala 119:24]
  wire [2:0] Icache_io_fccache_state; // @[ysyx_22051553.scala 119:24]
  wire  Dcache_clock; // @[ysyx_22051553.scala 120:24]
  wire  Dcache_reset; // @[ysyx_22051553.scala 120:24]
  wire  Dcache_io_cpu_req_valid; // @[ysyx_22051553.scala 120:24]
  wire [31:0] Dcache_io_cpu_req_bits_addr; // @[ysyx_22051553.scala 120:24]
  wire [63:0] Dcache_io_cpu_req_bits_data; // @[ysyx_22051553.scala 120:24]
  wire [7:0] Dcache_io_cpu_req_bits_mask; // @[ysyx_22051553.scala 120:24]
  wire  Dcache_io_cpu_resp_valid; // @[ysyx_22051553.scala 120:24]
  wire [63:0] Dcache_io_cpu_resp_bits_data; // @[ysyx_22051553.scala 120:24]
  wire [5:0] Dcache_io_cpu_sram0_addr; // @[ysyx_22051553.scala 120:24]
  wire  Dcache_io_cpu_sram0_cen; // @[ysyx_22051553.scala 120:24]
  wire  Dcache_io_cpu_sram0_wen; // @[ysyx_22051553.scala 120:24]
  wire [127:0] Dcache_io_cpu_sram0_wmask; // @[ysyx_22051553.scala 120:24]
  wire [127:0] Dcache_io_cpu_sram0_wdata; // @[ysyx_22051553.scala 120:24]
  wire [127:0] Dcache_io_cpu_sram0_rdata; // @[ysyx_22051553.scala 120:24]
  wire [5:0] Dcache_io_cpu_sram1_addr; // @[ysyx_22051553.scala 120:24]
  wire  Dcache_io_cpu_sram1_cen; // @[ysyx_22051553.scala 120:24]
  wire  Dcache_io_cpu_sram1_wen; // @[ysyx_22051553.scala 120:24]
  wire [127:0] Dcache_io_cpu_sram1_wmask; // @[ysyx_22051553.scala 120:24]
  wire [127:0] Dcache_io_cpu_sram1_wdata; // @[ysyx_22051553.scala 120:24]
  wire [127:0] Dcache_io_cpu_sram1_rdata; // @[ysyx_22051553.scala 120:24]
  wire [5:0] Dcache_io_cpu_sram2_addr; // @[ysyx_22051553.scala 120:24]
  wire  Dcache_io_cpu_sram2_cen; // @[ysyx_22051553.scala 120:24]
  wire  Dcache_io_cpu_sram2_wen; // @[ysyx_22051553.scala 120:24]
  wire [127:0] Dcache_io_cpu_sram2_wmask; // @[ysyx_22051553.scala 120:24]
  wire [127:0] Dcache_io_cpu_sram2_wdata; // @[ysyx_22051553.scala 120:24]
  wire [127:0] Dcache_io_cpu_sram2_rdata; // @[ysyx_22051553.scala 120:24]
  wire [5:0] Dcache_io_cpu_sram3_addr; // @[ysyx_22051553.scala 120:24]
  wire  Dcache_io_cpu_sram3_cen; // @[ysyx_22051553.scala 120:24]
  wire  Dcache_io_cpu_sram3_wen; // @[ysyx_22051553.scala 120:24]
  wire [127:0] Dcache_io_cpu_sram3_wmask; // @[ysyx_22051553.scala 120:24]
  wire [127:0] Dcache_io_cpu_sram3_wdata; // @[ysyx_22051553.scala 120:24]
  wire [127:0] Dcache_io_cpu_sram3_rdata; // @[ysyx_22051553.scala 120:24]
  wire  Dcache_io_axi_req_valid; // @[ysyx_22051553.scala 120:24]
  wire  Dcache_io_axi_req_bits_rw; // @[ysyx_22051553.scala 120:24]
  wire [31:0] Dcache_io_axi_req_bits_addr; // @[ysyx_22051553.scala 120:24]
  wire [63:0] Dcache_io_axi_req_bits_data; // @[ysyx_22051553.scala 120:24]
  wire  Dcache_io_axi_resp_valid; // @[ysyx_22051553.scala 120:24]
  wire [63:0] Dcache_io_axi_resp_bits_data; // @[ysyx_22051553.scala 120:24]
  wire  Dcache_io_axi_resp_bits_valid; // @[ysyx_22051553.scala 120:24]
  wire  Dcache_io_axi_resp_bits_choose; // @[ysyx_22051553.scala 120:24]
  wire [2:0] Dcache_io_fccache_state; // @[ysyx_22051553.scala 120:24]
  wire  ioformem_clock; // @[ysyx_22051553.scala 123:26]
  wire  ioformem_reset; // @[ysyx_22051553.scala 123:26]
  wire  ioformem_io_axi_req_valid; // @[ysyx_22051553.scala 123:26]
  wire  ioformem_io_axi_req_bits_rw; // @[ysyx_22051553.scala 123:26]
  wire [31:0] ioformem_io_axi_req_bits_addr; // @[ysyx_22051553.scala 123:26]
  wire [63:0] ioformem_io_axi_req_bits_data; // @[ysyx_22051553.scala 123:26]
  wire [7:0] ioformem_io_axi_req_bits_mask; // @[ysyx_22051553.scala 123:26]
  wire [7:0] ioformem_io_axi_req_bits_len; // @[ysyx_22051553.scala 123:26]
  wire [2:0] ioformem_io_axi_req_bits_size; // @[ysyx_22051553.scala 123:26]
  wire  ioformem_io_axi_resp_valid; // @[ysyx_22051553.scala 123:26]
  wire [63:0] ioformem_io_axi_resp_bits_data; // @[ysyx_22051553.scala 123:26]
  wire  ioformem_io_ex_req; // @[ysyx_22051553.scala 123:26]
  wire [31:0] ioformem_io_excute_addr; // @[ysyx_22051553.scala 123:26]
  wire [63:0] ioformem_io_excute_data; // @[ysyx_22051553.scala 123:26]
  wire [7:0] ioformem_io_excute_mask; // @[ysyx_22051553.scala 123:26]
  wire [2:0] ioformem_io_excute_ld_type; // @[ysyx_22051553.scala 123:26]
  wire [2:0] ioformem_io_excute_sd_type; // @[ysyx_22051553.scala 123:26]
  wire  ioformem_io_fetch_req; // @[ysyx_22051553.scala 123:26]
  wire [31:0] ioformem_io_fetch_addr; // @[ysyx_22051553.scala 123:26]
  wire  ioformem_io_decode_inst_valid; // @[ysyx_22051553.scala 123:26]
  wire [63:0] ioformem_io_decode_inst_bits; // @[ysyx_22051553.scala 123:26]
  wire  ioformem_io_decode_load_use; // @[ysyx_22051553.scala 123:26]
  wire  ioformem_io_mem_data_valid; // @[ysyx_22051553.scala 123:26]
  wire [63:0] ioformem_io_mem_data_bits; // @[ysyx_22051553.scala 123:26]
  wire  ioformem_io_fc_stall; // @[ysyx_22051553.scala 123:26]
  wire [1:0] ioformem_io_fc_state; // @[ysyx_22051553.scala 123:26]
  reg [63:0] fdreg_pc; // @[ysyx_22051553.scala 48:24]
  reg [63:0] dereg_op_a; // @[ysyx_22051553.scala 54:24]
  reg [63:0] dereg_op_b; // @[ysyx_22051553.scala 54:24]
  reg [4:0] dereg_reg_waddr; // @[ysyx_22051553.scala 54:24]
  reg  dereg_branch_type; // @[ysyx_22051553.scala 54:24]
  reg [63:0] dereg_branch_addr; // @[ysyx_22051553.scala 54:24]
  reg [5:0] dereg_alu_op; // @[ysyx_22051553.scala 54:24]
  reg [5:0] dereg_shamt; // @[ysyx_22051553.scala 54:24]
  reg [1:0] dereg_wb_type; // @[ysyx_22051553.scala 54:24]
  reg [2:0] dereg_sd_type; // @[ysyx_22051553.scala 54:24]
  reg [63:0] dereg_reg2_rdata; // @[ysyx_22051553.scala 54:24]
  reg [2:0] dereg_ld_type; // @[ysyx_22051553.scala 54:24]
  reg [63:0] dereg_csr_t; // @[ysyx_22051553.scala 54:24]
  reg [11:0] dereg_csr_waddr; // @[ysyx_22051553.scala 54:24]
  reg  dereg_csr_wen; // @[ysyx_22051553.scala 54:24]
  reg  dereg_has_inst; // @[ysyx_22051553.scala 54:24]
  reg [63:0] emreg_reg_wdata; // @[ysyx_22051553.scala 72:24]
  reg [4:0] emreg_reg_waddr; // @[ysyx_22051553.scala 72:24]
  reg [1:0] emreg_wb_type; // @[ysyx_22051553.scala 72:24]
  reg [2:0] emreg_ld_type; // @[ysyx_22051553.scala 72:24]
  reg [2:0] emreg_ld_addr_lowbit; // @[ysyx_22051553.scala 72:24]
  reg [63:0] emreg_csr_wdata; // @[ysyx_22051553.scala 72:24]
  reg  emreg_csr_wen; // @[ysyx_22051553.scala 72:24]
  reg [11:0] emreg_csr_waddr; // @[ysyx_22051553.scala 72:24]
  reg  emreg_has_inst; // @[ysyx_22051553.scala 72:24]
  reg [63:0] mwreg_reg_wdata; // @[ysyx_22051553.scala 86:24]
  reg [4:0] mwreg_reg_waddr; // @[ysyx_22051553.scala 86:24]
  reg [1:0] mwreg_wb_type; // @[ysyx_22051553.scala 86:24]
  reg [63:0] mwreg_csr_wdata; // @[ysyx_22051553.scala 86:24]
  reg  mwreg_csr_wen; // @[ysyx_22051553.scala 86:24]
  reg [11:0] mwreg_csr_waddr; // @[ysyx_22051553.scala 86:24]
  reg  mwreg_has_inst; // @[ysyx_22051553.scala 86:24]
  wire [63:0] _emreg_reg_wdata_T = excute_io_emio_reg_wdata; // @[Mux.scala 101:16]
  wire [1:0] _emreg_wb_type_T = excute_io_emio_wb_type; // @[Mux.scala 101:16]
  wire [4:0] _emreg_reg_waddr_T = excute_io_emio_reg_waddr; // @[Mux.scala 101:16]
  wire [2:0] _emreg_ld_type_T = excute_io_emio_ld_type; // @[Mux.scala 101:16]
  wire [2:0] _emreg_ld_addr_lowbit_T = excute_io_emio_ld_addr_lowbit; // @[Mux.scala 101:16]
  wire [63:0] _emreg_csr_wdata_T = excute_io_emio_csr_wdata; // @[Mux.scala 101:16]
  wire [11:0] _emreg_csr_waddr_T = excute_io_emio_csr_waddr; // @[Mux.scala 101:16]
  wire [1:0] _mwreg_wb_type_T = mem_io_mwio_wb_type; // @[Mux.scala 101:16]
  wire [4:0] _mwreg_reg_waddr_T = mem_io_mwio_reg_waddr; // @[Mux.scala 101:16]
  wire [63:0] _mwreg_reg_wdata_T = mem_io_mwio_reg_wdata; // @[Mux.scala 101:16]
  wire [63:0] _mwreg_csr_wdata_T = mem_io_mwio_csr_wdata; // @[Mux.scala 101:16]
  wire [11:0] _mwreg_csr_waddr_T = mem_io_mwio_csr_waddr; // @[Mux.scala 101:16]
  wire [31:0] _trap_io_inst_T_3 = fdreg_pc[2] ? Icache_io_cpu_resp_bits_data[63:32] : Icache_io_cpu_resp_bits_data[31:0]
    ; // @[ysyx_22051553.scala 431:12]
  wire  Icache_choose = fetch_io_pc_bits[63:30] > 34'h0; // @[ysyx_22051553.scala 466:54]
  wire [63:0] excute_addr = excute_io_waddr | excute_io_raddr; // @[ysyx_22051553.scala 469:39]
  wire  Dcache_choose = excute_addr[63:30] > 34'h0; // @[ysyx_22051553.scala 470:49]
  ysyx_22051553_Fetch fetch ( // @[ysyx_22051553.scala 40:23]
    .clock(fetch_clock),
    .reset(fetch_reset),
    .io_fdio_pc(fetch_io_fdio_pc),
    .io_pc_valid(fetch_io_pc_valid),
    .io_pc_bits(fetch_io_pc_bits),
    .io_fcfe_jump_flag(fetch_io_fcfe_jump_flag),
    .io_fcfe_jump_pc(fetch_io_fcfe_jump_pc),
    .io_fcfe_flush(fetch_io_fcfe_flush),
    .io_fcfe_stall(fetch_io_fcfe_stall)
  );
  ysyx_22051553_Decode decode ( // @[ysyx_22051553.scala 41:24]
    .clock(decode_clock),
    .reset(decode_reset),
    .io_inst_valid(decode_io_inst_valid),
    .io_inst_bits_data(decode_io_inst_bits_data),
    .io_inst_io_inst_valid(decode_io_inst_io_inst_valid),
    .io_inst_io_inst_bits(decode_io_inst_io_inst_bits),
    .io_inst_io_load_use(decode_io_inst_io_load_use),
    .io_fdio_pc(decode_io_fdio_pc),
    .io_rfio_reg1_raddr(decode_io_rfio_reg1_raddr),
    .io_rfio_reg2_raddr(decode_io_rfio_reg2_raddr),
    .io_rfio_reg1_rdata(decode_io_rfio_reg1_rdata),
    .io_rfio_reg2_rdata(decode_io_rfio_reg2_rdata),
    .io_deio_op_a(decode_io_deio_op_a),
    .io_deio_op_b(decode_io_deio_op_b),
    .io_deio_reg_waddr(decode_io_deio_reg_waddr),
    .io_deio_branch_type(decode_io_deio_branch_type),
    .io_deio_branch_addr(decode_io_deio_branch_addr),
    .io_deio_alu_op(decode_io_deio_alu_op),
    .io_deio_shamt(decode_io_deio_shamt),
    .io_deio_wb_type(decode_io_deio_wb_type),
    .io_deio_sd_type(decode_io_deio_sd_type),
    .io_deio_reg2_rdata(decode_io_deio_reg2_rdata),
    .io_deio_ld_type(decode_io_deio_ld_type),
    .io_deio_csr_t(decode_io_deio_csr_t),
    .io_deio_csr_waddr(decode_io_deio_csr_waddr),
    .io_deio_csr_wen(decode_io_deio_csr_wen),
    .io_deio_has_inst(decode_io_deio_has_inst),
    .io_jump_flag(decode_io_jump_flag),
    .io_jump_pc(decode_io_jump_pc),
    .io_load_use(decode_io_load_use),
    .io_branch(decode_io_branch),
    .io_stall(decode_io_stall),
    .io_flush(decode_io_flush),
    .io_fwde_reg1_raddr(decode_io_fwde_reg1_raddr),
    .io_fwde_reg2_raddr(decode_io_fwde_reg2_raddr),
    .io_fwde_fw_sel1(decode_io_fwde_fw_sel1),
    .io_fwde_fw_sel2(decode_io_fwde_fw_sel2),
    .io_fwde_fw_data1(decode_io_fwde_fw_data1),
    .io_fwde_fw_data2(decode_io_fwde_fw_data2),
    .io_fwde_csr_raddr(decode_io_fwde_csr_raddr),
    .io_fwde_csr_fw_sel(decode_io_fwde_csr_fw_sel),
    .io_fwde_csr_fw_data(decode_io_fwde_csr_fw_data),
    .io_csrs_csr_raddr(decode_io_csrs_csr_raddr),
    .io_csrs_csr_rdata(decode_io_csrs_csr_rdata)
  );
  ysyx_22051553_Excute excute ( // @[ysyx_22051553.scala 42:24]
    .clock(excute_clock),
    .reset(excute_reset),
    .io_deio_op_a(excute_io_deio_op_a),
    .io_deio_op_b(excute_io_deio_op_b),
    .io_deio_reg_waddr(excute_io_deio_reg_waddr),
    .io_deio_branch_type(excute_io_deio_branch_type),
    .io_deio_branch_addr(excute_io_deio_branch_addr),
    .io_deio_alu_op(excute_io_deio_alu_op),
    .io_deio_shamt(excute_io_deio_shamt),
    .io_deio_wb_type(excute_io_deio_wb_type),
    .io_deio_sd_type(excute_io_deio_sd_type),
    .io_deio_reg2_rdata(excute_io_deio_reg2_rdata),
    .io_deio_ld_type(excute_io_deio_ld_type),
    .io_deio_csr_t(excute_io_deio_csr_t),
    .io_deio_csr_waddr(excute_io_deio_csr_waddr),
    .io_deio_csr_wen(excute_io_deio_csr_wen),
    .io_deio_has_inst(excute_io_deio_has_inst),
    .io_emio_reg_wdata(excute_io_emio_reg_wdata),
    .io_emio_reg_waddr(excute_io_emio_reg_waddr),
    .io_emio_wb_type(excute_io_emio_wb_type),
    .io_emio_ld_type(excute_io_emio_ld_type),
    .io_emio_ld_addr_lowbit(excute_io_emio_ld_addr_lowbit),
    .io_emio_csr_wdata(excute_io_emio_csr_wdata),
    .io_emio_csr_wen(excute_io_emio_csr_wen),
    .io_emio_csr_waddr(excute_io_emio_csr_waddr),
    .io_emio_has_inst(excute_io_emio_has_inst),
    .io_fcex_jump_flag(excute_io_fcex_jump_flag),
    .io_fcex_jump_pc(excute_io_fcex_jump_pc),
    .io_fcex_mul_div_busy(excute_io_fcex_mul_div_busy),
    .io_fcex_mul_div_valid(excute_io_fcex_mul_div_valid),
    .io_fcex_stall(excute_io_fcex_stall),
    .io_raddr(excute_io_raddr),
    .io_waddr(excute_io_waddr),
    .io_wdata(excute_io_wdata),
    .io_wmask(excute_io_wmask),
    .io_fwex_reg_waddr(excute_io_fwex_reg_waddr),
    .io_fwex_reg_wdata(excute_io_fwex_reg_wdata),
    .io_fwex_reg_we(excute_io_fwex_reg_we),
    .io_fwex_csr_wdata(excute_io_fwex_csr_wdata),
    .io_fwex_csr_wen(excute_io_fwex_csr_wen),
    .io_fwex_csr_waddr(excute_io_fwex_csr_waddr),
    .io_clex_valid(excute_io_clex_valid),
    .io_clex_ld_type(excute_io_clex_ld_type),
    .io_clex_raddr(excute_io_clex_raddr),
    .io_clex_sd_type(excute_io_clex_sd_type),
    .io_clex_waddr(excute_io_clex_waddr),
    .io_clex_wmask(excute_io_clex_wmask),
    .io_clex_wdata(excute_io_clex_wdata),
    .io_has_inst(excute_io_has_inst),
    .io_ioformem_addr(excute_io_ioformem_addr),
    .io_ioformem_data(excute_io_ioformem_data),
    .io_ioformem_mask(excute_io_ioformem_mask),
    .io_ioformem_ld_type(excute_io_ioformem_ld_type),
    .io_ioformem_sd_type(excute_io_ioformem_sd_type)
  );
  ysyx_22051553_Mem mem ( // @[ysyx_22051553.scala 44:21]
    .clock(mem_clock),
    .reset(mem_reset),
    .io_emio_reg_wdata(mem_io_emio_reg_wdata),
    .io_emio_reg_waddr(mem_io_emio_reg_waddr),
    .io_emio_wb_type(mem_io_emio_wb_type),
    .io_emio_ld_type(mem_io_emio_ld_type),
    .io_emio_ld_addr_lowbit(mem_io_emio_ld_addr_lowbit),
    .io_emio_csr_wdata(mem_io_emio_csr_wdata),
    .io_emio_csr_wen(mem_io_emio_csr_wen),
    .io_emio_csr_waddr(mem_io_emio_csr_waddr),
    .io_emio_has_inst(mem_io_emio_has_inst),
    .io_mwio_reg_wdata(mem_io_mwio_reg_wdata),
    .io_mwio_reg_waddr(mem_io_mwio_reg_waddr),
    .io_mwio_wb_type(mem_io_mwio_wb_type),
    .io_mwio_csr_wdata(mem_io_mwio_csr_wdata),
    .io_mwio_csr_wen(mem_io_mwio_csr_wen),
    .io_mwio_csr_waddr(mem_io_mwio_csr_waddr),
    .io_mwio_has_inst(mem_io_mwio_has_inst),
    .io_rdata_valid(mem_io_rdata_valid),
    .io_rdata_bits_data(mem_io_rdata_bits_data),
    .io_rdata_io_data_valid(mem_io_rdata_io_data_valid),
    .io_rdata_io_data_bits(mem_io_rdata_io_data_bits),
    .io_fwmem_reg_waddr(mem_io_fwmem_reg_waddr),
    .io_fwmem_reg_wdata(mem_io_fwmem_reg_wdata),
    .io_fwmem_reg_we(mem_io_fwmem_reg_we),
    .io_fwmem_csr_wdata(mem_io_fwmem_csr_wdata),
    .io_fwmem_csr_wen(mem_io_fwmem_csr_wen),
    .io_fwmem_csr_waddr(mem_io_fwmem_csr_waddr),
    .io_clmem_Clrvalue_valid(mem_io_clmem_Clrvalue_valid),
    .io_clmem_Clrvalue_bits(mem_io_clmem_Clrvalue_bits),
    .io_stall(mem_io_stall),
    .io_has_inst(mem_io_has_inst)
  );
  ysyx_22051553_Wb wb ( // @[ysyx_22051553.scala 45:20]
    .io_mwio_reg_wdata(wb_io_mwio_reg_wdata),
    .io_mwio_reg_waddr(wb_io_mwio_reg_waddr),
    .io_mwio_wb_type(wb_io_mwio_wb_type),
    .io_mwio_csr_wdata(wb_io_mwio_csr_wdata),
    .io_mwio_csr_wen(wb_io_mwio_csr_wen),
    .io_mwio_csr_waddr(wb_io_mwio_csr_waddr),
    .io_mwio_has_inst(wb_io_mwio_has_inst),
    .io_rfio_rd(wb_io_rfio_rd),
    .io_rfio_reg_wen(wb_io_rfio_reg_wen),
    .io_rfio_reg_wdata(wb_io_rfio_reg_wdata),
    .io_fwwb_reg_waddr(wb_io_fwwb_reg_waddr),
    .io_fwwb_reg_wdata(wb_io_fwwb_reg_wdata),
    .io_fwwb_reg_we(wb_io_fwwb_reg_we),
    .io_fwwb_csr_wdata(wb_io_fwwb_csr_wdata),
    .io_fwwb_csr_wen(wb_io_fwwb_csr_wen),
    .io_fwwb_csr_waddr(wb_io_fwwb_csr_waddr),
    .io_csrs_rd(wb_io_csrs_rd),
    .io_csrs_csr_wen(wb_io_csrs_csr_wen),
    .io_csrs_csr_wdata(wb_io_csrs_csr_wdata),
    .io_stall(wb_io_stall),
    .io_has_inst(wb_io_has_inst)
  );
  ysyx_22051553_CLINT clint ( // @[ysyx_22051553.scala 98:23]
    .clock(clint_clock),
    .reset(clint_reset),
    .io_clex_valid(clint_io_clex_valid),
    .io_clex_ld_type(clint_io_clex_ld_type),
    .io_clex_raddr(clint_io_clex_raddr),
    .io_clex_sd_type(clint_io_clex_sd_type),
    .io_clex_waddr(clint_io_clex_waddr),
    .io_clex_wmask(clint_io_clex_wmask),
    .io_clex_wdata(clint_io_clex_wdata),
    .io_clmem_Clrvalue_valid(clint_io_clmem_Clrvalue_valid),
    .io_clmem_Clrvalue_bits(clint_io_clmem_Clrvalue_bits),
    .io_timer_int(clint_io_timer_int)
  );
  ysyx_22051553_Forward fw ( // @[ysyx_22051553.scala 101:20]
    .io_fwde_reg1_raddr(fw_io_fwde_reg1_raddr),
    .io_fwde_reg2_raddr(fw_io_fwde_reg2_raddr),
    .io_fwde_fw_sel1(fw_io_fwde_fw_sel1),
    .io_fwde_fw_sel2(fw_io_fwde_fw_sel2),
    .io_fwde_fw_data1(fw_io_fwde_fw_data1),
    .io_fwde_fw_data2(fw_io_fwde_fw_data2),
    .io_fwde_csr_raddr(fw_io_fwde_csr_raddr),
    .io_fwde_csr_fw_sel(fw_io_fwde_csr_fw_sel),
    .io_fwde_csr_fw_data(fw_io_fwde_csr_fw_data),
    .io_fwex_reg_waddr(fw_io_fwex_reg_waddr),
    .io_fwex_reg_wdata(fw_io_fwex_reg_wdata),
    .io_fwex_reg_we(fw_io_fwex_reg_we),
    .io_fwex_csr_wdata(fw_io_fwex_csr_wdata),
    .io_fwex_csr_wen(fw_io_fwex_csr_wen),
    .io_fwex_csr_waddr(fw_io_fwex_csr_waddr),
    .io_fwmem_reg_waddr(fw_io_fwmem_reg_waddr),
    .io_fwmem_reg_wdata(fw_io_fwmem_reg_wdata),
    .io_fwmem_reg_we(fw_io_fwmem_reg_we),
    .io_fwmem_csr_wdata(fw_io_fwmem_csr_wdata),
    .io_fwmem_csr_wen(fw_io_fwmem_csr_wen),
    .io_fwmem_csr_waddr(fw_io_fwmem_csr_waddr),
    .io_fwwb_reg_waddr(fw_io_fwwb_reg_waddr),
    .io_fwwb_reg_wdata(fw_io_fwwb_reg_wdata),
    .io_fwwb_reg_we(fw_io_fwwb_reg_we),
    .io_fwwb_csr_wdata(fw_io_fwwb_csr_wdata),
    .io_fwwb_csr_wen(fw_io_fwwb_csr_wen),
    .io_fwwb_csr_waddr(fw_io_fwwb_csr_waddr)
  );
  ysyx_22051553_Regfile regfile ( // @[ysyx_22051553.scala 104:25]
    .clock(regfile_clock),
    .reset(regfile_reset),
    .io_RfDe_reg1_raddr(regfile_io_RfDe_reg1_raddr),
    .io_RfDe_reg2_raddr(regfile_io_RfDe_reg2_raddr),
    .io_RfDe_reg1_rdata(regfile_io_RfDe_reg1_rdata),
    .io_RfDe_reg2_rdata(regfile_io_RfDe_reg2_rdata),
    .io_RfWb_rd(regfile_io_RfWb_rd),
    .io_RfWb_reg_wen(regfile_io_RfWb_reg_wen),
    .io_RfWb_reg_wdata(regfile_io_RfWb_reg_wdata)
  );
  ysyx_22051553_FlowControl fc ( // @[ysyx_22051553.scala 107:20]
    .io_fcfe_jump_flag(fc_io_fcfe_jump_flag),
    .io_fcfe_jump_pc(fc_io_fcfe_jump_pc),
    .io_fcfe_flush(fc_io_fcfe_flush),
    .io_fcfe_stall(fc_io_fcfe_stall),
    .io_fcde_jump_flag(fc_io_fcde_jump_flag),
    .io_fcde_jump_pc(fc_io_fcde_jump_pc),
    .io_fcde_load_use(fc_io_fcde_load_use),
    .io_fcde_flush(fc_io_fcde_flush),
    .io_fcde_stall(fc_io_fcde_stall),
    .io_fcex_jump_flag(fc_io_fcex_jump_flag),
    .io_fcex_jump_pc(fc_io_fcex_jump_pc),
    .io_fcex_mul_div_busy(fc_io_fcex_mul_div_busy),
    .io_fcex_mul_div_valid(fc_io_fcex_mul_div_valid),
    .io_fcex_stall(fc_io_fcex_stall),
    .io_fcmem_stall(fc_io_fcmem_stall),
    .io_fcwb_stall(fc_io_fcwb_stall),
    .io_fctr_pop_NOP(fc_io_fctr_pop_NOP),
    .io_fctr_trap_state(fc_io_fctr_trap_state),
    .io_fctr_jump_flag(fc_io_fctr_jump_flag),
    .io_fctr_jump_pc(fc_io_fctr_jump_pc),
    .io_fcIcache_state(fc_io_fcIcache_state),
    .io_fcDcache_state(fc_io_fcDcache_state),
    .io_fcio_stall(fc_io_fcio_stall),
    .io_fcio_state(fc_io_fcio_state)
  );
  ysyx_22051553_CSRs csrs ( // @[ysyx_22051553.scala 110:22]
    .clock(csrs_clock),
    .reset(csrs_reset),
    .io_CSRDe_csr_raddr(csrs_io_CSRDe_csr_raddr),
    .io_CSRDe_csr_rdata(csrs_io_CSRDe_csr_rdata),
    .io_CSRWb_rd(csrs_io_CSRWb_rd),
    .io_CSRWb_csr_wen(csrs_io_CSRWb_csr_wen),
    .io_CSRWb_csr_wdata(csrs_io_CSRWb_csr_wdata),
    .io_CSRTr_MTVEC(csrs_io_CSRTr_MTVEC),
    .io_CSRTr_MCAUSE(csrs_io_CSRTr_MCAUSE),
    .io_CSRTr_MEPC(csrs_io_CSRTr_MEPC),
    .io_CSRTr_MIE(csrs_io_CSRTr_MIE),
    .io_CSRTr_MIP(csrs_io_CSRTr_MIP),
    .io_CSRTr_MSTATUS(csrs_io_CSRTr_MSTATUS),
    .io_CSRTr_rd(csrs_io_CSRTr_rd),
    .io_CSRTr_csr_wen(csrs_io_CSRTr_csr_wen),
    .io_CSRTr_csr_wdata(csrs_io_CSRTr_csr_wdata),
    .io_timer_int(csrs_io_timer_int)
  );
  ysyx_22051553_Trap trap ( // @[ysyx_22051553.scala 113:22]
    .clock(trap_clock),
    .reset(trap_reset),
    .io_ex_hasinst(trap_io_ex_hasinst),
    .io_mem_hasinst(trap_io_mem_hasinst),
    .io_wb_hasinst(trap_io_wb_hasinst),
    .io_csrtr_MTVEC(trap_io_csrtr_MTVEC),
    .io_csrtr_MCAUSE(trap_io_csrtr_MCAUSE),
    .io_csrtr_MEPC(trap_io_csrtr_MEPC),
    .io_csrtr_MIE(trap_io_csrtr_MIE),
    .io_csrtr_MIP(trap_io_csrtr_MIP),
    .io_csrtr_MSTATUS(trap_io_csrtr_MSTATUS),
    .io_csrtr_rd(trap_io_csrtr_rd),
    .io_csrtr_csr_wen(trap_io_csrtr_csr_wen),
    .io_csrtr_csr_wdata(trap_io_csrtr_csr_wdata),
    .io_inst(trap_io_inst),
    .io_pc(trap_io_pc),
    .io_fctr_pop_NOP(trap_io_fctr_pop_NOP),
    .io_fctr_trap_state(trap_io_fctr_trap_state),
    .io_fctr_jump_flag(trap_io_fctr_jump_flag),
    .io_fctr_jump_pc(trap_io_fctr_jump_pc)
  );
  ysyx_22051553_AXIArbitor arbitor ( // @[ysyx_22051553.scala 116:25]
    .clock(arbitor_clock),
    .reset(arbitor_reset),
    .io_master0_req_valid(arbitor_io_master0_req_valid),
    .io_master0_req_bits_rw(arbitor_io_master0_req_bits_rw),
    .io_master0_req_bits_addr(arbitor_io_master0_req_bits_addr),
    .io_master0_req_bits_data(arbitor_io_master0_req_bits_data),
    .io_master0_req_bits_mask(arbitor_io_master0_req_bits_mask),
    .io_master0_req_bits_len(arbitor_io_master0_req_bits_len),
    .io_master0_req_bits_size(arbitor_io_master0_req_bits_size),
    .io_master0_resp_valid(arbitor_io_master0_resp_valid),
    .io_master0_resp_bits_data(arbitor_io_master0_resp_bits_data),
    .io_master1_req_valid(arbitor_io_master1_req_valid),
    .io_master1_req_bits_rw(arbitor_io_master1_req_bits_rw),
    .io_master1_req_bits_addr(arbitor_io_master1_req_bits_addr),
    .io_master1_req_bits_data(arbitor_io_master1_req_bits_data),
    .io_master1_resp_valid(arbitor_io_master1_resp_valid),
    .io_master1_resp_bits_data(arbitor_io_master1_resp_bits_data),
    .io_master1_resp_bits_valid(arbitor_io_master1_resp_bits_valid),
    .io_master1_resp_bits_choose(arbitor_io_master1_resp_bits_choose),
    .io_master2_req_valid(arbitor_io_master2_req_valid),
    .io_master2_req_bits_rw(arbitor_io_master2_req_bits_rw),
    .io_master2_req_bits_addr(arbitor_io_master2_req_bits_addr),
    .io_master2_req_bits_data(arbitor_io_master2_req_bits_data),
    .io_master2_resp_valid(arbitor_io_master2_resp_valid),
    .io_master2_resp_bits_data(arbitor_io_master2_resp_bits_data),
    .io_master2_resp_bits_valid(arbitor_io_master2_resp_bits_valid),
    .io_master2_resp_bits_choose(arbitor_io_master2_resp_bits_choose),
    .io_AXI_O_awready(arbitor_io_AXI_O_awready),
    .io_AXI_O_awvalid(arbitor_io_AXI_O_awvalid),
    .io_AXI_O_awaddr(arbitor_io_AXI_O_awaddr),
    .io_AXI_O_awlen(arbitor_io_AXI_O_awlen),
    .io_AXI_O_awsize(arbitor_io_AXI_O_awsize),
    .io_AXI_O_wready(arbitor_io_AXI_O_wready),
    .io_AXI_O_wvalid(arbitor_io_AXI_O_wvalid),
    .io_AXI_O_wdata(arbitor_io_AXI_O_wdata),
    .io_AXI_O_wstrb(arbitor_io_AXI_O_wstrb),
    .io_AXI_O_wlast(arbitor_io_AXI_O_wlast),
    .io_AXI_O_bready(arbitor_io_AXI_O_bready),
    .io_AXI_O_bvalid(arbitor_io_AXI_O_bvalid),
    .io_AXI_O_arready(arbitor_io_AXI_O_arready),
    .io_AXI_O_arvalid(arbitor_io_AXI_O_arvalid),
    .io_AXI_O_araddr(arbitor_io_AXI_O_araddr),
    .io_AXI_O_arlen(arbitor_io_AXI_O_arlen),
    .io_AXI_O_arsize(arbitor_io_AXI_O_arsize),
    .io_AXI_O_rready(arbitor_io_AXI_O_rready),
    .io_AXI_O_rvalid(arbitor_io_AXI_O_rvalid),
    .io_AXI_O_rdata(arbitor_io_AXI_O_rdata),
    .io_AXI_O_rlast(arbitor_io_AXI_O_rlast)
  );
  ysyx_22051553_Cache Icache ( // @[ysyx_22051553.scala 119:24]
    .clock(Icache_clock),
    .reset(Icache_reset),
    .io_cpu_req_valid(Icache_io_cpu_req_valid),
    .io_cpu_req_bits_addr(Icache_io_cpu_req_bits_addr),
    .io_cpu_req_bits_data(Icache_io_cpu_req_bits_data),
    .io_cpu_req_bits_mask(Icache_io_cpu_req_bits_mask),
    .io_cpu_resp_valid(Icache_io_cpu_resp_valid),
    .io_cpu_resp_bits_data(Icache_io_cpu_resp_bits_data),
    .io_cpu_sram0_addr(Icache_io_cpu_sram0_addr),
    .io_cpu_sram0_cen(Icache_io_cpu_sram0_cen),
    .io_cpu_sram0_wen(Icache_io_cpu_sram0_wen),
    .io_cpu_sram0_wmask(Icache_io_cpu_sram0_wmask),
    .io_cpu_sram0_wdata(Icache_io_cpu_sram0_wdata),
    .io_cpu_sram0_rdata(Icache_io_cpu_sram0_rdata),
    .io_cpu_sram1_addr(Icache_io_cpu_sram1_addr),
    .io_cpu_sram1_cen(Icache_io_cpu_sram1_cen),
    .io_cpu_sram1_wen(Icache_io_cpu_sram1_wen),
    .io_cpu_sram1_wmask(Icache_io_cpu_sram1_wmask),
    .io_cpu_sram1_wdata(Icache_io_cpu_sram1_wdata),
    .io_cpu_sram1_rdata(Icache_io_cpu_sram1_rdata),
    .io_cpu_sram2_addr(Icache_io_cpu_sram2_addr),
    .io_cpu_sram2_cen(Icache_io_cpu_sram2_cen),
    .io_cpu_sram2_wen(Icache_io_cpu_sram2_wen),
    .io_cpu_sram2_wmask(Icache_io_cpu_sram2_wmask),
    .io_cpu_sram2_wdata(Icache_io_cpu_sram2_wdata),
    .io_cpu_sram2_rdata(Icache_io_cpu_sram2_rdata),
    .io_cpu_sram3_addr(Icache_io_cpu_sram3_addr),
    .io_cpu_sram3_cen(Icache_io_cpu_sram3_cen),
    .io_cpu_sram3_wen(Icache_io_cpu_sram3_wen),
    .io_cpu_sram3_wmask(Icache_io_cpu_sram3_wmask),
    .io_cpu_sram3_wdata(Icache_io_cpu_sram3_wdata),
    .io_cpu_sram3_rdata(Icache_io_cpu_sram3_rdata),
    .io_axi_req_valid(Icache_io_axi_req_valid),
    .io_axi_req_bits_rw(Icache_io_axi_req_bits_rw),
    .io_axi_req_bits_addr(Icache_io_axi_req_bits_addr),
    .io_axi_req_bits_data(Icache_io_axi_req_bits_data),
    .io_axi_resp_valid(Icache_io_axi_resp_valid),
    .io_axi_resp_bits_data(Icache_io_axi_resp_bits_data),
    .io_axi_resp_bits_valid(Icache_io_axi_resp_bits_valid),
    .io_axi_resp_bits_choose(Icache_io_axi_resp_bits_choose),
    .io_fccache_state(Icache_io_fccache_state)
  );
  ysyx_22051553_Cache Dcache ( // @[ysyx_22051553.scala 120:24]
    .clock(Dcache_clock),
    .reset(Dcache_reset),
    .io_cpu_req_valid(Dcache_io_cpu_req_valid),
    .io_cpu_req_bits_addr(Dcache_io_cpu_req_bits_addr),
    .io_cpu_req_bits_data(Dcache_io_cpu_req_bits_data),
    .io_cpu_req_bits_mask(Dcache_io_cpu_req_bits_mask),
    .io_cpu_resp_valid(Dcache_io_cpu_resp_valid),
    .io_cpu_resp_bits_data(Dcache_io_cpu_resp_bits_data),
    .io_cpu_sram0_addr(Dcache_io_cpu_sram0_addr),
    .io_cpu_sram0_cen(Dcache_io_cpu_sram0_cen),
    .io_cpu_sram0_wen(Dcache_io_cpu_sram0_wen),
    .io_cpu_sram0_wmask(Dcache_io_cpu_sram0_wmask),
    .io_cpu_sram0_wdata(Dcache_io_cpu_sram0_wdata),
    .io_cpu_sram0_rdata(Dcache_io_cpu_sram0_rdata),
    .io_cpu_sram1_addr(Dcache_io_cpu_sram1_addr),
    .io_cpu_sram1_cen(Dcache_io_cpu_sram1_cen),
    .io_cpu_sram1_wen(Dcache_io_cpu_sram1_wen),
    .io_cpu_sram1_wmask(Dcache_io_cpu_sram1_wmask),
    .io_cpu_sram1_wdata(Dcache_io_cpu_sram1_wdata),
    .io_cpu_sram1_rdata(Dcache_io_cpu_sram1_rdata),
    .io_cpu_sram2_addr(Dcache_io_cpu_sram2_addr),
    .io_cpu_sram2_cen(Dcache_io_cpu_sram2_cen),
    .io_cpu_sram2_wen(Dcache_io_cpu_sram2_wen),
    .io_cpu_sram2_wmask(Dcache_io_cpu_sram2_wmask),
    .io_cpu_sram2_wdata(Dcache_io_cpu_sram2_wdata),
    .io_cpu_sram2_rdata(Dcache_io_cpu_sram2_rdata),
    .io_cpu_sram3_addr(Dcache_io_cpu_sram3_addr),
    .io_cpu_sram3_cen(Dcache_io_cpu_sram3_cen),
    .io_cpu_sram3_wen(Dcache_io_cpu_sram3_wen),
    .io_cpu_sram3_wmask(Dcache_io_cpu_sram3_wmask),
    .io_cpu_sram3_wdata(Dcache_io_cpu_sram3_wdata),
    .io_cpu_sram3_rdata(Dcache_io_cpu_sram3_rdata),
    .io_axi_req_valid(Dcache_io_axi_req_valid),
    .io_axi_req_bits_rw(Dcache_io_axi_req_bits_rw),
    .io_axi_req_bits_addr(Dcache_io_axi_req_bits_addr),
    .io_axi_req_bits_data(Dcache_io_axi_req_bits_data),
    .io_axi_resp_valid(Dcache_io_axi_resp_valid),
    .io_axi_resp_bits_data(Dcache_io_axi_resp_bits_data),
    .io_axi_resp_bits_valid(Dcache_io_axi_resp_bits_valid),
    .io_axi_resp_bits_choose(Dcache_io_axi_resp_bits_choose),
    .io_fccache_state(Dcache_io_fccache_state)
  );
  ysyx_22051553_IoforMem ioformem ( // @[ysyx_22051553.scala 123:26]
    .clock(ioformem_clock),
    .reset(ioformem_reset),
    .io_axi_req_valid(ioformem_io_axi_req_valid),
    .io_axi_req_bits_rw(ioformem_io_axi_req_bits_rw),
    .io_axi_req_bits_addr(ioformem_io_axi_req_bits_addr),
    .io_axi_req_bits_data(ioformem_io_axi_req_bits_data),
    .io_axi_req_bits_mask(ioformem_io_axi_req_bits_mask),
    .io_axi_req_bits_len(ioformem_io_axi_req_bits_len),
    .io_axi_req_bits_size(ioformem_io_axi_req_bits_size),
    .io_axi_resp_valid(ioformem_io_axi_resp_valid),
    .io_axi_resp_bits_data(ioformem_io_axi_resp_bits_data),
    .io_ex_req(ioformem_io_ex_req),
    .io_excute_addr(ioformem_io_excute_addr),
    .io_excute_data(ioformem_io_excute_data),
    .io_excute_mask(ioformem_io_excute_mask),
    .io_excute_ld_type(ioformem_io_excute_ld_type),
    .io_excute_sd_type(ioformem_io_excute_sd_type),
    .io_fetch_req(ioformem_io_fetch_req),
    .io_fetch_addr(ioformem_io_fetch_addr),
    .io_decode_inst_valid(ioformem_io_decode_inst_valid),
    .io_decode_inst_bits(ioformem_io_decode_inst_bits),
    .io_decode_load_use(ioformem_io_decode_load_use),
    .io_mem_data_valid(ioformem_io_mem_data_valid),
    .io_mem_data_bits(ioformem_io_mem_data_bits),
    .io_fc_stall(ioformem_io_fc_stall),
    .io_fc_state(ioformem_io_fc_state)
  );
  assign io_master_awvalid = arbitor_io_AXI_O_awvalid; // @[ysyx_22051553.scala 127:15]
  assign io_master_awid = 4'h0; // @[ysyx_22051553.scala 127:15]
  assign io_master_awaddr = arbitor_io_AXI_O_awaddr; // @[ysyx_22051553.scala 127:15]
  assign io_master_awlen = arbitor_io_AXI_O_awlen; // @[ysyx_22051553.scala 127:15]
  assign io_master_awsize = arbitor_io_AXI_O_awsize; // @[ysyx_22051553.scala 127:15]
  assign io_master_awburst = 2'h1; // @[ysyx_22051553.scala 127:15]
  assign io_master_wvalid = arbitor_io_AXI_O_wvalid; // @[ysyx_22051553.scala 127:15]
  assign io_master_wdata = arbitor_io_AXI_O_wdata; // @[ysyx_22051553.scala 127:15]
  assign io_master_wstrb = arbitor_io_AXI_O_wstrb; // @[ysyx_22051553.scala 127:15]
  assign io_master_wlast = arbitor_io_AXI_O_wlast; // @[ysyx_22051553.scala 127:15]
  assign io_master_bready = 1'h1; // @[ysyx_22051553.scala 127:15]
  assign io_master_arvalid = arbitor_io_AXI_O_arvalid; // @[ysyx_22051553.scala 127:15]
  assign io_master_arid = 4'h0; // @[ysyx_22051553.scala 127:15]
  assign io_master_araddr = arbitor_io_AXI_O_araddr; // @[ysyx_22051553.scala 127:15]
  assign io_master_arlen = arbitor_io_AXI_O_arlen; // @[ysyx_22051553.scala 127:15]
  assign io_master_arsize = arbitor_io_AXI_O_arsize; // @[ysyx_22051553.scala 127:15]
  assign io_master_arburst = 2'h1; // @[ysyx_22051553.scala 127:15]
  assign io_master_rready = arbitor_io_AXI_O_rready; // @[ysyx_22051553.scala 127:15]
  assign io_slave_awready = 1'h0; // @[ysyx_22051553.scala 26:22]
  assign io_slave_wready = 1'h0; // @[ysyx_22051553.scala 27:21]
  assign io_slave_bvalid = 1'h0; // @[ysyx_22051553.scala 28:21]
  assign io_slave_bid = 4'h0; // @[ysyx_22051553.scala 29:18]
  assign io_slave_bresp = 2'h0; // @[ysyx_22051553.scala 30:20]
  assign io_slave_arready = 1'h0; // @[ysyx_22051553.scala 31:22]
  assign io_slave_rvalid = 1'h0; // @[ysyx_22051553.scala 32:21]
  assign io_slave_rid = 4'h0; // @[ysyx_22051553.scala 33:18]
  assign io_slave_rresp = 2'h0; // @[ysyx_22051553.scala 34:20]
  assign io_slave_rdata = 64'h0; // @[ysyx_22051553.scala 35:20]
  assign io_slave_rlast = 1'h0; // @[ysyx_22051553.scala 36:20]
  assign io_sram0_addr = Icache_io_cpu_sram0_addr; // @[ysyx_22051553.scala 484:25]
  assign io_sram0_cen = Icache_io_cpu_sram0_cen; // @[ysyx_22051553.scala 484:25]
  assign io_sram0_wen = Icache_io_cpu_sram0_wen; // @[ysyx_22051553.scala 484:25]
  assign io_sram0_wmask = Icache_io_cpu_sram0_wmask; // @[ysyx_22051553.scala 484:25]
  assign io_sram0_wdata = Icache_io_cpu_sram0_wdata; // @[ysyx_22051553.scala 484:25]
  assign io_sram1_addr = Icache_io_cpu_sram1_addr; // @[ysyx_22051553.scala 485:25]
  assign io_sram1_cen = Icache_io_cpu_sram1_cen; // @[ysyx_22051553.scala 485:25]
  assign io_sram1_wen = Icache_io_cpu_sram1_wen; // @[ysyx_22051553.scala 485:25]
  assign io_sram1_wmask = Icache_io_cpu_sram1_wmask; // @[ysyx_22051553.scala 485:25]
  assign io_sram1_wdata = Icache_io_cpu_sram1_wdata; // @[ysyx_22051553.scala 485:25]
  assign io_sram2_addr = Icache_io_cpu_sram2_addr; // @[ysyx_22051553.scala 486:25]
  assign io_sram2_cen = Icache_io_cpu_sram2_cen; // @[ysyx_22051553.scala 486:25]
  assign io_sram2_wen = Icache_io_cpu_sram2_wen; // @[ysyx_22051553.scala 486:25]
  assign io_sram2_wmask = Icache_io_cpu_sram2_wmask; // @[ysyx_22051553.scala 486:25]
  assign io_sram2_wdata = Icache_io_cpu_sram2_wdata; // @[ysyx_22051553.scala 486:25]
  assign io_sram3_addr = Icache_io_cpu_sram3_addr; // @[ysyx_22051553.scala 487:25]
  assign io_sram3_cen = Icache_io_cpu_sram3_cen; // @[ysyx_22051553.scala 487:25]
  assign io_sram3_wen = Icache_io_cpu_sram3_wen; // @[ysyx_22051553.scala 487:25]
  assign io_sram3_wmask = Icache_io_cpu_sram3_wmask; // @[ysyx_22051553.scala 487:25]
  assign io_sram3_wdata = Icache_io_cpu_sram3_wdata; // @[ysyx_22051553.scala 487:25]
  assign io_sram4_addr = Dcache_io_cpu_sram0_addr; // @[ysyx_22051553.scala 498:25]
  assign io_sram4_cen = Dcache_io_cpu_sram0_cen; // @[ysyx_22051553.scala 498:25]
  assign io_sram4_wen = Dcache_io_cpu_sram0_wen; // @[ysyx_22051553.scala 498:25]
  assign io_sram4_wmask = Dcache_io_cpu_sram0_wmask; // @[ysyx_22051553.scala 498:25]
  assign io_sram4_wdata = Dcache_io_cpu_sram0_wdata; // @[ysyx_22051553.scala 498:25]
  assign io_sram5_addr = Dcache_io_cpu_sram1_addr; // @[ysyx_22051553.scala 499:25]
  assign io_sram5_cen = Dcache_io_cpu_sram1_cen; // @[ysyx_22051553.scala 499:25]
  assign io_sram5_wen = Dcache_io_cpu_sram1_wen; // @[ysyx_22051553.scala 499:25]
  assign io_sram5_wmask = Dcache_io_cpu_sram1_wmask; // @[ysyx_22051553.scala 499:25]
  assign io_sram5_wdata = Dcache_io_cpu_sram1_wdata; // @[ysyx_22051553.scala 499:25]
  assign io_sram6_addr = Dcache_io_cpu_sram2_addr; // @[ysyx_22051553.scala 500:25]
  assign io_sram6_cen = Dcache_io_cpu_sram2_cen; // @[ysyx_22051553.scala 500:25]
  assign io_sram6_wen = Dcache_io_cpu_sram2_wen; // @[ysyx_22051553.scala 500:25]
  assign io_sram6_wmask = Dcache_io_cpu_sram2_wmask; // @[ysyx_22051553.scala 500:25]
  assign io_sram6_wdata = Dcache_io_cpu_sram2_wdata; // @[ysyx_22051553.scala 500:25]
  assign io_sram7_addr = Dcache_io_cpu_sram3_addr; // @[ysyx_22051553.scala 501:25]
  assign io_sram7_cen = Dcache_io_cpu_sram3_cen; // @[ysyx_22051553.scala 501:25]
  assign io_sram7_wen = Dcache_io_cpu_sram3_wen; // @[ysyx_22051553.scala 501:25]
  assign io_sram7_wmask = Dcache_io_cpu_sram3_wmask; // @[ysyx_22051553.scala 501:25]
  assign io_sram7_wdata = Dcache_io_cpu_sram3_wdata; // @[ysyx_22051553.scala 501:25]
  assign fetch_clock = clock;
  assign fetch_reset = reset;
  assign fetch_io_fcfe_jump_flag = fc_io_fcfe_jump_flag; // @[ysyx_22051553.scala 132:19]
  assign fetch_io_fcfe_jump_pc = fc_io_fcfe_jump_pc; // @[ysyx_22051553.scala 132:19]
  assign fetch_io_fcfe_flush = fc_io_fcfe_flush; // @[ysyx_22051553.scala 132:19]
  assign fetch_io_fcfe_stall = fc_io_fcfe_stall; // @[ysyx_22051553.scala 132:19]
  assign decode_clock = clock;
  assign decode_reset = reset;
  assign decode_io_inst_valid = Icache_io_cpu_resp_valid; // @[ysyx_22051553.scala 480:24]
  assign decode_io_inst_bits_data = Icache_io_cpu_resp_bits_data; // @[ysyx_22051553.scala 480:24]
  assign decode_io_inst_io_inst_valid = ioformem_io_decode_inst_valid; // @[ysyx_22051553.scala 514:24]
  assign decode_io_inst_io_inst_bits = ioformem_io_decode_inst_bits; // @[ysyx_22051553.scala 514:24]
  assign decode_io_fdio_pc = fdreg_pc; // @[ysyx_22051553.scala 135:23]
  assign decode_io_rfio_reg1_rdata = regfile_io_RfDe_reg1_rdata; // @[ysyx_22051553.scala 136:20]
  assign decode_io_rfio_reg2_rdata = regfile_io_RfDe_reg2_rdata; // @[ysyx_22051553.scala 136:20]
  assign decode_io_branch = fc_io_fcex_jump_flag; // @[ysyx_22051553.scala 137:22]
  assign decode_io_stall = fc_io_fcde_stall; // @[ysyx_22051553.scala 138:22]
  assign decode_io_flush = fc_io_fcde_flush; // @[ysyx_22051553.scala 139:21]
  assign decode_io_fwde_fw_sel1 = fw_io_fwde_fw_sel1; // @[ysyx_22051553.scala 418:16]
  assign decode_io_fwde_fw_sel2 = fw_io_fwde_fw_sel2; // @[ysyx_22051553.scala 418:16]
  assign decode_io_fwde_fw_data1 = fw_io_fwde_fw_data1; // @[ysyx_22051553.scala 418:16]
  assign decode_io_fwde_fw_data2 = fw_io_fwde_fw_data2; // @[ysyx_22051553.scala 418:16]
  assign decode_io_fwde_csr_fw_sel = fw_io_fwde_csr_fw_sel; // @[ysyx_22051553.scala 418:16]
  assign decode_io_fwde_csr_fw_data = fw_io_fwde_csr_fw_data; // @[ysyx_22051553.scala 418:16]
  assign decode_io_csrs_csr_rdata = csrs_io_CSRDe_csr_rdata; // @[ysyx_22051553.scala 141:20]
  assign excute_clock = clock;
  assign excute_reset = reset;
  assign excute_io_deio_op_a = dereg_op_a; // @[ysyx_22051553.scala 143:25]
  assign excute_io_deio_op_b = dereg_op_b; // @[ysyx_22051553.scala 144:25]
  assign excute_io_deio_reg_waddr = dereg_reg_waddr; // @[ysyx_22051553.scala 145:30]
  assign excute_io_deio_branch_type = dereg_branch_type; // @[ysyx_22051553.scala 146:32]
  assign excute_io_deio_branch_addr = dereg_branch_addr; // @[ysyx_22051553.scala 147:32]
  assign excute_io_deio_alu_op = dereg_alu_op; // @[ysyx_22051553.scala 148:27]
  assign excute_io_deio_shamt = dereg_shamt; // @[ysyx_22051553.scala 149:26]
  assign excute_io_deio_wb_type = dereg_wb_type; // @[ysyx_22051553.scala 150:28]
  assign excute_io_deio_sd_type = dereg_sd_type; // @[ysyx_22051553.scala 151:28]
  assign excute_io_deio_reg2_rdata = dereg_reg2_rdata; // @[ysyx_22051553.scala 152:31]
  assign excute_io_deio_ld_type = dereg_ld_type; // @[ysyx_22051553.scala 153:28]
  assign excute_io_deio_csr_t = dereg_csr_t; // @[ysyx_22051553.scala 154:26]
  assign excute_io_deio_csr_waddr = dereg_csr_waddr; // @[ysyx_22051553.scala 155:30]
  assign excute_io_deio_csr_wen = dereg_csr_wen; // @[ysyx_22051553.scala 156:28]
  assign excute_io_deio_has_inst = dereg_has_inst; // @[ysyx_22051553.scala 157:29]
  assign excute_io_fcex_stall = fc_io_fcex_stall; // @[ysyx_22051553.scala 457:16]
  assign mem_clock = clock;
  assign mem_reset = reset;
  assign mem_io_emio_reg_wdata = emreg_reg_wdata; // @[ysyx_22051553.scala 160:27]
  assign mem_io_emio_reg_waddr = emreg_reg_waddr; // @[ysyx_22051553.scala 162:27]
  assign mem_io_emio_wb_type = emreg_wb_type; // @[ysyx_22051553.scala 161:25]
  assign mem_io_emio_ld_type = emreg_ld_type; // @[ysyx_22051553.scala 164:25]
  assign mem_io_emio_ld_addr_lowbit = emreg_ld_addr_lowbit; // @[ysyx_22051553.scala 165:32]
  assign mem_io_emio_csr_wdata = emreg_csr_wdata; // @[ysyx_22051553.scala 167:27]
  assign mem_io_emio_csr_wen = emreg_csr_wen; // @[ysyx_22051553.scala 168:25]
  assign mem_io_emio_csr_waddr = emreg_csr_waddr; // @[ysyx_22051553.scala 169:27]
  assign mem_io_emio_has_inst = emreg_has_inst; // @[ysyx_22051553.scala 171:26]
  assign mem_io_rdata_valid = Dcache_io_cpu_resp_valid; // @[ysyx_22051553.scala 494:24]
  assign mem_io_rdata_bits_data = Dcache_io_cpu_resp_bits_data; // @[ysyx_22051553.scala 494:24]
  assign mem_io_rdata_io_data_valid = ioformem_io_mem_data_valid; // @[ysyx_22051553.scala 512:21]
  assign mem_io_rdata_io_data_bits = ioformem_io_mem_data_bits; // @[ysyx_22051553.scala 512:21]
  assign mem_io_clmem_Clrvalue_valid = clint_io_clmem_Clrvalue_valid; // @[ysyx_22051553.scala 444:20]
  assign mem_io_clmem_Clrvalue_bits = clint_io_clmem_Clrvalue_bits; // @[ysyx_22051553.scala 444:20]
  assign mem_io_stall = fc_io_fcmem_stall; // @[ysyx_22051553.scala 175:18]
  assign wb_io_mwio_reg_wdata = mwreg_reg_wdata; // @[ysyx_22051553.scala 179:26]
  assign wb_io_mwio_reg_waddr = mwreg_reg_waddr; // @[ysyx_22051553.scala 178:26]
  assign wb_io_mwio_wb_type = mwreg_wb_type; // @[ysyx_22051553.scala 177:24]
  assign wb_io_mwio_csr_wdata = mwreg_csr_wdata; // @[ysyx_22051553.scala 180:26]
  assign wb_io_mwio_csr_wen = mwreg_csr_wen; // @[ysyx_22051553.scala 181:24]
  assign wb_io_mwio_csr_waddr = mwreg_csr_waddr; // @[ysyx_22051553.scala 182:26]
  assign wb_io_mwio_has_inst = mwreg_has_inst; // @[ysyx_22051553.scala 184:25]
  assign wb_io_stall = fc_io_fcwb_stall; // @[ysyx_22051553.scala 190:17]
  assign clint_clock = clock;
  assign clint_reset = reset;
  assign clint_io_clex_valid = excute_io_clex_valid; // @[ysyx_22051553.scala 443:19]
  assign clint_io_clex_ld_type = excute_io_clex_ld_type; // @[ysyx_22051553.scala 443:19]
  assign clint_io_clex_raddr = excute_io_clex_raddr; // @[ysyx_22051553.scala 443:19]
  assign clint_io_clex_sd_type = excute_io_clex_sd_type; // @[ysyx_22051553.scala 443:19]
  assign clint_io_clex_waddr = excute_io_clex_waddr; // @[ysyx_22051553.scala 443:19]
  assign clint_io_clex_wmask = excute_io_clex_wmask; // @[ysyx_22051553.scala 443:19]
  assign clint_io_clex_wdata = excute_io_clex_wdata; // @[ysyx_22051553.scala 443:19]
  assign fw_io_fwde_reg1_raddr = decode_io_fwde_reg1_raddr; // @[ysyx_22051553.scala 418:16]
  assign fw_io_fwde_reg2_raddr = decode_io_fwde_reg2_raddr; // @[ysyx_22051553.scala 418:16]
  assign fw_io_fwde_csr_raddr = decode_io_fwde_csr_raddr; // @[ysyx_22051553.scala 418:16]
  assign fw_io_fwex_reg_waddr = excute_io_fwex_reg_waddr; // @[ysyx_22051553.scala 419:16]
  assign fw_io_fwex_reg_wdata = excute_io_fwex_reg_wdata; // @[ysyx_22051553.scala 419:16]
  assign fw_io_fwex_reg_we = excute_io_fwex_reg_we; // @[ysyx_22051553.scala 419:16]
  assign fw_io_fwex_csr_wdata = excute_io_fwex_csr_wdata; // @[ysyx_22051553.scala 419:16]
  assign fw_io_fwex_csr_wen = excute_io_fwex_csr_wen; // @[ysyx_22051553.scala 419:16]
  assign fw_io_fwex_csr_waddr = excute_io_fwex_csr_waddr; // @[ysyx_22051553.scala 419:16]
  assign fw_io_fwmem_reg_waddr = mem_io_fwmem_reg_waddr; // @[ysyx_22051553.scala 420:17]
  assign fw_io_fwmem_reg_wdata = mem_io_fwmem_reg_wdata; // @[ysyx_22051553.scala 420:17]
  assign fw_io_fwmem_reg_we = mem_io_fwmem_reg_we; // @[ysyx_22051553.scala 420:17]
  assign fw_io_fwmem_csr_wdata = mem_io_fwmem_csr_wdata; // @[ysyx_22051553.scala 420:17]
  assign fw_io_fwmem_csr_wen = mem_io_fwmem_csr_wen; // @[ysyx_22051553.scala 420:17]
  assign fw_io_fwmem_csr_waddr = mem_io_fwmem_csr_waddr; // @[ysyx_22051553.scala 420:17]
  assign fw_io_fwwb_reg_waddr = wb_io_fwwb_reg_waddr; // @[ysyx_22051553.scala 421:16]
  assign fw_io_fwwb_reg_wdata = wb_io_fwwb_reg_wdata; // @[ysyx_22051553.scala 421:16]
  assign fw_io_fwwb_reg_we = wb_io_fwwb_reg_we; // @[ysyx_22051553.scala 421:16]
  assign fw_io_fwwb_csr_wdata = wb_io_fwwb_csr_wdata; // @[ysyx_22051553.scala 421:16]
  assign fw_io_fwwb_csr_wen = wb_io_fwwb_csr_wen; // @[ysyx_22051553.scala 421:16]
  assign fw_io_fwwb_csr_waddr = wb_io_fwwb_csr_waddr; // @[ysyx_22051553.scala 421:16]
  assign regfile_clock = clock;
  assign regfile_reset = reset;
  assign regfile_io_RfDe_reg1_raddr = decode_io_rfio_reg1_raddr; // @[ysyx_22051553.scala 136:20]
  assign regfile_io_RfDe_reg2_raddr = decode_io_rfio_reg2_raddr; // @[ysyx_22051553.scala 136:20]
  assign regfile_io_RfWb_rd = wb_io_rfio_rd; // @[ysyx_22051553.scala 186:16]
  assign regfile_io_RfWb_reg_wen = wb_io_rfio_reg_wen; // @[ysyx_22051553.scala 186:16]
  assign regfile_io_RfWb_reg_wdata = wb_io_rfio_reg_wdata; // @[ysyx_22051553.scala 186:16]
  assign fc_io_fcde_jump_flag = decode_io_jump_flag; // @[ysyx_22051553.scala 453:26]
  assign fc_io_fcde_jump_pc = decode_io_jump_pc; // @[ysyx_22051553.scala 454:24]
  assign fc_io_fcde_load_use = decode_io_load_use; // @[ysyx_22051553.scala 455:25]
  assign fc_io_fcex_jump_flag = excute_io_fcex_jump_flag; // @[ysyx_22051553.scala 457:16]
  assign fc_io_fcex_jump_pc = excute_io_fcex_jump_pc; // @[ysyx_22051553.scala 457:16]
  assign fc_io_fcex_mul_div_busy = excute_io_fcex_mul_div_busy; // @[ysyx_22051553.scala 457:16]
  assign fc_io_fcex_mul_div_valid = excute_io_fcex_mul_div_valid; // @[ysyx_22051553.scala 457:16]
  assign fc_io_fctr_pop_NOP = trap_io_fctr_pop_NOP; // @[ysyx_22051553.scala 439:18]
  assign fc_io_fctr_trap_state = trap_io_fctr_trap_state; // @[ysyx_22051553.scala 439:18]
  assign fc_io_fctr_jump_flag = trap_io_fctr_jump_flag; // @[ysyx_22051553.scala 439:18]
  assign fc_io_fctr_jump_pc = trap_io_fctr_jump_pc; // @[ysyx_22051553.scala 439:18]
  assign fc_io_fcIcache_state = Icache_io_fccache_state; // @[ysyx_22051553.scala 482:23]
  assign fc_io_fcDcache_state = Dcache_io_fccache_state; // @[ysyx_22051553.scala 496:23]
  assign fc_io_fcio_state = ioformem_io_fc_state; // @[ysyx_22051553.scala 511:20]
  assign csrs_clock = clock;
  assign csrs_reset = reset;
  assign csrs_io_CSRDe_csr_raddr = decode_io_csrs_csr_raddr; // @[ysyx_22051553.scala 141:20]
  assign csrs_io_CSRWb_rd = wb_io_csrs_rd; // @[ysyx_22051553.scala 188:16]
  assign csrs_io_CSRWb_csr_wen = wb_io_csrs_csr_wen; // @[ysyx_22051553.scala 188:16]
  assign csrs_io_CSRWb_csr_wdata = wb_io_csrs_csr_wdata; // @[ysyx_22051553.scala 188:16]
  assign csrs_io_CSRTr_rd = trap_io_csrtr_rd; // @[ysyx_22051553.scala 428:19]
  assign csrs_io_CSRTr_csr_wen = trap_io_csrtr_csr_wen; // @[ysyx_22051553.scala 428:19]
  assign csrs_io_CSRTr_csr_wdata = trap_io_csrtr_csr_wdata; // @[ysyx_22051553.scala 428:19]
  assign csrs_io_timer_int = clint_io_timer_int; // @[ysyx_22051553.scala 447:23]
  assign trap_clock = clock;
  assign trap_reset = reset;
  assign trap_io_ex_hasinst = excute_io_has_inst; // @[ysyx_22051553.scala 424:24]
  assign trap_io_mem_hasinst = mem_io_has_inst; // @[ysyx_22051553.scala 425:25]
  assign trap_io_wb_hasinst = wb_io_has_inst; // @[ysyx_22051553.scala 426:24]
  assign trap_io_csrtr_MTVEC = csrs_io_CSRTr_MTVEC; // @[ysyx_22051553.scala 428:19]
  assign trap_io_csrtr_MCAUSE = csrs_io_CSRTr_MCAUSE; // @[ysyx_22051553.scala 428:19]
  assign trap_io_csrtr_MEPC = csrs_io_CSRTr_MEPC; // @[ysyx_22051553.scala 428:19]
  assign trap_io_csrtr_MIE = csrs_io_CSRTr_MIE; // @[ysyx_22051553.scala 428:19]
  assign trap_io_csrtr_MIP = csrs_io_CSRTr_MIP; // @[ysyx_22051553.scala 428:19]
  assign trap_io_csrtr_MSTATUS = csrs_io_CSRTr_MSTATUS; // @[ysyx_22051553.scala 428:19]
  assign trap_io_inst = Icache_io_cpu_resp_valid ? _trap_io_inst_T_3 : 32'h13; // @[ysyx_22051553.scala 430:24]
  assign trap_io_pc = fetch_io_pc_bits; // @[ysyx_22051553.scala 437:16]
  assign arbitor_clock = clock;
  assign arbitor_reset = reset;
  assign arbitor_io_master0_req_valid = ioformem_io_axi_req_valid; // @[ysyx_22051553.scala 517:24]
  assign arbitor_io_master0_req_bits_rw = ioformem_io_axi_req_bits_rw; // @[ysyx_22051553.scala 517:24]
  assign arbitor_io_master0_req_bits_addr = ioformem_io_axi_req_bits_addr; // @[ysyx_22051553.scala 517:24]
  assign arbitor_io_master0_req_bits_data = ioformem_io_axi_req_bits_data; // @[ysyx_22051553.scala 517:24]
  assign arbitor_io_master0_req_bits_mask = ioformem_io_axi_req_bits_mask; // @[ysyx_22051553.scala 517:24]
  assign arbitor_io_master0_req_bits_len = ioformem_io_axi_req_bits_len; // @[ysyx_22051553.scala 517:24]
  assign arbitor_io_master0_req_bits_size = ioformem_io_axi_req_bits_size; // @[ysyx_22051553.scala 517:24]
  assign arbitor_io_master1_req_valid = Dcache_io_axi_req_valid; // @[ysyx_22051553.scala 518:24]
  assign arbitor_io_master1_req_bits_rw = Dcache_io_axi_req_bits_rw; // @[ysyx_22051553.scala 518:24]
  assign arbitor_io_master1_req_bits_addr = Dcache_io_axi_req_bits_addr; // @[ysyx_22051553.scala 518:24]
  assign arbitor_io_master1_req_bits_data = Dcache_io_axi_req_bits_data; // @[ysyx_22051553.scala 518:24]
  assign arbitor_io_master2_req_valid = Icache_io_axi_req_valid; // @[ysyx_22051553.scala 519:24]
  assign arbitor_io_master2_req_bits_rw = Icache_io_axi_req_bits_rw; // @[ysyx_22051553.scala 519:24]
  assign arbitor_io_master2_req_bits_addr = Icache_io_axi_req_bits_addr; // @[ysyx_22051553.scala 519:24]
  assign arbitor_io_master2_req_bits_data = Icache_io_axi_req_bits_data; // @[ysyx_22051553.scala 519:24]
  assign arbitor_io_AXI_O_awready = io_master_awready; // @[ysyx_22051553.scala 127:15]
  assign arbitor_io_AXI_O_wready = io_master_wready; // @[ysyx_22051553.scala 127:15]
  assign arbitor_io_AXI_O_bvalid = io_master_bvalid; // @[ysyx_22051553.scala 127:15]
  assign arbitor_io_AXI_O_arready = io_master_arready; // @[ysyx_22051553.scala 127:15]
  assign arbitor_io_AXI_O_rvalid = io_master_rvalid; // @[ysyx_22051553.scala 127:15]
  assign arbitor_io_AXI_O_rdata = io_master_rdata; // @[ysyx_22051553.scala 127:15]
  assign arbitor_io_AXI_O_rlast = io_master_rlast; // @[ysyx_22051553.scala 127:15]
  assign Icache_clock = clock;
  assign Icache_reset = reset;
  assign Icache_io_cpu_req_valid = Icache_choose & fetch_io_pc_valid; // @[ysyx_22051553.scala 475:35]
  assign Icache_io_cpu_req_bits_addr = fetch_io_pc_bits[31:0]; // @[ysyx_22051553.scala 476:52]
  assign Icache_io_cpu_req_bits_data = 64'h0;
  assign Icache_io_cpu_req_bits_mask = 8'h0;
  assign Icache_io_cpu_sram0_rdata = io_sram0_rdata; // @[ysyx_22051553.scala 484:25]
  assign Icache_io_cpu_sram1_rdata = io_sram1_rdata; // @[ysyx_22051553.scala 485:25]
  assign Icache_io_cpu_sram2_rdata = io_sram2_rdata; // @[ysyx_22051553.scala 486:25]
  assign Icache_io_cpu_sram3_rdata = io_sram3_rdata; // @[ysyx_22051553.scala 487:25]
  assign Icache_io_axi_resp_valid = arbitor_io_master2_resp_valid; // @[ysyx_22051553.scala 519:24]
  assign Icache_io_axi_resp_bits_data = arbitor_io_master2_resp_bits_data; // @[ysyx_22051553.scala 519:24]
  assign Icache_io_axi_resp_bits_valid = arbitor_io_master2_resp_bits_valid; // @[ysyx_22051553.scala 519:24]
  assign Icache_io_axi_resp_bits_choose = arbitor_io_master2_resp_bits_choose; // @[ysyx_22051553.scala 519:24]
  assign Dcache_clock = clock;
  assign Dcache_reset = reset;
  assign Dcache_io_cpu_req_valid = excute_addr[63:30] > 34'h0; // @[ysyx_22051553.scala 470:49]
  assign Dcache_io_cpu_req_bits_addr = excute_addr[31:0]; // @[ysyx_22051553.scala 490:33]
  assign Dcache_io_cpu_req_bits_data = excute_io_wdata; // @[ysyx_22051553.scala 491:33]
  assign Dcache_io_cpu_req_bits_mask = excute_io_wmask; // @[ysyx_22051553.scala 492:33]
  assign Dcache_io_cpu_sram0_rdata = io_sram4_rdata; // @[ysyx_22051553.scala 498:25]
  assign Dcache_io_cpu_sram1_rdata = io_sram5_rdata; // @[ysyx_22051553.scala 499:25]
  assign Dcache_io_cpu_sram2_rdata = io_sram6_rdata; // @[ysyx_22051553.scala 500:25]
  assign Dcache_io_cpu_sram3_rdata = io_sram7_rdata; // @[ysyx_22051553.scala 501:25]
  assign Dcache_io_axi_resp_valid = arbitor_io_master1_resp_valid; // @[ysyx_22051553.scala 518:24]
  assign Dcache_io_axi_resp_bits_data = arbitor_io_master1_resp_bits_data; // @[ysyx_22051553.scala 518:24]
  assign Dcache_io_axi_resp_bits_valid = arbitor_io_master1_resp_bits_valid; // @[ysyx_22051553.scala 518:24]
  assign Dcache_io_axi_resp_bits_choose = arbitor_io_master1_resp_bits_choose; // @[ysyx_22051553.scala 518:24]
  assign ioformem_clock = clock;
  assign ioformem_reset = reset;
  assign ioformem_io_axi_resp_valid = arbitor_io_master0_resp_valid; // @[ysyx_22051553.scala 517:24]
  assign ioformem_io_axi_resp_bits_data = arbitor_io_master0_resp_bits_data; // @[ysyx_22051553.scala 517:24]
  assign ioformem_io_ex_req = ~Dcache_choose & excute_addr != 64'h0; // @[ysyx_22051553.scala 503:43]
  assign ioformem_io_excute_addr = excute_io_ioformem_addr; // @[ysyx_22051553.scala 504:24]
  assign ioformem_io_excute_data = excute_io_ioformem_data; // @[ysyx_22051553.scala 504:24]
  assign ioformem_io_excute_mask = excute_io_ioformem_mask; // @[ysyx_22051553.scala 504:24]
  assign ioformem_io_excute_ld_type = excute_io_ioformem_ld_type; // @[ysyx_22051553.scala 504:24]
  assign ioformem_io_excute_sd_type = excute_io_ioformem_sd_type; // @[ysyx_22051553.scala 504:24]
  assign ioformem_io_fetch_req = ~Icache_choose & fetch_io_pc_valid; // @[ysyx_22051553.scala 508:33]
  assign ioformem_io_fetch_addr = fetch_io_pc_bits[31:0]; // @[ysyx_22051553.scala 509:47]
  assign ioformem_io_decode_load_use = decode_io_inst_io_load_use; // @[ysyx_22051553.scala 514:24]
  assign ioformem_io_fc_stall = fc_io_fcio_stall; // @[ysyx_22051553.scala 511:20]
  always @(posedge clock) begin
    if (reset) begin // @[ysyx_22051553.scala 48:24]
      fdreg_pc <= 64'h30000000; // @[ysyx_22051553.scala 48:24]
    end else begin
      fdreg_pc <= fetch_io_fdio_pc; // @[ysyx_22051553.scala 194:14]
    end
    if (reset) begin // @[ysyx_22051553.scala 54:24]
      dereg_op_a <= 64'h0; // @[ysyx_22051553.scala 54:24]
    end else if (!(fc_io_fcde_stall)) begin // @[Mux.scala 101:16]
      if (fc_io_fcde_flush) begin // @[Mux.scala 101:16]
        dereg_op_a <= 64'h0;
      end else begin
        dereg_op_a <= decode_io_deio_op_a;
      end
    end
    if (reset) begin // @[ysyx_22051553.scala 54:24]
      dereg_op_b <= 64'h0; // @[ysyx_22051553.scala 54:24]
    end else if (!(fc_io_fcde_stall)) begin // @[Mux.scala 101:16]
      if (fc_io_fcde_flush) begin // @[Mux.scala 101:16]
        dereg_op_b <= 64'h0;
      end else begin
        dereg_op_b <= decode_io_deio_op_b;
      end
    end
    if (reset) begin // @[ysyx_22051553.scala 54:24]
      dereg_reg_waddr <= 5'h0; // @[ysyx_22051553.scala 54:24]
    end else if (!(fc_io_fcde_stall)) begin // @[Mux.scala 101:16]
      if (fc_io_fcde_flush) begin // @[Mux.scala 101:16]
        dereg_reg_waddr <= 5'h0;
      end else begin
        dereg_reg_waddr <= decode_io_deio_reg_waddr;
      end
    end
    if (reset) begin // @[ysyx_22051553.scala 54:24]
      dereg_branch_type <= 1'h0; // @[ysyx_22051553.scala 54:24]
    end else if (!(fc_io_fcde_stall)) begin // @[Mux.scala 101:16]
      if (fc_io_fcde_flush) begin // @[Mux.scala 101:16]
        dereg_branch_type <= 1'h0;
      end else begin
        dereg_branch_type <= decode_io_deio_branch_type;
      end
    end
    if (reset) begin // @[ysyx_22051553.scala 54:24]
      dereg_branch_addr <= 64'h0; // @[ysyx_22051553.scala 54:24]
    end else if (!(fc_io_fcde_stall)) begin // @[Mux.scala 101:16]
      if (fc_io_fcde_flush) begin // @[Mux.scala 101:16]
        dereg_branch_addr <= 64'h0;
      end else begin
        dereg_branch_addr <= decode_io_deio_branch_addr;
      end
    end
    if (reset) begin // @[ysyx_22051553.scala 54:24]
      dereg_alu_op <= 6'h3f; // @[ysyx_22051553.scala 54:24]
    end else if (!(fc_io_fcde_stall)) begin // @[Mux.scala 101:16]
      if (fc_io_fcde_flush) begin // @[Mux.scala 101:16]
        dereg_alu_op <= 6'h0;
      end else begin
        dereg_alu_op <= decode_io_deio_alu_op;
      end
    end
    if (reset) begin // @[ysyx_22051553.scala 54:24]
      dereg_shamt <= 6'h0; // @[ysyx_22051553.scala 54:24]
    end else if (!(fc_io_fcde_stall)) begin // @[Mux.scala 101:16]
      if (fc_io_fcde_flush) begin // @[Mux.scala 101:16]
        dereg_shamt <= 6'h0;
      end else begin
        dereg_shamt <= decode_io_deio_shamt;
      end
    end
    if (reset) begin // @[ysyx_22051553.scala 54:24]
      dereg_wb_type <= 2'h0; // @[ysyx_22051553.scala 54:24]
    end else if (!(fc_io_fcde_stall)) begin // @[Mux.scala 101:16]
      if (fc_io_fcde_flush) begin // @[Mux.scala 101:16]
        dereg_wb_type <= 2'h0;
      end else begin
        dereg_wb_type <= decode_io_deio_wb_type;
      end
    end
    if (reset) begin // @[ysyx_22051553.scala 54:24]
      dereg_sd_type <= 3'h0; // @[ysyx_22051553.scala 54:24]
    end else if (!(fc_io_fcde_stall)) begin // @[Mux.scala 101:16]
      if (fc_io_fcde_flush) begin // @[Mux.scala 101:16]
        dereg_sd_type <= 3'h0;
      end else begin
        dereg_sd_type <= decode_io_deio_sd_type;
      end
    end
    if (reset) begin // @[ysyx_22051553.scala 54:24]
      dereg_reg2_rdata <= 64'h0; // @[ysyx_22051553.scala 54:24]
    end else if (!(fc_io_fcde_stall)) begin // @[Mux.scala 101:16]
      if (fc_io_fcde_flush) begin // @[Mux.scala 101:16]
        dereg_reg2_rdata <= 64'h0;
      end else begin
        dereg_reg2_rdata <= decode_io_deio_reg2_rdata;
      end
    end
    if (reset) begin // @[ysyx_22051553.scala 54:24]
      dereg_ld_type <= 3'h0; // @[ysyx_22051553.scala 54:24]
    end else if (!(fc_io_fcde_stall)) begin // @[Mux.scala 101:16]
      if (fc_io_fcde_flush) begin // @[Mux.scala 101:16]
        dereg_ld_type <= 3'h0;
      end else begin
        dereg_ld_type <= decode_io_deio_ld_type;
      end
    end
    if (reset) begin // @[ysyx_22051553.scala 54:24]
      dereg_csr_t <= 64'h0; // @[ysyx_22051553.scala 54:24]
    end else if (!(fc_io_fcde_stall)) begin // @[Mux.scala 101:16]
      if (fc_io_fcde_flush) begin // @[Mux.scala 101:16]
        dereg_csr_t <= 64'h0;
      end else begin
        dereg_csr_t <= decode_io_deio_csr_t;
      end
    end
    if (reset) begin // @[ysyx_22051553.scala 54:24]
      dereg_csr_waddr <= 12'h0; // @[ysyx_22051553.scala 54:24]
    end else if (!(fc_io_fcde_stall)) begin // @[Mux.scala 101:16]
      if (fc_io_fcde_flush) begin // @[Mux.scala 101:16]
        dereg_csr_waddr <= 12'h0;
      end else begin
        dereg_csr_waddr <= decode_io_deio_csr_waddr;
      end
    end
    if (reset) begin // @[ysyx_22051553.scala 54:24]
      dereg_csr_wen <= 1'h0; // @[ysyx_22051553.scala 54:24]
    end else if (!(fc_io_fcde_stall)) begin // @[Mux.scala 101:16]
      if (fc_io_fcde_flush) begin // @[Mux.scala 101:16]
        dereg_csr_wen <= 1'h0;
      end else begin
        dereg_csr_wen <= decode_io_deio_csr_wen;
      end
    end
    if (!(fc_io_fcde_stall)) begin // @[Mux.scala 101:16]
      if (fc_io_fcde_flush) begin // @[Mux.scala 101:16]
        dereg_has_inst <= 1'h0;
      end else begin
        dereg_has_inst <= decode_io_deio_has_inst;
      end
    end
    if (reset) begin // @[ysyx_22051553.scala 72:24]
      emreg_reg_wdata <= 64'h0; // @[ysyx_22051553.scala 72:24]
    end else if (!(fc_io_fcex_stall)) begin // @[Mux.scala 101:16]
      emreg_reg_wdata <= _emreg_reg_wdata_T;
    end
    if (reset) begin // @[ysyx_22051553.scala 72:24]
      emreg_reg_waddr <= 5'h0; // @[ysyx_22051553.scala 72:24]
    end else if (!(fc_io_fcex_stall)) begin // @[Mux.scala 101:16]
      emreg_reg_waddr <= _emreg_reg_waddr_T;
    end
    if (reset) begin // @[ysyx_22051553.scala 72:24]
      emreg_wb_type <= 2'h0; // @[ysyx_22051553.scala 72:24]
    end else if (!(fc_io_fcex_stall)) begin // @[Mux.scala 101:16]
      emreg_wb_type <= _emreg_wb_type_T;
    end
    if (reset) begin // @[ysyx_22051553.scala 72:24]
      emreg_ld_type <= 3'h0; // @[ysyx_22051553.scala 72:24]
    end else if (!(fc_io_fcex_stall)) begin // @[Mux.scala 101:16]
      emreg_ld_type <= _emreg_ld_type_T;
    end
    if (reset) begin // @[ysyx_22051553.scala 72:24]
      emreg_ld_addr_lowbit <= 3'h0; // @[ysyx_22051553.scala 72:24]
    end else if (!(fc_io_fcex_stall)) begin // @[Mux.scala 101:16]
      emreg_ld_addr_lowbit <= _emreg_ld_addr_lowbit_T;
    end
    if (reset) begin // @[ysyx_22051553.scala 72:24]
      emreg_csr_wdata <= 64'h0; // @[ysyx_22051553.scala 72:24]
    end else if (!(fc_io_fcex_stall)) begin // @[Mux.scala 101:16]
      emreg_csr_wdata <= _emreg_csr_wdata_T;
    end
    if (reset) begin // @[ysyx_22051553.scala 72:24]
      emreg_csr_wen <= 1'h0; // @[ysyx_22051553.scala 72:24]
    end else if (!(fc_io_fcex_stall)) begin // @[Mux.scala 101:16]
      emreg_csr_wen <= excute_io_emio_csr_wen;
    end
    if (reset) begin // @[ysyx_22051553.scala 72:24]
      emreg_csr_waddr <= 12'h0; // @[ysyx_22051553.scala 72:24]
    end else if (!(fc_io_fcex_stall)) begin // @[Mux.scala 101:16]
      emreg_csr_waddr <= _emreg_csr_waddr_T;
    end
    if (!(fc_io_fcex_stall)) begin // @[Mux.scala 101:16]
      emreg_has_inst <= excute_io_emio_has_inst;
    end
    if (reset) begin // @[ysyx_22051553.scala 86:24]
      mwreg_reg_wdata <= 64'h0; // @[ysyx_22051553.scala 86:24]
    end else if (!(fc_io_fcmem_stall)) begin // @[Mux.scala 101:16]
      mwreg_reg_wdata <= _mwreg_reg_wdata_T;
    end
    if (reset) begin // @[ysyx_22051553.scala 86:24]
      mwreg_reg_waddr <= 5'h0; // @[ysyx_22051553.scala 86:24]
    end else if (!(fc_io_fcmem_stall)) begin // @[Mux.scala 101:16]
      mwreg_reg_waddr <= _mwreg_reg_waddr_T;
    end
    if (reset) begin // @[ysyx_22051553.scala 86:24]
      mwreg_wb_type <= 2'h0; // @[ysyx_22051553.scala 86:24]
    end else if (!(fc_io_fcmem_stall)) begin // @[Mux.scala 101:16]
      mwreg_wb_type <= _mwreg_wb_type_T;
    end
    if (reset) begin // @[ysyx_22051553.scala 86:24]
      mwreg_csr_wdata <= 64'h0; // @[ysyx_22051553.scala 86:24]
    end else if (!(fc_io_fcmem_stall)) begin // @[Mux.scala 101:16]
      mwreg_csr_wdata <= _mwreg_csr_wdata_T;
    end
    if (reset) begin // @[ysyx_22051553.scala 86:24]
      mwreg_csr_wen <= 1'h0; // @[ysyx_22051553.scala 86:24]
    end else if (!(fc_io_fcmem_stall)) begin // @[Mux.scala 101:16]
      mwreg_csr_wen <= mem_io_mwio_csr_wen;
    end
    if (reset) begin // @[ysyx_22051553.scala 86:24]
      mwreg_csr_waddr <= 12'h0; // @[ysyx_22051553.scala 86:24]
    end else if (!(fc_io_fcmem_stall)) begin // @[Mux.scala 101:16]
      mwreg_csr_waddr <= _mwreg_csr_waddr_T;
    end
    if (!(fc_io_fcmem_stall)) begin // @[Mux.scala 101:16]
      mwreg_has_inst <= mem_io_mwio_has_inst;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  fdreg_pc = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  dereg_op_a = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  dereg_op_b = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  dereg_reg_waddr = _RAND_3[4:0];
  _RAND_4 = {1{`RANDOM}};
  dereg_branch_type = _RAND_4[0:0];
  _RAND_5 = {2{`RANDOM}};
  dereg_branch_addr = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  dereg_alu_op = _RAND_6[5:0];
  _RAND_7 = {1{`RANDOM}};
  dereg_shamt = _RAND_7[5:0];
  _RAND_8 = {1{`RANDOM}};
  dereg_wb_type = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  dereg_sd_type = _RAND_9[2:0];
  _RAND_10 = {2{`RANDOM}};
  dereg_reg2_rdata = _RAND_10[63:0];
  _RAND_11 = {1{`RANDOM}};
  dereg_ld_type = _RAND_11[2:0];
  _RAND_12 = {2{`RANDOM}};
  dereg_csr_t = _RAND_12[63:0];
  _RAND_13 = {1{`RANDOM}};
  dereg_csr_waddr = _RAND_13[11:0];
  _RAND_14 = {1{`RANDOM}};
  dereg_csr_wen = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  dereg_has_inst = _RAND_15[0:0];
  _RAND_16 = {2{`RANDOM}};
  emreg_reg_wdata = _RAND_16[63:0];
  _RAND_17 = {1{`RANDOM}};
  emreg_reg_waddr = _RAND_17[4:0];
  _RAND_18 = {1{`RANDOM}};
  emreg_wb_type = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  emreg_ld_type = _RAND_19[2:0];
  _RAND_20 = {1{`RANDOM}};
  emreg_ld_addr_lowbit = _RAND_20[2:0];
  _RAND_21 = {2{`RANDOM}};
  emreg_csr_wdata = _RAND_21[63:0];
  _RAND_22 = {1{`RANDOM}};
  emreg_csr_wen = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  emreg_csr_waddr = _RAND_23[11:0];
  _RAND_24 = {1{`RANDOM}};
  emreg_has_inst = _RAND_24[0:0];
  _RAND_25 = {2{`RANDOM}};
  mwreg_reg_wdata = _RAND_25[63:0];
  _RAND_26 = {1{`RANDOM}};
  mwreg_reg_waddr = _RAND_26[4:0];
  _RAND_27 = {1{`RANDOM}};
  mwreg_wb_type = _RAND_27[1:0];
  _RAND_28 = {2{`RANDOM}};
  mwreg_csr_wdata = _RAND_28[63:0];
  _RAND_29 = {1{`RANDOM}};
  mwreg_csr_wen = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  mwreg_csr_waddr = _RAND_30[11:0];
  _RAND_31 = {1{`RANDOM}};
  mwreg_has_inst = _RAND_31[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
