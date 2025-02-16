# Compiler and flags
VERILATOR = verilator
VFLAGS = -cc --exe --build -j 0 -Wall

# Source files
SV_SRC = thruwire.sv
CPP_SRC = thruwire.cpp

# Output executable
OUT = thruwire

# Verilator build directory
BUILD_DIR = obj_dir

# Default target
all: $(OUT)

# Run Verilator command
$(OUT):
	$(VERILATOR) $(VFLAGS) $(SV_SRC) $(CPP_SRC) -o $(OUT)

# Clean rule to remove generated files
clean:
	rm -rf $(BUILD_DIR) $(OUT)
