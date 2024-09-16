`ifndef CASE_000_SVH_
`define CASE_000_SVH_

task case_000();

    $display(" Writing value 8'hAC to address 0");
    $display("Configuring master");
    @(posedge testbench.clock);
    testbench.rw            = 0;            //write operation
    testbench.reg_addr      = 8'h00;        //writing to slave register 0
    testbench.data_to_write = 8'hAC;
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
    testbench.reg_addr      = 8'h00;        //reading from slave register 0
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

endtask: case_000

`endif  // CASE_000_SVH_
