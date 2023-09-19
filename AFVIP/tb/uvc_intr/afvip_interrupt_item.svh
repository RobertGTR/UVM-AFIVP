class afvip_interrupt_item extends uvm_sequence_item;

    byte afvip_intr;

    `uvm_object_utils_begin(afvip_interrupt_item)
        `uvm_field_int(afvip_intr,    UVM_DEFAULT)
    `uvm_object_utils_end

    function new (string name ="");
    super.new(name);
    endfunction

endclass