// -----------------------------------------------------------------------------
// Module name: afvip_sequencer
// HDL        : System Verilog
// Author     : Duca Robert
// Description: Sequencer for AFVIP.
// Date       : 5 August, 2023
// -----------------------------------------------------------------------------
class afvip_sequencer extends uvm_sequencer#(afvip_item);
    `uvm_component_utils(afvip_sequencer)
    function new(string name="afvip_sequencer", uvm_component parent);
    super.new(name,parent);
    endfunction
    
endclass