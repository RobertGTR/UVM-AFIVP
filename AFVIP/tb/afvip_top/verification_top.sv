// -----------------------------------------------------------------------------
// Module name: verification_top
// HDL        : System Verilog
// Author     : Duca Robert
// Description: Testbench for Design.
// Date       : 5 August, 2023
// -----------------------------------------------------------------------------
module verification_top;
    import uvm_pkg::*;
        `include "uvm_macros.svh"
    import  tb_pkg::*;
        
    // System interface  
      logic clk;
     reg rst_n;
      // APB interface
     reg psel;
     reg penable;
     reg[15:0] paddr;
     reg pwrite;
     reg[31:0] pwdata;
     reg pready;
     reg[31:0] prdata;
    afvip_if   i_afvip_if(
     .clk(clk),
    .rst_n(rst_n)
    );
    system_if  i_system_if (
    .clk(clk)
  );

   system_if  interrupt (
    .clk(clk)
  );

 afvip #(
 .TP(0)
 )durere(
 .psel(psel),
 .penable(penable),
 .paddr(paddr),
 .pwrite(pwrite),
 .pwdata(pwdata),
 .pready(pready),
 .prdata(prdata),
 .pslverr(pslverr),
 .clk(clk),
 .rst_n(rst_n),
 .afvip_intr(afvip_intr)
);
initial begin 
    clk=1;
    forever begin 
      #5 clk=~clk;
        end
    end
    

    initial begin
    uvm_config_db#(virtual afvip_if)::set(null,"*.env_afvip_agent.*","afvip_if",i_afvip_if);
    uvm_config_db#(virtual system_if)::set(null,"*.env_reset_agent.*","system_if",i_system_if);
    uvm_config_db#(virtual system_if)::set(null,"*.env_afvip_interrupt_agent.*","system_if",interrupt);
    //run_test("afvip_read_all_test");
    //run_test("afvip_read_write_test");
    //run_test("afvip_start_config_test");
    //run_test("afvip_functional_test");
    run_test("afvip_random_test");
end

    assign rst_n=i_system_if.rst_n;
    assign i_system_if.afvip_intr= afvip_intr;
    
    assign psel    = i_afvip_if.psel;
    assign penable = i_afvip_if.penable;
    assign paddr   = i_afvip_if.paddr;
    assign pwrite  = i_afvip_if.pwrite;
    assign pwdata=i_afvip_if.pwdata;
    assign i_afvip_if.pready=pready;
    assign i_afvip_if.prdata=prdata;
    



endmodule