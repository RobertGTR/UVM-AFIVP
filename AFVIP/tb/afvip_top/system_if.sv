// -----------------------------------------------------------------------------
// Module name: system_if
// HDL        : System Verilog
// Author     : Duca Robert
// Description: System Interface.
// Date       : 5 August, 2023
// -----------------------------------------------------------------------------
interface system_if
(
    input clk
);

import uvm_pkg::*;
    logic rst_n;
    logic afvip_intr;


clocking cb_mon_intrr_system@(posedge clk);
    input afvip_intr;
endclocking


endinterface : system_if