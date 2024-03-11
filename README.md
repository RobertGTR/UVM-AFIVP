# Test Enviorment for ARM APB with a ALU(Arhitmetic Logic Unit)
This module implements an arithmetic unit configurable and controllable through APB interface. 
Supports only Addition and Multiplication operations.
Please see below the block diagram and interfaces:

![Block diagram](./img/system_design.jpg "Block diagram of the system")

*Block diagram of the system*
# Features
- Single clock domain (1Ghz)
- Support asynchronous reset active low

| APB Address  | Type | Name                     | APB Access            | Internal Access |
| ------------ | ---- | ------------------------ | --------------------- | --------------- |
| 0x0000–007C  | RWS  | Working Registers        | Read/Write access     | Read/Write      |
| 0x0080       | RW   | Configuration instruction| Read/Write access     | Read            |
| 0x0084       | RO   | Interrupt status         | Read Only             | Read/Write      |
| 0x0088       | RWA  | Interrupt Clear          | Read/Write Auto reset | Read            |
| 0x008C       | RWA  | Control Register         | Read/Write Auto reset | Read            |

Fore more information you can find it in [here](./hw_reg/hw_registers.xlsx)

![instruct_list](./img/instruct_format.jpg "instruct_format")
*Instruction format*

- **Imm** – Immediate value
- **DST** – Destination register address
- **RS0** – Source register 0
- **RS1** – Source register 1
- **Opcode** – Operation code
  The module supports the next operations according to the operation code:
- **Opcode** == 3’d0: reg[dst] = reg[rs0] + imm
- **Opcode** == 3’d1: reg[dst] = reg[rs0] * imm
- **Opcode** == 3’d2: reg[dst] = reg[rs0] + reg[rs1]
- **Opcode** == 3’d3: reg[dst] = reg[rs0] * reg[rs1]
- **Opcode** == 3’d4: reg[dst] = reg[rs0] * reg[rs1] + imm

If the arithmetic operation result exceeds 32 bits, the result written in the destination register will be overlapped: for example 
- 0xFFFFFFFE + 0x2 = 0x1
- 0xFFFFFFFF * 0x2 = 0xFFFF FFFE


- Include a set of 32 RW registers mapped in next way:

| APB Address | RS0/RS1/DST address | Name   |
| ----------- | ------------------- | ------ |
| 0x0000      | 0x00                | reg[00]|
| 0x0004      | 0x01                | reg[01]|
| 0x0008      | 0x02                | reg[02]|
| 0x000C      | 0x03                | reg[03]|
| 0x0010      | 0x04                | reg[04]|
| 0x0014      | 0x05                | reg[05]|
| 0x0018      | 0x06                | reg[06]|
| 0x001C      | 0x07                | reg[07]|
| 0x0020      | 0x08                | reg[08]|
| 0x0024      | 0x09                | reg[09]|
| 0x0028      | 0x0A                | reg[10]|
| 0x002C      | 0x0B                | reg[11]|
| 0x0030      | 0x0C                | reg[12]|
| 0x0034      | 0x0D                | reg[13]|
| 0x0038      | 0x0E                | reg[14]|
| 0x003C      | 0x0F                | reg[15]|
| 0x0040      | 0x10                | reg[16]|
| 0x0044      | 0x11                | reg[17]|
| 0x0048      | 0x12                | reg[18]|
| 0x004C      | 0x13                | reg[19]|
| 0x0050      | 0x14                | reg[20]|
| 0x0054      | 0x15                | reg[21]|
| 0x0058      | 0x16                | reg[22]|
| 0x005C      | 0x17                | reg[23]|
| 0x0060      | 0x18                | reg[24]|
| 0x0064      | 0x19                | reg[25]|
| 0x0068      | 0x1A                | reg[26]|
| 0x006C      | 0x1B                | reg[27]|
| 0x0070      | 0x1C                | reg[28]|
| 0x0074      | 0x1D                | reg[29]|
| 0x0078      | 0x1E                | reg[30]|
| 0x007C      | 0x1F                | reg[31]|

## HW-SW Handshake
The HW-SW handshake will be done according to the control and status registers and the interrupt:
- **afvip_intr** – is a level output signal and can be triggered for 2 reasons:
- The module finished the instruction execution
- The module is wrong configured (unsupported opcode)
- **ev_ctrl_start** – Is an event type register and is controlled through APB. When this register is written through APB with 1, the module will start processing the configured instruction.
- **sts_intr_error** – Is a status register that can be read-only through APB. It indicates when the interrupt is raised because of an illegal configuration.
- **sts_intr_finish** – Is a status register that can be read-only through APB. It indicates when the interrupt is raised because the instruction execution is finished.
- **ev_intr_clr_err** – It is an event type register, and its job is to clear the error interrupt.
- **ev_intr_clr_finish** – It is an event type register, and its job is to clear the finish interrupt.
The HW-SW handshake for 1 instruction execution is done in 5 steps:

 **Step 1** - Configure Registers through APB (Instruction, set values)
 **Step 2** - Set start register through APB
 **Step 3** - Wait for interrupt
 **Step 4** - Read interrupt status
 **Step 5** - Clear interrupt 
The Interrupt must be raised in maximum 10 cycles from APB transfer completion of event_control_start register write-access with “1” value. (Minimum 1 cycle).


## Limitation
The configuration must be stable during the instruction execution, From start event until to the interrupt indication.
 The APB will return slave error in the next cases:
- Decoded address is unknown (Out of the address map).
- A write access was performed to a read-only register address.
- Address is misaligned at 4 bytes boundary.

## System Interface   
| Name     | Direction | Size     | Description |
| -------- | :--------: | -------- | ----------- |
| Clk      | I         | 1        | Clock     |
| rst_n    | I         | 1        | Asynchronous Reset active low      |
| afvip_intr  | O      | 1        | Interrupt   |

## APB Interface 
| Name     | Direction | Size     | Description |
| -------- | :--------: | -------- | -----------|
| psel      | I         | 1        | Select     |
| penable   | I         | 1        | Enable     |
| paddr     | I         | 16        | Addres     |
| pwrite    | I         | 1        | Direction     |
| pwdata    | I         | 32        | Write Data     |
| pready    | O         | 1        | Ready     |
| prdata    | O         | 32       | Read data     |
| pslverr   | O         | 1        | Transfer error     |
