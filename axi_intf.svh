`ifndef AXI_INTF_SVH_
`define AXI_INTF_SVH_

interface axi_intf #(
  parameter int unsigned AXI_ADRESS_WIDTH = 32,
  parameter int unsigned AXI_DATA_WIDTH   = 32,
  parameter int unsigned AID_WIDTH        = 4
) (
  input ACLK,
  input ARESETn
);

  localparam int unsigned AXI_STRB_WIDTH = AXI_DATA_WIDTH / 8;

  typedef logic [AID_WIDTH-1:0]         id_t;
  typedef logic [AXI_ADRESS_WIDTH-1:0]  address_t;
  typedef logic [AXI_DATA_WIDTH-1:0]    data_t;
  typedef logic [AXI_STRB_WIDTH-1:0]    strb_t;

  // Write address (AXI-AW) channel
  id_t              AWID;
  address_t         AWADDR;
  logic     [3:0]   AWLEN;
  logic     [2:0]   AWSIZE;
  logic     [1:0]   AWBURST;
  logic     [1:0]   AWLOCK;
  logic     [3:0]   AWCACHE;
  logic     [2:0]   AWPROT;
  logic             AWVALID;
  logic             AWREADY;
  // Write data (AXI-W) channel
  id_t              WID;
  data_t            WDATA;
  strb_t            WSTRB;
  logic             WLAST;
  logic             WVALID;
  logic             WREADY;
  // Write response (AXI-B) channel
  id_t              BID;
  logic             BREADY;
  logic     [1:0]   BRESP;
  logic             BVALID;
  logic             BREADY;
  // Read address (AXI-AR) channel
  id_t              ARID;
  address_t         ARADDR;
  logic     [3:0]   ARLEN;
  logic     [2:0]   ARSIZE;
  logic     [1:0]   ARBURST;
  logic     [1:0]   ARLOCK;
  logic     [3:0]   ARCACHE;
  logic     [2:0]   ARPROT;
  logic             ARREADY;
  logic             ARVALID;
  // Read data (AXI-R) channel
  id_t              RID;
  data_t            RDATA;
  logic     [1:0]   RRESP;
  logic             RLAST;
  logic             RREADY;
  logic             RVALID;

  clocking master_cb @(posedge ACLK);
    // Write address (AXI-AW) channel
    output  AWID;
    output  AWADDR;
    output  AWLEN;
    output  AWSIZE;
    output  AWBURST;
    output  AWLOCK;
    output  AWCACHE;
    output  AWPROT;
    output  AWVALID;
    input   AWREADY;
    // Write data (AXI-W) channel
    output  WID;
    output  WDATA;
    output  WSTRB;
    output  WLAST;
    output  WVALID;
    input   WREADY;
    // Write response (AXI-B) channel
    input   BID;
    input   BREADY;
    input   BRESP;
    input   BVALID;
    output  BREADY;
    // Read address (AXI-AR) channel
    output  ARID;
    output  ARADDR;
    output  ARLEN;
    output  ARSIZE;
    output  ARBURST;
    output  ARLOCK;
    output  ARCACHE;
    output  ARPROT;
    output  ARREADY;
    input   ARVALID;
    // Read data (AXI-R) channel
    input   RID;
    input   RDATA;
    input   RRESP;
    input   RLAST;
    input   RREADY;
    output  RVALID;
  endclocking

  modport master (
    input     ACLK,
    input     ARESETn,
    clocking  master_cb
  );

  clocking slave_cb @(posedge ACLK);
    // Write address (AXI-AW) channel
    input   AWID;
    input   AWADDR;
    input   AWLEN;
    input   AWSIZE;
    input   AWBURST;
    input   AWLOCK;
    input   AWCACHE;
    input   AWPROT;
    input   AWVALID;
    output  AWREADY;
    // Write data (AXI-W) channel
    input   WID;
    input   WDATA;
    input   WSTRB;
    input   WLAST;
    input   WVALID;
    output  WREADY;
    // Write response (AXI-B) channel
    output  BID;
    output  BREADY;
    output  BRESP;
    output  BVALID;
    input   BREADY;
    // Read address (AXI-AR) channel
    input   ARID;
    input   ARADDR;
    input   ARLEN;
    input   ARSIZE;
    input   ARBURST;
    input   ARLOCK;
    input   ARCACHE;
    input   ARPROT;
    input   ARREADY;
    output  ARVALID;
    // Read data (AXI-R) channel
    output  RID;
    output  RDATA;
    output  RRESP;
    output  RLAST;
    output  RREADY;
    input   RVALID;
  endclocking

  modport slave (
    input     ACLK,
    input     ARESETn,
    clocking  slave_cb
  );

  clocking monitor_cb @(posedge ACLK);
    // Write address (AXI-AW) channel
    input   AWID;
    input   AWADDR;
    input   AWLEN;
    input   AWSIZE;
    input   AWBURST;
    input   AWLOCK;
    input   AWCACHE;
    input   AWPROT;
    input   AWVALID;
    input   AWREADY;
    // Write data (AXI-W) channel
    input   WID;
    input   WDATA;
    input   WSTRB;
    input   WLAST;
    input   WVALID;
    input   WREADY;
    // Write response (AXI-B) channel
    input   BID;
    input   BREADY;
    input   BRESP;
    input   BVALID;
    input   BREADY;
    // Read address (AXI-AR) channel
    input   ARID;
    input   ARADDR;
    input   ARLEN;
    input   ARSIZE;
    input   ARBURST;
    input   ARLOCK;
    input   ARCACHE;
    input   ARPROT;
    input   ARREADY;
    input   ARVALID;
    // Read data (AXI-R) channel
    input   RID;
    input   RDATA;
    input   RRESP;
    input   RLAST;
    input   RREADY;
    input   RVALID;
  endclocking

  modport monitor (
    input     ACLK,
    input     ARESETn,
    clocking  monitor_cb
  );

endinterface

`endif  // AXI_INTF_SVH_