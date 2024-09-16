set TESTCASES   {case_000 case_001}

set DO_CMD      {add wave -r /*; do run_all.do; quit}
set LOGDIR      log

set VLOG_FLAGS  {-sv -work work +incdir+test/case_000 +incdir+test/case_001}
set VSIM_FLAGS  {-voptargs=+acc}
lappend VSIM_FLAGS -do "{*}${DO_CMD}"

vlib work
vmap work

if { [file exists ${LOGDIR}] == 1 } then {
    file delete -force ${LOGDIR}
}
file mkdir ${LOGDIR}

vlog {*}${VLOG_FLAGS} -l ${LOGDIR}/vlog.log \
    "rtl/i2c_master.sv" \
    "test/i2c_slave.v" \
    "test/testbench.sv"

foreach case ${TESTCASES} {
    file mkdir ${LOGDIR}/${case}
    vsim {*}${VSIM_FLAGS} -l ${LOGDIR}/${case}/vsim.log -wlf ${LOGDIR}/${case}/vsim.wlf +${case} work.testbench
}

run -all
