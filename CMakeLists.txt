cmake_minimum_required(VERSION 3.10)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR riscv32)

set(CMAKE_VERBOSE_MAKEFILE ON)
# toolchain name : TL32 ELF MCULIB V5F GCC12.2
set(TOOLCHAIN_PATH C:/TelinkIoTStudio/RDS/V5.3.x/toolchains/nds32le-elf-mculib-v5f)
set(CMAKE_C_COMPILER ${TOOLCHAIN_PATH}/bin/riscv32-elf-gcc)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PATH}/bin/riscv32-elf-g++)
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_PATH}/bin/riscv32-elf-gcc)
set(CMAKE_OBJDUMP ${TOOLCHAIN_PATH}/bin/riscv32-elf-objdump)
set(CMAKE_OBJCOPY ${TOOLCHAIN_PATH}/bin/riscv32-elf-objcopy)
set(CMAKE_PRINTSIZE ${TOOLCHAIN_PATH}/bin/riscv32-elf-size)

project(TL_PLATFORM_SDK_322X LANGUAGES ASM C)

add_compile_options(-fno-lto)
add_link_options(-fno-lto)

set(CMAKE_SKIP_RPATH True)
set(CMAKE_LINK_LIBRARY_SUFFIX )
set(ProjDirPath ${CMAKE_CURRENT_SOURCE_DIR}/.)

function(recursive_glob folder sources_var)
    file(GLOB_RECURSE files RELATIVE ${folder} *.c *.S)
    list(APPEND ${sources_var} ${files})
    set(${sources_var} ${${sources_var}} PARENT_SCOPE)
endfunction()

recursive_glob(${CMAKE_CURRENT_SOURCE_DIR} GPIO_Demo_SOURCES)
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/N22_STimer_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/SD_ADC_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/CAN_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^common/tl_usb/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/Timer_BB_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/N22_TRAP_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/PKE_Demo/PKE_Demo_Telink_2024Q3-v1.0.3-a/PKE_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/SPI_Demo/SPI_V1.1/SPI_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/TRNG_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/Flash_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/TRAP_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/ADC_Demo/ADC_V1.1/ADC_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/UART_DEMO/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/ALG_REG_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/MULTI_CORE_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/HASH_Demo/HASH_Demo_Telink_2024Q3-v1.0.3-a/HASH_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/Dhrystone_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/Debug_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/SKE_Demo/SKE_Demo_Telink_2024Q3-v1.0.3-a/SKE_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/Coremark_demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/Timer_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/RF_DEMO/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/N22_Test_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^tools/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/STimer_Demo/")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/EMI_BQB_Demo/")
list(FILTER GPIO_Demo_SOURCES INCLUDE REGEX "^chip/tl322x/boot|^common|^chip/tl322x/drivers|^chip/tl322x/link|^demo/vendor/GPIO_Demo|^demo/vendor/common/common|^demo/vendor/common/tl322x/calibration|^demo/vendor/common/tl322x/exception.c|^demo/vendor/common/tl322x/exception_n22.c")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^cmake_build/")

# Exclude unwanted demos
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^demo/vendor/N22_STimer_Demo/")

# Exclude D25 startup files (TLSR8258 is N22 core)
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^chip/tl322x/boot/D25/")

# Make sure we still keep N22 startup files + exception handlers
list(FILTER GPIO_Demo_SOURCES INCLUDE REGEX "^chip/tl322x/boot/N22|^common|^chip/tl322x/drivers|^chip/tl322x/link|^demo/vendor/GPIO_Demo|^demo/vendor/common/common|^demo/vendor/common/tl322x/calibration|^demo/vendor/common/tl322x/exception.c|^demo/vendor/common/tl322x/exception_n22.c")
list(FILTER GPIO_Demo_SOURCES EXCLUDE REGEX "^chip/tl322x/link/D25F/")

list(FILTER GPIO_Demo_SOURCES INCLUDE REGEX
    "^chip/tl322x/boot/N22|^chip/tl322x/drivers|^chip/tl322x/link/N22|^common|^demo/vendor/GPIO_Demo|^demo/vendor/common/common|^demo/vendor/common/tl322x/calibration|^demo/vendor/common/tl322x/exception.c|^demo/vendor/common/tl322x/exception_n22.c"
)


add_executable(GPIO_Demo ${GPIO_Demo_SOURCES} )

set_target_properties(GPIO_Demo PROPERTIES SUFFIX "")

# assemble_opts_define

target_compile_options(GPIO_Demo PRIVATE $<$<COMPILE_LANGUAGE:ASM>: -DMCU_STARTUP_FLASH=1 -DMCU_CORE_TL322X=1>)

# assemble_opts_include
set(ASM_INCLUDE_OPTS -I${ProjDirPath}/chip/tl322x/drivers -I${ProjDirPath}/demo/vendor/common/tl322x/calibration -I${ProjDirPath}/common -I${ProjDirPath}/demo/vendor/common/common)

target_compile_options(GPIO_Demo PRIVATE $<$<COMPILE_LANGUAGE:ASM>: ${ASM_INCLUDE_OPTS}>)


# assemble_opts_contents

target_compile_options(GPIO_Demo PRIVATE $<$<COMPILE_LANGUAGE:ASM>: -mcmodel=medium -fmessage-length=0 -ffunction-sections -fdata-sections -flto -Werror -O2 -g3 -Wall -Wextra -Wshadow -Wimplicit-fallthrough -Wpointer-arith -Wredundant-decls -Wcast-qual -Wsign-compare -Wunused-parameter -Wunused-variable -Wswitch -Wstrict-prototypes -Wmissing-field-initializers -Wdeprecated-declarations -Wenum-conversion -Wpacked-not-aligned -Waddress-of-packed-member -Wundef -x assembler-with-cpp -mcpu=d25f -mext-dsp -fomit-frame-pointer -fno-strict-aliasing -std=c99 -fno-jump-tables -fno-fat-lto-objects -fuse-ld=bfd>)

