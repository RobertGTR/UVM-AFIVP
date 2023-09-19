// -----------------------------------------------------------------------------
// Module name: afvip_monitor
// HDL        : System Verilog
// Author     : Duca Robert
// Description: Monitor for AFVIP.
// Date       : 5 August, 2023
// -----------------------------------------------------------------------------
class afvip_monitor extends uvm_monitor;
    `uvm_component_utils(afvip_monitor)

    function new(string name = "afvip_monitor",uvm_component parent = null);
    super.new(name, parent);
    endfunction

    virtual afvip_if  i_afvip_if;

        uvm_analysis_port #(afvip_item) mon_analysis_port;

        virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            mon_analysis_port = new("mon_analysis_port",this);
                if(!uvm_config_db #(virtual afvip_if)::get(this,"","afvip_if",i_afvip_if)) begin
                    `uvm_error(get_type_name(),"DUT interface not found")
                end
            endfunction

            virtual task run_phase(uvm_phase phase);
                afvip_item  afvip_item_obj = afvip_item::type_id::create("afvip_item_obj",this);

                    forever begin
                        @(i_afvip_if.cb_mon iff (i_afvip_if.cb_mon.psel &
                        i_afvip_if.cb_mon.penable & i_afvip_if.cb_mon.pready));
                        afvip_item_obj.psel =           i_afvip_if.psel;
                        afvip_item_obj.penable =     i_afvip_if.penable;
                        afvip_item_obj.paddr  =        i_afvip_if.paddr;
                        afvip_item_obj.pwrite =       i_afvip_if.pwrite;
                        afvip_item_obj.prdata =       i_afvip_if.prdata;
                        afvip_item_obj.pwdata =       i_afvip_if.pwdata;

                        if(i_afvip_if.cb_mon.paddr==16'h80) begin
                        afvip_item_obj.opcode = i_afvip_if.pwdata[2:0];
                        afvip_item_obj.rs0    = i_afvip_if.pwdata[7:3];
                        afvip_item_obj.rs1    = i_afvip_if.pwdata[12:8];
                        afvip_item_obj.dst    = i_afvip_if.pwdata[20:16];
                        afvip_item_obj.imm    = i_afvip_if.pwdata[31:24];
                        end
                        `uvm_info("Monitor",$sformatf("Saw item%s",afvip_item_obj.sprint()),UVM_NONE)
                          mon_analysis_port.write(afvip_item_obj);

                    end 
            endtask
endclass : afvip_monitor