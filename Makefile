###############################################################################
# User settings
###############################################################################
WORK		 = work

SRCS		 = rtl/i2c_master.sv
SRCS		+= test/i2c_slave.v test/testbench.sv

LOGDIR		 = log

TESTCASES	 = case_000 case_001 case_002

DO_CMD		 = add wave -r /*; run -all; quit

VLOG_FLAGS	 = -sv -work work
VLOG_FLAGS	+= +incdir+test/pat

VSIM_FLAGS	 = -c
VSIM_FLAGS	+= -voptargs=+acc
VSIM_FLAGS	+= -do "$(DO_CMD)"

###############################################################################
# Macros
###############################################################################
define VSIM
	rm -rf $(LOGDIR)/$(1)
	mkdir $(LOGDIR)/$(1)
	vsim $(VSIM_FLAGS) -l $(LOGDIR)/$(1)/vsim.log -wlf $(LOGDIR)/$(1)/vsim.wlf +$(1) work.testbench

endef

###############################################################################
# Rules
###############################################################################
all: run

build: $(LOGDIR)/vlog.log

run: $(LOGDIR)/vlog.log
	$(foreach case,$(TESTCASES),$(call VSIM,$(case)))
	python3 check_log.py

$(WORK):
	vlib $@
	vmap work $@

$(LOGDIR)/vlog.log: $(WORK) $(SRCS)
	if [ -d $(@D) ]; then rm -rf $(@D); fi
	mkdir $(@D)
	vlog $(VLOG_FLAGS) -l $@ $(SRCS)

clean:
	rm -rf $(WORK) $(LOGDIR) transcript *.wlf
