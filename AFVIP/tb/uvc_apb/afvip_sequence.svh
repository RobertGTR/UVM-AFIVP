// -----------------------------------------------------------------------------
// Module name: afvip_sequence
// HDL        : System Verilog
// Author     : Duca Robert
// Description: Seuqences for AFVIP tests.
// Date       : 5 August, 2023
// -----------------------------------------------------------------------------
class afvip_base_sequence extends uvm_sequence;
    `uvm_object_utils (afvip_base_sequence)

    function new (string name = "afvip_base_sequence");
        super.new (name);
    endfunction : new

    virtual task body ();
    endtask : body
endclass : afvip_base_sequence


class afvip_sequence extends afvip_base_sequence;

    `uvm_object_utils (afvip_sequence)


    function new (string name = "afvip_sequence");
        super.new (name);
    endfunction : new


    virtual task body ();

        afvip_item afvip_i_item;
        afvip_i_item = afvip_item::type_id::create("afvip_i_item");
        for (int i = 0; i < 32; i++) begin
        start_item (afvip_i_item);
        //if (!(req_ack_item.randomize() with {meta_data inside {[1:10]};}))
        //
        
       if (!(afvip_i_item.randomize() with {
       paddr[1:0]==0;
       paddr inside{[0:16'h7C]};
       pwrite==1;
       pwdata == (i+4);}))
       
        `uvm_error (get_type_name (), "Rand error!")
        finish_item (afvip_i_item);

        start_item (afvip_i_item);
        afvip_i_item.pwrite = 0;
        finish_item (afvip_i_item);

        end
    endtask : body
endclass : afvip_sequence


class afvip_sequence_read_all extends afvip_base_sequence;

    `uvm_object_utils (afvip_sequence_read_all)


    function new (string name = "afvip_sequence_read_all");
        super.new (name);
    endfunction : new


    virtual task body ();

        afvip_item afvip_i_item;
        afvip_i_item = afvip_item::type_id::create("afvip_i_item");
        for (int i = 0; i < 32; i++) begin
        start_item (afvip_i_item);
        //if (!(req_ack_item.randomize() with {meta_data inside {[1:10]};}))
        //
        
       if (!(afvip_i_item.randomize() with {
        paddr[1:0]==0;
        paddr inside{[0:16'h7C]};
        pwrite==0;
        pwdata == (i+4);}))
       
        `uvm_error (get_type_name (), "Rand error!")
        finish_item (afvip_i_item);

        //start_item (afvip_i_item);
        //afvip_i_item.pwrite = 0;
        //finish_item (afvip_i_item);

        end
    endtask : body
endclass : afvip_sequence_read_all


class afvip_sequence_write_all extends afvip_base_sequence;

    `uvm_object_utils (afvip_sequence_write_all)


    function new (string name = "afvip_sequence_write_all");
        super.new (name);
    endfunction : new


    virtual task body ();

        afvip_item afvip_i_item;
        afvip_i_item = afvip_item::type_id::create("afvip_i_item");
        for (int i = 0; i < 32; i++) begin
        start_item (afvip_i_item);
        //if (!(req_ack_item.randomize() with {meta_data inside {[1:10]};}))
        //
        
       if (!(afvip_i_item.randomize() with {
        paddr[1:0]==0;
        paddr inside{[0:16'h7C]};
        pwrite==1;
        pwdata == (i+4);}))
       
        `uvm_error (get_type_name (), "Rand error!")
        finish_item (afvip_i_item);
        /*
        start_item (afvip_i_item);
        afvip_i_item.pwrite = 1;
        finish_item (afvip_i_item);
        */
        end
    endtask : body
endclass : afvip_sequence_write_all



class afvip_sequence_config extends afvip_base_sequence;

    `uvm_object_utils (afvip_sequence_config)


    function new (string name = "afvip_sequence_config");
        super.new (name);
    endfunction : new


    virtual task body ();

        afvip_item afvip_i_item;
        afvip_i_item = afvip_item::type_id::create("afvip_i_item");
       
        start_item (afvip_i_item);
        afvip_i_item.paddr = 16'h00;
        afvip_i_item.pwdata = 5;
        afvip_i_item.pwrite = 1;
        finish_item (afvip_i_item);

        start_item (afvip_i_item);
        afvip_i_item.paddr = 16'h04;
        afvip_i_item.pwdata = 2;
        afvip_i_item.pwrite = 1;
        finish_item (afvip_i_item);

        start_item (afvip_i_item);
        afvip_i_item.paddr=16'h80;
        afvip_i_item.pwdata[2:0] = 2;          //opcode
        afvip_i_item.pwdata[7:3] = 0;          //rs0
        afvip_i_item.pwdata[12:8] = 1;         //rs1
        afvip_i_item.pwdata[20:16] = 2;        //dst
        afvip_i_item.pwdata[31:24] = 5;        //imm
        afvip_i_item.pwrite=1;
        finish_item (afvip_i_item);

        start_item (afvip_i_item);           // Start Operation
        afvip_i_item.paddr = 16'h8C;
        afvip_i_item.pwdata = 1;
        afvip_i_item.pwrite = 1;
        finish_item (afvip_i_item);  

        start_item (afvip_i_item);           // Read Interrupt
        afvip_i_item.paddr = 16'h84;
        afvip_i_item.pwrite = 0;
        finish_item (afvip_i_item);           


        start_item (afvip_i_item);           // Clear Interrupt
        afvip_i_item.paddr = 16'h88;
        afvip_i_item.pwdata = 2;
        afvip_i_item.pwrite = 1;
        finish_item (afvip_i_item);  

        start_item (afvip_i_item);           // Read Dst
        afvip_i_item.paddr = 16'h08;
        afvip_i_item.pwrite = 0;
        finish_item (afvip_i_item);  

    endtask : body
endclass : afvip_sequence_config


class afvip_functional_sequence extends afvip_base_sequence;

    `uvm_object_utils (afvip_functional_sequence)


    function new (string name = "afvip_functional_sequence");
        super.new (name);
    endfunction : new


    virtual task body ();

        afvip_item afvip_i_item;
        afvip_i_item = afvip_item::type_id::create("afvip_i_item");
       
        for(int i=2; i<=31; i++)
        begin
        start_item (afvip_i_item);
        afvip_i_item.paddr = 16'h00;        //set rs0 value on h00
        afvip_i_item.pwdata = 5;
        afvip_i_item.pwrite = 1;
        finish_item (afvip_i_item);

        start_item (afvip_i_item);
        afvip_i_item.paddr = 16'h04;        //set rs1 value on h04
        afvip_i_item.pwdata = 2;
        afvip_i_item.pwrite = 1;
        finish_item (afvip_i_item);

        start_item (afvip_i_item);
        afvip_i_item.paddr=16'h80;             //config register
        afvip_i_item.pwdata[2:0] = 2;          //opcode
        afvip_i_item.pwdata[7:3] = 0;          //rs0
        afvip_i_item.pwdata[12:8] = 1;         //rs1
        afvip_i_item.pwdata[20:16] = i;        //dst
        afvip_i_item.pwdata[31:24] = 5;        //imm
        afvip_i_item.pwrite=1;
        finish_item (afvip_i_item);

        start_item (afvip_i_item);           // Start Operation
        afvip_i_item.paddr = 16'h8C;
        afvip_i_item.pwdata = 1;
        afvip_i_item.pwrite = 1;
        finish_item (afvip_i_item);  

        start_item (afvip_i_item);           // Read Interrupt
        afvip_i_item.paddr = 16'h84;
        afvip_i_item.pwrite = 0;
        finish_item (afvip_i_item);           


        start_item (afvip_i_item);           // Clear Interrupt
        afvip_i_item.paddr = 16'h88;
        afvip_i_item.pwdata = 2;
        afvip_i_item.pwrite = 1;
        finish_item (afvip_i_item);  

        start_item (afvip_i_item);           // Read Dst
        afvip_i_item.paddr = i*4;
        afvip_i_item.pwrite = 0;
        finish_item (afvip_i_item);  
    end

    endtask : body
endclass : afvip_functional_sequence

class afvip_random_sequence extends afvip_base_sequence;

    `uvm_object_utils (afvip_random_sequence)


    function new (string name = "afvip_random_sequence");
        super.new (name);
    endfunction : new


    virtual task body ();

        afvip_item afvip_i_item;
        afvip_i_item = afvip_item::type_id::create("afvip_i_item");
       
        for(int i=2; i<=5000; i++)
        begin
        start_item (afvip_i_item);
        afvip_i_item.paddr = 16'h00;
        afvip_i_item.pwdata = $urandom_range(1,10);
        afvip_i_item.pwrite = 1;
        finish_item (afvip_i_item);

        start_item (afvip_i_item);
        afvip_i_item.paddr = 16'h04;
        afvip_i_item.pwdata = $urandom_range(12,2000000);
        afvip_i_item.pwrite = 1;
        finish_item (afvip_i_item);

        start_item (afvip_i_item);
        afvip_i_item.paddr=16'h80;
        afvip_i_item.pwdata[2:0] = 2;          //opcode
        afvip_i_item.pwdata[7:3] = 0;          //rs0
        afvip_i_item.pwdata[12:8] = 1;         //rs1
        afvip_i_item.pwdata[20:16] = i;        //dst
        afvip_i_item.pwdata[31:24] = 5;        //imm
        afvip_i_item.pwrite=1;
        finish_item (afvip_i_item);

        start_item (afvip_i_item);           // Start Operation
        afvip_i_item.paddr = 16'h8C;
        afvip_i_item.pwdata = 1;
        afvip_i_item.pwrite = 1;
        finish_item (afvip_i_item);  

        start_item (afvip_i_item);           // Read Interrupt
        afvip_i_item.paddr = 16'h84;
        afvip_i_item.pwrite = 0;
        finish_item (afvip_i_item);           


        start_item (afvip_i_item);           // Clear Interrupt
        afvip_i_item.paddr = 16'h88;
        afvip_i_item.pwdata = 2;
        afvip_i_item.pwrite = 1;
        finish_item (afvip_i_item);  

        if(i<32)begin
        start_item (afvip_i_item);           // Read Dst
        afvip_i_item.paddr = i*4;
        afvip_i_item.pwrite = 0;
        finish_item (afvip_i_item);
        end  
    end

    endtask : body
endclass : afvip_random_sequence