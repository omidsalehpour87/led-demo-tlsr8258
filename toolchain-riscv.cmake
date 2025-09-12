set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR riscv32)

# Path to Telink toolchain
set(TOOLCHAIN_PATH "C:/TelinkIoTStudio/RDS/V5.1.2/toolchains/nds32le-elf-mculib-v5f")

set(CMAKE_C_COMPILER   ${TOOLCHAIN_PATH}/bin/riscv32-elf-gcc)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PATH}/bin/riscv32-elf-g++)
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_PATH}/bin/riscv32-elf-gcc)
set(CMAKE_OBJCOPY      ${TOOLCHAIN_PATH}/bin/riscv32-elf-objcopy)
set(CMAKE_OBJDUMP      ${TOOLCHAIN_PATH}/bin/riscv32-elf-objdump)
set(CMAKE_SIZE         ${TOOLCHAIN_PATH}/bin/riscv32-elf-size)

# Don’t try to run test executables
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
