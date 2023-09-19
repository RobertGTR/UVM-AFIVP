 
 // -----------------------------------------------------------------------------
// Module name: my_scoreboard
// HDL        : System Verilog
// Author     : Duca Robert
// Description: Scoreboard for AFVIP.
// Date       : 5 August, 2023
// -----------------------------------------------------------------------------
 `uvm_analysis_imp_decl(_apb)
 `uvm_analysis_imp_decl(_reset)
 `uvm_analysis_imp_decl(_interr)

class my_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(my_scoreboard)

    function new (string name="my_scoreboard",uvm_component parent=null);
    super.new(name,parent);
    endfunction

    uvm_analysis_imp_apb    #(afvip_item,my_scoreboard)ap_imp_afvip;
    uvm_analysis_imp_reset  #(reset_item,my_scoreboard)ap_imp_reset;
    uvm_analysis_imp_interr #(afvip_interrupt_item,my_scoreboard)ap_imp_interr;
    
    function void build_phase(uvm_phase phase);
        ap_imp_afvip  =   new("ap_imp_afvip",this);
        ap_imp_reset  =   new("ap_imp_reset",this);
        ap_imp_interr =   new("ap_imp_interr",this);
    endfunction

    bit[31:0] expected_addr[32];
    bit[31:0] expected_addr_test[32];

    bit [2:0] expected_opcode;
    bit [4:0] expected_rs0;
    bit [4:0] expected_rs1;
    bit [4:0] expected_dst;
    bit [7:0] expected_imm;
    
    virtual function void write_apb (afvip_item item_afvip);
        if(item_afvip.paddr [1:0]!=0)
        `uvm_error("\nScoreboard",$sformatf("\nIs paddr cannot be divided by 4",item_afvip.paddr))
        
        if(item_afvip.psel && item_afvip.penable && item_afvip.pwrite && item_afvip.paddr < 125) begin
    expected_addr[item_afvip.paddr / 4] = item_afvip.pwdata;
        end

    expected_addr_test[item_afvip.paddr / 4] = item_afvip.prdata;

        if (item_afvip.pwrite && item_afvip.paddr == 16'h80) begin
    expected_opcode = item_afvip.pwdata[2:0];
    expected_rs0    = item_afvip.pwdata[7:3];
    expected_rs1    = item_afvip.pwdata[12:8];
    expected_dst    = item_afvip.pwdata[20:16];
    expected_imm    = item_afvip.pwdata[31:24];
        end
        
        if(!item_afvip.pwrite && item_afvip.paddr < 125)begin
            

            if(expected_opcode==0)
            expected_addr[expected_dst]=expected_addr[expected_rs0] + expected_imm;

            if(expected_opcode==1)
            expected_addr[expected_dst]=expected_addr[expected_rs0] * expected_imm;

            if(expected_opcode==2)
            expected_addr[expected_dst]=expected_addr[expected_rs0] + expected_addr[expected_rs1];

            if(expected_opcode==3)
            expected_addr[expected_dst]=expected_addr[expected_rs0] * expected_addr[expected_rs1];

            if(expected_opcode==4)
            expected_addr[expected_dst]=expected_addr[expected_rs0] * expected_addr[expected_rs1]+ expected_imm;
       

        if(expected_addr[item_afvip.paddr / 4]==expected_addr_test[item_afvip.paddr / 4])  begin
       // $display("Opcode:%d, RS0:%h, RS1:%h, DST:%h, IMM:%d",item_afvip.opcode,item_afvip.rs0,item_afvip.rs1,item_afvip.dst,item_afvip.imm);
        `uvm_info("Scoreboard",$sformatf("Data received = %h, Data expected=%h",expected_addr_test[item_afvip.paddr / 4],expected_addr[item_afvip.paddr / 4]),UVM_MEDIUM)
        end
        else
        `uvm_error("Scoreboard",$sformatf("Data received = %h, Data expected=%h",expected_addr_test[item_afvip.paddr / 4],expected_addr[item_afvip.paddr / 4]))

    end     
    endfunction
    
     virtual function void write_reset (reset_item item_reset);
        //`uvm_info("Scoreboard",$sformatf("Data received = %s",item_reset.sprint()),UVM_MEDIUM)

                    
    endfunction
    
    virtual function void write_interr (afvip_interrupt_item item_interrupt);
        //`uvm_info("Scoreboard",$sformatf("Data received = %s",item_interrupt.sprint()),UVM_MEDIUM)

                    
    endfunction
    
        virtual task run_phase(uvm_phase phase);


        
        endtask:run_phase

    endclass : my_scoreboard