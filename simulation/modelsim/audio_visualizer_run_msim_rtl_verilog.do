transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/dcagl/Desktop/ECE385/final {C:/Users/dcagl/Desktop/ECE385/final/ram.v}
vlog -sv -work work +incdir+C:/Users/dcagl/Desktop/ECE385/final {C:/Users/dcagl/Desktop/ECE385/final/VGA_controller.sv}
vlog -sv -work work +incdir+C:/Users/dcagl/Desktop/ECE385/final {C:/Users/dcagl/Desktop/ECE385/final/Color_Mapper.sv}
vlog -sv -work work +incdir+C:/Users/dcagl/Desktop/ECE385/final {C:/Users/dcagl/Desktop/ECE385/final/ball.sv}
vlog -sv -work work +incdir+C:/Users/dcagl/Desktop/ECE385/final {C:/Users/dcagl/Desktop/ECE385/final/FastFourierTransform.sv}
vlog -sv -work work +incdir+C:/Users/dcagl/Desktop/ECE385/final {C:/Users/dcagl/Desktop/ECE385/final/butterfly_module.sv}
vlog -sv -work work +incdir+C:/Users/dcagl/Desktop/ECE385/final {C:/Users/dcagl/Desktop/ECE385/final/lab62.sv}

vlog -sv -work work +incdir+C:/Users/dcagl/Desktop/ECE385/final {C:/Users/dcagl/Desktop/ECE385/final/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
