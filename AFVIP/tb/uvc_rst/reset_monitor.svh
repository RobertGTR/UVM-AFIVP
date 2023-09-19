class reset_monitor extends uvm_monitor;
    `uvm_component_utils(reset_monitor)

    function new(string name = "reset_monitor",uvm_component parent = null);
    super.new(name, parent);
    endfunction

    virtual system_if  i_system_if;

        uvm_analysis_port #(reset_item) reset_mon_analysis_port;

        virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            reset_mon_analysis_port = new("reset_mon_analysis_port",this);
                if(!uvm_config_db #(virtual system_if)::get(this,"","system_if",i_system_if)) begin
                    `uvm_error(get_type_name(),"DUT interface not found")
                end
            endfunction

            virtual task run_phase(uvm_phase phase);
                reset_item  reset_item_obj = reset_item::type_id::create("reset_item_obj",this);

               // @(negedge i_system_if.cb_mon_system.rst_n);
                //reset_item_obj.rst_n=i_system_if.cb_mon_system.rst_n;
               // reset_mon_analysis_port.write(reset_item_obj);
               // `uvm_info(get_type_name(), $sformatf("Reset monitor item: %s",reset_item_obj.sprint()),UVM_NONE)


            endtask
endclass : reset_monitor