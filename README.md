# 📘 LED blinky Demo on TLSR8258

## 1. Overview
This project demonstrates a simple **GPIO LED application** running on the **Telink TLSR8258 (TL322x series, RISC-V N22/D25F core)**.  
It is intended as a starting point for getting familiar with the Telink platform, SDK, and build environment.

The demo toggles GPIO pins to drive onboard LEDs, illustrating basic GPIO configuration and software build workflow.

---

## 2. CPU Information
- **SoC Family**: Telink TLSR8258 / TL322x series  
- **Core**: RISC-V (N22/D25F depending on variant)  
- **Memory**:  
  - DRAM: 128 KB  
  - IRAM: 16 KB  
- **Peripherals**: GPIO, I²C, SPI, UART, PWM, ADC, USB, Bluetooth 5.0 LE (depending on package)

---

## 3. Toolchain and IDE Setup

### Install CMake (Windows)
- Download from [CMake official site](https://cmake.org/download/).  
- Add to `PATH`:  C:\Program Files\CMake\bin


### Download & Install **Telink IoT Studio**
- Eclipse-based IDE for Telink SDKs.  
- Includes toolchains, SDK examples, and flashing utilities.  
- [Telink Semiconductor – IoT Studio download](https://wiki.telink-semi.cn/wiki/IDE-and-Tools/Telink_IoT_Studio//)

### SDK
``` bash
Option 1: clone the official Telink SDK (used inside Telink IoT Studio)
git clone https://github.com/TelinkSemi/tl_platform_sdk.git

Option 2: clone this assignment project with CMake build support
git clone git@github.com:omidsalehpour87/led-demo-tlsr8258.git
```

## 4. Build Instructions

Using Telink IoT Studio (IDE)

Telink IoT Studio supports SDK or projects import for TLSR8 series chip.

Users can use the File -> Import... to import SDK or projects
- Select the 32xx project.
- Build via Project → Build.
- Output artifacts will be generated:
 - GPIO_Demo.elf (for debugging)
 - GPIO_Demo.bin (for flashing)
 - GPIO_Demo.lst (disassembly)
 - GPIO_Demo.siz (memory size report)

 Using CMake (CLI)
 ``` bash
### configure
cmake -G "Unix Makefiles" -B build -S .

# Build the GPIO demo target
cmake --build build --target GPIO_Demo
```
After building:
- ELF: build/GPIO_Demo or build/GPIO_Demo.elf
- BIN: generate with objcopy:

```
riscv32-elf-objcopy -O binary build/GPIO_Demo build/GPIO_Demo.bin
```
## 5. flashing device
The recommended method is using the **Telink Burning and Debugging Tool (BDT)**.  
This tool is integrated in Telink IoT Studio, or you can download it separately and follwo instructions there:

[Telink Burning and Debugging Tools](https://wiki.telink-semi.cn/wiki/IDE-and-Tools/Burning-and-Debugging-Tools-for-all-Series/)


## 6. Pin Mapping

When running the demo on the 48-pin TLSR8258 dev board, take care of GPIO/LED numbering:

- LED1 → GPIO_PD2
- LED2 → GPIO_PD3
- LED3 → GPIO_PD4
- LED4 → GPIO_PD5

(Refer to the board schematic: pin names may appear as TL_P3_D2, etc.)

## 7. Next steps
- Explore other SDK demos such as `UART_Demo` or `SPI_Demo`.  
- Try to integrate BLE functionality to toggle LEDs wirelessly.

## trouble shooting
- Ensure CMake is in your PATH (`cmake --version` should work). If not found add it to windows PATH  
- If the build fails with `undefined symbol __N22_*`, check that the correct linker script is selected (`chip/tl322x/link/N22/flash_boot_ramcode.link`).  
- If flashing fails, confirm the COM port of your USB dongle in Windows Device Manager.
