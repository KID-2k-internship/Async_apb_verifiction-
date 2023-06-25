
`ifndef GUARD_APB_SLAVE_MEMORY_SEQUENCE_SV
`define GUARD_APB_SLAVE_MEMORY_SEQUENCE_SV


class apb_slave_memory_sequence extends svt_apb_slave_base_sequence;

    `uvm_object_utils(apb_slave_memory_sequence)

  /** Slave memory. */
    svt_apb_memory apb_slave_mem;

    function new(string name="apb_slave_memory_sequence");
        super.new(name);
    endfunction

    virtual task body();

        super.body();

        // Instantiate the slave memory
        create_apb_slave_mem();

        forever begin
            // Gets the request from monitor
            p_sequencer.response_request_port.peek(req);

            if (req.cfg == null) begin
                req.cfg = cfg;
            end

            if (req.xact_type != svt_apb_transaction::IDLE &&
                !apb_slave_mem.is_in_bounds(req.address)) begin
                req.pslverr_enable = 1;
            end
            else begin
                // if (!req.pslverr_enable) begin
                req.pslverr_enable = 0;
                // For write transaction, put the write data to memory
                if(req.xact_type == svt_apb_slave_transaction::WRITE) begin
                    void'(apb_slave_mem.write(req.address,req.data));
                end
                // For Read transaction, get the read data from memory
                else if(req.xact_type == svt_apb_slave_transaction::READ)begin
                    req.data = apb_slave_mem.read(req.address);
                end
            end

            // Finally send the response
            `svt_xvm_send(req)
        end
    endtask: body

    virtual function void create_apb_slave_mem();
        svt_apb_slave_agent slave_agent;

        if ($cast(slave_agent, p_sequencer.get_parent())) begin
            apb_slave_mem = new("apb_slave_mem"   ,                // Memory name
                                cfg.sys_cfg.pdata_width,           // Data width
                                0,                                 // Address region
                                0,                                 // Lower address bound
                                ((1<<cfg.sys_cfg.paddr_width)-1)); // Upper address bound

            slave_agent.apb_slave_mem = apb_slave_mem;
        end

        apb_slave_mem.print();

    endfunction: create_apb_slave_mem

endclass: apb_slave_memory_sequence


`endif