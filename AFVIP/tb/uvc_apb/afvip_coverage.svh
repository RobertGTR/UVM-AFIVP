// -----------------------------------------------------------------------------
// Module name: afvip_coverage
// HDL        : System Verilog
// Author     : Duca Robert
// Description: Coverage percentage information and database storage.
// Date       : 22 August, 2023
// -----------------------------------------------------------------------------
class afvip_coverage extends uvm_subscriber #(afvip_item);
    `uvm_component_utils (afvip_coverage)
    // Constructor
    function new (string name = "afvip_coverage", uvm_component parent);
        super.new (name, parent);
        cg_addr = new ();
        cg_instruction_list = new ();
        cg_data= new ();
      endfunction

    // Local storage variable declaration
    real ep_cov;
    real instruction_list_cov;
    real data_cov;
    
    // APB item handle
    afvip_item cov_afvip_item;
    // Address covergroup
    covergroup cg_addr;
        PADDR: coverpoint cov_afvip_item.paddr {
            
            bins reg00 = {'h00};
            bins reg01 = {'h04};
            bins reg02 = {'h08};
            bins reg03 = {'h0C};
            bins reg04 = {'h10};
            bins reg05 = {'h14};
            bins reg06 = {'h18};
            bins reg07 = {'h1C};
            bins reg08 = {'h20};
            bins reg09 = {'h24};
            bins reg10 = {'h28};
            bins reg12 = {'h2C};
            bins reg13 = {'h30};
            bins reg14 = {'h34};
            bins reg15 = {'h38};
            bins reg16 = {'h40};
            bins reg17 = {'h44};
            bins reg18 = {'h48};
            bins reg19 = {'h4C};
            bins reg20 = {'h50};
            bins reg21 = {'h54};
            bins reg22 = {'h58};
            bins reg23 = {'h5C};
            bins reg24 = {'h60};
            bins reg25 = {'h64};
            bins reg26 = {'h68};
            bins reg27 = {'h6C};
            bins reg28 = {'h70};
            bins reg29 = {'h74};
            bins reg30 = {'h78};
            bins reg31 = {'h7C};
        }
    endgroup : cg_addr

     covergroup cg_instruction_list;
        OPCODE : coverpoint cov_afvip_item.opcode {
            bins opcode0 = {0};
            bins opcode1 = {1};
            bins opcode2 = {2};
            bins opcode3 = {3};       
            bins opcode4 = {4};    
        }
        /*
        RS0 : coverpoint cov_afvip_item.pwdata[7:3] {
            bins RS0_0 = {'h00};
            bins RS0_1 = {'h01};
            bins RS0_2 = {'h02};
            bins RS0_3 = {'h03};
            bins RS0_4 = {'h04};
            bins RS0_5 = {'h05};
            bins RS0_6 = {'h06};
            bins RS0_7 = {'h07};
            bins RS0_8 = {'h08};
            bins RS0_9 = {'h09};
            bins RS0_10 = {'h0A};
            bins RS0_11 = {'h0B};
            bins RS0_12 = {'h0C};
            bins RS0_13 = {'h0D};
            bins RS0_14 = {'h0E};
            bins RS0_15 = {'h0F};
            bins RS0_16 = {'h10};
            bins RS0_17 = {'h11};
            bins RS0_18 = {'h12};
            bins RS0_19 = {'h13};
            bins RS0_20 = {'h14};
            bins RS0_21 = {'h15};
            bins RS0_22 = {'h16};
            bins RS0_23 = {'h17};
            bins RS0_24 = {'h18};
            bins RS0_25 = {'h19};
            bins RS0_26 = {'h1A};
            bins RS0_27 = {'h1B};
            bins RS0_28 = {'h1C};
            bins RS0_29 = {'h1D};
            bins RS0_30 = {'h1E};
            bins RS0_31 = {'h1F};          
        }

        RS1 : coverpoint cov_afvip_item.pwdata[12:8] {
            bins RS1_0 = {'h00};
            bins RS1_1 = {'h01};
            bins RS1_2 = {'h02};
            bins RS1_3 = {'h03};
            bins RS1_4 = {'h04};
            bins RS1_5 = {'h05};
            bins RS1_6 = {'h06};
            bins RS1_7 = {'h07};
            bins RS1_8 = {'h08};
            bins RS1_9 = {'h09};
            bins RS1_10 = {'h0A};
            bins RS1_11 = {'h0B};
            bins RS1_12 = {'h0C};
            bins RS1_13 = {'h0D};
            bins RS1_14 = {'h0E};
            bins RS1_15 = {'h0F};
            bins RS1_16 = {'h10};
            bins RS1_17 = {'h11};
            bins RS1_18 = {'h12};
            bins RS1_19 = {'h13};
            bins RS1_20 = {'h14};
            bins RS1_21 = {'h15};
            bins RS1_22 = {'h16};
            bins RS1_23 = {'h17};
            bins RS1_24 = {'h18};
            bins RS1_25 = {'h19};
            bins RS1_26 = {'h1A};
            bins RS1_27 = {'h1B};
            bins RS1_28 = {'h1C};
            bins RS1_29 = {'h1D};
            bins RS1_30 = {'h1E};
            bins RS1_31 = {'h1F};          
        }

         DST : coverpoint cov_afvip_item.pwdata[20:16] {
            bins DST0 = {'h00};
            bins DST1 = {'h01};
            bins DST2 = {'h02};
            bins DST3 = {'h03};
            bins DST4 = {'h04};
            bins DST5 = {'h05};
            bins DST6 = {'h06};
            bins DST7 = {'h07};
            bins DST8 = {'h08};
            bins DST9 = {'h09};
            bins DST10 = {'h0A};
            bins DST11 = {'h0B};
            bins DST12 = {'h0C};
            bins DST13 = {'h0D};
            bins DST14 = {'h0E};
            bins DST15 = {'h0F};
            bins DST16 = {'h10};
            bins DST17 = {'h11};
            bins DST18 = {'h12};
            bins DST19 = {'h13};
            bins DST20 = {'h14};
            bins DST21 = {'h15};
            bins DST22 = {'h16};
            bins DST23 = {'h17};
            bins DST24 = {'h18};
            bins DST25 = {'h19};
            bins DST26 = {'h1A};
            bins DST27 = {'h1B};
            bins DST28 = {'h1C};
            bins DST29 = {'h1D};
            bins DST30 = {'h1E};
            bins DST31 = {'h1F};          
        }

        IMM : coverpoint cov_afvip_item.pwdata[31:24] {
            bins IMM0 = {'h00};
            bins IMM1 = {'h01};
            bins IMM2 = {'h02};
            bins IMM3 = {'h03};
            bins IMM4 = {'h04};
            bins IMM5 = {'h05};
            bins IMM6 = {'h06};
            bins IMM7 = {'h07};
            bins IMM8 = {'h08};
            bins IMM9 = {'h09};
            bins IMM10 = {'h0A};
            bins IMM11 = {'h0B};
            bins IMM12 = {'h0C};
            bins IMM13 = {'h0D};
            bins IMM14 = {'h0E};
            bins IMM15 = {'h0F};
            bins IMM16 = {'h10};
            bins IMM17 = {'h11};
            bins IMM18 = {'h12};
            bins IMM19 = {'h13};
            bins IMM20 = {'h14};
            bins IMM21 = {'h15};
            bins IMM22 = {'h16};
            bins IMM23 = {'h17};
            bins IMM24 = {'h18};
            bins IMM25 = {'h19};
            bins IMM26 = {'h1A};
            bins IMM27 = {'h1B};
            bins IMM28 = {'h1C};
            bins IMM29 = {'h1D};
            bins IMM30 = {'h1E};
            bins IMM31 = {'h1F};          
        } */
        //instruction_format: cross OPCODE, RS0, RS1, DST, IMM;
    
    endgroup : cg_instruction_list

    covergroup cg_data;
        DATA:coverpoint cov_afvip_item.pwdata{

            bins minvalue[32]={[32'h00000000:32'h0000FFFF]};
            bins midvalue[32]={[32'h00000000:32'h00FFFFFF]};
            bins maxvalue[32]={[32'h00000000:32'hFFFFFFFF]};
        }
    endgroup:cg_data

    function void write (afvip_item t);
        cov_afvip_item = t;
        cg_addr.sample ();
        cg_instruction_list.sample();
        cg_data.sample();
    endfunction : write
    
    function void extract_phase (uvm_phase phase);
        super.extract_phase (phase);
        ep_cov = cg_addr.get_coverage ();
        instruction_list_cov = cg_instruction_list.get_coverage();
        data_cov = cg_data.get_coverage();
    endfunction : extract_phase
    



    function void report_phase (uvm_phase phase);
        super.report_phase (phase);
        `uvm_info ("AFVIP Reg Coverage", $sformatf ("Coverage is %0.2f", ep_cov), UVM_MEDIUM)
        `uvm_info ("OPCODE Coverage", $sformatf ("Coverage is %0.2f", instruction_list_cov), UVM_MEDIUM)
        `uvm_info ("PWDATA Coverage", $sformatf ("Coverage is %0.00000002f", data_cov), UVM_MEDIUM)

    endfunction : report_phase
    
endclass : afvip_coverage