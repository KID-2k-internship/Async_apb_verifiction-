`ifndef GUARD_APB_WR_RD_ADDR_MAX_SEQUENCE_SV
`define GUARD_APB_WR_RD_ADDR_MAX_SEQUENCE_SV

class apb_wr_rd_addr_max_sequence extends svt_apb_master_base_sequence;

    /** Parameter that controls the number of transactions that will be generated */
    rand int unsigned sequence_length = 10;

    /** Constrain the sequence length to a reasonable value */
    constraint reasonable_sequence_length {
        sequence_length <= 100;
    }

    /** UVM Object Utility macro */
    `uvm_object_utils(apb_wr_rd_addr_max_sequence)

    /** Class Constructor */
    function new(string name="apb_wr_rd_addr_max_sequence");
        super.new(name);
    endfunction

    virtual task body();
        svt_apb_master_transaction write_tran, read_tran, idle_trans;
        bit status;
        `uvm_info("body", "Entered ...", UVM_LOW)

        super.body();

        status = uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
        `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);

        for(int i = 0; i < sequence_length; i++) begin

            /** Set up the write transaction */
            `uvm_create(write_tran)
            write_tran.cfg       = cfg;
             write_tran.xact_type = svt_apb_transaction::WRITE;
             write_tran.address   = 32'hffff_fffc + i; //| ('h100 * i);
            write_tran.data      = 32'hffff_ffff + i;

            /** Send the write transaction */
            `uvm_send(write_tran)

            /** Wait for the write transaction to complete */
             get_response(rsp);
            `uvm_info("body", "APB WRITE transaction completed", UVM_LOW);

            /** Set up the read transaction */
            `uvm_create(read_tran)
            read_tran.cfg       = cfg;
            read_tran.xact_type = svt_apb_transaction::READ;
            read_tran.address   = 32'hffff_fffc + i;
            read_tran.pstrb     = 0;
            /** Send the read transaction */
            `uvm_send(read_tran)

            /** Wait for the read transaction to complete */
            get_response(rsp);
            `uvm_info("body", "APB READ transaction completed", UVM_LOW);

            `uvm_create(idle_trans)
            idle_trans.cfg       = cfg;
            idle_trans.xact_type = svt_apb_transaction::IDLE;
            idle_trans.address   = 32'h0000_0000;
            idle_trans.data      = i;
            idle_trans.num_idle_cycles = 3;

            /** Send the read transaction */
            `uvm_send(idle_trans)

            /** Wait for the read transaction to complete */
            get_response(rsp);
    end
    `uvm_info("body", "APB IDLE transaction completed", UVM_LOW);
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask: body

endclass: apb_wr_rd_addr_max_sequence

`endif
