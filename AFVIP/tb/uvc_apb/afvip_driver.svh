// -----------------------------------------------------------------------------
// Module name: afvip_driver
// HDL        : System Verilog
// Author     : Duca Robert
// Description: Driver for AFVIP.
// Date       : 5 August, 2023
// -----------------------------------------------------------------------------
class afvip_driver extends uvm_driver #(afvip_item);
    `uvm_component_utils(afvip_driver)
   
    function new(string name="afvip_driver",uvm_component parent = null);
        super.new(name,parent);
        endfunction

    virtual afvip_if i_afvip_if;

    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual afvip_if):: get(this,"","afvip_if",i_afvip_if))begin
        `uvm_fatal(get_type_name(),"Didn't get the handle to virtual interface dut_if")
    end
    endfunction

    virtual task run_phase (uvm_phase phase);

        afvip_item afvip_i_item;
        
        @(posedge i_afvip_if.rst_n);
        forever begin
            `uvm_info(get_type_name(), $sformatf("Waiting for data sequencer"),UVM_MEDIUM)
            seq_item_port.get_next_item(afvip_i_item);
           
             i_afvip_if.cb_drv.psel<=1;
            
            
            i_afvip_if.cb_drv.paddr  <=        afvip_i_item.paddr;
            i_afvip_if.cb_drv.pwrite <=       afvip_i_item.pwrite;
            i_afvip_if.cb_drv.pwdata <=       afvip_i_item.pwdata;
            


            @(i_afvip_if.cb_drv iff i_afvip_if.cb_mon.psel)
            i_afvip_if.cb_drv.penable<=1;
           @(i_afvip_if.cb_drv iff i_afvip_if.cb_mon.pready)
            i_afvip_if.cb_drv.penable<=0;
            i_afvip_if.cb_drv.psel<=0;
            @(i_afvip_if.cb_drv)
            i_afvip_if.cb_drv.psel<=1;
            @(i_afvip_if.cb_drv)

            $display("%s", afvip_i_item.sprint());
            seq_item_port.item_done();
        end

    endtask
endclass : afvip_driver
