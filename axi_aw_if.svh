interface axi_aw_if # (
  // Width of address bus in bits
  parameter ADDR_WIDTH = 32,
  // Width of data bus in bits
  parameter DATA_WIDTH = 32,
  // Width of wstrb (width of data bus in words)
  parameter STRB_WIDTH = (DATA_WIDTH/8),
  // Width of ID signal
  parameter ID_WIDTH = 8,
  // Propagate awuser signal
  parameter AWUSER_ENABLE = 0,
  // Width of awuser signal
  parameter AWUSER_WIDTH = 1,
  // Propagate wuser signal
  parameter WUSER_ENABLE = 0,
  // Width of wuser signal
  parameter WUSER_WIDTH = 1,
  // Propagate buser signal
  parameter BUSER_ENABLE = 0,
  // Width of buser signal
  parameter BUSER_WIDTH = 1,
  // When adapting to a wider bus, re-pack full-width burst instead of passing through narrow burst if possible
  parameter CONVERT_BURST = 1,
  // When adapting to a wider bus, re-pack all bursts instead of passing through narrow burst if possible
  parameter CONVERT_NARROW_BURST = 0,
  // Forward ID through adapter
  parameter FORWARD_ID = 0,
  parameter AWLEN_WIDTH = 8,
  parameter AWSIZE_WIDTH = 3,
  parameter AWBURST_WIDTH = 2,
  parameter AWLOCK_WIDTH = 1,
  parameter AWCACHE_WIDTH = 4,
  parameter AWPROT_WIDTH = 3,
  parameter AWQOS_WIDTH = 4,
  parameter AWREGION_WIDTH = 4
) (
  input aclk,
  input aresetn
);
  logic [ID_WIDTH-1:0]        axi_awid      ;
  logic [ADDR_WIDTH-1:0]      axi_awaddr    ;
  logic [AWLEN_WIDTH-1:0]     axi_awlen     ;
  logic [AWSIZE_WIDTH-1:0]    axi_awsize    ;
  logic [AWBURST_WIDTH-1:0]   axi_awburst   ;
  logic [AWCACHE_WIDTH-1:0]   axi_awlock    ;
  logic [AWLOCK_WIDTH-1:0]    axi_awcache   ;
  logic [AWPROT_WIDTH-1:0]    axi_awprot    ;
  logic [AWQOS_WIDTH-1:0]     axi_awqos     ;
  logic [AWREGION_WIDTH-1:0]  axi_awregion  ;
  logic [AWUSER_WIDTH-1:0]    axi_awuser    ;
  logic                       axi_awvalid   ;
  logic                       axi_awready   ;
  logic [DATA_WIDTH-1:0]      axi_wdata     ;
  logic [STRB_WIDTH-1:0]      axi_wstrb     ;
  logic                       axi_wlast     ;
  logic [WUSER_WIDTH-1:0]     axi_wuser     ;
  logic                       axi_wvalid    ;
  logic                       axi_wready    ;
  logic [ID_WIDTH-1:0]        axi_bid       ;
  logic [1:0]                 axi_bresp     ;
  logic [BUSER_WIDTH-1:0]     axi_buser     ;
  logic                       axi_bvalid    ;
  logic                       axi_bready    ;

`ifndef VERILATOR
  clocking mst_cb @(posedge aclk);
    output  axi_awid      ;
    output  axi_awaddr    ;
    output  axi_awlen     ;
    output  axi_awsize    ;
    output  axi_awburst   ;
    output  axi_awlock    ;
    output  axi_awcache   ;
    output  axi_awprot    ;
    output  axi_awqos     ;
    output  axi_awregion  ;
    output  axi_awuser    ;
    output  axi_awvalid   ;
    input   axi_awready   ;
    output  axi_wdata     ;
    output  axi_wstrb     ;
    output  axi_wlast     ;
    output  axi_wuser     ;
    output  axi_wvalid    ;
    input   axi_wready    ;
    input   axi_bid       ;
    input   axi_bresp     ;
    input   axi_buser     ;
    input   axi_bvalid    ;
    output  axi_bready    ;
  endclocking

  modport mst (
    input     aclk    ,
    input     aresetn ,
    clocking  mst_cb
  );

  clocking slv_cb @(posedge aclk);
    input   axi_awid      ;
    input   axi_awaddr    ;
    input   axi_awlen     ;
    input   axi_awsize    ;
    input   axi_awburst   ;
    input   axi_awlock    ;
    input   axi_awcache   ;
    input   axi_awprot    ;
    input   axi_awqos     ;
    input   axi_awregion  ;
    input   axi_awuser    ;
    input   axi_awvalid   ;
    output  axi_awready   ;
    input   axi_wdata     ;
    input   axi_wstrb     ;
    input   axi_wlast     ;
    input   axi_wuser     ;
    input   axi_wvalid    ;
    output  axi_wready    ;
    output  axi_bid       ;
    output  axi_bresp     ;
    output  axi_buser     ;
    output  axi_bvalid    ;
    input   axi_bready    ;
  endclocking

  modport slave (
    input     aclk    ,
    input     aresetn ,
    clocking  slv_cb
  );

  clocking mon_cb @(posedge aclk);
    input axi_awid      ;
    input axi_awaddr    ;
    input axi_awlen     ;
    input axi_awsize    ;
    input axi_awburst   ;
    input axi_awlock    ;
    input axi_awcache   ;
    input axi_awprot    ;
    input axi_awqos     ;
    input axi_awregion  ;
    input axi_awuser    ;
    input axi_awvalid   ;
    input axi_awready   ;
    input axi_wdata     ;
    input axi_wstrb     ;
    input axi_wlast     ;
    input axi_wuser     ;
    input axi_wvalid    ;
    input axi_wready    ;
    input axi_bid       ;
    input axi_bresp     ;
    input axi_buser     ;
    input axi_bvalid    ;
    input axi_bready    ;
  endclocking
`else
  modport mst (
    input   aclk          ,
    input   aresetn       ,
    output  axi_awid      ,
    output  axi_awaddr    ,
    output  axi_awlen     ,
    output  axi_awsize    ,
    output  axi_awburst   ,
    output  axi_awlock    ,
    output  axi_awcache   ,
    output  axi_awprot    ,
    output  axi_awqos     ,
    output  axi_awregion  ,
    output  axi_awuser    ,
    output  axi_awvalid   ,
    input   axi_awready   ,
    output  axi_wdata     ,
    output  axi_wstrb     ,
    output  axi_wlast     ,
    output  axi_wuser     ,
    output  axi_wvalid    ,
    input   axi_wready    ,
    input   axi_bid       ,
    input   axi_bresp     ,
    input   axi_buser     ,
    input   axi_bvalid    ,
    output  axi_bready
  );
`endif  // VERILATOR
endinterface
