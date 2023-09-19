class reset_agent extends uvm_agent;
    `uvm_component_utils(reset_agent)

    function new(string name = "reset_agent", uvm_component parent = null);
        super.new ( name,parent);

    endfunction

    reset_driver        reset_drv;
    reset_monitor       reset_mon;
    reset_sequencer     reset_seq;


    virtual function void build_phase(uvm_phase phase);
    if(get_is_active()) begin
 
        reset_drv = reset_driver::type_id::create("reset_drv",this);
        reset_seq = reset_sequencer::type_id::create("reset_seq",this);
        `uvm_info(get_name (),"Generated reset agent",UVM_MEDIUM);
            end
        reset_mon = reset_monitor::type_id::create("reset_mon",this);
        endfunction
          
        virtual function void connect_phase(uvm_phase phase);
            if(get_is_active())
        reset_drv.seq_item_port.connect(reset_seq.seq_item_export);
        endfunction

endclass : reset_agent
