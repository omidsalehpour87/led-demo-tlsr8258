# Make sure Telink's Cygwin tools are in PATH
$env:PATH="C:\TelinkIoTStudio\RDS\V5.3.x\cygwin\bin;$env:PATH"

# Configure with toolchain file
 cmake -G "Unix Makefiles" -B build -S .

# Build only the GPIO demo target
cmake --build build --target GPIO_Demo


# in case the cmake is not on system path you can use below command
 & "C:\Program Files\CMake\bin\cmake.exe" -G "Unix Makefiles" -B build -S .

  & "C:\Program Files\CMake\bin\cmake.exe" --build build --target GPIO_Demo