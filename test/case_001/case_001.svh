`ifndef CASE_001_SVH_
`define CASE_001_SVH_

task case_001();

    $display(" Writing value 8'hDC to address 1");
    $display("Configuring master");
    @(posedge testbench.clock);
    testbench.rw            = 0;            //write operation
    testbench.reg_addr      = 8'h01;        //writing to slave register 1
    testbench.data_to_write = 8'hDC;
    testbench.device_addr   = 7'b001_0001;  //slave address
    testbench.divider       = 16'hFFFF;     //divider value for i2c serial clock
    testbench.sb.write_exp(testbench.data_to_write);
    @(posedge testbench.clock);
    $display("Enabling master");
    testbench.enable        = 1;
    @(posedge testbench.i2c_master_busy)
    $display("Master has started writing");
    testbench.enable        = 0;
    @(negedge testbench.i2c_master_busy);
    $display("Master has finsihed writing");

    $display("Reading from address 0");
    $display("Configuring master");
    @(posedge testbench.clock);
    testbench.rw            = 1;            //read operation
    testbench.reg_addr      = 8'h01;        //reading from slave register 1
    testbench.data_to_write = 8'h00;
    testbench.device_addr   = 7'b001_0001;  //slave address
    @(posedge testbench.clock);
    $display("Enabling master");
    testbench.enable        = 1;
    @(posedge testbench.i2c_master_busy)
    $display("Master has started reading");
    testbench.enable        = 0;
    @(negedge testbench.i2c_master_busy);
    $display("Master has finsihed reading");
    testbench.sb.write_obs(testbench.i2c_master_miso_data);

endtask: case_001

`endif  // CASE_001_SVH_
