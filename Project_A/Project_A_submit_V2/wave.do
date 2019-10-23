onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_mips_processor_v3/s_CLK
add wave -noupdate /tb_mips_processor_v3/s_rs
add wave -noupdate /tb_mips_processor_v3/s_rt
add wave -noupdate /tb_mips_processor_v3/s_rd
add wave -noupdate /tb_mips_processor_v3/s_ALUSrc
add wave -noupdate /tb_mips_processor_v3/s_ALUOp
add wave -noupdate /tb_mips_processor_v3/s_regWrite
add wave -noupdate /tb_mips_processor_v3/s_mem_we
add wave -noupdate /tb_mips_processor_v3/s_MemtoReg
add wave -noupdate /tb_mips_processor_v3/s_immediate
add wave -noupdate /tb_mips_processor_v3/TB_MIPS_processor_V3/RegFile1/s_data0
add wave -noupdate /tb_mips_processor_v3/TB_MIPS_processor_V3/RegFile1/s_data1
add wave -noupdate /tb_mips_processor_v3/TB_MIPS_processor_V3/RegFile1/s_data2
add wave -noupdate /tb_mips_processor_v3/TB_MIPS_processor_V3/RegFile1/s_data3
add wave -noupdate /tb_mips_processor_v3/TB_MIPS_processor_V3/RegFile1/s_data4
add wave -noupdate /tb_mips_processor_v3/TB_MIPS_processor_V3/RegFile1/s_data5
add wave -noupdate /tb_mips_processor_v3/TB_MIPS_processor_V3/RegFile1/s_data6
add wave -noupdate /tb_mips_processor_v3/TB_MIPS_processor_V3/RegFile1/s_data7
add wave -noupdate /tb_mips_processor_v3/TB_MIPS_processor_V3/RegFile1/s_data8
add wave -noupdate /tb_mips_processor_v3/TB_MIPS_processor_V3/RegFile1/s_data9
add wave -noupdate /tb_mips_processor_v3/TB_MIPS_processor_V3/RegFile1/s_data10
add wave -noupdate /tb_mips_processor_v3/TB_MIPS_processor_V3/RegFile1/s_data11
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {738 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 367
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1304 ns} {2142 ns}
