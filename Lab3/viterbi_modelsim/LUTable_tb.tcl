proc AddWaves {} {
	;#Add waves we're interested in to the Wave window
    add wave -position end sim:/LUTable_tb/codeword
    add wave -position end sim:/LUTable_tb/mapped_0
    add wave -position end sim:/LUTable_tb/mapped_1
    add wave -position end sim:/LUTable_tb/mapped_2
    add wave -position end sim:/LUTable_tb/mapped_3
    add wave -position end sim:/LUTable_tb/mapped_4
    add wave -position end sim:/LUTable_tb/mapped_5
    add wave -position end sim:/LUTable_tb/mapped_6
    add wave -position end sim:/LUTable_tb/mapped_7
}

vlib work

;# Compile components if any
vcom LUTable.v
vcom LUTable_tb.v

;# Start simulation
vsim LUTable_tb

;# Generate a clock with 1ns period
#force -deposit clk 0 0 ns, 1 1.0 ns -repeat 2 ns

;# Add the waves
AddWaves

;# Run for 100 ns
run 100ns
