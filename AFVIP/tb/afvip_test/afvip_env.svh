// -----------------------------------------------------------------------------
// Module name: afvip_env
// HDL        : System Verilog
// Author     : Duca Robert
// Description: Test environment for AFVIP.
// Date       : 5 August, 2023
// -----------------------------------------------------------------------------
class afvip_env extends uvm_env;
    `uvm_component_utils(afvip_env)    

    function  new(string name = "afvip_env",uvm_component parent= null);
        super.new(name, parent);
    endfunction

    afvip_agent                          env_afvip_agent;
    reset_agent                          env_reset_agent;
    afvip_interrupt_agent      env_afvip_interrupt_agent;
    my_scoreboard                                 m_scbd;
    afvip_coverage                    env_afvip_coverage;
    virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    env_afvip_agent             = afvip_agent::type_id::create("env_afvip_agent",this);
    env_reset_agent             = reset_agent::type_id::create("env_reset_agent",this);
    env_afvip_interrupt_agent   = afvip_interrupt_agent::type_id::create("env_afvip_interrupt_agent",this);
    env_afvip_coverage          = afvip_coverage::type_id::create("env_afvip_coverage",this);
    uvm_config_db #(uvm_active_passive_enum)::set(this, "env_afvip_interrupt_agent", "is_active", UVM_PASSIVE);
    m_scbd                      = my_scoreboard::type_id::create("m_scbd",this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        env_afvip_agent.                afvip_mon.                    mon_analysis_port.    connect(m_scbd.ap_imp_afvip);
        env_reset_agent.                reset_mon.              reset_mon_analysis_port.    connect(m_scbd.ap_imp_reset);
        env_afvip_interrupt_agent.  interrupt_mon.             interr_mon_analysis_port.   connect(m_scbd.ap_imp_interr);
        env_afvip_agent.                afvip_mon.                    mon_analysis_port.    connect(env_afvip_coverage.analysis_export);
        
    endfunction

endclass : afvip_env