transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/dcagl/Desktop/ECE385/final {C:/Users/dcagl/Desktop/ECE385/final/ram.v}
vlib lab62_soc
vmap lab62_soc lab62_soc
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/lab62_soc.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_avalon_i2c.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_avalon_i2c_clk_cnt.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_avalon_i2c_condt_det.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_avalon_i2c_condt_gen.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_avalon_i2c_csr.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_avalon_i2c_fifo.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_avalon_i2c_mstfsm.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_avalon_i2c_rxshifter.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_avalon_i2c_spksupp.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_avalon_i2c_txout.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_avalon_i2c_txshifter.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_avalon_sc_fifo.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_reset_controller.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_reset_synchronizer.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_hex_digits_pio.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_irq_timer.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_jtag_uart_0.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_key.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_keycode.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_leds_pio.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_mm_interconnect_0.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_mm_interconnect_0_avalon_st_adapter.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_mm_interconnect_0_avalon_st_adapter_005.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_nios2_gen2_0.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_nios2_gen2_0_cpu.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_nios2_gen2_0_cpu_debug_slave_sysclk.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_nios2_gen2_0_cpu_debug_slave_tck.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_nios2_gen2_0_cpu_debug_slave_wrapper.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_nios2_gen2_0_cpu_test_bench.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_sdram.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_sdram_pll.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_spi_0.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_sysid_qsys_0.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_usb_gpx.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_usb_rst.v}
vlog -sv -work work +incdir+C:/Users/dcagl/Desktop/ECE385/final {C:/Users/dcagl/Desktop/ECE385/final/VGA_controller.sv}
vlog -sv -work work +incdir+C:/Users/dcagl/Desktop/ECE385/final {C:/Users/dcagl/Desktop/ECE385/final/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/dcagl/Desktop/ECE385/final {C:/Users/dcagl/Desktop/ECE385/final/Color_Mapper.sv}
vlog -sv -work work +incdir+C:/Users/dcagl/Desktop/ECE385/final {C:/Users/dcagl/Desktop/ECE385/final/ball.sv}
vlog -sv -work work +incdir+C:/Users/dcagl/Desktop/ECE385/final {C:/Users/dcagl/Desktop/ECE385/final/FastFourierTransform.sv}
vlog -sv -work work +incdir+C:/Users/dcagl/Desktop/ECE385/final {C:/Users/dcagl/Desktop/ECE385/final/butterfly_module.sv}
vlog -sv -work work +incdir+C:/Users/dcagl/Desktop/ECE385/final {C:/Users/dcagl/Desktop/ECE385/final/lab62.sv}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_avalon_st_clock_crosser.v}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_avalon_st_handshake_clock_crosser.v}
vlog -sv -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_merlin_arbitrator.sv}
vlog -sv -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_merlin_burst_adapter.sv}
vlog -sv -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_merlin_burst_adapter_uncmpr.sv}
vlog -sv -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_merlin_burst_uncompressor.sv}
vlog -sv -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_merlin_master_agent.sv}
vlog -sv -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_merlin_master_translator.sv}
vlog -sv -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_merlin_slave_agent.sv}
vlog -sv -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_merlin_slave_translator.sv}
vlog -sv -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_merlin_width_adapter.sv}
vlog -vlog01compat -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/altera_std_synchronizer_nocut.v}
vlog -sv -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_irq_mapper.sv}
vlog -sv -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_mm_interconnect_0_avalon_st_adapter_005_error_adapter_0.sv}
vlog -sv -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv}
vlog -sv -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_mm_interconnect_0_cmd_demux.sv}
vlog -sv -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_mm_interconnect_0_cmd_mux.sv}
vlog -sv -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_mm_interconnect_0_router.sv}
vlog -sv -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_mm_interconnect_0_router_002.sv}
vlog -sv -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_mm_interconnect_0_router_007.sv}
vlog -sv -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_mm_interconnect_0_rsp_demux.sv}
vlog -sv -work lab62_soc +incdir+c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules {c:/users/dcagl/desktop/ece385/final/db/ip/lab62_soc/submodules/lab62_soc_mm_interconnect_0_rsp_mux.sv}

vlog -sv -work work +incdir+C:/Users/dcagl/Desktop/ECE385/final {C:/Users/dcagl/Desktop/ECE385/final/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -L lab62_soc -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
