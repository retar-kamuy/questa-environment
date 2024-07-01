TOP_MODULE	 = axi_aw_buffer

OBJ_DIR		 = obj_dir

TARGET		 = $(OBJ_DIR)/V$(TOP_MODULE)

VERILATOR_ARGS	 = -sc 
VERILATOR_ARGS	+= --exe
# VERILATOR_ARGS	+= -Wall
VERILATOR_ARGS	+= -CFLAGS "-std=c++17" sc_main.cpp $(TOP_MODULE).sv

verilator: $(TARGET).cpp
build: $(TARGET)

$(TARGET).cpp: sc_main.cpp our.sv
	verilator $(VERILATOR_ARGS) sc_main.cpp $(TOP_MODULE).sv

$(TARGET): $(TARGET).cpp
	make -j -C $(@D) -f $(@F).mk $(@F)

run: $(TARGET)
	$^

clean:
	rm -rf $(OBJ_DIR)
