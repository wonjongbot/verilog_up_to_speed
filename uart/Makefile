# Compiler and flags
VERILATOR = verilator
VFLAGS = -cc --exe --build -j 0 -Wall

# Add flag for parameters
# VFLAGS += -GWIDTH=12

# Add flag for trace generation
VFLAGS += --trace

# Verilator build directory
BUILD_DIR = obj_dir

# Default target
all: uart # strobe blinky

# Strobe target
uart: uart.sv uart_tx.sv baude_gen.sv tb_uart.cpp testb.h
	$(VERILATOR) $(VFLAGS) uart.sv uart_tx.sv baude_gen.sv tb_uart.cpp -o uart


# # Blinky target
# blinky: blinky.sv tb_blinky.cpp
# 	$(VERILATOR) $(VFLAGS) blinky.sv tb_blinky.cpp -o blinky

# # dimmer target
# dimmer: dimmer.sv tb_dimmer.cpp
# 	$(VERILATOR) $(VFLAGS) dimmer.sv tb_dimmer.cpp -o dimmer

# Clean rule to remove generated files
clean:
	rm -rf $(BUILD_DIR) uart