# c_opts_define
target_compile_options(GPIO_Demo PRIVATE $<$<COMPILE_LANGUAGE:C>: -DMCU_STARTUP_FLASH=1 -DMCU_CORE_TL322X=1>)

# c_opts_include
target_compile_options(GPIO_Demo PRIVATE $<$<COMPILE_LANGUAGE:C>: -I${ProjDirPath}/chip/tl322x/drivers -I${ProjDirPath}/demo/vendor/common/tl322x/calibration -I${ProjDirPath}/common -I${ProjDirPath}/demo/vendor/common/common>)

# c_opts_contents
target_compile_options(GPIO_Demo PRIVATE $<$<COMPILE_LANGUAGE:C>: -mcmodel=medium -fmessage-length=0 -ffunction-sections -fdata-sections -flto -Werror -O2 -g3 -Wall -Wextra -Wshadow -Wimplicit-fallthrough -Wpointer-arith -Wredundant-decls -Wcast-qual -Wsign-compare -Wunused-parameter -Wunused-variable -Wswitch -Wstrict-prototypes -Wmissing-field-initializers -Wdeprecated-declarations -Wenum-conversion -Wpacked-not-aligned -Waddress-of-packed-member -Wundef -mcpu=d25f -mext-dsp -fomit-frame-pointer -fno-strict-aliasing -std=c99 -fno-jump-tables -fno-fat-lto-objects -fuse-ld=bfd>)


target_link_directories(GPIO_Demo PRIVATE ${ProjDirPath}/chip/tl322x/drivers/lib)
#target_link_options(GPIO_Demo PRIVATE -mcmodel=medium -fmessage-length=0 -ffunction-sections -fdata-sections -flto -Werror -O2 -g3 -Wall -Wextra -Wshadow -Wimplicit-fallthrough -Wpointer-arith -Wredundant-decls -Wcast-qual -Wsign-compare -Wunused-parameter -Wunused-variable -Wswitch -Wstrict-prototypes -Wmissing-field-initializers -Wdeprecated-declarations -Wenum-conversion -Wpacked-not-aligned -Waddress-of-packed-member -Wundef -Xlinker --gc-sections -nostartfiles -T${ProjDirPath}/chip/tl322x/link/D25F/flash_boot.link -mcpu=d25f -mext-dsp -fomit-frame-pointer -fno-strict-aliasing -std=c99 -fno-jump-tables -fno-fat-lto-objects -fuse-ld=bfd -Wl,-Map,GPIO_Demo.map)
target_link_options(GPIO_Demo PRIVATE
    -mcmodel=medium
    -fmessage-length=0
    -ffunction-sections
    -fdata-sections
    -flto
    -Werror
    -O2
    -g3
    -Wall
    -Wextra
    -Wshadow
    -Wimplicit-fallthrough
    -Wpointer-arith
    -Wredundant-decls
    -Wcast-qual
    -Wsign-compare
    -Wunused-parameter
    -Wunused-variable
    -Wswitch
    -Wstrict-prototypes
    -Wmissing-field-initializers
    -Wdeprecated-declarations
    -Wenum-conversion
    -Wpacked-not-aligned
    -Waddress-of-packed-member
    -Wundef
    -Xlinker --gc-sections
    -nostartfiles
    -T${ProjDirPath}/chip/tl322x/link/D25F/flash_boot.link   # ✅ still D25F linker
    -mcpu=d25f                                             
    -fomit-frame-pointer
    -fno-strict-aliasing
    -std=c99
    -fno-jump-tables
    -fno-fat-lto-objects
    -fuse-ld=bfd
    "-Wl,-Map,GPIO_Demo.map,--defsym,__D25F_DRAM_SIZE=0x20000,--defsym,__D25F_IRAM_SIZE=0x4000"
)

target_link_libraries(GPIO_Demo PRIVATE driver_d25f)

# prebuild postbuild
add_custom_command(TARGET GPIO_Demo PRE_BUILD COMMAND sh ${ProjDirPath}/project/tlsr_riscv/tl322x/../../../tools/tl_gen_config_header_tool/tl_gen_config_header.sh   GPIO_Demo)
add_custom_command(TARGET GPIO_Demo POST_BUILD COMMAND sh ${ProjDirPath}/project/tlsr_riscv/tl322x/../../../tools/tl_check_fw_tool/tl_check_fw.sh   GPIO_Demo   ${PROJECT_NAME})

# The following is the default generated postbuild, which can be annotated if not needed
add_custom_command(TARGET GPIO_Demo POST_BUILD COMMAND ${CMAKE_OBJCOPY} -O binary  $<TARGET_FILE:GPIO_Demo> $<TARGET_FILE_DIR:GPIO_Demo>/GPIO_Demo.bin)
add_custom_command(TARGET GPIO_Demo POST_BUILD COMMAND ${CMAKE_OBJDUMP} --source --all-headers --demangle --line-numbers --wide  $<TARGET_FILE:GPIO_Demo> > $<TARGET_FILE_DIR:GPIO_Demo>/GPIO_Demo.lst)
add_custom_command(TARGET GPIO_Demo POST_BUILD COMMAND ${CMAKE_PRINTSIZE}  $<TARGET_FILE:GPIO_Demo>)
