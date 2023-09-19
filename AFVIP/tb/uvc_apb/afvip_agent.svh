// -----------------------------------------------------------------------------
// Module name: afvip_agent
// HDL        : System Verilog
// Author     : Duca Robert
// Description: AFVIP Agent.
// Date       : 1 August, 2023
// -----------------------------------------------------------------------------
class afvip_agent extends uvm_agent;
    `uvm_component_utils(afvip_agent)

    function new(string name = "afvip_agent", uvm_component parent = null);
        super.new ( name,parent);

    endfunction

    afvip_driver        afvip_drv;
    afvip_monitor       afvip_mon;
    afvip_sequencer     afvip_seq;


    virtual function void build_phase(uvm_phase phase);
    if(get_is_active()) begin
        
        afvip_seq = afvip_sequencer::type_id::create("afvip_seq",this);
        afvip_drv = afvip_driver::type_id::create("afvip_drv",this);
        `uvm_info(get_name(),"generated an APB active agent",UVM_MEDIUM );
        end
        afvip_mon = afvip_monitor::type_id::create("afvip_monitor",this);
        endfunction

        virtual function void connect_phase(uvm_phase phase);
        if(get_is_active())
        afvip_drv.seq_item_port.connect(afvip_seq.seq_item_export);
        endfunction

endclass : afvip_agent
