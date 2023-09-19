class afvip_interrupt_agent extends uvm_agent;
    `uvm_component_utils(afvip_interrupt_agent)

    function new(string name = "afvip_interrupt_agent", uvm_component parent = null);
        super.new ( name,parent);

    endfunction
                   
    afvip_interrupt_monitor       interrupt_mon;



    virtual function void build_phase(uvm_phase phase);
       //if(get_is_active() == UVM_PASSIVE)
        interrupt_mon = afvip_interrupt_monitor ::type_id::create("interrupt_mon",this);
                `uvm_info(get_name (),"Generated interrupt_passive agent",UVM_MEDIUM);
               // end
            endfunction
        
        virtual function void connect_phase(uvm_phase phase);
      // reset_driver.seq_item_port.connect(interrupt_mon.seq_item_export);
        endfunction

endclass : afvip_interrupt_agent
