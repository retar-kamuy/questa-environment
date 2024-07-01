`include "axi_aw_if.svh"

module axi_aw_buffer # (
  parameter DEPTH = 256,
//  // Width of address bus in bits
//  parameter ADDR_WIDTH = 32,
//  // Width of data bus in bits
//  parameter DATA_WIDTH = 32,
//  // Width of wstrb (width of data bus in words)
//  parameter STRB_WIDTH = (DATA_WIDTH/8),
  // Width of ID signal
  parameter ID_WIDTH = 8
  // Propagate awuser signal
//  parameter AWUSER_ENABLE = 0,
//  // Width of awuser signal
//  parameter AWUSER_WIDTH = 1,
//  // Propagate wuser signal
//  parameter WUSER_ENABLE = 0,
//  // Width of wuser signal
//  parameter WUSER_WIDTH = 1,
//  // Propagate buser signal
//  parameter BUSER_ENABLE = 0,
//  // Width of buser signal
//  parameter BUSER_WIDTH = 1,
//  // When adapting to a wider bus, re-pack full-width burst instead of passing through narrow burst if possible
//  parameter CONVERT_BURST = 1,
//  // When adapting to a wider bus, re-pack all bursts instead of passing through narrow burst if possible
//  parameter CONVERT_NARROW_BURST = 0,
//  // Forward ID through adapter
//  parameter FORWARD_ID = 0,
//  parameter AWLEN_WIDTH = 8,
//  parameter AWSIZE_WIDTH = 3,
//  parameter AWBURST_WIDTH = 2,
//  parameter AWLOCK_WIDTH = 1,
//  parameter AWCACHE_WIDTH = 4,
//  parameter AWPROT_WIDTH = 3,
//  parameter AWQOS_WIDTH = 4,
//  parameter AWREGION_WIDTH = 4
) (
  input clk                                         ,
  input rst_n                                       ,
  output  logic [ID_WIDTH-1:0]        axi_awid
  // output  logic [ADDR_WIDTH-1:0]      axi_awaddr    ,
  // output  logic [AWLEN_WIDTH-1:0]     axi_awlen     ,
  // output  logic [AWSIZE_WIDTH-1:0]    axi_awsize    ,
  // output  logic [AWBURST_WIDTH-1:0]   axi_awburst   ,
  // output  logic [AWCACHE_WIDTH-1:0]   axi_awlock    ,
  // output  logic [AWLOCK_WIDTH-1:0]    axi_awcache   ,
  // output  logic [AWPROT_WIDTH-1:0]    axi_awprot    ,
  // output  logic [AWQOS_WIDTH-1:0]     axi_awqos     ,
  // output  logic [AWREGION_WIDTH-1:0]  axi_awregion  ,
  // output  logic [AWUSER_WIDTH-1:0]    axi_awuser    ,
  // output  logic                       axi_awvalid   ,
  // input   logic                       axi_awready   ,
  // output  logic [DATA_WIDTH-1:0]      axi_wdata     ,
  // output  logic [STRB_WIDTH-1:0]      axi_wstrb     ,
  // output  logic                       axi_wlast     ,
  // output  logic [WUSER_WIDTH-1:0]     axi_wuser     ,
  // output  logic                       axi_wvalid    ,
  // input   logic                       axi_wready    ,
  // input   logic [ID_WIDTH-1:0]        axi_bid       ,
  // input   logic [1:0]                 axi_bresp     ,
  // input   logic [BUSER_WIDTH-1:0]     axi_buser     ,
  // input   logic                       axi_bvalid    ,
  // output  logic                       axi_bready
);
  export "DPI-C" task dpic_write;
  export "DPI-C" task dpic_read;

  typedef struct {
    logic [ID_WIDTH-1:0] axi_awid;
  } AXI;

  logic [ID_WIDTH-1:0] mem[0:DEPTH-1];

  task automatic dpic_write (
    input int wr_ptr,
    input int _axi_awid
  );
    mem[wr_ptr] = _axi_awid;
    $info("wr_ptr = 0x%h, axi_awid = 0x%h",wr_ptr, _axi_awid);
    wr_ptr = wr_ptr + 1;
  endtask

  task automatic dpic_read (
    input int rd_ptr,
    output int _axi_awid
  );
    _axi_awid = mem[rd_ptr];
    $info("rd_ptr = 0x%h, axi_awid = 0x%h",rd_ptr, _axi_awid);
    rd_ptr = rd_ptr + 1;
  endtask

endmodule
