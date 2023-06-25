`ifndef GUARD_APB_MASTER_WR_RD_SEQUENCE_SV
`define GUARD_APB_MASTER_WR_RD_SEQUENCE_SV

class apb_master_wr_rd_sequence extends svt_apb_master_base_sequence;

    rand int unsigned sequence_length = 1000;

    constraint resonable_sequence_length {
        sequence_length <= 1000;

    }

    `uvm_object_utils(apb_master_wr_rd_sequence)


    function new(string name = "apb_master_wr_rd_sequence");
        super.new(name);
    endfunction

    virtual task body();
    svt_apb_master_transaction write_tran, read_tran, idle_trans;
        bit status;
        `uvm_info("body", "Entered ... ", UVM_LOW)

        super.body();

        status = uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
        `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);

        repeat (sequence_length) begin
         `uvm_do_with(req, { xact_type == svt_apb_transaction::WRITE; })

         `uvm_do_with(req, { xact_type == svt_apb_transaction::READ;
                                    pstrb   == 4'h0;})
        end

        `uvm_info("body", "Exiting...", UVM_LOW)
    endtask: body


endclass


`endif
