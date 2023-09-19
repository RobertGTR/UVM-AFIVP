// -----------------------------------------------------------------------------
// Module name: afvip_if
// HDL        : System Verilog
// Author     : Duca Robert
// Description: APB Interface.
// Date       : 5 August, 2023
// -----------------------------------------------------------------------------
interface afvip_if
(   
      input clk,
      input rst_n
);

import uvm_pkg::*;
   `include "uvm_macros.svh"

    wire        psel;
    wire        penable;
    wire[15:0]  paddr;
    wire        pwrite;
    wire[31:0]  pwdata;
    wire         pready;
    wire [31:0]  prdata;
    wire         pslverr;
clocking cb_drv@(posedge i_system_if.clk);

    output        psel;
    output        penable;
    output        paddr;
    output        pwrite;
    output        pwdata;
    input         pready;
    input         prdata;
    input         pslverr;
endclocking


clocking cb_mon@(posedge i_system_if.clk);
    input        psel;
    input        penable;
    input        paddr;
    input        pwrite;
    input        pwdata;
    input        pready;
    input        prdata;
    input        pslverr;
endclocking


property assert_psel;
    @ (psel)
    (psel |-> penable);
endproperty : assert_psel

assert property (assert_psel)   `uvm_info ("Assertions", $sformatf ("[assert_psel] Running Good"), UVM_NONE)
else                            `uvm_error("Assertions", $sformatf ("[assert_psel] psel isn't working"))




property  assert_write_state;
@(posedge clk) disable iff(!rst_n)
 (pready & penable ) |-> ($stable(pwdata));
endproperty : assert_write_state 


assert property (assert_write_state)  `uvm_info ("Assertions", $sformatf ("[assert_write_state] Running Good"), UVM_NONE)
else                                  `uvm_error("Assertions", $sformatf ("[assert_write_state] write state bad"))
                                   

property  assert_read_state;
    @(posedge clk) disable iff(!rst_n)
     (pready & penable  & !pwrite ) |-> ($stable(pwdata));
    endproperty : assert_read_state 

    assert property (assert_read_state)  `uvm_info ("Assertions", $sformatf ("[assert_write_state] Running Good"), UVM_NONE)
else                                  `uvm_error("Assertions", $sformatf ("[assert_write_state] read state bad"))


endinterface