set broken 0

onbreak {
    set broken 1
    resume
}

run -all

if { $broken } {
    puts "failure -- exit status $broken"
    exit -code $broken
} else {
    puts "success"
}

quit -force
