`ifndef __ASYNC_APB_ENV__
`define __ASYNC_APB_ENV__

class async_apb_env extends uvm_env;

     vip_clkrst_agent                                    _clkrst_master_agent       ;
     vip_clkrst_agent                                    _clkrst_slave_agent        ;

      /** APB VIP Master ENV */
    svt_apb_system_env apb_master_env;
    svt_apb_system_env apb_master_passive_env;

     /** APB VIP Slave  ENV */
    svt_apb_system_env apb_slave_env;

    cust_svt_apb_system_configuration                  cfg                 ;
    apb_to_apb_sb                                      _apb_scoreboard     ;
    async_apb_coverage                                 _apb_coverage       ;

    `uvm_component_utils(async_apb_env)

    function new(string name = "async_apb_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    //  Build phase
    //  Arguments
    //      phase   : UVM phasing object
    virtual function void build_phase(uvm_phase phase);
        virtual vip_clkrst_intf      _intf_clkrst_master;
        virtual vip_clkrst_intf      _intf_clkrst_slave;

        `uvm_info("build_phase", "Entered...",UVM_LOW)
        super.build_phase(phase);

        //  Create sub-blocks
        _clkrst_master_agent        = vip_clkrst_agent                          ::type_id::create("_clkrst_master_agent"      , this  );
        _clkrst_slave_agent         = vip_clkrst_agent                          ::type_id::create("_clkrst_slave_agent"       , this  );
        apb_master_env              = svt_apb_system_env                        ::type_id::create("apb_master_env"    , this  );
        apb_slave_env               = svt_apb_system_env                        ::type_id::create("apb_slave_env"     , this  );
        apb_master_passive_env      = svt_apb_system_env                        ::type_id::create("apb_master_passive_env"    , this  );
        cfg                         = cust_svt_apb_system_configuration         ::type_id::create("cfg"               , this  );
        _apb_scoreboard             = apb_to_apb_sb                             ::type_id::create("_apb_scoreboard"   , this  );
        _apb_coverage               = async_apb_coverage                        ::type_id::create("_apb_coverage"   , this  );

        // Add custom config to VIP system env and create virtual sequencer
        uvm_config_db#(svt_apb_system_configuration)       ::set(this, "apb_master_env", "cfg", cfg.master_cfg);
        uvm_config_db#(svt_apb_system_configuration)       ::set(this, "apb_slave_env", "cfg", cfg.slave_cfg);
        uvm_config_db#(svt_apb_system_configuration)       ::set(this, "apb_master_passive_env", "cfg", cfg.master_passive_cfg);

        if(!uvm_config_db#(virtual vip_clkrst_intf)     ::get(null, "uvm_test_top", "vip_clkrst_master_intf", _intf_clkrst_master))
            `uvm_fatal (get_full_name(), "Clock/Reset interface is not set")
        uvm_config_db#(virtual vip_clkrst_intf)         ::set(_clkrst_master_agent, "", "_intf", _intf_clkrst_master);

        if(!uvm_config_db#(virtual vip_clkrst_intf)      ::get(null, "uvm_test_top", "vip_clkrst_slave_intf", _intf_clkrst_slave))
            `uvm_fatal (get_full_name(), "Clock/Reset interface is not set")
        uvm_config_db#(virtual vip_clkrst_intf)          ::set(_clkrst_slave_agent, "", "_intf", _intf_clkrst_slave);

        `uvm_info("build_phase", "Exiting...", UVM_LOW)
    endfunction

    //  Connect phase
    //  Arguments
    //      phase   : UVM phasing object
    function void connect_phase(uvm_phase phase);
        `uvm_info("connect_phase", "Entered...",UVM_LOW)

        super.connect_phase(phase);

        apb_master_passive_env.master.monitor.item_observed_port.connect(_apb_scoreboard.item_observed_initiated_export);
        apb_slave_env.slave[1].monitor.item_observed_port.connect(_apb_scoreboard.item_observed_response_export);

        _clkrst_master_agent._drv.analysis_port.connect(_apb_coverage.master_ap);
        _clkrst_slave_agent._drv.analysis_port.connect(_apb_coverage.slave_ap);

        $display("print_topology");
		uvm_top.print_topology();
    endfunction

endclass

`endif
