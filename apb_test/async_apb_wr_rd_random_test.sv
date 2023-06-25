`ifndef __ASYNC_APB_WR_RD_RANDOM_TEST__
`define __ASYNC_APB_WR_RD_RANDOM_TEST__

class async_apb_wr_rd_random_test extends async_apb_base_test;

  `uvm_component_utils(async_apb_wr_rd_random_test)

  function new(string name = "async_apb_wr_rd_random_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    `uvm_info ("build_phase", "Entered...",UVM_LOW)
    super.build_phase(phase);
  endfunction: build_phase

  task run_phase(uvm_phase phase);

    vip_clkrst_bseq                            _seq_master;
    vip_clkrst_bseq                            _seq_slave;
    apb_master_wr_rd_sequence                  _base_seq;
    apb_constraint_addr_sequence               _constraint_seq;
    apb_slave_memory_sequence 		             _apb_slv_resp;

    phase.raise_objection(this);
      _base_seq                = apb_master_wr_rd_sequence::type_id                    ::create("_base_seq");
      _constraint_seq          = apb_constraint_addr_sequence::type_id                 ::create("_costraint_seq");
      _seq_master              = vip_clkrst_bseq::type_id                              ::create("_seq_master");
      _seq_slave               = vip_clkrst_bseq::type_id                              ::create("_seq_slave");

      _seq_master.start(_env._clkrst_master_agent._seqr);
      _seq_slave.start(_env._clkrst_slave_agent._seqr);

        fork
            begin
              _base_seq.start(_env.apb_master_env.master.sequencer);
            end
            begin
              _apb_slv_resp            = apb_slave_memory_sequence::type_id                    ::create("_apb_slv_resp");
              _apb_slv_resp.start(_env.apb_slave_env.slave[0].sequencer);
            end
        join_any
        disable fork ;

        fork
            begin
              _constraint_seq.start(_env.apb_master_env.master.sequencer);
            end
            begin
              _apb_slv_resp            = apb_slave_memory_sequence::type_id                    ::create("_apb_slv_resp");
              _apb_slv_resp.start(_env.apb_slave_env.slave[0].sequencer);
            end
        join_any
      #100ns;
    phase.drop_objection(this);

    endtask

endclass

`endif



