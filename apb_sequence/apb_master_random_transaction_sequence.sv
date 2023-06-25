`ifndef GUARD_APB_MASTER_RANDOM_TRANSACTION_SEQUENCE_SV
`define GUARD_APB_MASTER_RANDOM_TRANSACTION_SEQUENCE_SV

class apb_master_random_transaction_sequence extends svt_apb_master_base_sequence;

    rand int unsigned sequence_length = 10;

  /** Constrain the sequence length to a reasonable value */
    constraint reasonable_sequence_length {
        sequence_length <= 10;
     }

  /** UVM Object Utility macro */
    `uvm_object_utils(apb_master_random_transaction_sequence)

  /** Class Constructor */
    function new(string name="apb_master_random_transaction_sequence"); //uvm_component parent = null);
        super.new(name);
    endfunction

    virtual task body();
        svt_apb_master_transaction  trans;
        bit status;
        `uvm_info("body", "Entered ...", UVM_LOW)

        super.body();

        status = uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
        `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);

    for(int i = 0; i < sequence_length; i++) begin
        /** Set up the random transaction */
        `uvm_create(trans)
        `uvm_rand_send(trans)
         /** Wait for the read transaction to complete */
        get_response(rsp);

        `uvm_info("body", "APB Random transaction completed", UVM_LOW);
    end
  endtask: body

endclass: apb_master_random_transaction_sequence

`endif // apb_master_only_write_sequence
