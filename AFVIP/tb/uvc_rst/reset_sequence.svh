class reset_sequence extends uvm_sequence;
    `uvm_object_utils (reset_sequence)

    function new (string name = "reset_sequence");
        super.new (name);
    endfunction : new

    virtual task body ();
        reset_item  i_reset_item;
        i_reset_item = reset_item ::type_id::create("i_reset_item");

        start_item(i_reset_item);
        i_reset_item.rst_n=0;
        finish_item(i_reset_item);
        #20ns;
        start_item(i_reset_item);
        i_reset_item.rst_n=1;
        finish_item(i_reset_item);
    endtask : body
endclass : reset_sequence
