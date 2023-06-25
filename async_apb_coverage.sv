`ifndef __ASYNC_APB_COVERAGE__
`define __ASYNC_APB_COVERAGE__

`uvm_analysis_imp_decl(_master)
`uvm_analysis_imp_decl(_slave)

class async_apb_coverage extends  uvm_component;

    `uvm_component_utils(async_apb_coverage)

    uvm_analysis_imp_master #(vip_clkrst_action, async_apb_coverage) master_ap;
    uvm_analysis_imp_slave  #(vip_clkrst_action, async_apb_coverage) slave_ap;

   rand bit [4:0] a, b;

    covergroup  clock_rate;
        c1: coverpoint a {
                            bins a1[31] = {[1:31]};
                          }
        c2: coverpoint  b {
                            bins b1[31] = {[1:31]};
                          }
        c1_x_c2: cross c1, c2;
    endgroup

    function new (string name = "async_apb_coverage", uvm_component parent = null);
        super.new(name, parent);
        master_ap = new("master_ap", this);
        slave_ap  = new("slave_ap", this);
        clock_rate   = new();
    endfunction

    virtual function void write_master (vip_clkrst_action _item);
        $display("Get the vip_clkrst_action items master");

        if(_item._action == CHG_PERIOD) begin
            a = _item._value;
            $display("Value of a  = %t", a);
        end
    endfunction

    virtual function void write_slave (vip_clkrst_action _item);
        $display("Get the vip_clkrst_action items slave");

        if(_item._action == CHG_PERIOD ) begin
            b = _item._value;
            $display("Value of b  = %t", b);
            clock_rate.sample();

        end
    endfunction

endclass

`endif