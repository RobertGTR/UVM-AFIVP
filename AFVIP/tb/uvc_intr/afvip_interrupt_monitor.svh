class afvip_interrupt_monitor extends uvm_monitor;
    `uvm_component_utils(afvip_interrupt_monitor)

    function new(string name = "afvip_interrupt_monitor",uvm_component parent = null);
    super.new(name, parent);
    endfunction

    virtual system_if  i_system_if;

        uvm_analysis_port #(afvip_interrupt_item) interr_mon_analysis_port;


        virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    
            interr_mon_analysis_port = new("interr_mon_analysis_port",this);
                if(!uvm_config_db #(virtual system_if)::get(this,"","system_if",i_system_if)) begin
                    `uvm_error(get_type_name(),"System interface not found")
                end
            endfunction

            virtual task run_phase(uvm_phase phase);
                afvip_interrupt_item  afvip_interrupt_item_obj = afvip_interrupt_item::type_id::create("afvip_interrupt_item_obj",this);

                
            endtask : run_phase
endclass : afvip_interrupt_monitor