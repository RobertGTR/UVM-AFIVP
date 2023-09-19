// -----------------------------------------------------------------------------
// Module name: afvip_item
// HDL        : System Verilog
// Author     : Duca Robert
// Description: Items for afvip.
// Date       : 5 August, 2023
// -----------------------------------------------------------------------------
class afvip_item extends uvm_sequence_item;

    rand bit            psel;
    rand bit         penable;
    rand bit [15:0]    paddr;
    rand bit          pwrite;
    rand bit [31:0]   prdata;
    rand bit [31:0]   pwdata;
    rand bit [2:0]    opcode;
    rand bit [4:0]       rs0;
    rand bit [4:0]       rs1;
    rand bit [4:0]       dst;
    rand bit [7:0]       imm;

    `uvm_object_utils_begin(afvip_item)
        `uvm_field_int(psel,      UVM_DEFAULT)
        `uvm_field_int(penable,   UVM_DEFAULT)    
        `uvm_field_int(paddr,     UVM_DEFAULT)
        `uvm_field_int(pwrite,    UVM_DEFAULT)
        `uvm_field_int(prdata,    UVM_DEFAULT)
        `uvm_field_int(pwdata,    UVM_DEFAULT)
        `uvm_field_int(opcode,    UVM_DEFAULT)
        `uvm_field_int(rs0,    UVM_DEFAULT)
        `uvm_field_int(rs1,    UVM_DEFAULT)
        `uvm_field_int(dst,    UVM_DEFAULT)
        `uvm_field_int(imm,    UVM_DEFAULT)
    `uvm_object_utils_end

    function new (string name =" ");
    super.new(name);
    endfunction

endclass : afvip_item