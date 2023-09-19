// -----------------------------------------------------------------------------
// Module name: afvip_test
// HDL        : System Verilog
// Author     : Duca Robert
// Description: Test library for AFVIP.
// Date       : 5 August, 2023
// -----------------------------------------------------------------------------
class afvip_base_test extends uvm_test;
    `uvm_component_utils(afvip_base_test)

    afvip_env   afvip_env_top;

    function new (string name="afvip_base_test", uvm_component parent = null);
        super.new(name,parent);
    endfunction


        virtual function  void build_phase (uvm_phase phase);
        afvip_env_top=afvip_env::type_id::create("afvip_env_top",this);
        endfunction

        virtual task run_phase (uvm_phase phase);
        //
        endtask : run_phase

    endclass:afvip_base_test


    class afvip_read_all_test extends afvip_base_test;
    `uvm_component_utils(afvip_read_all_test)
     

    function new (string name="afvip_read_all_test", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    afvip_env   afvip_env_top;
    
    virtual function  void build_phase (uvm_phase phase);
        afvip_env_top=afvip_env::type_id::create("afvip_env_top",this);
    endfunction

    virtual task run_phase (uvm_phase phase);

        //afvip_sequence i_afvip_sequence;
        afvip_sequence_read_all i_afvip_sequence_read_all;
        reset_sequence         i_reset_sequence;
        i_afvip_sequence_read_all = afvip_sequence_read_all::type_id::create ("i_afvip_sequence_read_all");
        i_reset_sequence = reset_sequence::type_id::create ("i_reset_sequence");
        phase.raise_objection (this);
        i_afvip_sequence_read_all.start (afvip_env_top.env_afvip_agent.afvip_seq);
        i_reset_sequence.start(afvip_env_top.env_reset_agent.reset_seq); 
        phase.drop_objection (this);

    endtask : run_phase
endclass : afvip_read_all_test

class afvip_write_all_test extends afvip_base_test;
    `uvm_component_utils(afvip_write_all_test)

    function new (string name="afvip_write_all_test", uvm_component parent = null);
        super.new(name,parent);
    endfunction
    
    virtual function  void build_phase (uvm_phase phase);
        afvip_env_top=afvip_env::type_id::create("afvip_env_top",this);
    endfunction

    virtual task run_phase (uvm_phase phase);
        afvip_sequence_write_all i_afvip_sequence_write_all;
        reset_sequence         i_reset_sequence;
        i_afvip_sequence_write_all = afvip_sequence_write_all::type_id::create ("i_afvip_sequence_write_all");
        i_reset_sequence = reset_sequence::type_id::create ("i_reset_sequence");
        phase.raise_objection (this);
        i_afvip_sequence_write_all.start (afvip_env_top.env_afvip_agent.afvip_seq); 
        i_reset_sequence.start(afvip_env_top.env_reset_agent.reset_seq);               
        phase.drop_objection (this);

    endtask : run_phase
endclass : afvip_write_all_test

class afvip_read_write_test extends afvip_base_test;
    `uvm_component_utils(afvip_read_write_test)

    function new (string name="afvip_read_write_test", uvm_component parent = null);
        super.new(name,parent);
    endfunction
    
    virtual function  void build_phase (uvm_phase phase);
        afvip_env_top=afvip_env::type_id::create("afvip_env_top",this);
    endfunction

    virtual task run_phase (uvm_phase phase);
        afvip_sequence         i_afvip_sequence;
        reset_sequence         i_reset_sequence;
        i_afvip_sequence = afvip_sequence::type_id::create ("i_afvip_sequence");
        i_reset_sequence = reset_sequence::type_id::create ("i_reset_sequence");
        phase.raise_objection (this);
        i_reset_sequence.start(afvip_env_top.env_reset_agent.reset_seq);  
        i_afvip_sequence.start (afvip_env_top.env_afvip_agent.afvip_seq);        
        phase.drop_objection (this);

    endtask : run_phase
endclass : afvip_read_write_test


class afvip_start_config_test extends afvip_base_test;
    `uvm_component_utils(afvip_start_config_test)

    function new (string name="afvip_start_config_test", uvm_component parent = null);
        super.new(name,parent);
    endfunction
    
    virtual function  void build_phase (uvm_phase phase);
        afvip_env_top=afvip_env::type_id::create("afvip_env_top",this);
    endfunction

    virtual task run_phase (uvm_phase phase);
        afvip_sequence_config i_afvip_sequence_config;
        reset_sequence         i_reset_sequence;
        i_afvip_sequence_config = afvip_sequence_config::type_id::create ("i_afvip_sequence_config");
        i_reset_sequence = reset_sequence::type_id::create ("i_reset_sequence");
        phase.raise_objection (this);
        i_reset_sequence.start(afvip_env_top.env_reset_agent.reset_seq);
        i_afvip_sequence_config.start (afvip_env_top.env_afvip_agent.afvip_seq);        
        phase.drop_objection (this);

    endtask : run_phase
endclass : afvip_start_config_test

class afvip_functional_test extends afvip_base_test;
    `uvm_component_utils(afvip_functional_test)

    function new (string name="afvip_functional_test", uvm_component parent = null);
        super.new(name,parent);
    endfunction
    
    virtual function  void build_phase (uvm_phase phase);
        afvip_env_top=afvip_env::type_id::create("afvip_env_top",this);
    endfunction

    virtual task run_phase (uvm_phase phase);
        afvip_functional_sequence i_afvip_functional_sequence;
        reset_sequence                       i_reset_sequence;
        i_afvip_functional_sequence = afvip_functional_sequence::type_id::create ("i_afvip_functional_sequence");
        i_reset_sequence = reset_sequence::type_id::create ("i_reset_sequence");
        phase.raise_objection (this);
        i_reset_sequence.start(afvip_env_top.env_reset_agent.reset_seq);
        i_afvip_functional_sequence.start (afvip_env_top.env_afvip_agent.afvip_seq);        
        phase.drop_objection (this);

    endtask : run_phase
endclass : afvip_functional_test

class afvip_random_test extends afvip_base_test;
    `uvm_component_utils(afvip_random_test)

    function new (string name="afvip_random_test", uvm_component parent = null);
        super.new(name,parent);
    endfunction
    
    virtual function  void build_phase (uvm_phase phase);
        afvip_env_top=afvip_env::type_id::create("afvip_env_top",this);
    endfunction

    virtual task run_phase (uvm_phase phase);
        afvip_random_sequence i_afvip_random_sequence;
        reset_sequence                       i_reset_sequence;
        i_afvip_random_sequence = afvip_random_sequence::type_id::create ("i_afvip_random_sequence");
        i_reset_sequence = reset_sequence::type_id::create ("i_reset_sequence");
        phase.raise_objection (this);
        i_reset_sequence.start(afvip_env_top.env_reset_agent.reset_seq);
        i_afvip_random_sequence.start (afvip_env_top.env_afvip_agent.afvip_seq);        
        phase.drop_objection (this);

    endtask : run_phase
endclass : afvip_random_test