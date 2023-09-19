class reset_driver extends uvm_driver #(reset_item);
    `uvm_component_utils(reset_driver)
    
    function new(string name="reset_driver",uvm_component parent = null);
        super.new(name,parent);
        endfunction

    virtual system_if i_system_if;

    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual system_if):: get(this,"","system_if",i_system_if))begin
        `uvm_fatal(get_type_name(),"Didn't get the handle to virtual interface dut_if")
    end
    endfunction


    virtual task run_phase (uvm_phase phase);

        reset_item  i_reset_item = reset_item::type_id::create("i_reset_item",this);

        forever begin
            `uvm_info(get_type_name(), $sformatf("Waiting for data sequencer"),UVM_MEDIUM)
            seq_item_port.get_next_item(i_reset_item);
            //$display("%s",i_reset_item.sprint());
            i_system_if.rst_n <= i_reset_item.rst_n;
            seq_item_port.item_done();
            end
            
    endtask : run_phase
endclass : reset_driver
