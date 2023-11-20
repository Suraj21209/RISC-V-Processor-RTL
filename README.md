# RISC-V-Processor-RTL
## RTL Design of 5-stage pipelined RISC-V processor

### Overview

This repository hosts the implementation of a 5-stage pipelined RISC-V processor based on the RV32I variant of the RISC-V ISA. The processor is designed in Register Transfer Level (RTL) using Verilog.

### Features

- **5-Stage Pipeline:** Implements the classic Fetch, Decode, Execute, Memory, and Writeback stages.
- **Single Clock Design:** Entire design operates on a single clock.
- **Separate Memory:** Utilizes separate memory for instruction and data.
- **Forwarding/Bypassing:** Microarchitecture includes forwarding/bypassing mechanisms.
- **Special Instructions:**
  - `LOADNOC`: Stores data in memory-mapped registers.
  - `SENDNOC`: Writes the integer 1 to a specific memory-mapped register.
- **Branch Prediction:** 2 bit branch predictor

### Testing Infrastructure

- **Test Bench:** Verify processor functionality with a test bench that takes the binary path as input.
- **Waveform Visualization:** Plot waveforms of control and datapath signals using Vivado.

### Usage

1. **Dependencies:**
   - Any tool capable of running verilog code, eg., Vivado, Vidual Studio Code

2. **Building and Simulating:**
   - Clone all the verilog files in the folder name RISC_V_Final_project
   - In order to change the binary files, write the commands in hexa decimal format, save it with .hex extenstion and provide the path and the file name in Instruction_Memory.v line 13 $readmemh command
   - Follow the below commands

```bash
# Example commands
$ iverilog -o out.vvp RISCV_tb.v Top_module.v
$ vvp out.vvp
$ gtkwave dump.vcd
```

### Directory Structure

```plaintext
/RISC_V_Final_project  # Source code, binary and waveforms for the processor
```

### Contributors

- ANAND KUMAR DIXIT(anand22184@iiitd.ac.in)
- VARUN SINGH(varun22189@iiitd.ac.in)
- SANKHADEEP MONDAL(sankhadeep22174@iiitd.ac.in)
- MILIND THAKUR(milind22163@iiitd.ac.in)
- SURAJ KUMAR JHA(suraj21209@iiitd.ac.in)


