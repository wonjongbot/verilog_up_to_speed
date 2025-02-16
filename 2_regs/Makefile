# Compiler and flags
VERILATOR = verilator
VFLAGS = -cc --exe --build -j 0 -Wall

# Add flag for parameters
VFLAGS += -GWIDTH=12

# Add flag for trace generation
VFLAGS += --trace

# Verilator build directory
BUILD_DIR = obj_dir

# Default target
all: strobe blinky

# Strobe target
strobe: strobe.sv tb_strobe.cpp
	$(VERILATOR) $(VFLAGS) strobe.sv tb_strobe.cpp -o strobe

# Blinky target
blinky: blinky.sv tb_blinky.cpp
	$(VERILATOR) $(VFLAGS) blinky.sv tb_blinky.cpp -o blinky

# dimmer target
dimmer: dimmer.sv tb_dimmer.cpp
	$(VERILATOR) $(VFLAGS) dimmer.sv tb_dimmer.cpp -o dimmer

# Clean rule to remove generated files
clean:
	rm -rf $(BUILD_DIR) strobe blinky