`ifndef __ASYNC_APB_BASE_TEST__
`define __ASYNC_APB_BASE_TEST__

class async_apb_base_test extends uvm_test;

  async_apb_env     _env    ;

  `uvm_component_utils(async_apb_base_test)


  function new(string name = "async_apb_base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    `uvm_info ("build_phase", "Entered...",UVM_LOW)
    _env    = async_apb_env::type_id::create("_env", this);
    super.build_phase(phase);
    endfunction: build_phase

  task run_phase(uvm_phase phase);
    vip_clkrst_bseq                  _seq_master;
    vip_clkrst_bseq                  _seq_slave;
    vip_clkrst_change_period         _seq_slave_change_clk;
    vip_clkrst_change_period         _seq_master_change_clk;
    vip_clkrst_start_clk             _seq_master_clk_start;
    vip_clkrst_stop_clk              _seq_master_clk_stop;
    vip_clkrst_start_clk             _seq_slave_clk_start;

    vip_clkrst_action    _item_master   ;
    vip_clkrst_action    _item_slave    ;

        // apb transactions
    apb_master_random_transaction_sequence     _base_seq;
    apb_slave_memory_sequence 		             _apb_slv_resp;

    phase.raise_objection(this);

        _base_seq                = apb_master_random_transaction_sequence::type_id       ::create("_base_seq");
        _seq_master              = vip_clkrst_bseq::type_id                              ::create("_seq_master");
        _seq_slave               = vip_clkrst_bseq::type_id                              ::create("_seq_slave");
        _seq_slave_change_clk    = vip_clkrst_change_period::type_id                     ::create("_seq_slave_change_clk");
        _seq_master_change_clk   = vip_clkrst_change_period::type_id                     ::create("_seq_master_change_clk");
        _seq_master_clk_start    = vip_clkrst_start_clk::type_id                         ::create("_seq_master_clk_start");
        _seq_master_clk_stop     = vip_clkrst_stop_clk::type_id                          ::create("_seq_master_clk_stop");
        _seq_slave_clk_start     = vip_clkrst_start_clk::type_id                         ::create("_seq_slave_clk_start");

        _seq_master_change_clk._period = 5;
        _seq_master_change_clk.start(_env._clkrst_master_agent._seqr);
        _seq_slave_change_clk._period = 5;
        _seq_slave_change_clk.start(_env._clkrst_slave_agent._seqr);

        _seq_master.start(_env._clkrst_master_agent._seqr);
        _seq_slave.start(_env._clkrst_slave_agent._seqr);

        fork
            begin
                _base_seq.start(_env.apb_master_env.master.sequencer);
            end
            begin
                _apb_slv_resp      = apb_slave_memory_sequence::type_id                    ::create("_apb_slv_resp");
                _apb_slv_resp.start(_env.apb_slave_env.slave[0].sequencer);
            end
      join_any

        #100ns;

        phase.drop_objection(this);

    endtask

endclass

`endif



