
`ifndef GUARD_APB_SLAVE_RANDOM_RESPONSE_SEQUENCE_SV
`define GUARD_APB_SLAVE_RANDOM_RESPONSE_SEQUENCE_SV

class apb_slave_random_response_sequence extends svt_apb_slave_base_sequence;

  /** UVM Object Utility macro */
    `uvm_object_utils(apb_slave_random_response_sequence)

    /** Class Constructor */
    function new(string name="apb_slave_random_response_sequence");
        super.new(name);
    endfunction

    virtual task body();
        `uvm_info("body", "Entered ...", UVM_LOW)

        forever begin
            p_sequencer.response_request_port.peek(req);
            if (req.cfg == null) begin
                req.cfg = cfg;
            end

            req.cfg.default_pready = $urandom_range(0,1);
            `uvm_rand_send(req)

        end

        `uvm_info("body", "Exiting...", UVM_LOW)
    endtask: body

endclass: apb_slave_random_response_sequence

`endif // GUARD_APB_SLAVE_RANDOM_RESPONSE_SEQUENCE_SV
