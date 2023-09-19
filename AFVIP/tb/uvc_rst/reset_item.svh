class reset_item extends uvm_sequence_item;

    rand bit rst_n;

    `uvm_object_utils_begin(reset_item)
        `uvm_field_int(rst_n,    UVM_DEFAULT)
    `uvm_object_utils_end

    function new (string name =" ");
    super.new(name);
    endfunction

endclass