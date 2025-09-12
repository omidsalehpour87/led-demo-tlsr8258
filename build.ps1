# Make sure Telink's Cygwin tools are in PATH
$env:PATH="C:\TelinkIoTStudio\RDS\V5.1.2\cygwin\bin;$env:PATH"

# Configure with toolchain file
 cmake -G "Unix Makefiles" -B build -S .

# Build only the GPIO demo target
cmake --build build --target GPIO_Demo

