class reset_sequencer extends uvm_sequencer#(reset_item);
    `uvm_component_utils(reset_sequencer)
    function new(string name="reset_sequencer", uvm_component parent);
    super.new(name,parent);
    endfunction
    
endclass : reset_sequencer