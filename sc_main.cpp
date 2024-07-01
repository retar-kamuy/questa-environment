#include "systemc.h"

#include "Vaxi_aw_buffer.h"
#include "Vaxi_aw_buffer__Dpi.h"
#include "svdpi.h"

int sc_main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);

    sc_clock clk{"clk", 10, SC_NS, 0.5, 3, SC_NS, true};
    sc_signal<bool> rst_n;
    sc_signal<uint32_t> axi_awid;

    Vaxi_aw_buffer* top = new Vaxi_aw_buffer{"top"};

    top->clk(clk);
    top->rst_n(rst_n);
    top->axi_awid(axi_awid);

    const svScope scope = svGetScopeFromName("top.axi_aw_buffer");
    assert(scope);  // Check for nullptr if scope not found
    svSetScope(scope);

    int i;
    int axi_awid_ptr;
    while (!Verilated::gotFinish()) {
        sc_start(1, SC_NS);
        dpic_write(i, i+1);
        dpic_read(i, &axi_awid_ptr);
        //std::cout << "read = " << *axi_awid_ptr;
        i++;
    }

    delete top;
    return 0;
}
