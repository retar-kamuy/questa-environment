`ifndef SCOREBOARD_SVH_
`define SCOREBOARD_SVH_

class scoreboard#(
    parameter DATA_WIDTH = 8
);
    logic [DATA_WIDTH-1:0] exp_queue [$];
    logic [DATA_WIDTH-1:0] exp;

    virtual function void write_exp(logic [DATA_WIDTH-1:0] data);
        this.exp_queue.push_back(data);
    endfunction

    virtual function void write_obs(logic [DATA_WIDTH-1:0] data);
        this.exp = this.exp_queue.pop_front();
        assert (data === this.exp) $info("Read correct data");
        else begin $error("Read incorrect data. Expected %h but got %h", this.exp, data); $stop(); end
    endfunction

endclass

`endif  // SCOREBOARD_SVH_
