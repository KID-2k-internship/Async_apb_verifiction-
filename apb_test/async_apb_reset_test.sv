`ifndef __ASYNC_APB_RESET_TEST__
`define __ASYNC_APB_RESET_TEST__

class async_apb_reset_test extends async_apb_base_test;

    `uvm_component_utils(async_apb_reset_test)

    virtual interface apb_intf  apb_intf;

    function new(string name = "async_apb_reset_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        `uvm_info ("build_phase", "Entered...",UVM_LOW)
        super.build_phase(phase);
        if(!uvm_config_db#(virtual apb_intf)      ::get(null, "uvm_test_top", "apb_intf", apb_intf))
            `uvm_fatal (get_full_name(), "apb_intf interface is not set")
        uvm_config_db#(uvm_object_wrapper)::set(this,"_env.apb_slave_env.slave*.sequencer.run_phase","default_sequence", apb_slave_random_response_sequence::type_id::get());
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        vip_clkrst_bseq                            _seq_master;
        vip_clkrst_bseq                            _seq_slave;
        apb_wr_rd_addr_max_sequence                _base_seq;
        apb_slave_memory_sequence 		             _apb_slv_resp;
        vip_clkrst_change_period                   _seq_slave_change_clk;
        vip_clkrst_change_period                   _seq_master_change_clk;
        apb_slave_random_response_sequence         _apb_slv_random_resp;

        phase.raise_objection(this);
            _base_seq                = apb_wr_rd_addr_max_sequence::type_id                  ::create("_base_seq");
            _seq_master              = vip_clkrst_bseq::type_id                              ::create("_seq_master");
            _seq_slave               = vip_clkrst_bseq::type_id                              ::create("_seq_slave");
            _seq_slave_change_clk    = vip_clkrst_change_period::type_id                     ::create("_seq_slave_change_clk");
            _seq_master_change_clk   = vip_clkrst_change_period::type_id                     ::create("_seq_master_change_clk");

            _seq_master.start(_env._clkrst_master_agent._seqr);
            _seq_slave.start(_env._clkrst_slave_agent._seqr);

    for(int i = 0; i < 100; i++)begin

            _seq_master_change_clk._period = $urandom_range(1,31);
            _seq_master_change_clk.start(_env._clkrst_master_agent._seqr);
            _seq_slave_change_clk._period = $urandom_range(1,31);
            _seq_slave_change_clk.start(_env._clkrst_slave_agent._seqr);

            _seq_master.start(_env._clkrst_master_agent._seqr);
            _seq_slave.start(_env._clkrst_slave_agent._seqr);
        fork
            begin
                _base_seq.start(_env.apb_master_env.master.sequencer);
            end
            begin
                #280ns;
                apb_intf.PRESETSn = 0;
                #60ns;
                apb_intf.PRESETSn = 1;
            end
            // begin
            //     #320ns;
            //     apb_intf.PRESETMn = 0;
            //     #40ns;
            //     apb_intf.PRESETMn = 1;
            // end
        join
    end

            #100ns;
        phase.drop_objection(this);
    endtask

endclass

`endif
