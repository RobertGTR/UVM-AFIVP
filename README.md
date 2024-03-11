# Test Enviorment for ARM APB with a ALU(Arhitmetic Logic Unit)
![Block diagram](./img/system_design.jpg "Block diagram of the system")

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
