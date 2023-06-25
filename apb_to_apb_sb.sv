//Macro that define two analysis ports with unique suffixes
`uvm_analysis_imp_decl(_initiated)
`uvm_analysis_imp_decl(_response)

class apb_to_apb_sb extends uvm_scoreboard;
   typedef reg [31:0] data_queue [$];
    reg [31:0] type_apb_master[$];
    reg [31:0] type_dut_master[$];

    reg [31:0] wdata_input[$];
    reg [31:0] wdata_output[$];

    reg [31:0] rdata_output[$];
    reg [31:0] rdata_input[$];

    reg [31:0] paddr_input[$];
    reg [31:0] paddr_output[$];

    reg [31:0] pstrb_input[$];
    reg [31:0] pstrb_output[$];

    reg [31:0] prrot0_input[$];
    reg [31:0] prrot0_output[$];

    reg [31:0] prrot1_input[$];
    reg [31:0] prrot1_output[$];

    reg [31:0] prrot2_input[$];
    reg [31:0] prrot2_output[$];

    reg [31:0] pslverr_output[$];
    reg [31:0] pslverr_input[$];

    //  Analysis port connected to the APB Master Agent */
    uvm_analysis_imp_initiated#(svt_apb_transaction, apb_to_apb_sb) item_observed_initiated_export;

    //  Analysis port connected to the APB Slave Agent */
    uvm_analysis_imp_response#(svt_apb_transaction, apb_to_apb_sb) item_observed_response_export;


    // Factory registration
    `uvm_component_utils(apb_to_apb_sb)
    //-------------------------------------------------------------------------
    //  Methods
    //------------------------------------------
    function new (string name = "apb_to_apb_sb", uvm_component parent=null);
        super.new(name, parent);
    endfunction


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // construct the analysis ports
        item_observed_initiated_export = new("item_observed_initiated_export", this);
        item_observed_response_export = new("item_observed_response_export", this);
        `uvm_info(get_type_name(), "SCOREBOAD IS START.............", UVM_LOW)
    endfunction : build_phase
    virtual interface apb_intf  apb_intf;
    virtual function void connect_phase(uvm_phase phase);

        super.connect_phase(phase);
        if (!uvm_config_db#(virtual apb_intf)::get(null, "uvm_test_top", "apb_intf", apb_intf)) begin
            `uvm_fatal(get_full_name(), "APB master interface is not set")
        end
    endfunction

    /** This method is called by item_observed_initiated_export */
    virtual function void write_initiated(input svt_apb_transaction xact);
        svt_apb_transaction init_xact;
        if (!$cast(init_xact, xact.clone())) begin
            `uvm_fatal("write_initiated", "Unable to $cast the received transaction to svt_apb_transaction");
        end

            // `uvm_info("write_initiated", $sformatf("xact:\n%s", init_xact.sprint()), UVM_LOW)

        if (apb_intf.PSELS && !$isunknown(apb_intf.PWRITES) && apb_intf.PENABLES) begin
            // SAMPLE PSTRB
            `uvm_info(get_type_name(), "PUSH PSTRB IN QUEUE 0.............", UVM_LOW)
            pstrb_input.push_back(init_xact.pstrb);
            $display ("pstrb_output  = %p", pstrb_output);

            //SAMPLE ADDR
            // if (apb_intf.PSELS && apb_intf.PWRITES && apb_intf.PENABLES) begin
           `uvm_info(get_type_name(), "PUSH WADDR IN QUEUE 0.............", UVM_LOW)
            paddr_input.push_back(init_xact.address);
            $display ("paddr_input = %p", paddr_input);

            //SAMPLE PPROT0
            `uvm_info(get_type_name(), "PUSH PPROT0 IN QUEUE 0.............", UVM_LOW)
            prrot0_input.push_back(init_xact.pprot0);
            $display ("prrot0_input  = %p", prrot0_input);

            //SAMPLE PPROT1
            `uvm_info(get_type_name(), "PUSH PPROT1 IN QUEUE 0.............", UVM_LOW)
             prrot1_input.push_back(init_xact.pprot1);
            $display ("prrot1_input  = %p", prrot1_input);

            //SAMPLE PPROT2
            `uvm_info(get_type_name(), "PUSH PPROT2 IN QUEUE 0.............", UVM_LOW)
            prrot2_input.push_back(init_xact.pprot2);
            $display ("prrot2_input  = %p", prrot2_input);
        end

        if( init_xact.xact_type == svt_apb_transaction::READ ) begin
            // SAMPLE PRDATA
            `uvm_info(get_type_name(), "PUSH RDATA IN QUEUE 0.............", UVM_LOW)
            rdata_output.push_back(init_xact.data);
            $display ("wdata_output  = %p",  wdata_output);
        end

        if( apb_intf.PSELS && apb_intf.PWRITES && apb_intf.PENABLES) begin
            // SAMPLE PWDATA
            `uvm_info(get_type_name(), "PUSH WDATA IN QUEUE 0.............", UVM_LOW)
            wdata_input.push_back(init_xact.data);
            $display ("wdata_output  = %p",  wdata_output);
        end

        if(init_xact.xact_type == svt_apb_transaction::WRITE || init_xact.xact_type == svt_apb_transaction::READ ) begin
            // SAMPLE PSLVERR
                `uvm_info(get_type_name(), "PUSH PSLVERR IN QUEUE 0.............", UVM_LOW)
                pslverr_output.push_back(init_xact.pslverr_enable);
            $display ("pslverr_output  = %p", pslverr_output);
        end
    endfunction

 /** This method is called by item_observed_response_export */
    virtual function void write_response(input svt_apb_transaction xact);
        svt_apb_transaction response_xact;
        if (!$cast(response_xact, xact.clone())) begin
            `uvm_fatal("write_response", "Unable to $cast the received transaction to svt_apb_transaction");
        end

        // `uvm_info("write_response", $sformatf("xact:\n%s", response_xact.sprint()), UVM_LOW)

        if (apb_intf.PSELS && !$isunknown(apb_intf.PWRITES) && apb_intf.PENABLES) begin
            //SAMPLE ADDR
            `uvm_info(get_type_name(), "PUSH WADDR IN QUEUE 1.............", UVM_LOW)
            paddr_output.push_back(response_xact.address);
            $display ("paddr_output  = %p",  paddr_output);

            //SAMPLE PSTRB
           `uvm_info(get_type_name(), "PUSH PSTRB IN QUEUE 1.............", UVM_LOW)
            pstrb_output.push_back(response_xact.pstrb);
            $display ("pstrb_output  = %p", pstrb_output);

            //SAMPLE PPROT0
            `uvm_info(get_type_name(), "PUSH PPROT0 IN QUEUE 1.............", UVM_LOW)
            prrot0_output.push_back(response_xact.pprot0);
            $display ("prrot0_output  = %p", prrot0_output);

            //SAMPLE PPROT1
            `uvm_info(get_type_name(), "PUSH PPROT1 IN QUEUE 1.............", UVM_LOW)
            prrot1_output.push_back(response_xact.pprot1);
            $display ("prrot1_output  = %p", prrot1_output);

            //SAMPLE PPROT2
            `uvm_info(get_type_name(), "PUSH PPROT2 IN QUEUE 1.............", UVM_LOW)
            prrot2_output.push_back(response_xact.pprot2);
            $display ("prrot2_output  = %p", prrot2_output);

        end

        if( apb_intf.PSELS && apb_intf.PWRITES && apb_intf.PENABLES) begin
            //SAMPLE PWDATA
            `uvm_info(get_type_name(), "PUSH WDATA IN QUEUE 1.............", UVM_LOW)
            wdata_output.push_back(response_xact.data);
            $display ("wdata_output  = %p",  wdata_output);
        end

        if( response_xact.xact_type == svt_apb_transaction::READ ) begin
            // SAMPLE PRDATA
            `uvm_info(get_type_name(), "PUSH RDATA IN QUEUE 1.............", UVM_LOW)
            rdata_input.push_back(response_xact.data);
            $display ("wdata_output  = %p",  wdata_output);
        end

        if((response_xact.xact_type == svt_apb_transaction::WRITE || response_xact.xact_type == svt_apb_transaction::READ)) begin
            // SAMPLE PSLVERR
            `uvm_info(get_type_name(), "PUSH PSLVERR IN QUEUE 1.............", UVM_LOW)
                pslverr_input.push_back(response_xact.pslverr_enable);
            $display ("pslverr_output  = %p", pslverr_input);
        end
    endfunction


    function void check_number_of_transaction(data_queue apb_vip_master_queue, data_queue apb_dut_master_queue);
        `uvm_info(get_type_name(), "START CHECK NUMBER OF TRANSACTION ...", UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("APB VIP Queue = %p , Output Data APB2APB IP  QUEUE= %p", apb_vip_master_queue, apb_dut_master_queue), UVM_LOW)
        if (apb_dut_master_queue.size() == apb_vip_master_queue.size()) begin
            `uvm_info(get_type_name(), $sformatf("MATCH NUMBER OF TRANSACTION FROM APB CONVERT TO APB: size of Input Transaction APB2APB IP Data queue = %p , size of Output Transaction APB2APB IP queue = %p", apb_vip_master_queue.size(), apb_dut_master_queue.size() ), UVM_LOW)
        end
        else begin
            `uvm_error(get_type_name(), $sformatf("MISMATCH NUMBER OF TRANSACTION FROM APB CONVERT TO APB: size of Input Transaction APB2APB IP Data queue = %p, size of Output Transaction APB2APB IP queue = %p", apb_vip_master_queue.size(), apb_dut_master_queue.size() ) )
        end
    endfunction : check_number_of_transaction

    function void check_apb_to_apb(data_queue apb_vip_master_queue, data_queue apb_dut_master_queue );
        int data_vip_apb;
        int data_dut_apb;
        int size_apb_data_queue ;

       //`uvm_info(get_type_name(), "START CHECK..........................................", UVM_LOW)

        if (apb_vip_master_queue.size() >= apb_dut_master_queue.size()) begin
            size_apb_data_queue = apb_dut_master_queue.size();
        end
        else begin
            size_apb_data_queue = apb_vip_master_queue.size();
        end

        if (apb_vip_master_queue.size() == apb_dut_master_queue.size())begin
           for (int i = 0; i < size_apb_data_queue; i++) begin
                data_vip_apb = apb_vip_master_queue.pop_front();
                data_dut_apb = apb_dut_master_queue.pop_front();

                if (data_dut_apb == data_vip_apb) begin
                    $display("CHECK SUCESSFULL...........................................");
                end
                else begin
                    `uvm_error(get_type_name(), $sformatf("Output from APB2APB DUT Mismatched with send from APB VIP from i = %d th data, APB VIP  = %h , Output APB2APB IP = %h", i, data_vip_apb, data_dut_apb))
                end
            end
        end
    endfunction : check_apb_to_apb


    virtual function void check_phase(uvm_phase phase);
        super.check_phase(phase);


       // $display("");
        `uvm_info(get_type_name(), "START CHECK WDATA..........................................", UVM_LOW)
        check_number_of_transaction(wdata_input, wdata_output);
        check_apb_to_apb(wdata_input, wdata_output);

        // $display("");
        `uvm_info(get_type_name(), "START CHECK RDATA..........................................", UVM_LOW)
        check_number_of_transaction(rdata_input, rdata_output);
        check_apb_to_apb(rdata_input, rdata_output);

        // $display("");
        `uvm_info(get_type_name(), "START CHECK ADDR..........................................", UVM_LOW)
        check_number_of_transaction(paddr_input, paddr_output);
        check_apb_to_apb(paddr_input, paddr_output);

        // $display("");
        `uvm_info(get_type_name(), "START CHECK PSTRB..........................................", UVM_LOW)
        check_number_of_transaction(pstrb_input, pstrb_output);
        check_apb_to_apb(pstrb_input, pstrb_output);

        // $display("");
        `uvm_info(get_type_name(), "START CHECK PPROT0..........................................", UVM_LOW)
        check_number_of_transaction(prrot0_input, prrot0_output);
        check_apb_to_apb(prrot0_input, prrot0_output);

        // $display("");
        `uvm_info(get_type_name(), "START CHECK PPROT1..........................................", UVM_LOW)
        check_number_of_transaction(prrot1_input, prrot1_output);
        check_apb_to_apb(prrot1_input, prrot1_output);

        // $display("");
        `uvm_info(get_type_name(), "START CHECK PPROT2..........................................", UVM_LOW)
        check_number_of_transaction(prrot2_input, prrot2_output);
        check_apb_to_apb(prrot2_input, prrot2_output);

        // $display("");
        `uvm_info(get_type_name(), "START CHECK PSLVERR..........................................", UVM_LOW)
        check_number_of_transaction(pslverr_output, pslverr_input);
        check_apb_to_apb(pslverr_output, pslverr_input);



    endfunction : check_phase

   // end



endclass : apb_to_apb_sb