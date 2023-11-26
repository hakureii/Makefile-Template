# Check if ANDROID_HOME is set
ifndef ANDROID_HOME
$(error ANDROID_HOME is not set. Please set it to the path of your Android NDK installation.)
endif

# Check if the NDK directory exists
NDK_DIR := $(ANDROID_HOME)/ndk/26.1.10909125
ifeq ($(wildcard $(NDK_DIR)),)
$(error NDK directory not found: $(NDK_DIR))
endif

# Define variables
CC := ccache $(NDK_DIR)/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android33-clang
AR := $(NDK_DIR)/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar
LD := $(NDK_DIR)/toolchains/llvm/prebuilt/linux-x86_64/bin/ld
STRIP := aarch64-linux-android-strip

# Define flags
# LDFLAGS := -static
CFLAGS := -Wall -O2

# Define source directory
SRC_DIR := src

# Define object files
OBJECTS := $(SRC_DIR)/main.o

# Define target
TARGET := main

# Build rule
$(TARGET): $(OBJECTS)
	@echo "Linking $@"
	@$(CC) -o $@ $^ $(LDFLAGS)
	@$(STRIP) $@
	@echo "$@ build completed."

# Clean rule
.PHONY: clean
clean:
	@echo "Cleaning..."
	@rm -f $(OBJECTS) $(TARGET)
	@echo "Clean complete."

# Generate dependency files during compilation
%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

# Silence make
MAKEFLAGS += --silent

